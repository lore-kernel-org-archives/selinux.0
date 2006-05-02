Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremy Katz <katzj@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>,
        SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1146587175.13611.145.camel@moss-spartans.epoch.ncsc.mil>
References: <44576B91.8060607@redhat.com>
	 <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
	 <1146583639.32102.20.camel@orodruin.boston.redhat.com>
	 <1146587175.13611.145.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 May 2006 13:42:32 -0400
Message-Id: <1146591753.13611.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 12:26 -0400, Stephen Smalley wrote:
> Ok, let's assume that we implement kernel mechanism for
> revalidating/updating the incore inode SIDs upon policy reload.  But
> where does this leave us with regard to being able to meaningfully
> confine rpm in the future, e.g. by moving the real processing into a
> helper and running it in different domains based on package
> trustworthiness and purpose?  If rpm (and potentially other programs, as
> this becomes a tempting way to deal with e.g. dump/restore) can set down
> arbitrary values as file contexts, then can they be meaningfully
> restricted in any way?  To me that is the larger concern.

Ok, it has been pointed out to me that rpm and friends can still be
meaningfully restricted if:
a) we still apply the usual checking on setxattr() when the context is
valid under the policy (thereby preventing rpm from setting to a context
that is known but not accessible to it under the policy), and just use
unlabeled_t as the target context when the context is not known under
the policy and the process has some new privilege for setting unknown
contexts (so the privilege no longer confers completely arbitrary
values),
b) we apply fine-grained access control over the policy modules being
loaded by rpm so that it cannot add types with arbitrary permissions to
the policy (so that it cannot gain access to something it should not via
the previously unknown types it is introducing), which is necessary
anyway for confinement of rpm and should be addressed via the policy
server.

In which case I have a couple of other questions:
1) Are there any implications of having these files exist temporarily
with the unlabeled_t type, as that type is generally inaccessible except
to privileged domains?  Seems like we could end up with spurious denials
on running processes, e.g. upon glibc upgrade or similar.
2) What kind of error checking will rpm do to deal with the fact that
the kernel won't know that the context is invalid at setxattr() time, so
if rpm feeds it one that ends up being invalid even under the new
policy, that won't be known until the policy load occurs?  I suppose rpm
could call lgetxattr()/lgetfilecon() on the files after the policy load
and recheck that they have the expected values.  But does that fit with
your proposed approach?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
