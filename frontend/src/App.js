import React, { useState } from 'react';
import axios from 'axios';

function App() {
  const [message, setMessage] = useState('');

  const submitMessage = () => {
    axios.post('http://<EC2_PUBLIC_IP>:5000/message', { message })
      .then(res => alert('Message sent!'))
      .catch(err => alert('Error sending message'));
  }

  return (
    <div>
      <h1>Submit a Message</h1>
      <input value={message} onChange={e => setMessage(e.target.value)} />
      <button onClick={submitMessage}>Send</button>
    </div>
  );
}

export default App;
