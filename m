Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6KCqRrT019670
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 08:52:28 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6KCpqUj019785
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 12:51:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: Troubles with etc/passwd being relabeled to shadow_t upon useradd/usermod
Date: Tue, 20 Jul 2004 22:43:17 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20040720093704.GD21906@wintermute.xmldesign.de>
In-Reply-To: <20040720093704.GD21906@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407202243.17726.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Jul 2004 19:37, Erich Schubert <erich@debian.org> wrote:
> i'm using SELinux from Russels Debian packages.
> Whenever i (or an dpkg postinst script) modifies the etc/passwd,
> or etc/group files they are transferred to the
>   "root:object_r:shadow_t" type, thus being unable to be read
> even by root.
> What is causing this, and how can i prevent this?
> (doing a "make relabel" is the only way i found to solve this)

Yes, this is a known bug.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
