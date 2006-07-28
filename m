From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH] SELinux: new /proc/self/attr/ipccreate for expliciteipc object labeling
Date: Fri, 28 Jul 2006 15:23:20 +1000
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov, jbrindle@tresys.com
References: <6FE441CD9F0C0C479F2D88F959B015882989A9@exchange.columbia.tresys.com> <1154019529.5028.19.camel@localhost.localdomain> <Pine.LNX.4.64.0607280018180.13981@d.namei>
In-Reply-To: <Pine.LNX.4.64.0607280018180.13981@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607281523.24488.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 28 July 2006 14:19, James Morris <jmorris@namei.org> wrote:
> On Thu, 27 Jul 2006, Eric Paris wrote:
> > At this point in time SysV IPC objects (semaphores, message queues, etc)
> > are labeled with the label of the process which created them.  This
> > patch introduces a new /proc/self/attr/ipccreate which will allow a
> > program to set the label on ipc objects it is about to create.  This may
> > be useful in future trusted applications but at this time I do not know
> > of any application which needs this functionality.
>
> This makes it difficult to justify upstream.

The X server creates shared memory regions that are used by the user.

If the X server is run from xdm_t then the user needs access to 
xdm_xserver_t:shm, which means that multiple roles can communicate via that 
shared memory type.

It seems ideal to me to have the X server create shared memory regions on 
behalf of the user with user_t as the type.  At the moment this would not be 
convenient, but when we get Security Enhanced X going (something that I want 
to work on when I get Debian SE Linux in a good shape again) it will be 
practical.

I believe that PostgreSQL will on occasion perform operations that operate in 
a similar manner but don't have proof.

IMHO the X server alone is enough justification for this feature.  PostgreSQL 
is merely supporting evidence of such interfaces being a reasonable way of 
solving certain classes of problem.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
