Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42GaeiS005710
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:36:40 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42Gad4f020242
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 16:36:39 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k42Gb1Ku011878
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:37:01 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k42Gb1HL011877
	for selinux@tycho.nsa.gov; Tue, 2 May 2006 12:37:01 -0400
Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Jeremy Katz <katzj@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>,
        SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
References: <44576B91.8060607@redhat.com>
	 <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 May 2006 11:27:19 -0400
Message-Id: <1146583639.32102.20.camel@orodruin.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 11:12 -0400, Stephen Smalley wrote:
> On Tue, 2006-05-02 at 10:24 -0400, Daniel J Walsh wrote:
> > I had more meetings with the install and RPM team at Red Hat about 
> > splitting out policy into individual packages for RHEL5/FC6.  We had 
> > many discussions about possible ways of doing this including breaking 
> > out policy into separate packages, ie http_policy.rpm but this was 
> > discounted as it was seen as a policy explosion.
> 
> Not every package requires policy.

Lots do.  On the order of as many packages as require users at least.
And I'd expect more over time (especially given policy around dbus and
the increasing reliance on dbus through the distribution).  Imagine a
world where every user you wanted to add had to have a separate package
to create the user first. 

> >   Also we discussed only 
> > doing the semodule as the last in the transaction but this ability is 
> > being de-emphasized in the installer, so it was thought to keep it 
> > simple and install the policy within each RPM that ships with policy, 
> > sort of the ldconfig model.
> > 
> > We need the ability for RPM to be able to write a file context on disk 
> > without the kernel verifying it.  The kernel should treat this as an 
> > unlabeled_t file. the same way it would if I ran
> > 
> > semodule -i XYZ.pp
> > restorecon /usr/bin/XYZ
> > semoduel -e XYZ
> > 
> > I don't think this is an unreasonable request to allow rpm_t to have the 
> > privilege of writing the "invalid" context to disk.
> 
> To restate my concerns with this approach:
> - It means that rpm (and any other program in the future to which we
> extend the same privilege, which will be increasingly tempting for a
> whole range of functionality) can never be effectively confined in any
> way, as they can set down arbitrary contexts (remember too that we'd
> ultimately like rpm or a helper that does the real work to run in
> different domains depending on the trustworthiness of the package),
> - It means that the kernel needs a mechanism for revalidating/updating
> the incore inode SIDs upon a policy reload, i.e. a policy reload would
> then need to trigger a traversal of the inode lists (including suitable
> locking of those lists) to fix up the incore inode SIDs for files that
> previously had invalid attributes.  Or that rpm has to go around fixing
> them up from userspace after loading the policy.

You _already_ have to handle this case.  Think about the case where I
load a policy with some file context.  Then, I create files labeled as
such.  Then I remove the policy.   Use the files.  Then load policy
again.  

And to be fully up-front about it, if there is continued opposition to
being able to set things like this, then what's going to end up having
to happen is that we're going to have to generate some dummy policy
mapping new file contexts to unlabeled_t (or some such) and load it
before the files get put down and then load the real policy afterwards.
And you've now doubled the amount of time spent on policy loads[1] and
gaining nothing beyond having the kernel do the right thing.

Jeremy

[1] Which has already been stated to be expensive and getting _more_ so
instead of less

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
