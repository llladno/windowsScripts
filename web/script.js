let messages = document.querySelector('.messages')
let lastStatus = []
setInterval(async ()=>{
    const response = await fetch("http://localhost:3000/checkstatus");
    const status = await response.json();
    console.log(lastStatus.length)
    if (lastStatus.length === status.counter.length) {

    } else {
        messages.innerHTML = ``
        lastStatus = status.counter.reverse()
        lastStatus.forEach((element) => {
            messages.innerHTML += `
            <div class="message">
            <p>Изменения в дерриктории обнаружены! <br> 
            <b>Дата: ${element.slice(0, 10)}</b><br>
            <b>Время: ${element.slice(11, 20)}</b>
            </p>
            <p>Проверьте целостность документов!</p>
            </div>`
    })}
    console.log(status.counter)

},1000)