Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0BK63Rb009443
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 15:06:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0BK4uxr004114
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 20:04:57 GMT
Received: from zaphod.crypt.gen.nz (218-101-15-197.paradise.net.nz [218.101.15.197])
	by jazzswing.ncsc.mil  with ESMTP id i0BK4tYc004102
	for <selinux@tycho.nsa.gov>; Sun, 11 Jan 2004 20:04:56 GMT
Subject: Re: rshd
From: Kerry Thompson <kerry@crypt.gen.nz>
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200401081814.40877.russell@coker.com.au>
References: <200401081814.40877.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1073851542.1547.2.camel@edmond.crypt.gen.nz>
Mime-Version: 1.0
Date: Mon, 12 Jan 2004 09:05:43 +1300
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-08 at 20:14, Russell Coker wrote:
> ifdef(`rshd.te',
> `# Connect second port to rshd.
> can_tcp_connect(rshd_t, $1_t)')
> ')dnl end tcp server
> 
> What is the above section of user_macros.te about?  Why does an rsh server 
> connect back to the client?

It might be the stderr stream connection. stdin and stdout are carried
via the normal socket connection, but stderr is a separate socket.

-- 
Kerry Thompson, CISSP
IT Security Consultant
Auckland, New Zealand
http://www.crypt.gen.nz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
