Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14J6v53010744
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 14:06:57 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Best way to label a filesystem for another system
Date: Fri, 4 Feb 2005 11:06:54 -0800
Message-ID: <60C14C611F1DDD4198D53F2F43D8CA3B0365AD08@orsmsx410>
From: "Villalovos, John L" <john.l.villalovos@intel.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> setfiles -r allows you to specify an alternate root path.  Don't
> reinvent the logic for processing file_contexts; we have been
> moving in
> the opposite direction, centralizing it all in the matchpathcon()
> function in libselinux and rewriting all programs to use it.  In the
> sourceforge CVS tree (and thus the next release on nsa.gov), setfiles
> has also been rewritten in this manner.

Thanks for the info :)

I tried it by doing:

[root@linuxjohn4 iq80310]# mount -o loop root_fs_arm mnt/

[root@linuxjohn4 iq80310]# setfiles -r mnt/ -v
mnt/etc/selinux/targeted/contexts/files/file_contexts mnt/
setfiles:  read 463 specifications
setfiles:  invalid context system_u:object_r:checkpolicy_exec_t on line
number 526
setfiles:  invalid context system_u:object_r:chkpwd_exec_t on line
number 528
setfiles:  invalid context system_u:object_r:chkpwd_exec_t on line
number 529
setfiles:  invalid context system_u:object_r:system_cron_spool_t on line
number 532
setfiles:  invalid context system_u:object_r:system_cron_spool_t on line
number 533
setfiles:  invalid context system_u:object_r:crond_exec_t on line number
534
setfiles:  invalid context system_u:object_r:anacron_exec_t on line
number 535
setfiles:  invalid context system_u:object_r:sysadm_cron_spool_t on line
number 539
setfiles:  invalid context system_u:object_r:sysadm_cron_spool_t on line
number 540
Exiting after 10 errors.


I am using Fedora Core 3 as my development system and it has all the
current updates applied.

I am using policy-1.20.tgz from the NSA website for the code I am using
for the target system.

If I use my local file_contexts file it works fine:
[root@linuxjohn4 iq80310]# setfiles -r mnt/ -v
/etc/selinux/targeted/contexts/files/file_contexts mnt/
setfiles:  read 573 specifications
setfiles:  labeling files, pretending mnt is /
setfiles:  labeling files under mnt/
setfiles:  hash table stats: 505 elements, 505/65536 buckets used,
longest chain length 1
setfiles:  Done.


Any ideas on how to make the first method work?

Thanks,
John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
