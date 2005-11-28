From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Guillaume PETITJEAN'" <guillaume.petitjean@st.com>
Cc: "'selinux'" <selinux@tycho.nsa.gov>
Subject: RE: link between roles and domains
Date: Mon, 28 Nov 2005 11:41:52 -0500
Message-ID: <023901c5f43a$a315e9d0$6c0d010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1133192777.348.117.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Stephen Smalley
> Sent: Monday, November 28, 2005 10:46 AM
> To: Guillaume PETITJEAN
> Cc: selinux
> Subject: Re: link between roles and domains
> 
> On Mon, 2005-11-21 at 09:22 +0100, Guillaume PETITJEAN wrote:
> > Hello,
> >
> > I'm new to SELinux.
> >
> > I have a question regarding the management of users and roles.
> >
> > I understood that a user is associated with a role (or several roles)
> > and that each role is allowed to enter a set of domain. I understood
> > how access control permissions are defined on couple of domains and the
> > process of domain transitions. But I didn't understand which domain
> > (among the set of domains allowed for a role) is selected at any time.
> >
> > In other terms let's say you have a process foo belonging to the role
> > user_r and suppose user_r is allowed for (domain1_t, domain2_t,
> > domain3_t), how does the policy decides to which domain will belong the
> > process in practice in order to compute security decisions ?
> 
> The security context of a user process is set up by some "entrypoint"
> program, like login or sshd, by querying libselinux for an ordered list
> of reachable security contexts from the entrypoint process for the user.
> libselinux consults the kernel security server via selinuxfs as well as
> a default_contexts configuration to generate and order this list.  The
> kernel security server computes reachability based on process transition
> permission from the context of the entrypoint process to contexts for
> the user.
> 
> Once the security context has been initially set for the user process,
> any subsequent domain transitions are governed by the policy based on
> the usual (file:execute, process:transition, file:entrypoint) triple.
> Any accesses by a process are governed by the domain stored in its
> security context.  A process may only have a single domain in its
> security context at any given time.
> 

These slides give an overview of domain transitions and include information
about how users and roles further restrict the allowed domain transitions.
http://www.tresys.com/files/course/03-PolicyConcepts.pdf. They are part of
our SELinux training (more info and the rest of the slides are at
http://www.tresys.com/selinux/).

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
