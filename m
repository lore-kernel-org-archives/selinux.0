Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i976mtrT012018
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 02:48:55 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i976mqov017436
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 06:48:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: petre rodan <kaiowas@gentoo.org>
Subject: Re: gentoo diff for mysqld
Date: Thu, 7 Oct 2004 16:48:47 +1000
Cc: Erich Schubert <erich@debian.org>, selinux@tycho.nsa.gov
References: <41625B74.2090503@gentoo.org> <1097001016.15549.4.camel@wintermute.xmldesign.de> <4163CF0D.4070201@gentoo.org>
In-Reply-To: <4163CF0D.4070201@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410071648.47636.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Oct 2004 20:55, petre rodan <kaiowas@gentoo.org> wrote:
> Here is a new patch with no distro_gentoo ifdefs.
> Also can someone please tell me when is that 'allow mysqld_t
> sysadm_home_t:file { read getattr };' needed? I have never felt the need
> for that rule and I'd be happy to see it go.

The start command for mysqld reads the file /root/.my.cnf , or used to at 
least.  Has it changed?

I've merged the tmp_domain and daemontools bits into my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
