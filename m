Date: Fri, 5 Jul 2002 08:33:35 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <gdsmarshall@hushmail.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: This does not look correct....
In-Reply-To: <200207041319.g64DJ8448572@mailserver2.hushmail.com>
Message-ID: <Pine.GSO.4.33.0207050830480.29942-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 4 Jul 2002 gdsmarshall@hushmail.com wrote:

> I know I have not been trying to configure SELinux for very long, but this does not look correct to me.  Should ssh have a getty_t definision?  I know it needs one to prevent this error message, but is it correct for ssh to have a getty_t definision?
>
> Jul  4 08:05:33 gatekeeper kernel: avc:  denied  { use } for  pid=339 exe=/usr/b
> in/ssh path=/dev/tty3 dev=03:01 ino=71770 scontext=root:sysadm_r:sysadm_ssh_t tc
> ontext=system_u:system_r:getty_t tclass=fd
>
> I am running debian (woody), with kernel from NSA, and packages from Russell's site.

This indicates that the ssh client program is inheriting a descriptor
originally opened by getty.  This doesn't show up on our RedHat systems -
we only need to grant fd use permission to the login domains
(local_login_t), but it seems harmless to grant this permission.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
