Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBMDrMRb021729
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 08:53:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBMDqTjx024867
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 13:52:29 GMT
Received: from nox.lemuria.org ([213.191.86.35])
	by jazzswing.ncsc.mil  with ESMTP id hBMDqSSR024863
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 13:52:29 GMT
Date: Mon, 22 Dec 2003 14:53:10 +0100
From: Tom <tom@lemuria.org>
To: =?iso-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: DoS and DDoS attacks
Message-ID: <20031222145310.C30151@lemuria.org>
References: <3FE6E480.6090606@ipen.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3FE6E480.6090606@ipen.br>; from monteiro@ipen.br on Mon, Dec 22, 2003 at 10:33:04AM -0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 22, 2003 at 10:33:04AM -0200, Carlos Anísio Monteiro wrote:
> How can SELinux obstruct the DoS and DDoS attacks ?

It doesn't (except for a very small class of host-based DoSes).

SELinux is, essentially, TE+MAC+RBAC. 


You are, essentially, asking how a good door lock obstructs a tornado.
It doesn't - it's not its job. :)


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
