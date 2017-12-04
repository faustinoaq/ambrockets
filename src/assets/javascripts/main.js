import Amber from 'amber';

let socket = new Amber.Socket('/chat');

let message = $('#message')[0];
let messages = $('#messages')[0];

localStorage.setItem('user', $('.user').text());

socket.connect().then(() => {
    let channel = socket.channel('chat_room:hello');

    channel.join();

    channel.on('message_new', payload => {
        let p = document.createElement('p');
        p.innerText = payload.message;
        if (payload.user.length > 0) {
            p.innerHTML = `<b>${payload.user.trim()}: </b>` + p.innerText;
        }
        messages.append(p);
        messages.scrollTop = messages.scrollHeight;
    });

    $('#form-message').on('submit', event => {
        event.preventDefault();
        if (localStorage.getItem('user') === null) {
            let p = document.createElement('p');
            p.innerText = "You are disconnected!";
            messages.append(p);
        } else {
            channel.push('message_new', {
                user: localStorage.getItem('user'),
                message: message.value
            });
            message.value = '';
        }
    });

    $('.logout').on('click', event => {
        socket.disconnect();
        localStorage.clear();
    });
});
