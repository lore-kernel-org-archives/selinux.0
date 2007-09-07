Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87I9pZ5007299
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 14:09:51 -0400
Received: from fw5540.nrl.navy.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l87I9ohF013033
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 18:09:50 GMT
From: "Kim Lawson-Jenkins" <lawson@itd.nrl.navy.mil>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>
References: <000c01c7f17a$f2047130$c301000a@PC05> <1189187056.13435.16.camel@gorn>
Subject: RE: Kernel panic when using refpolicy
Date: Fri, 7 Sep 2007 13:56:58 -0500
Message-ID: <000d01c7f180$de3a9e80$c301000a@PC05>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1189187056.13435.16.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris (and Eric & Brian),

I was running in permissive mode and yes, I did have TYPE=targeted, not
TYPE=targeted-mcs.  I'll make the change.  Thanks everyone for the
responses.

Kim

-----Original Message-----
From: Christopher J. PeBenito [mailto:cpebenito@tresys.com] 
Sent: Friday, September 07, 2007 12:44 PM
To: Kim Lawson-Jenkins
Cc: selinux@tycho.nsa.gov
Subject: Re: Kernel panic when using refpolicy

On Fri, 2007-09-07 at 13:14 -0500, Kim Lawson-Jenkins wrote:
> I'm running RHEL5.  I downloaded refpolicy-20070629.tar.bz2 and
> selinux-refpolicy-sources-20070629-1.noarch.rpm and installed the files
for
> the reference policy.  When rebooting the system there was a fatal error -
> Kernel panic - not syncing: Fatal exception.
> 
> There were many unknown Boolean errors for libsepol.load.booleans and
there
> was the following error - 
> libsepol.sepol_genbools: error while reading
/etc/selinux/refpolicy/Booleans
> 
> It looks like ifconfig was running when the kernel panic occurred.  To
> recover booted into single-user mode and changed the SELINUXTYPE in the
file
> /etc/selinux/config from refpolicy to targeted.  I can easily repeat the
> problem by using the SELinux Management Tool to change the System Default
> Policy Type from targeted to refpolicy and rebooting.  I've looked at all
of
> the documentation to see if I missed a step or downloaded an incorrect
file
> but I can't find anything.  Can anyone give me some insight into what the
> problem may be?  Thanks in advance for a response.

You set TYPE=targeted, not TYPE=targeted-mcs, right?  If so, I suspect
that you've hit the kernel bug in RHEL5 that happens when the SELinux
MLS support is disabled.  Loading a MCS policy turns on the MLS support.
In fact the RHEL5 targeted policy is targeted-mcs, in refpolicy terms.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
