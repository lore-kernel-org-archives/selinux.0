Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA17522
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 21:28:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA11845
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 01:27:22 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
	by jazzswing.ncsc.mil  with ESMTP id BAA11841
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 01:27:21 GMT
Date: Tue, 16 Jul 2002 18:27:21 -0700
From: Paul Krumviede <pwk@acm.org>
To: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>,
        selinux@tycho.nsa.gov
Subject: Re: inetd and tcpd services
Message-ID: <37841302.1026844041@localhost>
In-Reply-To: <Pine.LNX.4.44.0207170904280.559-100000@coffeesaur>
References: <Pine.LNX.4.44.0207170904280.559-100000@coffeesaur>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Wednesday, 17 July, 2002 09:07 +0800 "Rogelio M. Serrano Jr." 
<rogelio@evoworks.evoserve.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> im running imapd as an inetd service. in enforcing mode i cant access the
> mail spool directory because tcpd_t does not have permissions to lock the
> directory. should i create a new impadd_t or give tcpd_t permissions?

out of curiousity, which IMAP package are you running? i've been thinking
of creating a domain and the policy for the cyrus version...

anyway, i'd think you would be better off with a separate domain, as 
otherwise
other things may have unnecessary access to things such as IMAP control 
files.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
