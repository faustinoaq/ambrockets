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
            p.innerHTML = `<b>${payload.user}: </b> ${p.innerHTML}`;
        }
        messages.appendChild(p);
        messages.scrollTop = messages.scrollHeight;
    });

    messageForm.addEventListener('submit', event => {
        event.preventDefault();
        let user = getUser();
        if (localStorage.getItem('user') == user) {
            channel.push('message_new', {
                user: user,
                message: message.value
            });
            message.value = '';
        } else {
            alert(`${user} is disconnected!`);
            window.location.reload();
        }
    });

    logout.addEventListener('click', event => {
        let user = getUser();
        if (localStorage.getItem('user') == user) {
            channel.leave();
            socket.disconnect();
            localStorage.clear();
        } else {
            event.preventDefault();
            alert(`${user} is already disconnected!`);
            window.location.reload();
        }
    });
});
