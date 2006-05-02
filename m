Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42Gac1M005694
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:36:38 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42Gab4f020237
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 16:36:37 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k42Gaxin011873
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 12:36:59 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k42GaxC1011872
	for selinux@tycho.nsa.gov; Tue, 2 May 2006 12:36:59 -0400
Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Jeremy Katz <katzj@redhat.com>
To: Joshua Brindle <method@gentoo.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>, Paul Nasrat <pnasrat@redhat.com>,
        James Antill <jantill@redhat.com>
In-Reply-To: <44577454.5040204@gentoo.org>
References: <44576B91.8060607@redhat.com>  <44577454.5040204@gentoo.org>
Content-Type: text/plain
Date: Tue, 02 May 2006 11:16:39 -0400
Message-Id: <1146583000.32102.8.camel@orodruin.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 11:01 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > I had more meetings with the install and RPM team at Red Hat about 
> > splitting out policy into individual packages for RHEL5/FC6.  We had 
> > many discussions about possible ways of doing this including breaking 
> > out policy into separate packages, ie http_policy.rpm but this was 
> > discounted as it was seen as a policy explosion.  Also
> How is it a policy explosion? What does that mean exactly?

Package explosion. For every package in the "universe", there is more
metadata to be downloaded and more memory to be used.  Having to have a
separate subpackage for *every* package containing policy is madness.

> > we discussed only doing the semodule as the last in the transaction 
> > but this ability is being de-emphasized in the installer, so it was 
> > thought to keep it simple and install the policy within each RPM that 
> > ships with policy, sort of the ldconfig model.
> >
> de-emphasized by the installer?  Not sure I follow, rebuilding the 
> policy every time is expensive and may get worse (policy server 
> enforcement).

There's movement underway to split transactions into minimal closed
sets.  Which means that you're going to end up running semodule about as
many times as there are policy packages.  If this takes absurd amounts
of time, then people further get the impression that SELinux is an
impediment more than a help :(

> > Secondly the rpm team would like to be able to execute the equivalent 
> > of matchpathcon(XYZ.pp)  IE be able to extract the FC file mapping 
> > from the policy package and combine it with the on disk representation 
> > to determine the file context to associate with the new files being 
> > put on disk.
> >
> hrm, this is unreliable unless you are combining file contexts from all 
> possible modules being installed. Any given RPM transaction can easily 
> have multiple policy packages and this needs to be addressed.

The policy for a given package needs to be able to be contained to that
package.  Otherwise, it's pretty much impossible to sanely handle policy
in anything other than the huge blob that there is now[1].  Saying
otherwise is like saying that the uid/gid that owns a file should be
able to be specified by combining things from multiple packages.

> > At the end of the rpm install, postinstall would do an semodule -i 
> > XYZ.pp.
> The ideal order is to install all the policy packages first (shouldn't 
> be too hard to move them to the beginning of the ordered list) and after 
> they are installed do a single transaction to install them all (you have 
> to do something like this regardless due to mutual dependencies) and 
> then proceed to regular packages. This seems much cleaner than the sort 
> of hackery being described here.

If policy packages require running a tool for the policy to be active,
then they fundamentally cannot be at the beginning of a transaction as
the package containing, eg, semodule will need to be installed too.  And
the dep tree cascades down from there.  Plus, special casing policy
packages to be different from every other piece of software shipped is
more hack-ish, not less.

Jeremy

[1] And while it's a huge blob, there will continue to be little to no
movement on actually ensuring that developers develop and maintain their
own policy as a manner of course.  It'll just be that thing that some
other person does.  Which, frankly, doesn't scale any better than it did
2.5 years ago when I said it doesn't work at all.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
