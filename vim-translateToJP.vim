" @author : sasike
" @susage : translate selected text of English to Japanese 

" Define the translation function
function! JPTranslate()
  " Get the currently selected word
  let word = expand("<cword>")

  " URL encode the word
  let encoded_word = substitute(word, '\(\k\+\)', '\=nr2char(matchstart(0) + 64) . nr2char(matchend(0) + 63)', 'g')

  " Build the translation URL
  let url = 'https://translate.google.com/?sl=auto&tl=ja&text=' . encoded_word

  " Use curl to fetch the translation HTML
  let html = system('curl -s "' . url . '"')

  " Extract the translation text from the HTML using a regular expression
  let translation = matchstr(html, '<span[^>]*?class="tlid-translation[^>]*?">[^<]*</span>')
  let translation = substitute(translation, '<[^>]*>', '', 'g')

  " Display the translation in a new buffer
  let buf = nvim_create_buf(0, 1)
  call nvim_buf_set_lines(buf, 0, -1, 0, split(translation, '\n'))
  call nvim_set_current_buf(buf)
  call nvim_buf_set_option(buf, 'filetype', 'text')
endfunction
