Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AKOGrT001014
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:24:16 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5AKODaH022841
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:24:13 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 20:24:14 -0000
Date: Thu, 10 Jun 2004 20:21:34 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Ed Street <edstreet@street-tek.com>, "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040610202134.GB2861@lkcl.net>
References: <20040610022221.7796D3A4063@abyss.simplyaquatics.com> <200406101510.31547.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406101510.31547.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 10, 2004 at 03:10:31PM +1000, Russell Coker wrote:
> On Thu, 10 Jun 2004 12:22, "Ed Street" <edstreet@street-tek.com> wrote:
> > Well why ANY app needs write access to /etc is beyond me. ?Also are you
> > using run_init /etc/init.d/foo ?
> 
> It's not /etc, it's /var/spool/postfix/etc.  Fortunately LaMont addressed this 


> issue in version 1.1.7-5 by making the files not be copied to the chroot if 
> master.cf does not specify any services to be chrooted.
 
 ah - ah... do you know if he addressed the issue of the context of
 those files being copied over from /etc/ to /var/spool/postfix/etc
 as well, such that of course initrd_t then needs to have permission
 to rm etc_t and such?

 l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
