import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [data, setData] = useState(null);

  useEffect(() => {
    fetch('/api/data')
      .then(res => res.json())
      .then(data => setData(data))
      .catch(err => console.error(err));
  }, []);

  return (
    <div className="App">
      <div className="dashboard-card">
        <div className="header-row">
          <div className="logo-icon">☁️</div>
          <h1>Prod Platform</h1>
        </div>

        <div className="status-container">
          <div className={`status-indicator ${data ? 'connected' : 'loading'}`}></div>
          <span className={`status-text ${data ? 'connected' : 'loading'}`}>
            {data ? "System Operational" : "Connecting..."}
          </span>
        </div>

        <div className="data-window">
          {data ? (
            <pre>{JSON.stringify(data, null, 2)}</pre>
          ) : (
            <pre>{"{ status: 'waiting_for_packet' }"}</pre>
          )}
        </div>
      </div>
    </div>
  );
}

export default App;
