Date: Sun, 16 Dec 2001 18:18:29 -0800
From: Paul Krumviede <pwk@acm.org>
To: Shaun Savage <savages@pcez.com>, SELinux@tycho.nsa.gov
Subject: Re: iptables.te  errors
Message-ID: <136657933.1008526709@localhost>
In-Reply-To: <3C1CE2BD.20707@pcez.com>
References: <3C1CE2BD.20707@pcez.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Sunday, 16 December, 2001 10:06 -0800 Shaun Savage <savages@pcez.com> 
wrote:

> HI
> I am having a hard time with getting courier to work that I decided to
> try somwthing easier. iptables. Attached is the te file that I am using.
> During make load I get the error
>
> security: context system_u:system_r:iptables_t is invalid

iptables_t needs to be added to the allowed set of types
for the system_r role. this can be done in policy/rbac or
it can be added to iptables.te (i prefer the latter since
it makes the .te file relatively self-contained, but at the
expense of not having all the allowed types for a given
role in one place to look at; tastes may vary).

> the during the command iptables -t nat -L
> I get the errors
> avc: denied { create } for pid=9757 exe=/sbin/iptables
> scontext=root:sysadmin_r:sysadmin_t tcontext=root_u:sysadm_r:sysadm_t
> tclass=rawip_socket avc: denied { getopt } for pid=9757
> exe=/sbin/iptables scontext=root:sysadmin_r:sysadmin_t
> tcontext=root_u:sysadm_r:sysadm_t tclass=rawip_socket

there is no rule to change the domain of the process when
iptables is run in the system administrator role (nor does
there seem to be domain transition rule for when ipchains
is run by init). this could be added in policy/domains/admin/sysadm.te
or in iptables.te (similarly, a domain transition rule could be added
to policy/domains/system/initrc.te or to iptables.te).

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
