Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA11387
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 06:25:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA27822
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 11:23:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA27818 for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 11:23:08 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Koichi ONOUE <koichi@osss.is.tsukuba.ac.jp>, selinux@tycho.nsa.gov
Subject: Re: login
Date: Tue, 19 Nov 2002 12:24:52 +0100
References: <20021119171235.40736181.koichi@osss.is.tsukuba.ac.jp>
In-Reply-To: <20021119171235.40736181.koichi@osss.is.tsukuba.ac.jp>
MIME-Version: 1.0
Message-Id: <200211191224.52641.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Nov 2002 09:12, Koichi ONOUE wrote:
> when I started SELinux, I was required to input at "Enter role", "Enter
> type". But I do not know what I should input at it.
> Please tell me.

If you have the /etc/security/default_contexts (or 
/etc/security/default_context for the old version) file setup correctly then 
it should offer a default that is suitable.

For role try "user_r" and for type try "user_t".

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
