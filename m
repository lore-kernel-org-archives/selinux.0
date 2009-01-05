Subject: Re: transition policy/logic for shell-, perl- and python-scripts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: domg472 g472 <domg472@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <1230404677.2932.19.camel@localhost.localdomain>
References: <1230370454.2932.11.camel@localhost.localdomain>
	 <5aebb9fb0812270301n5dacfe0dr73a71650e1a3c3a0@mail.gmail.com>
	 <1230404677.2932.19.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Jan 2009 10:47:00 -0500
Message-Id: <1231170420.3102.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-12-27 at 20:04 +0100, Stefan Schulze Frielinghaus wrote:
> On Sat, 2008-12-27 at 12:01 +0100, domg472 g472 wrote:
> > A (executable) file is an "entrypoint" for domain transition.
> > 
> > source domain -> executable files type -> target domain
> > 
> > but domain transition is not default behaviour. Remember SELinux is
> > least privilege
> > 
> > 1. deny access ( default )
> > 2. run the executable file in the source domain (can_exec(source
> > domain, executable files type)
> > 3. Transition from a source domain to a target domain though a
> > executable files type ( domain_auto_trans(source domain, executable
> > files type, target domain)
> > 
> > the unconfined domain is designed to NOT transition. unconfined_t is
> > not targeted, in other words it is (for the most part) exempted from
> > SELinux.
> 
> How do you check if an entrypoint exists? Via security_check_context()?
> I couldn't find any other function which could do the job. Or in general
> how would you do it programmatically? What set of functions do you
> recommend?

security_compute_create().  See the rpm_execcon() source code in
libselinux/src/rpm.c for an example, or the compute_create sample
utility in libselinux/utils/compute_create.c.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
