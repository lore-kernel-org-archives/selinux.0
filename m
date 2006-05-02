Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremy Katz <katzj@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>,
        SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1146583639.32102.20.camel@orodruin.boston.redhat.com>
References: <44576B91.8060607@redhat.com>
	 <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
	 <1146583639.32102.20.camel@orodruin.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 02 May 2006 12:26:15 -0400
Message-Id: <1146587175.13611.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 11:27 -0400, Jeremy Katz wrote:
> Lots do.  On the order of as many packages as require users at least.
> And I'd expect more over time (especially given policy around dbus and
> the increasing reliance on dbus through the distribution).  Imagine a
> world where every user you wanted to add had to have a separate package
> to create the user first. 

I'm not sure these all require separate policy.  Ideally, we'd like to
see greater use of the equivalence class concepts to limit the explosion
in policy and not require per-application/per-package policy in so many
cases.  There is a tradeoff here in least privilege vs. manageability.

> You _already_ have to handle this case.  Think about the case where I
> load a policy with some file context.  Then, I create files labeled as
> such.  Then I remove the policy.   Use the files.  Then load policy
> again.  

If you didn't remove the files when you removed the policy, and you
didn't bother to relabel them, then they truly have become unlabeled.
Arguing that they should auto-magically be converted back to the
original types when those types re-appear in the policy (regardless of
what they may mean) is not a clear cut case.  Consider an analogy:
Admin creates some user accounts, those users create some files, admin
deletes the user accounts but some files owned by those uids are left
around the system, later the admin creates some other user accounts but
reuses the same uids.  Now those leftover files will be accessible to
the new users, but it is debatable as to whether that is a good thing.

> And to be fully up-front about it, if there is continued opposition to
> being able to set things like this, then what's going to end up having
> to happen is that we're going to have to generate some dummy policy
> mapping new file contexts to unlabeled_t (or some such) and load it
> before the files get put down and then load the real policy afterwards.
> And you've now doubled the amount of time spent on policy loads[1] and
> gaining nothing beyond having the kernel do the right thing.

Ok, let's assume that we implement kernel mechanism for
revalidating/updating the incore inode SIDs upon policy reload.  But
where does this leave us with regard to being able to meaningfully
confine rpm in the future, e.g. by moving the real processing into a
helper and running it in different domains based on package
trustworthiness and purpose?  If rpm (and potentially other programs, as
this becomes a tempting way to deal with e.g. dump/restore) can set down
arbitrary values as file contexts, then can they be meaningfully
restricted in any way?  To me that is the larger concern.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
