Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB81ImcY026427
	for <selinux@tycho.nsa.gov>; Sat, 7 Dec 2013 20:18:55 -0500
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
	Sat, 7 Dec 2013 18:18:29 -0700
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A380A19D803E
	for <selinux@tycho.nsa.gov>; Sat,  7 Dec 2013 18:18:20 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp07027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rB7NGKIB1376568
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2013 00:16:20 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rB81IQOF019201
	for <selinux@tycho.nsa.gov>; Sat, 7 Dec 2013 18:18:26 -0700
Message-ID: <1386465505.11096.10.camel@dhcp-9-2-203-236.watson.ibm.com>
Subject: Re: kmemleak: filename_trans_read()?
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@parisplace.org>, SELinux List <selinux@tycho.nsa.gov>
Date: Sat, 07 Dec 2013 20:18:25 -0500
In-Reply-To: <1534592.gDiucM3RBN@sifl>
References: <1386192372.20519.91.camel@dhcp-9-2-203-236.watson.ibm.com>
	 <CACLa4ptpQj2NR6f_DnRYnRqpx9mJeFcD8uLGAQ2c=coSCsYwrw@mail.gmail.com>
	 <1534592.gDiucM3RBN@sifl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-12-06 at 17:54 -0500, Paul Moore wrote:
> On Friday, December 06, 2013 08:57:51 AM Eric Paris wrote:
> > Hmmm, it could happen if hashtab_insert failed...
> > 
> > I wonder why we don't check the return value there....
> 
> I noticed the same thing when Mimi and I were talking about this offline.  
> Although, I've got to think that if the hash insert operation was failing we 
> would notice it as the loaded policy would be wonky, wouldn't it?

What's confusing is that policy seems to have loaded.
>From "journalctl -a":

 SELinux:  Permission attach_queue in class tun_socket not defined in policy.
 SELinux: the above unknown classes and permissions will be allowed
 SELinux:  Completing initialization.
 SELinux:  Setting up existing superblocks.
 SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
 SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
 SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
 SELinux: initialized (dev proc, type proc), uses genfs_contexts
 SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
 SELinux: initialized (dev devtmpfs, type devtmpfs), uses transition SIDs
 SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
 SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
 SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
 SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts
 SELinux: initialized (dev devpts, type devpts), uses transition SIDs
 SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses transition SIDs
 SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
 SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
 SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
 SELinux: initialized (dev securityfs, type securityfs), uses genfs_contexts
 SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
 SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
 SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
 SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
 SELinux: initialized (dev pstore, type pstore), uses genfs_contexts
 SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
 SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
 SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
 SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
 SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
 SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
 SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
 SELinux: initialized (dev cgroup, type cgroup), uses genfs_contexts
 SELinux: initialized (dev vda2, type ext4), uses xattr
 type=1403 audit(1386081788.639:3): policy loaded auid=4294967295 ses=4294967295
Dec 03 09:43:09 localhost.localdomain systemd[1]: Successfully loaded SELinux policy in 2.978298s.
Dec 03 09:43:09 localhost.localdomain systemd[1]: Relabelled /dev and /run in 24.555ms.
 SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
 SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses transition SIDs

Let me know if you need anything else.

Mimi


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
