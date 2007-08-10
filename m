Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AD759B001523
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 09:07:05 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7AD73LC024671
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 13:07:04 GMT
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 Aug 2007 15:07:03 +0200
From: =?iso-8859-1?Q?=22Bj=F6rn_Vogel=22?= <selinux770@tortenboxer.de>
In-Reply-To: <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <20070810130703.128070@gmx.net>
MIME-Version: 1.0
References: <20070810101003.128080@gmx.net>	
 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810121259.128050@gmx.net>
 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: wrong magic number (using old sources)
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > It could be solved by removing -z,defs from the src/Makefile. I don't
> know the consequences but it works.
> 
> No, it depends on thread local storage support in your glibc.  Manoj was
> using a workaround patch for it at one time for Debian,
> http://marc.info/?l=selinux&m=115807948020898&w=2

> restorecond depends on inotify.  But you don't need restorecond to have
> a working system, so you can always remove it from the Makefile SUBDIRS
> definition.

I'll try that. Thanks.

> > That's why I'm using the old sources. They work.
> 
> Well, except that they evidently don't.

Ok, you're right. Actually I meant: They compile with less problems ;o)

> > > Those versions are consistent with one another.
> > > Kernel version?  Policy version?
> > kernel version is 2.6.16-omap1
> > How do I find out the policy version?
> 
> Same way you found out what package version you were using of
> checkpolicy and friends, I assume.

Then i think it's 
selinux-policy-default_1.26-7 or
selinux-policy-default_1.26

I'm not really sure about that, because the policy was not written by me. It's only for testing. If the version of the policy is relevant, this might by the most probable error. Which version has the policyto be (at least)  to work with the (old) packages I mentioned?

-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
