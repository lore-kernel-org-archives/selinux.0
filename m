Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13986
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 09:18:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA17701
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 13:17:14 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
        by jazzband.ncsc.mil  with ESMTP id NAA17696 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 13:17:13 GMT
Date: Wed, 28 Aug 2002 08:18:53 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208281318.IAA07615@tomcat.admin.navo.hpc.mil>
To: russell@coker.com.au, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ipsec access to { sysadm_tty_device_t sysadm_devpts_t }
In-Reply-To: <20020828125757.B48098F6E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---------  Received message begins Here  ---------

> 
> On Wed, 28 Aug 2002 14:28, Jesse Pollard wrote:
> > Russell Coker <russell@coker.com.au>:
> > > Now I'm working on ipsec which seems to require { read write ioctl
> > > getattr } access to those device types for correct functioning.  As I am
> >
> > Slightly OT/side question:
> >
> > Which IPSec implementation are you starting with - NIST reference,
> > Free/swan or a completely new one?
> 
> I'm using Free/swan, I wasn't aware that I had a choice.  Could you please 
> give us a brief analysis of the difference between the different versions?

I don't know that there really is one. The NIST web page shows updates as
of 2000. I also had looked at Freeswan a year ago, and saw several reports
that it wouldn't get included in the kernel due to "unapproved" coding
practices (quotes mine - they also may have cleaned up since then too).

Since both NIST and the NSA were working on related things (and how the
freeswan project wasn't interested in US involment) I was curious about
any merging of interest between the two groups.

I'm interested in data labeling being passed with network packets (including
user identity...) but don't get much time to do anything on it.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
