Date: Mon, 26 Aug 2002 13:51:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: openssh (run_init messages)
In-Reply-To: <1030380325.29145.92.camel@phobos>
Message-ID: <Pine.GSO.4.33.0208261350320.24426-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 26 Aug 2002, Timothy Wood wrote:

> avc:  denied  { transition } for  pid=1125
> exe=/usr/local/selinux/sbin/run_init path=/etc/rc.d/init.d/sshd
> dev=03:06 ino=18409 scontext=timothy:sysadm_r:sysadm_t
> tcontext=system_u:system_r:initrc_t tclass=process

This implies that run_init isn't labeled properly.  To fix by hand, use
chcon system_u:object_r:run_init_exec_t /usr/local/selinux/sbin/run_init.
As I recall, I posted a patch for run_init.fc for the prior release long
ago that fixed this error.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
