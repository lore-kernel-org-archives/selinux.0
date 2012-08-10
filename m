Message-ID: <1344622106.10631.75.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SELinux performance depending on type count
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Date: Fri, 10 Aug 2012 14:08:26 -0400
In-Reply-To: <20120810170008.GI2296@telvanni>
References: <20120807130244.GE2085@telvanni>
	 <20120810121113.GE2296@telvanni>
	 <1344603615.10631.26.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810143656.GF2296@telvanni>
	 <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810154454.GH2296@telvanni>
	 <1344614902.10631.70.camel@moss-pluto.epoch.ncsc.mil>
	 <1344615485.10631.72.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810170008.GI2296@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-10 at 19:00 +0200, Ole Kliemann wrote:
> I don't have an auditd, not running mcstransd and also had 
> disabled restorecond.
> 
> I take it, /sys/fs/selinux is equivalent to /selinux?

Yes.  /selinux moved to /sys/fs/selinux in more modern distro versions.

> /sys/fs/selinux is empty on both my Ubuntu systems.
> 
> /selinux/policyver in 26 as is the suffix of the policy file.
> 
> Complete policy is attached. choke/src/support/choke.spt can be tuned 
> to suck even more. Do 'make load' in choke/src/ and you are good 
> to go.

Ok, loaded.  Now what exactly are you doing to test it?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
