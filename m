Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LE2dH1009708
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 09:02:39 -0500
Received: from web51508.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1LE3uMD025731
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 14:03:56 GMT
Date: Wed, 21 Feb 2007 06:03:52 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: libselinux patch
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1172065357.14363.273.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <948733.27387.qm@web51508.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> >At present, libselinux dynamically determines where selinuxfs is mounted
>> >via /proc/mounts in init_selinuxmnt() and uses that path for all calls
>> >that operate on selinuxfs.
>> 
>> I guess that path could be used for statfs?
>
>That still leaves you with a dependency on successfully
>reading /proc/mounts and allocating memory, so no different than
>reading /proc/filesystems as far as robustness goes.

Actually, you could guess "/selinux" and drop back to dynamically determining if
that failed. that would get that call down to 1 syscall, too. I'd say 99.99% of
the time it would be the right guess. Only at boot, shutdown, or a strange chroot
config would there be a possibility of something different.

>is_selinux_enabled() should never be on a critical path (should
>always be called during startup by a program and saved for later
>use in a variable).

Every selinux aware app checks it and it could short circuit seeveral syscalls to
get the right answer.

-Steve


 
____________________________________________________________________________________
TV dinner still cooling? 
Check out "Tonight's Picks" on Yahoo! TV.
http://tv.yahoo.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
