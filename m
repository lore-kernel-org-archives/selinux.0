Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5JDB8rT023046
	for <selinux@tycho.nsa.gov>; Sat, 19 Jun 2004 09:11:08 -0400 (EDT)
Received: from zimbo.cs.wm.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5JDAvVl000699
	for <selinux@tycho.nsa.gov>; Sat, 19 Jun 2004 13:10:57 GMT
Date: Sat, 19 Jun 2004 09:09:40 -0400
From: "Serge E. Hallyn" <hallyn@cs.wm.edu>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   "Joshua D. Guttman disp: current" <guttman@mitre.org>,
   "John D. Ramsdell" <ramsdell@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   Amy L Herzog <aherzog@mitre.org>
Subject: Re: Fedora Core 2 setools RPM
Message-ID: <20040619130940.GA4950@escher.cs.wm.edu>
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com> <nhafz8s3f2y.fsf@malabar.mitre.org> <1087584215.27697.173.camel@moss-spartans.epoch.ncsc.mil> <200406191533.22037.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200406191533.22037.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Sat, 19 Jun 2004 04:43, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > A more realistic case is newrole.  user_t -> newrole_t -> sysadm_t is an
> > allowed series of domain transitions, and the only thing preventing
> > jdoe:user_r:user_t from using newrole to get to sysadm_t is the fact
> > that jdoe is restricted to user_r and user_r is restricted to user_t by
> > the kernel policy.  But from an information flow perspective, you simply
> > want to prove that user_t can only reach sysadm_t through specific gate
> > domains like newrole_t.
> 
> One feature I have suggested for policy analysis tools is a method of 
> specifying policy analysis hints in the policy source.
> 
> This would allow specifying newrole_t as a gate domain as well as providing 
> high level assertions about data flow.

In my graphical DTE policy analysis tools, I supported precisely this,
annotating things like "entry program has been verified, so concentrate
on other paths".

With DTE modules, types and domains can be annotated with "assert"
statements, which relay information to arbitrary policy consistency
classes.  For instance, "assert blp trusted" would tell a class checking
for maintenance of BLP type relations across a module application that
this domain or type is trusted.  Of course a class which was checking for
domain transitions could be listening for something like "assert xition
ignore".

The code is just about there to compile DTE modules into SELinux policies.
My SELinux partition decided to throw a hissy before I was able to finish
testing, but I plan to get back to this after this coming week or the next.

I will be talking about DTE (== selinux?) modules on thursday at Usenix Tech.
I would love to chat afterward with anyone who has ideas about how the
module language would need to be changed to actually be of interest to
selinux people, or about why the module language simply sucks.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
