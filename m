Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OBYUJS024017
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 07:34:31 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2OBYKKA026179
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 11:34:27 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 2ACE018C6C
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 21:33:06 +1100 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sfInsEX94wIl for <selinux@tycho.nsa.gov>;
	Mon, 24 Mar 2008 21:33:05 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id C78CD18547
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 21:33:05 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 84EC821D3D
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 21:33:03 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: /bin/passwd and a basic MLS install of Fedora 8
Date: Mon, 24 Mar 2008 21:33:01 +1100
References: <200803240035.40028.russell@coker.com.au>
In-Reply-To: <200803240035.40028.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803242133.03227.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 24 March 2008 00:35, Russell Coker <russell@coker.com.au> wrote:
> /tmp/a.out is a test program I wrote which calls setresuid(0,0,0);

I was trying to reproduce a problem from Debian/Etch with the latest Fedora to 
see if it was an upstream issue or an issue in Debian.

I had a few issues with the MLS policy (rsyslogd not being permitted to write 
to the log files and auditd not working) and by the time I got to doing the 
actual test (at about midnight) I forgot to put it in enforcing mode again.

Sorry for the inconvenience, I'll double-check my test results before posting 
in future.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
