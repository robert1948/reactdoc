import React from 'react';
import './LandingPage.css'; // Ensure you create and import the corresponding CSS file

const LandingPage = () => {
  return (
    <>
      <header className="header" style={{ background: 'linear-gradient(135deg, #667eea, #764ba2)', color: 'white', padding: '60px 20px', textAlign: 'center' }}>
        <h1>Empower Your Business with AI Craftsmanship</h1>
        <p>Transform your operations with intelligent solutions tailored for your success.</p>
        <div className="cta">
          <button onClick={() => window.location.href = '#try'}>Try Now</button>
          <button onClick={() => window.location.href = '#learn'}>Learn More</button>
        </div>
      </header>

      <main className="container">
        <section className="services">
          <div className="card">
            <h3>Chatbots</h3>
            <p>Enhance customer engagement with responsive and intuitive chatbots that understand your audience.</p>
          </div>
          <div className="card">
            <h3>Content Generation</h3>
            <p>Create compelling content effortlessly using our advanced AI writing tools designed for marketing and more.</p>
          </div>
          <div className="card">
            <h3>Data Analysis</h3>
            <p>Leverage AI-powered analytics to gain actionable insights, drive growth, and optimize your business operations.</p>
          </div>
        </section>

        <section className="features">
          <div className="card">
            <h3>User Accounts</h3>
            <p>Manage your projects with personalized dashboards and secure user authentication.</p>
          </div>
          <div className="card">
            <h3>Project Galleries</h3>
            <p>Showcase your AI-driven projects and explore innovative work from others in the community.</p>
          </div>
          <div className="card">
            <h3>Blog Posts</h3>
            <p>Stay updated with the latest trends, tips, and insights in AI innovation through our engaging blog.</p>
          </div>
          <div className="card">
            <h3>Email Contact Forms</h3>
            <p>Connect with us instantly for support, inquiries, and collaboration opportunities using our contact forms.</p>
          </div>
        </section>

        <section id="learn" className="contact">
          <h2>Get in Touch</h2>
          <div className="contact-form">
            <form action="/contact" method="post">
              <input type="text" name="name" placeholder="Your Name" required />
              <input type="email" name="email" placeholder="Your Email" required />
              <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
              <button type="submit">Send Message</button>
            </form>
          </div>
        </section>
      </main>

      <footer style={{ background: '#333', color: '#ccc', textAlign: 'center', padding: '20px' }}>
        <p>&copy; 2025 AI Craftsmanship. All rights reserved.</p>
      </footer>
    </>
  );
};

export default LandingPage;
