Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremy Katz <katzj@redhat.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
        Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1148570386.20976.119.camel@moss-spartans.epoch.ncsc.mil>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
	 <20060518181452.GA4935@thorium2.jmh.mhn.de>
	 <1148043593.25168.71.camel@moss-spartans.epoch.ncsc.mil>
	 <1148044725.8647.35.camel@jackjack.columbia.tresys.com>
	 <1148404514.24463.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1148491489.16558.38.camel@orodruin.boston.redhat.com>
	 <1148570386.20976.119.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 25 May 2006 11:28:30 -0400
Message-Id: <1148570910.20976.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 11:19 -0400, Stephen Smalley wrote:
> The alternative model to post checking after policy load would be to
> either:
> 1) Precheck the file contexts from the header against the .pp file in
> some manner at install time (in which case rpm can abort early), or

And as I suspect that you'll say that since those contexts were
generated from the .pp file in the first place, no such checking is
required, let me note that:
a) the contexts will have been generated from the file contexts part of
the .pp, not from the policy module itself, so there could be an
inconsistency between the two that leaves the context invalid under the
new policy, and
b) having rpm recheck at install time provides us with both greater
robustness (in the event of a bug in rpmbuild or a package corrupted in
some manner along the way) and security (in the event of a maliciously
constructed package).

> 2) Have load_policy fail if any of these labelpriv-created contexts were
> not made valid by the new policy, reverting to the old policy and
> returning an error all the way back to rpm (in which case rpm still has
> to take some corrective action).


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
