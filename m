Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i39CJcRb024206
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 08:19:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i39CJbmw012646
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 12:19:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i39CJb4w012643 for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 12:19:37 GMT
Subject: Re: initial load_policy problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Rogelio Serrano <rogelio@smsglobal.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6747e616269756e7e9c1174c695478e2@debian>
References: <6747e616269756e7e9c1174c695478e2@debian>
Content-Type: text/plain
Message-Id: <1081513170.8524.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 09 Apr 2004 08:19:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-04-09 at 06:37, Rogelio Serrano wrote:
> How long after the policy load is /dev/console supposed to
> become console_device_t? immediately after policy load the
> label of /dev/console is system_u:system_r:kernel_t.

No it isn't.  The label of the open file description is kernel_t, since
it was opened by a kernel thread, but the label of the device inode is
console_device_t.  Remember that SELinux labels and controls open file
descriptions (the state referenced by a file descriptor) as well as
files themselves, because they can be shared among processes.  The open
file descriptions are labeled based on the process that performed the
open, so when an initial kernel thread opens /dev/console, the open file
is labeled kernel_t.

> avc: denied { use } for pid=18 exe=/bin/bash path=/dev/console
> dev=hda16 ino=17895218 scontext=system_u:system_r:initrc_t
> tcontext=system_u:system_r:kernel_t tclass=fd

Look closely at the above avc message.  The tclass is "fd" (file
descriptor, or more accurately, open file description); the permission
is "use".  The question is whether initrc_t should be inheriting this
descriptor, not whether it can access /dev/console (the latter is also
checked, but is likely allowed).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
