Subject: Re: IPC security context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
        Steve G <linux_4ever@yahoo.com>, andy.suchoski@comcast.net,
        selinux@tycho.nsa.gov
In-Reply-To: <200609081005.37716.russell@coker.com.au>
References: <20060907210503.73467.qmail@web51510.mail.yahoo.com>
	 <200609081005.37716.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 09:25:01 -0400
Message-Id: <1157721901.31695.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-08 at 10:05 +1000, Russell Coker wrote:
> On Friday 08 September 2006 07:05, Steve G <linux_4ever@yahoo.com> wrote:
> > >To re-add, we would need a specific application that required such
> > > support.
> >
> > Would ipcs be that app?
> 
> I believe so.
> 
> I am currently working on writing policy for some proprietary software that 
> uses a lot of shared memory and semaphores.  The inability to display 
> contexts through ipcs is a significant obstacle for me in this work.

I'm a bit skeptical that ipcs itself is sufficient motivation, as one
can always make use of audit configuration (whether via auditallow in
policy or auditctl with the enhanced syscall audit that includes
contexts) to see the object contexts in the audit logs for development
purposes.  The motivating application would have to be software that is
actually using the IPC objects and needs to get or set the context of
those objects, and at least one such application would likely need to be
open source to serve as a compelling example for upstream.  See the
earlier discussion about adding a /proc/self/attr/ipccreate node on this
list and in redhat bug 197114; the same issue applies there.

Note that I'm not the obstacle here - I would be happy to see the entire
original SELinux API revived (in a different form that is acceptable
upstream, naturally, but equivalent in functionality to the old API),
but at the time we were forced to refactor the SELinux API (upon removal
of sys_security in 2.5), we were told that we needed real examples of
users for any interfaces we added.  Hence, we limited ourselves to the
process, file, and security interfaces, then added other interfaces as
needed (e.g. getpeercon).

If we want to go down this road, I think we need two things:
1) A concrete proposal on what such interfaces should look like, taking
into consideration the factors that led to the rejection of the original
API.  Offhand, I'd think that the approach most in line with the
existing IPC interfaces would be a new cmd value for msgctl, semctl, and
shmctl that gets the context, calling into the security module to obtain
the value, modeled on getpeercon.
2) A real user of such interfaces to demonstrate that they will be used
and that we at least have some evidence that the interface is correct
for the intended usage and won't have to immediately change when a real
user manifests.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
