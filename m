Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14JMV53010879
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 14:22:31 -0500 (EST)
Subject: RE: Best way to label a filesystem for another system
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Villalovos, John L" <john.l.villalovos@intel.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <60C14C611F1DDD4198D53F2F43D8CA3B0365AD08@orsmsx410>
References: <60C14C611F1DDD4198D53F2F43D8CA3B0365AD08@orsmsx410>
Content-Type: text/plain
Message-Id: <1107544554.8078.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 14:15:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 14:06, Villalovos, John L wrote:
> I am using Fedora Core 3 as my development system and it has all the
> current updates applied.
> 
> I am using policy-1.20.tgz from the NSA website for the code I am using
> for the target system.

Ok, so you are running with the default FC3 targeted policy (i.e.
confine specific network daemons, leave everything else uncontrolled)
but trying to install based on the NSA example strict policy (i.e.
fine-grained domains for many processes).  Hence, setfiles is trying to
check the validity of the contexts from the strict policy against your
running policy, which doesn't define many of the necessary types. 
Further, if setfiles were to get to the point of trying to set those
contexts, your running SELinux kernel would reject them as invalid, as
they aren't defined in its policy.

Don't do that.  Either disable SELinux on the development system (edit
/etc/selinux/config or use system-config-securitylevel), or use the same
policy for both (at least with respect to the set of defined types). 
FC3 also includes a strict policy RPM.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
