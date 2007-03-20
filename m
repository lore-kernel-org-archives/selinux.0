Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2KGvO0a024071
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 12:57:24 -0400
Received: from web86902.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2KGvMuO015358
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 16:57:23 GMT
Date: Tue, 20 Mar 2007 16:57:01 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: Confirmation about task_has_security in selinuxfs.c
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1173798480.2068.51.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <613217.17683.qm@web86902.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,
> Perhaps an example would make things clearer. 
> During open(2)
> processing, the fs/namei.c:permission() function is
> called to check
> permissions.  That function first applies the usual
> Linux checks,
> including DAC checks, and, if they pass, the
> function then calls the LSM
> security_inode_permission() hook, which is defined
> by
> include/linux/security.h.  

Within the fs/namei.c, there are two functions defined
for calling fs/namei.c:permission(), one is int
vfs_permission(struct nameidata *nd, int mask) and the
other is int file_permission(struct file *file, int
mask).

My question is that, which of the above two functions
is used to call fs/namei.c:permission() function in
the Linux 2.6 kernel, and which way is followed by
SELinux.

Best,
MA
















If using SELinux, this
> hook will call
> selinux_inode_permission() in
> security/selinux/hooks.c, which calls
> inode_has_perm(), which calls avc_has_perm() in
> security/selinux/avc.c.
> That is the access vector cache.  If there is a
> cache miss, then
> avc_has_perm_noaudit() in avc.c will call
> security_compute_av() to get
> the decision from the security server.  selinuxfs is
> not involved in
> that code path.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the
> selinux mailing list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as
> the message.
> 



		
___________________________________________________________ 
Now you can scan emails quickly with a reading pane. Get the new Yahoo! Mail. http://uk.docs.yahoo.com/nowyoucan.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
