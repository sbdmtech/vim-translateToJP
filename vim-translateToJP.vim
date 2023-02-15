" @author : sasike
" @susage : translate selected text of English to Japanese 

" Define a function to translate a word to Japanese using the Google Translate API
function! TranslateToJapanese(word) abort
    " Encode the selected word for use in a URL
    let encoded_word = substitute(a:word, '\W', '%\=printf("%%%02x", char2nr(submatch(0)))', 'g')

    " Construct the URL for the translation request
    let url = 'https://translate.google.com/?sl=auto&tl=ja&text=' . encoded_word

    " Send a GET request to the Google Translate URL
    let response = system('curl --silent "' . url . '"')

    " Parse the translation result from the HTML response
    let result = matchlist(response, '<span title=".*?">' . encoded_word . '</span><span>.*?</span><span>(.*?)</span>')[1]

    " Return the translated result
    return result
endfunction

" Define a Vim command to translate the selected word to Japanese
command! -range TranslateToJapanese <line1>,<line2>call setline('.', TranslateToJapanese(@"))
