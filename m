Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11J6b53017652
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 14:06:37 -0500 (EST)
Subject: Re: Advice on bringing up SE Linux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Villalovos, John L" <john.l.villalovos@intel.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <60C14C611F1DDD4198D53F2F43D8CA3B035B5359@orsmsx410>
References: <60C14C611F1DDD4198D53F2F43D8CA3B035B5359@orsmsx410>
Content-Type: text/plain
Message-Id: <1107284400.26936.212.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 14:00:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 13:51, Villalovos, John L wrote:
> I am trying to bring up SE Linux on an Intel Xscale processor.  An
> IQ80310 to be specific.
> 
> We are using a 2.6.5 kernel, since it is the last one to support the
> IQ80310 :(
> 
> We have compiled up a kernel with SE Linux.  Mounted the selinuxfs on
> /selinux.
> 
> Now I am trying to figure out how to enable SE Linux.  All the utilities
> say the SE Linux is disabled.
> 
> When I do:
> 
> [iq80310]# cat /proc/self/attr/current
> Kernel
> 
> And I think I should get something like:
> [fc3]# cat /proc/self/attr/current
> root:system_r:unconfined_t
> 
> I have tried compiling up a policy.15 file and then just cat >
> /selinux/load
> 
> But that doesn't seem to change anything.
> 
> Any help would be greatly appreciated :)

Any output in /var/log/messages from the attempt to write the policy to
/selinux/load?  Any difference if you run load_policy on the binary
policy instead of directly cat'ing it?

A lot has changed in SELinux since 2.6.5, so you really need to move to
a newer kernel if you want to seriously use it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
