Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7CJmLrT019454
	for <selinux@tycho.nsa.gov>; Thu, 12 Aug 2004 15:48:21 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7CJmLBo021234
	for <selinux@tycho.nsa.gov>; Thu, 12 Aug 2004 19:48:21 GMT
Subject: Re: device types
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <rcoker@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200408101539.14895.rcoker@redhat.com>
References: <200408101539.14895.rcoker@redhat.com>
Content-Type: text/plain
Message-Id: <1092340025.16219.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 15:47:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-10 at 01:39, Russell Coker wrote:
> /u?dev/irlpt[0-9]+     -c      system_u:object_r:tty_device_t
> 
> Wouldn't it be more appropriate to have irlpt be printer_device_t?
> 
> /u?dev/md.*            -c      system_u:object_r:fixed_disk_device_t
> 
> In what situation will a /dev/md* device node be a character device?  The 
> block devices are already labelled.  The only device nodes of class chr_file 
> labelled with fixed_disk_device_t are for raw devices and a flash device, 
> probably neither of which will work properly due to lack of policy.
> 
> 
> I have attached a patch which fixes these problems and a couple of other minor 
> issues (including making the /dev/*nrft* entries only take one line) and 
> adding an entry for /dev/dm-* (which LVM on Fedora seems to create).
> 
> Finally I've added a solution to the BSD pty issue.  I've labelled all the 
> device nodes as bsdpty_device_t and made domains that don't use such nodes 
> have dontaudit rules for them.  This stops programs like sshd from trying all 
> of the BSD pty's first and filling the audit logs for no good cause.

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
