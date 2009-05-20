Subject: Re: Policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200905202257.08555.linuxweb@gmx.net>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <200905202242.37606.linuxweb@gmx.net>
	 <1242830433.20082.402.camel@localhost.localdomain>
	 <200905202257.08555.linuxweb@gmx.net>
Content-Type: text/plain
Date: Wed, 20 May 2009 10:59:13 -0400
Message-Id: <1242831553.20082.406.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 22:57 +0800, Dennis Wronka wrote:
> Okay, here we go:
> 
> I unmounted /selinux and then got this:
> load_policy: Can't load policy: Invalid argument
> 
> I attached my kernel-config and the two traces (trace1 for the "Device or 
> resource busy"-error, trace2 for the "Invalid argument"-error).

Ahem.  Your kernel config has these SELinux options:
CONFIG_SECURITY_SELINUX=y
# CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
# CONFIG_SECURITY_SELINUX_DISABLE is not set
# CONFIG_SECURITY_SELINUX_DEVELOP is not set
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set

Note that your kernel config does not support:
1) The selinux= kernel boot parameter
(CONFIG_SECURITY_SELINUX_BOOTPARAM),
2) The ability to disable SELinux from /sbin/init based on
SELINUX=disabled in /etc/selinux/config
(CONFIG_SECURITY_SELINUX_DISABLE),
3) Permissive mode (CONFIG_SECURITY_SELINUX_DEVELOP)

Is that what you intended?  IOW, you cannot boot permissive, and the
load policy logic is failing when it tries to switch to permissive mode
(write to /selinux/enforce).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
