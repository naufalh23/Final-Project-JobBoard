'use client';

import { AppStore, makeStore } from '@/redux/store';
import { ReactNode, useState } from 'react';
import { Provider } from 'react-redux';
import { persistStore } from 'redux-persist';
import { PersistGate } from 'redux-persist/integration/react';
import LoadingComp from './loading';

export default function StoreProvider({ children }: { children: ReactNode }) {
  const [store] = useState<AppStore>(() => makeStore());
  const [persistor] = useState(() => persistStore(store));

  return (
    <Provider store={store}>
      <PersistGate persistor={persistor} loading={<LoadingComp />}>
        {children}
      </PersistGate>
    </Provider>
  );
}
