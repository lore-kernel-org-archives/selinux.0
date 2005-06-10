Message-Id: <200506101958.j5AJwc5F002311@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   <selinux-dev@tresys.com>
Subject: RE: Restorecon script
Date: Fri, 10 Jun 2005 15:58:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1118427661.3720.36.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, June 10, 2005 2:21 PM
> To: Karl MacMillan
> Cc: 'Stephen Smalley'; 'Joshua Brindle'; 'Daniel J Walsh'; 'SELinux'; selinux-
> dev@tresys.com
> Subject: RE: Restorecon script
> 
> 
> > Or only giving the read access I assume. So we are not trying to protect
> from
> > malicious code running in the user's domain disclosing data by relabeling to
> > httpd_user_content_t, for example?
> 
> Malicious code should not be running in the user_t domain.
> the user_t domain is highly privileged, and we should try to keep
> malicious code out of it. That's why most vulnerable applications
> are being placed in restricted domains.
> 

All applications are vulnerable and malicious code will run in this domain at
some point. This is about what happens when that eventually happens. I'm just
clarifying what the goals of these changes are.

> I don't think there's much we can do to protect from the user domain,
> since it also represents the actual user, working from the terminal,
> which must be allowed to do what he/she desires.
> 

Depends on the system - not all users get to do what they want on all systems .
. .

> > If that is the case the user domain is
> > trusted to manage these files at their discretion. One point I was trying to
> > make is that this probably has to be the case as removing relabel permission
> > from the user domain has no impact.
> 
> The user domain actually didn't have too many relabel privileges, until
> I added them just now to our version of policy.
> 
> > Relabeling on every login still seems excessive and based on what this
> policy is
> > trying to accomplish perhaps not a good idea.
> 
> Please note that *recursive* relabeling is only performed if
> relabeling of a top level directory (in that list) fails. Therefore
> it's not all that slow. Do you have an alternative proposal?
> 

I'm not concerned about the performance. Relabeling always has risks and
complicates analysis of security policies - I think it is best avoided except
under special circumstances. This is really the point that started this whole
thread - relabeling should be treated as a special case if at all possible.

The alternative is to do this at package installation time. This would allow,
for example, for an admin to verify that it is safe to relabel and potentially
take the system off line.

> >  If the files are under the user's
> > control then they should be fully under their control.
> 
> The way to do that is by integrating ugly libselinux code into
> a large number of applications. I think this will not be
> well received by the upstream developers at this time.
> 
> > What if I am waiting to
> > relabel my ~/public_html until I am done with the content and this
> administrator
> > controlled script does it for me?
> 
> The script is only invoked when you launch a login shell (this is
> actually a problem). Also, it does not do anything with public_html.

Public_html is just an example - replace it with .ssh if you want.

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
