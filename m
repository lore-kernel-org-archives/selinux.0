Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremy Katz <katzj@redhat.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
        Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1148491489.16558.38.camel@orodruin.boston.redhat.com>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
	 <20060517075435.GB7665@thorium.jmh.mhn.de>
	 <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
	 <20060518181452.GA4935@thorium2.jmh.mhn.de>
	 <1148043593.25168.71.camel@moss-spartans.epoch.ncsc.mil>
	 <1148044725.8647.35.camel@jackjack.columbia.tresys.com>
	 <1148404514.24463.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1148491489.16558.38.camel@orodruin.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 11:19:46 -0400
Message-Id: <1148570386.20976.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-24 at 13:24 -0400, Jeremy Katz wrote:
> Well, given that the only labels that will end up in a header will be
> from a policy in that package, I'm still not really convinced what
> adding a verification step _really_ accomplishes.  

In addition to the security aspects, think about it just from the
perspective of robustness and error reporting.  At present (w/o
labelpriv support), programs get an immediate indication if they attempt
to set a file label that is not defined by the policy, so they know when
they have tried to use an invalid label.  With labelpriv support, some
programs (like rpm) are going to get no indications of invalid file
labels when they are set, nor will they get any indication when the
policy is loaded that those file labels were never made valid.  Hence,
if they don't perform any separate verification, they'll never know that
an error occurred, and just leave the system in an inconsistent state.

Compare with chown/chmod with symbolic values rather than raw integers,
and note that those programs certainly report when the symbolic value is
invalid.  Eric Paris pointed out that if we gave user domains (i.e.
unconfined_t in targeted policy) the new labelpriv permission, then they
would certainly be unhappy to find that a seemingly successful chcon
command actually left the file in an unlabeled state without any warning
or error.  If rpm doesn't do any verification/checking, then it is in
the same situation - it violates the principle of least surprise.

The alternative model to post checking after policy load would be to
either:
1) Precheck the file contexts from the header against the .pp file in
some manner at install time (in which case rpm can abort early), or
2) Have load_policy fail if any of these labelpriv-created contexts were
not made valid by the new policy, reverting to the old policy and
returning an error all the way back to rpm (in which case rpm still has
to take some corrective action).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
