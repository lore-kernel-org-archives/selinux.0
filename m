Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5EBgTrT017512
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 07:42:29 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5EBgIxZ001187
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 11:42:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: too many sysadmfile?
Date: Mon, 14 Jun 2004 21:42:15 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1086884579.19414.30.camel@gorn.pebenito.net> <200406140051.i5E0plBk003937@turing-police.cc.vt.edu> <1087204813.23933.150.camel@gorn.pebenito.net>
In-Reply-To: <1087204813.23933.150.camel@gorn.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406142142.15560.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Jun 2004 19:20, Chris PeBenito <pebenito@gentoo.org> wrote:
> I don't see how these would be broken.  Admin_domain() has tmp_domain(),
> so /tmp/foo will be writable.  I'm not arguing that sysadmfile should be
> eliminated, just reduced; /etc/hosts would still be a sysadmfile, and
> therefore be writable.

Doing:
vi /bin/my-script
Then adding a cron entry to run /bin/my-script is fairly common sysadmin 
practise.  It's probably a bad idea, but it's what almost everyone does.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
