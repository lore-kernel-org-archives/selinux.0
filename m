Message-Id: <200506102105.j5AL5A5F003141@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   <selinux-dev@tresys.com>
Subject: RE: Restorecon script
Date: Fri, 10 Jun 2005 17:05:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1118436336.4812.9.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, June 10, 2005 4:46 PM
> To: Karl MacMillan
> Cc: 'Stephen Smalley'; 'Joshua Brindle'; 'Daniel J Walsh'; 'SELinux'; selinux-
> dev@tresys.com
> Subject: RE: Restorecon script
> 
> 
> > All applications are vulnerable and malicious code will run in this domain
> at
> > some point. This is about what happens when that eventually happens. I'm
> just
> > clarifying what the goals of these changes are.
> 
> The way to fix that is to put the applications in a restricted domain,
> not to make user_t that restricted domain, by refusing to grant the
> user relabel rights to files that he/she should have access to.
> 

This has nothing to do with whether the user should or should not have access -
it is about limiting the trust placed in code running on the user's behalf.

Creating more least-privilege code limits the damage from malicious code,
certainly, but in this case it doesn't fix all problems. Some code will be run
in the user domain that will be exploitable or the user will simply run a
Trojan. At that point the malicious code running in user_t can, for example,
disclose sensitive user data by either moving it or relabeling it so that an
application like apache can read it. This can potentially be addressed but it
will be enormously difficult and time consuming.

> > > Please note that *recursive* relabeling is only performed if
> > > relabeling of a top level directory (in that list) fails. Therefore
> > > it's not all that slow. Do you have an alternative proposal?
> > >
> >
> > I'm not concerned about the performance. Relabeling always has risks and
> > complicates analysis of security policies - I think it is best avoided
> except
> > under special circumstances. This is really the point that started this
> whole
> > thread - relabeling should be treated as a special case if at all possible.
> 
> The script was mostly concerned with creating things in the right
> context to begin with. It would be easy to modify it to not relabel
> anything if it locates a folder that's in the wrong context, but
> I'm not sure whether that should be done - seems to me like
> the wrong context should be fixed.
> 
> > The alternative is to do this at package installation time. This would
> allow,
> > for example, for an admin to verify that it is safe to relabel and
> potentially
> > take the system off line.
> 
> How exactly would this be done at installation time, in such a manner
> as to account for existing users?

A post install script that creates directories and/or relabels existing
directories.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
