Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFHWRIi024760
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 12:32:27 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFHWUAe011823
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 17:32:30 GMT
Subject: Re: learning about policies/transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Serge Hallyn <serge.hallyn@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46ce702f0411150907a569ef0@mail.gmail.com>
References: <46ce702f041103084530fe8539@mail.gmail.com>
	 <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104082042e4c02a@mail.gmail.com>
	 <1099588265.3174.158.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104182352cbcd1@mail.gmail.com>
	 <1099657575.6373.5.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041115081242f9f8e7@mail.gmail.com>
	 <1100536712.31773.134.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f0411150907a569ef0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1100539708.31773.178.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Nov 2004 12:28:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-15 at 12:07, Serge Hallyn wrote:
> On Mon, 15 Nov 2004 11:38:33 -0500, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > /etc/selinux/(strict|targeted)/policy/policy.NN under FC3.  The question
> > is whether you are subsequently loading a different policy, possibly too
> > late, after /bin/login has already been looked up and brought incore.
> 
> Alas no, the custom policy is in /etc/security/selinux/policy.17 (on a
> FC2 throwaway partition).

Not sure if I understand your meaning (FC2 throwaway partition?), but
the above statement makes me wonder if you also have an
/etc/security/selinux/policy.18 file, and whether /sbin/init is loading
it instead.  FC2 shipped with policy.17, then subsequent FC2 kernel
updates yielded kernels that understood policy.18 (but still support
policy.17 for backward compatibility) without corresponding updates to
the policy tools and policy itself.  /sbin/init will try to load the
latest policy supported by the kernel, so if you have a policy.18, it
will try to load it first, and failing that, it will fall back to
policy.17.  But you shouldn't have a policy.18 unless you grabbed a
newer checkpolicy yourself from the NSA site or from the Fedora
development tree.

In any event, migrating to FC3 is a good idea for continued use of
SELinux, as the FC2 SELinux support was never well maintained.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
