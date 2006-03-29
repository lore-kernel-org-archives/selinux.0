Subject: Re: ANN: Fedora Core 5 SELinux FAQ
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: "Stephen J. Smoogen" <smooge@gmail.com>
Cc: Chad Sellers <csellers@tresys.com>, fedora-selinux-list@redhat.com,
        SELinux@tycho.nsa.gov, selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <1143654814.24555.21.camel@moss-spartans.epoch.ncsc.mil>
References: <4429E6B6.7040108@tresys.com>
	 <80d7e4090603290919j7fbe917ctb8e0fbd1e83a02d8@mail.gmail.com>
	 <1143654814.24555.21.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 13:03:24 -0500
Message-Id: <1143655404.24555.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-29 at 12:53 -0500, Stephen Smalley wrote:
> > Q: What is the Reference Policy?
> > 
> >   [I found I am really confused by this answer.. if my muddled brain
> > is getting this correct.. the Reference Policy is the base policy that
> > the Fedora Core 5 targeted, strict, mls policies are based off of the
> > Reference Policy.. or are there 2 sets of policies shipped with Fedora
> > Core 5 some of which are based off of the old set and the others by
> > the new set.]
> 
> Reference policy is the new source policy tree from which all policy
> types (-strict, -targeted, -mls) are being built.  Previously, they were
> being built from the NSA example policy source tree.

I'm guessing that you were confused by this statement from the FAQ:
"Fedora policies at version 1.x are based on the traditional example
policy. Version 2.x policies (as used in Fedora Core 5) are based on the
Reference Policy."

This doesn't mean that there are two branches of policy (1.x and 2.x)
being carried in FC5; FC5 only has version 2.x.y policies based on
refpolicy.  The above statement from the FAQ just means that when the
developers switched from using example policy to reference policy as
their source base during development of FC5, they changed the package
version from being a 1.x series to being a 2.x series to signify that a
major change had occurred.  So when you see a policy package that has a
1.x version, you know you are dealing with a policy built from example
policy (as in FC4, RHEL4, FC3), and when you see a 2.x version, you know
you are dealing with a policy built from refpolicy (as in FC5 and
everything going forward).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
