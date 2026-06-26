import { useSelector } from 'react-redux';
import { RootState } from '@/redux/store';
import { useRouter } from 'next/navigation';
import { ReactNode, useEffect } from 'react';
import { toast } from 'react-toastify';

interface ProtectedRouteProps {
  children: ReactNode;
  requiredRole?: string;
}

const ProtectedRoute = ({ children, requiredRole }: ProtectedRouteProps) => {
  const { isAuthenticated, role } = useSelector(
    (state: RootState) => state.user,
  );
  const router = useRouter();

  // StoreProvider only renders `children` once redux-persist has rehydrated
  // (see PersistGate in StoreProvider.tsx), so this component never mounts
  // before the client-side auth state is available.
  useEffect(() => {
    if (!isAuthenticated) {
      toast.info('Register or login to view all features!');
      router.push('/auth');
    } else if (requiredRole && role !== requiredRole) {
      router.push('/');
      toast.error(
        'Access denied. Only' + ' ' + requiredRole + `'s can view this page.`,
      );
    }
  }, [isAuthenticated, role, router, requiredRole]);

  if (!isAuthenticated || (requiredRole && role !== requiredRole)) {
    return null;
  }

  return <>{children}</>;
};

export default ProtectedRoute;
