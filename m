Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5A5A3rT025051
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 01:10:03 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5A59rP2009256
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 01:09:57 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ed Street" <edstreet@street-tek.com>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Thu, 10 Jun 2004 15:10:31 +1000
Cc: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'SE-Linux'" <selinux@tycho.nsa.gov>
References: <20040610022221.7796D3A4063@abyss.simplyaquatics.com>
In-Reply-To: <20040610022221.7796D3A4063@abyss.simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <200406101510.31547.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jun 2004 12:22, "Ed Street" <edstreet@street-tek.com> wrote:
> Well why ANY app needs write access to /etc is beyond me.  Also are you
> using run_init /etc/init.d/foo ?

It's not /etc, it's /var/spool/postfix/etc.  Fortunately LaMont addressed this 
issue in version 1.1.7-5 by making the files not be copied to the chroot if 
master.cf does not specify any services to be chrooted.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
