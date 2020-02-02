import { reactShinyInput } from 'reactR';
import { Vega } from 'react-vega';
import { useMemo } from 'react';

const ReactVega = ({ configuration, value, setValue, el }) => {
  const spec = useMemo(() => configuration.spec)
  const data = useMemo(() => configuration.data)

  const signalHandler = function(type, value) {
    window.console.log(el, type, value)
    Shiny.onInputChange(el.id + "_" + type, value)
  }

  let signalListeners = {}

  if(spec.hasOwnProperty('signals') && Array.isArray(spec.signals)) {
    spec.signals.forEach( signal => {
      signalListeners[signal.name] = signalHandler
    })
  }

  return <Vega
            spec = {spec}
            data = {data}
            signalListeners = {signalListeners}
            logLevel = {2}
          />;
};

reactShinyInput('.reactvega', 'reactvega.reactvega', ReactVega);
