Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14MIQ53011880
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 17:18:27 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Best way to label a filesystem for another system
Date: Fri, 4 Feb 2005 14:18:25 -0800
Message-ID: <60C14C611F1DDD4198D53F2F43D8CA3B0365B114@orsmsx410>
From: "Villalovos, John L" <john.l.villalovos@intel.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Ok, so you are running with the default FC3 targeted policy (i.e.
> confine specific network daemons, leave everything else uncontrolled)
> but trying to install based on the NSA example strict policy (i.e.
> fine-grained domains for many processes).  Hence, setfiles is
> trying to
> check the validity of the contexts from the strict policy against your
> running policy, which doesn't define many of the necessary types.
> Further, if setfiles were to get to the point of trying to set those
> contexts, your running SELinux kernel would reject them as invalid, as
> they aren't defined in its policy.
> 
> Don't do that.  Either disable SELinux on the development system (edit
> /etc/selinux/config or use system-config-securitylevel), or
> use the same
> policy for both (at least with respect to the set of defined types).
> FC3 also includes a strict policy RPM.

So is there an option or anything to have setfiles not use the currently
running policy to verify things?  Can you specify different files for it
to use to verify information?

Can I just disable SE Linux on the host system before I run setfiles and
then enable it afterwards?  Is that even possible?  I know I can turn
off the enforcement but can I turn off SE Linux being enabled from a
command line tool or do I need to actually reboot and disable it?

I hope these aren't stupid questions.

Thanks,
John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
