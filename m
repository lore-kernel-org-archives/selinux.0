Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11060
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 12:51:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA09739
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 17:50:31 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA09735 for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 17:50:30 GMT
Date: Fri, 18 Jan 2002 12:50:46 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: devfs_contexts
In-Reply-To: <20020118171920.F3E3C3918E4@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0201181241010.3743-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 18 Jan 2002, Russell Coker wrote:

> OK.  I've just used chsid as I can't find chcon.  Is chcon still in the
> source distribution?  If so where?

chcon is in the modified fileutils package.  But you can also use chsid or
setfiles to label existing devfs nodes - all three programs invoke the
chsid system call to set the label on a file when run on a SELinux kernel.
chcon is merely a nicer interface than chsid that is derived from the
existing chmod/chown programs in fileutils.

For filesystems that use the persistent label mapping (e.g. ext2, ext3,
reiserfs), the label will set by the chsid call be retained across reboots
since it is stored in that mapping.  For pseudo filesystems like devfs,
the label won't be retained across reboots unless you also add it to
devfs_contexts, because there is no persistent storage of the label.  So,
if you want the labels to persist, you'll need to update devfs_contexts
and then reboot.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
