Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA01691
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 09:05:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA23057
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 13:04:01 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA23053 for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 13:04:01 GMT
Date: Tue, 28 May 2002 09:04:47 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: devfs mysterious relabelling
In-Reply-To: <20020524210438.2313E15EB@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205280903080.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 24 May 2002, Russell Coker wrote:

> On my systems I have devfsd do most of the device node labelling.
>
> I have noticed that often the system_u:object_r:fixed_disk_device_t labels
> (for /dev/ide/host0/bus0/target0/lun0/*) will get changed to
> system_u:object_r:devfs_t (the default context for devfs).
>
> It doesn't happen to the device node for the entire file system
> /dev/ide/host0/bus0/target0/lun0/disc and the device node
> /dev/ide/host0/bus0/target0/lun0/part5 (an extended partition).
>
> I believe that this is not a user-land issue, and it's something in the
> kernel (but I have not proven this yet).
>
> Also it seems to happen more often when under load (setfiles on the root file
> system usually does the job).

This could happen if a devfs entry is evicted from the dcache and is later
looked up again, causing the security context to be re-acquired from the
devfs_contexts configuration.  Doesn't this issue also arise for the
ownership and mode on devfs entries when they are managed by devfsd?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
