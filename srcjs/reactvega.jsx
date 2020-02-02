import { reactShinyInput } from 'reactR';
import { Vega } from 'react-vega';
import { useMemo } from 'react';

const ReactVega = ({ configuration, value, setValue }) => {
  const spec = useMemo(() => configuration.spec)
  const data = useMemo(() => configuration.data)

  return <Vega spec = {spec} data = {data}/>;
};

reactShinyInput('.reactvega', 'reactvega.reactvega', ReactVega);
