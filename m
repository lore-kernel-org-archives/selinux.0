From: "Frank Mayer" <mayerf@tresys.com>
To: <selinux@netgps.net>, <SELinux@tycho.nsa.gov>
Subject: RE: Process Transition
Date: Wed, 14 May 2003 21:13:25 -0400
Message-ID: <001001c31a7f$33327760$6701a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.33.0305141431210.16852-100000@GPS1.NETPGS.NET>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> avc:  denied  { transition } for  pid=1 comm=swapper path=/sbin/init /
> dev=08 :01 ino=229436 scontext=system_u:system_r:kernel_t /
> tcontext=system_u:system_r:init_t tclass=process
> 
> I have the following line in the policy.conf (post make install-src
> install, of course): 
> 
> allow kernel_t init_t:process transition;

The deny audit message seems to indicate that the above rule is indeed
*not* in the running policy???  Are you sure?  Perhaps there's a problem
with role allow and/or user definitions, but I thought they just
indicated an invalid context not a transition permission denied.

> 
> In Frank Mayer's post about domain transitions,
> 
> http://www.nsa.gov/selinux/list-archive/3984.html
>
> he states that program entry and program execute rules are also
> required. I have the following rules:

> allow init_t init_exec_t:file entrypoint;
> allow init_t init_exec_t:file { read getattr lock execute ioctl };

I think you have a slight misunderstanding.  For a domain transition:

1. OLD domain has "file execute" access to entry type (i.e.,
init_exec_t)
2. NEW domain has "file entrypoint" access to entry type.

in addition to the process transition permission above.

Frank 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
