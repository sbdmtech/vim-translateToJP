" @author : sasike
" @susage : translate selected text of English to Japanese 

" Define a command that translates the word under the cursor to Japanese and opens the results in a new buffer
command! TranslateToJapanese call TranslateToJapanese()

function! TranslateToJapanese()
    " Get the word under the cursor
    let word = expand("<cword>")

    " Define the API endpoint and query parameters
    let api_url = 'https://translate.google.com/translate_a/single'
    let params = {
                \   'client': 't',
                \   'sl': 'auto',
                \   'tl': 'ja',
                \   'dt': 't',
                \   'q': word,
                \}

    " Send a GET request to the Google Translate API and capture the response
    let response = systemlist('curl -sG --data-urlencode "' . join(params, '&') . '" ' . api_url)

    " Extract the translated text from the response
    let japanese_text = response[0][2][0]

    " Open a new buffer and populate it with the translated text
    execute 'new'
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nowrap
    setlocal noshowmode
    setlocal nolist
    setlocal nomodifiable
    call setline(1, [japanese_text])
endfunction

" Map the command to a key combination
nnoremap <leader>ff :TranslateToJapanese<CR>
vnoremap <leader>ff :TranslateToJapanese<CR>
