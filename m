Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5B0s7rT003253
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 20:54:07 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5B0s2aH000603
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 20:54:03 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [debian] - installation of mysqld requires chfn
Date: Fri, 11 Jun 2004 10:53:57 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040609222209.GH5727@lkcl.net> <200406101220.53966.russell@coker.com.au> <20040610203006.GD2861@lkcl.net>
In-Reply-To: <20040610203006.GD2861@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406111053.57914.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 Jun 2004 06:30, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> yerss, i noticed that if i run with "enforcing=0" and run chfn as
> sysadm_r, i end up with /etc/shadow labelled as root:object_r:system_t

How does that happen?  There is no system_t type in the default policy!

The usual problem with chfn etc on Debian is of getting /etc/passwd labeled as 
root:object_r:shadow_t...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
