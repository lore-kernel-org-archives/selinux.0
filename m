Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA20092
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 08:36:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA20287
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 13:35:26 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id NAA20283
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2001 13:35:26 GMT
Date: Fri, 14 Dec 2001 08:35:35 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Strange behavior (?)
In-Reply-To: <1008318406.1624.1.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0112140817110.24054-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 14 Dec 2001, Justin Smith wrote:

> It seems that my system occasionally toggles into permissive mode for no
> apparent reason.

The only situations where the SELinux development module should revert to
permissive mode after being toggled into enforcing mode are:
1) when you reboot the system,
2) when you run avc_toggle from a domain that has avc_toggle permission
(the initrc_t domain and the sysadm_t domain in the example policy).

When you next encounter this behavior, please verify that your system
wasn't rebooted (e.g. last reboot) and that no one ran avc_toggle again.
To verify that no one ran avc_toggle, add an auditallow rule so that it
will be audited when it is allowed as well as when it is denied:
	auditallow { initrc_t admin } kernel_t:system avc_toggle;

You should then see the following message when an avc_toggle occurs:
	avc:  granted { avc_toggle } for ...

> Also, whenever I reboot, it seems to boot up in permissive mode. Is this
> normal behavior? Is there a way to configure it to boot in enforcing
> mode?

Yes, this is the normal behavior.  Please read the help text for the NSA
SELinux Development Module option (select help from the 'make menuconfig'
when you are looking at that option, or just read it directly from the
Documentation/Configure.help file).  As noted there, you can either put
avc_toggle in an rc script to switch into enforcing mode while booting
(leaving open the option of later switching back to permissive mode from
an authorized domain) or you can rebuild the kernel without the option (in
which case the kernel will always be enforcing and cannot be toggled).  If
you do the latter, be sure to keep a copy of a development kernel
available so that you can do emergency recovery if you mess up your
policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
