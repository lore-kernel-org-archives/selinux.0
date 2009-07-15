Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6GBtnB5028201
	for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2009 07:55:50 -0400
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6GBtSS6012679
	for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2009 11:55:28 GMT
Received: by ey-out-1920.google.com with SMTP id 3so16522eyh.30
        for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2009 04:55:48 -0700 (PDT)
Message-ID: <4A5E4E8A.3090407@gmail.com>
Date: Wed, 15 Jul 2009 14:47:54 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Subject: Re: [refpolicy] refpolicy moved to git
References: <1247514939.31521.30.camel@gorn.columbia.tresys.com>
In-Reply-To: <1247514939.31521.30.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> The Reference Policy repository has been moved over to git.  The new
> repository can be cloned by:
>
> git clone http://oss.tresys.com/git/refpolicy.git
>
> The subversion repository will remain as it still has history on old
> branches and a few other items which were not propagated over to the git
> repository.  However the subversion repository will no longer be
> updated.
>
>    
Alright finally no more svn(hated to compile that from source)
SELinux looks good:

  uname -r
2.6.31-rc3-00040-g78d802d

dmesg | grep SELinux

[    0.000692] SELinux:  Initializing.
[    0.000706] SELinux:  Starting in enforcing mode.
[    0.573419] SELinux:  Registering netfilter hooks.
[    2.224123] SELinux: 8192 avtab hash slots, 156371 rules.
[    2.360334] SELinux: 8192 avtab hash slots, 156371 rules.
[    2.595788] SELinux:  7 users, 13 roles, 2840 types, 105 bools
[    2.612247] SELinux:  74 classes, 156371 rules
[    2.637378] SELinux:  Completing initialization.
[    2.654067] SELinux:  Setting up existing superblocks.
[    2.698848] SELinux: Initialized (dev sda3, type ext3), uses xattr
[    2.716222] SELinux: Initialized (dev selinuxfs, type selinuxfs), 
uses genfs_contexts
[    2.733764] SELinux: Initialized (dev mqueue, type mqueue), uses 
transition SIDs
[    2.751185] SELinux: Initialized (dev hugetlbfs, type hugetlbfs), 
uses genfs_contexts
[    2.768865] SELinux: Initialized (dev devpts, type devpts), uses 
transition SIDs
[    2.786455] SELinux: Initialized (dev inotifyfs, type inotifyfs), 
uses genfs_contexts
[    2.804309] SELinux: Initialized (dev tmpfs, type tmpfs), uses 
transition SIDs
[    2.822384] SELinux: Initialized (dev anon_inodefs, type 
anon_inodefs), uses genfs_contexts
[    2.840813] SELinux: Initialized (dev pipefs, type pipefs), uses task 
SIDs
[    2.840822] SELinux: Initialized (dev debugfs, type debugfs), uses 
genfs_contexts
[    2.841061] SELinux: Initialized (dev sockfs, type sockfs), uses task 
SIDs
[    2.841071] SELinux: Initialized (dev proc, type proc), uses 
genfs_contexts
[    2.841082] SELinux: Initialized (dev bdev, type bdev), uses 
genfs_contexts
[    2.841088] SELinux: Initialized (dev rootfs, type rootfs), uses 
genfs_contexts
[    2.841099] SELinux: Initialized (dev sysfs, type sysfs), uses 
genfs_contexts
[    5.141632] SELinux: Initialized (dev tmpfs, type tmpfs), uses 
transition SIDs
[    8.541464] SELinux: Initialized (dev tmpfs, type tmpfs), uses 
transition SIDs

If I find anything(other than grammar fixes) I'll send a post..

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
