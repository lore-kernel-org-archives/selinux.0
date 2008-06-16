Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5GLv34T017629
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 17:57:03 -0400
Received: from smtp110.prem.mail.sp1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5GLv2vV009121
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 21:57:02 GMT
Message-ID: <4856E19B.1060000@schaufler-ca.com>
Date: Mon, 16 Jun 2008 14:56:43 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        dwalsh@redhat.com, cpebenito@tresys.com
Subject: Re: [PATCH-v2] SELinux: allow fstype unknown to policy to use xattrs
 if present
References: <1213648942.3029.85.camel@localhost.localdomain>
In-Reply-To: <1213648942.3029.85.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> Currently if a FS is mounted for which SELinux policy does not define an
> fs_use_* that FS will either be genfs labeled or not labeled at all.
> This decision is based on the existence of a genfscon rule in policy and
> is irrespective of the capabilities of the filesystem itself.  This
> patch allows the kernel to check if the filesystem supports security
> xattrs and if so will use those if there is no fs_use_* rule in policy.
> An fstype with a no fs_use_* rule but with a genfs rule will use xattrs
> if available and will follow the genfs rule

Have you tried this with ntfs-3g and unionfs? I don't
think you'll have a problem with ntfs-3g, but if your
code works properly on getxattr on unionfs I'd be mildly
surprised. Pleased mind you, because then I could look
at your code and see what I've done wrong, but surprised
nonetheless.


-- 

----------------------

Casey Schaufler
casey@schaufler-ca.com
650.906.1780



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
