Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA21147
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 05:40:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA04204
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 09:39:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA04198
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 09:39:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>,
        selinux@tycho.nsa.gov
Subject: Re: inetd and tcpd services
Date: Tue, 23 Jul 2002 11:40:17 +0200
References: <Pine.LNX.4.44.0207170904280.559-100000@coffeesaur>
In-Reply-To: <Pine.LNX.4.44.0207170904280.559-100000@coffeesaur>
MIME-Version: 1.0
Message-Id: <20020723094017.A9CA87CC4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Jul 2002 03:07, Rogelio M. Serrano Jr. wrote:
> im running imapd as an inetd service. in enforcing mode i cant access the
> mail spool directory because tcpd_t does not have permissions to lock the
> directory. should i create a new impadd_t or give tcpd_t permissions?

I suggest creating a new domain for that and having an auto_trans rule to 
transition from tcpd_t to it.  Look at my courier.te file for hints (but note 
that you're using a much simpler IMAP server and don't need most of that).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
