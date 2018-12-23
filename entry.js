import { main } from './output/Main'

if (module.hot) {
  module.hot.accept(() => {
    console.info('hot module reload')
    Array.from(document.querySelectorAll('body > div')).forEach(x => x.remove())
    main()
  })

  main()
  console.info('started in hot reloading mode')
} else {
  main()
}
