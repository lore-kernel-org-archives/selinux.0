Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA01829
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 15:30:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA03052
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 19:29:45 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA03048
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 19:29:45 GMT
Date: Tue, 9 Jul 2002 15:29:52 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Bergauer <privateryan@mindspring.com>
cc: <selinux@tycho.nsa.gov>
Subject: RE: quota and ampd (and one more thing)
In-Reply-To: <000701c2277d$cf5f9be0$6501a8c0@donkey>
Message-ID: <Pine.GSO.4.33.0207091524380.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 9 Jul 2002, Ryan Bergauer wrote:

> Here are four of the ones appearing at boot. They're pretty
> representative of the rest.
>
> avc:  denied  { getattr } for  pid=712 exe=/sbin/killall5 path=/1/stat
> dev=00:03 ino=65547 scontext=system_u:system_r:apmd_t
> tcontext=system_u:system_r:init_t tclass=file

I see.  If apmd needs to be able to kill all processes, you'll need to add
permissions to permit it to access all /proc/PID directories and to send
signals to all processes, e.g.:
	allow apmd_t domain:{ file lnk_file } r_file_perms;
	allow apmd_t domain:dir r_dir_perms;
	allow apmd_t domain:process signal_perms;

> Also, I tried running run_init this morning and received the message
> (after authentication):
>
> execvp_secure: No such file or directory
>
> Has anyone encountered this?

This indicates that you specified a non-existing path as the script name
for run_init.  Or at least that run_init was unable to find it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
