Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA11916
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 15:34:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA28170
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 19:33:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA28153 for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 19:33:02 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: Apache 2 file contexts
Date: Wed, 9 Oct 2002 21:34:29 +0200
References: <20021008160033.A5253@lemuria.org> <200210081906.13285.russell@coker.com.au> <20021009172503.A22321@lemuria.org>
In-Reply-To: <20021009172503.A22321@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210092134.29020.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Oct 2002 17:25, Tom wrote:
> Apache2 requires some weird socket access, that I traced to the
> following (by disabling all the dontaudits in the apache.te):
>
> Oct  9 19:16:20 nsa2 kernel: avc:  denied  { read } for  pid=5347
> exe=/usr/sbin/apache2 path=/1 dev=00:07 ino=3
> scontext=system_u:system_r:httpd_t tcontext=tom:object_r:sysadm_devpts_t
> tclass=chr_file
>
> piping that into newrules tells me:
>
> allow httpd_t sysadm_devpts_t:chr_file { read };

Most daemons do that.  This is because they inherit file handles 0, 1, and 2 
(stdin, stdout, stderr) from the shell.  Some daemons can survive without 
such access, but many (most) can't.

In my tree for many daemons I have something like the following:
allow daemon_t admin_tty_type:chr_file { read write };

I am going to devise a different solution to this, see the list archives for 
my previous messages on the topic.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
