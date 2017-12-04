import Amber from 'amber';

let socket = new Amber.Socket('/chat');

let logout = document.getElementById('logout');
let message = document.getElementById('message');
let messages = document.getElementById('messages');
let messageForm = document.getElementById('message-form');

function getUser() {
    return document.getElementById('user').innerText.trim();
}

localStorage.setItem('user', getUser());

socket.connect().then(() => {
    let channel = socket.channel('chat_room:hello');

    channel.join();

    channel.on('message_new', payload => {
        let p = document.createElement('p');
        p.innerText = payload.message;
        if (payload.user) {
            p.innerHTML = `<b>${payload.user}: </b> ${p.innerText}`;
        }
        messages.appendChild(p);
        messages.scrollTop = messages.scrollHeight;
    });

    messageForm.addEventListener('submit', event => {
        event.preventDefault();
        if (localStorage.getItem('user') == getUser()) {
            channel.push('message_new', {
                user: getUser(),
                message: message.value
            });
            message.value = '';
        } else {
            alert(`${getUser()} is disconnected!`);
            window.location.reload();
        }
    });

    logout.addEventListener('click', event => {
        if (localStorage.getItem('user') == getUser()) {
            channel.leave();
            socket.disconnect();
            localStorage.clear();
        } else {
            event.preventDefault();
            alert(`${getUser()} is already disconnected!`);
            window.location.reload();
        }
    });
});
