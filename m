Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA11918
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 08:51:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA14647
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 12:51:30 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id MAA14643
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 12:51:29 GMT
Date: Tue, 4 Sep 2001 08:51:42 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Paul Rolland <rol@as2917.net>
cc: selinux@tycho.nsa.gov
Subject: Re: Question regarding security policy configuration
In-Reply-To: <200109021627.SAA09636@donald.oleane.net>
Message-ID: <Pine.SOL.3.95.1010904084649.319D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 2 Sep 2001, Paul Rolland wrote:

> For example, looking at the first one :
> Aug 29 17:58:46 www-dev kernel: avc:  denied  { read write } for  pid=58 
> exe=/bin/mount path=/etc/mtab dev=08:02 ino=166389
> Aug 29 17:58:46 www-dev kernel:    scontext=system_u:system_r:mount_t
> Aug 29 17:58:46 www-dev kernel:    tcontext=system_u:object_r:file_t
> Aug 29 17:58:46 www-dev kernel:    tclass=file
> Aug 29 17:58:46 www-dev kernel:
> 
> I've found in the source tree :
> /bin/mount: system_u:object_t:mount_exec_t
> /etc/mtab: system_u:object_r:etc_runtime_t
> 
> This is different from scontext (Security (?) context) and tcontext
> (Task (?) context)....
> 
> It seems I deeply missed some configs, but I can't find them. Could someone
> help me ?

Do the following:
	cd setfiles
	rm -f relabel
	make relabel

This was step #14 of the README.

The scontext is the source security context, which is typically
the security context of a process (but not always).  The tcontext
is the target security context, which can be the security
context of a target process (e.g. for controlling kill) or
the security context of an object (e.g. for file accesses).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
