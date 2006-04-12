Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3CGxQ7Y017992
	for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2006 12:59:26 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3CGxOSk005231
	for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2006 16:59:24 GMT
Subject: Re: Latest Updates
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <443BAE44.3060508@redhat.com>
References: <443BAE44.3060508@redhat.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 13:01:34 -0400
Message-Id: <1144861294.29499.20.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

Why is the range transition needed for secadm running auditctl_exec_t?
Why are the mls_* interfaces insufficient?

On Tue, 2006-04-11 at 09:25 -0400, Daniel J Walsh wrote:
> Added policy for ada to be allowed execmem privs (gnat)

Since this is only a policy for targeted, I ifdef'ed the file contexts
for targeted so that files don't get this label if the module
accidentally is added to a strict policy.

> New mono apps are communicating with userspace via dbus.  So need dbus 
> capabilities.

I rewrote this to use the established interfaces rather than creating a
new one.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
