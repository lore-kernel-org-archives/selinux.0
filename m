Subject: Re: udp receive
From: Timothy Wood <timothy@hallcomp.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0207031002290.29509-100000@raven>
References: <Pine.GSO.4.33.0207031002290.29509-100000@raven>
Content-Type: text/plain
Date: 03 Jul 2002 12:39:36 -0400
Message-Id: <1025714377.3620.18.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I need more detail from the audit message, in particular the two types
> from the scontext and tcontext fields. 

avc:  denied  { recvfrom } for  pid=1791 exe=/usr/sbin/rpc.rquotad
saddr=127.0.0.1 source=696 daddr=127.0.0.1 dest=111 netif=lo
scontext=system_u:system_r:portmap_t tcontext=root:sysadm_r:sysadm_t
tclass=udp_socket


> The can_udp_send macro
> (defined in macros/global_macros.te) grants appropriate permissions for
> the sender domain and the receiver domain, so you likely just need a
> can_udp_send macro between the particular sender and receiver.  Of course,
> this is only significant for loopback communication (or if you are using

It looks to me like it's loopback between the rpc quota daemon and the
portmapper.

> By the way, please note that the rpcd_t domain is simply a placeholder
> for rpc daemons, and that you should really define an individual
> domain for any rpc daemon that requires privilege (e.g. nfsd).  You
> should also consider limiting this domain to true least privilege by
> removing every_domain and only adding the bare minimum set of
> permissions needed for operation.

Is there a template I could use or could someone please explain how to
go about creating a new domain?  I understand how to do some basic
modifications so far but I'm no expert yet.  Thanks


Timothy,



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
