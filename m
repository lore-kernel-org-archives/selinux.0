Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87HjcOe005334
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:45:38 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l87HjbhF007746
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 17:45:37 GMT
Subject: Re: Kernel panic when using refpolicy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Kim Lawson-Jenkins <lawson@itd.nrl.navy.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <000c01c7f17a$f2047130$c301000a@PC05>
References: <000c01c7f17a$f2047130$c301000a@PC05>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 13:44:16 -0400
Message-Id: <1189187056.13435.16.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-07 at 13:14 -0500, Kim Lawson-Jenkins wrote:
> I'm running RHEL5.  I downloaded refpolicy-20070629.tar.bz2 and
> selinux-refpolicy-sources-20070629-1.noarch.rpm and installed the files for
> the reference policy.  When rebooting the system there was a fatal error -
> Kernel panic - not syncing: Fatal exception.
> 
> There were many unknown Boolean errors for libsepol.load.booleans and there
> was the following error - 
> libsepol.sepol_genbools: error while reading /etc/selinux/refpolicy/Booleans
> 
> It looks like ifconfig was running when the kernel panic occurred.  To
> recover booted into single-user mode and changed the SELINUXTYPE in the file
> /etc/selinux/config from refpolicy to targeted.  I can easily repeat the
> problem by using the SELinux Management Tool to change the System Default
> Policy Type from targeted to refpolicy and rebooting.  I've looked at all of
> the documentation to see if I missed a step or downloaded an incorrect file
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
