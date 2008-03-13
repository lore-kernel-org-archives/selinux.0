Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2D85nhI023038
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 04:05:49 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2D85mew010207
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 08:05:49 GMT
Received: by wf-out-1314.google.com with SMTP id 28so3545888wfc.30
        for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 01:05:48 -0700 (PDT)
Message-ID: <dd18b0c30803130105l7cfc19d8y793518d20b2fcd22@mail.gmail.com>
Date: Thu, 13 Mar 2008 08:05:48 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: 2.6.25-rc5
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9886_11893075.1205395548256"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_9886_11893075.1205395548256
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; I need to open my eyes better when looking for new versions of a
program.(I located svn refpolicy and plugged it on, looks very nice,)
The only question for now with this policy is, with building the allow
rules, its seems it takes longer to attain avc's, as in other policies. i.g.
when doing a reboot after the first install of the policy I noticed only
around 7 to 8 avc's, then after those were defined,  then the same amount on
the next reboot.
Previous policies would pour 100's of avc's on the first reboot of the newly
installed policy(was this planned).Personally; sitting and slowly going
through each and every avc's frustrated me, but then made me realize it is
better to take you're time with the rules, due to some rule that should'nt
be there that might find it's way in. Below is what I see in dmesg with
SELinux.





[    0.164286] SELinux:  Registering netfilter hooks
[    1.015122] SELinux:8192 avtab hash slots allocated. Num of rules:202124
[    1.045833] SELinux:8192 avtab hash slots allocated. Num of rules:202124
[    1.076950] security:  7 users, 7 roles, 2618 types, 89 bools
[    1.076953] security:  69 classes, 202124 rules
[    1.078288] SELinux:  Completing initialization.
[    1.078290] SELinux:  Setting up existing superblocks.
[    1.080008] SELinux: initialized (dev sda1, type ext3), uses xattr
[    1.080008] SELinux: initialized (dev debugfs, type debugfs), uses
genfs_contexts
[    1.080008] SELinux: initialized (dev selinuxfs, type selinuxfs), uses
genfs_contexts
[    1.080008] SELinux: initialized (dev mqueue, type mqueue), uses
transition SIDs
[    1.080008] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses
genfs_contexts
[    1.080008] SELinux: initialized (dev devpts, type devpts), uses
transition SIDs
[    1.080008] SELinux: initialized (dev inotifyfs, type inotifyfs), uses
genfs_contexts
[    1.080008] SELinux: initialized (dev tmpfs, type tmpfs), uses transition
SIDs
[    1.080008] SELinux: initialized (dev futexfs, type futexfs), uses
genfs_contexts
[    1.080008] SELinux: initialized (dev anon_inodefs, type anon_inodefs),
uses genfs_contexts
[    1.080008] SELinux: initialized (dev pipefs, type pipefs), uses task
SIDs
[    1.080008] SELinux: initialized (dev sockfs, type sockfs), uses task
SIDs
[    1.080008] SELinux: initialized (dev proc, type proc), uses
genfs_contexts
[    1.080008] SELinux: initialized (dev bdev, type bdev), uses
genfs_contexts
[    1.080008] SELinux: initialized (dev rootfs, type rootfs), uses
genfs_contexts
[    1.080008] SELinux: initialized (dev sysfs, type sysfs), uses
genfs_contexts
[    0.691525] SELinux: policy loaded with handle_unknown=deny
[    0.691532] type=1403 audit(1205354634.730:2): policy loaded
auid=4294967295 ses=4294967295
[    0.990260] SELinux: initialized (dev tmpfs, type tmpfs), uses transition
SIDs
[    1.373915] SELinux: initialized (dev tmpfs, type tmpfs), uses transition
SIDs
[    2.802217] SELinux: initialized (dev tmpfs, type tmpfs), uses transition
SIDs
[    4.354764] SELinux: initialized (dev usbfs, type usbfs), uses
genfs_contexts
[    5.863940] SELinux: initialized (dev tmpfs, type tmpfs), uses transition
SIDs

I'll leave this policy in place for the time being and test and see if
anything happens.
Thank you for the help.


-- 
Justin P. Mattock

------=_Part_9886_11893075.1205395548256
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; I need to open my eyes better when looking for new versions of a program.(I located svn refpolicy and plugged it on, looks very nice,)<br>The only question for now with this policy is, with building the allow rules, its seems it takes longer to attain avc&#39;s, as in other policies. i.g.<br>
when doing a reboot after the first install of the policy I noticed only around 7 to 8 avc&#39;s, then after those were defined,&nbsp; then the same amount on the next reboot.<br>Previous policies would pour 100&#39;s of avc&#39;s on the first reboot of the newly installed policy(was this planned).Personally; sitting and slowly going through each and every avc&#39;s frustrated me, but then made me realize it is better to take you&#39;re time with the rules, due to some rule that should&#39;nt be there that might find it&#39;s way in. Below is what I see in dmesg with SELinux.<br>
<br><br><br><br><br>[&nbsp;&nbsp;&nbsp; 0.164286] SELinux:&nbsp; Registering netfilter hooks<br>[&nbsp;&nbsp;&nbsp; 1.015122] SELinux:8192 avtab hash slots allocated. Num of rules:202124<br>[&nbsp;&nbsp;&nbsp; 1.045833] SELinux:8192 avtab hash slots allocated. Num of rules:202124<br>
[&nbsp;&nbsp;&nbsp; 1.076950] security:&nbsp; 7 users, 7 roles, 2618 types, 89 bools<br>[&nbsp;&nbsp;&nbsp; 1.076953] security:&nbsp; 69 classes, 202124 rules<br>[&nbsp;&nbsp;&nbsp; 1.078288] SELinux:&nbsp; Completing initialization.<br>[&nbsp;&nbsp;&nbsp; 1.078290] SELinux:&nbsp; Setting up existing superblocks.<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev sda1, type ext3), uses xattr<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev devpts, type devpts), uses transition SIDs<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev pipefs, type pipefs), uses task SIDs<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev sockfs, type sockfs), uses task SIDs<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev proc, type proc), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 0.691525] SELinux: policy loaded with handle_unknown=deny<br>[&nbsp;&nbsp;&nbsp; 0.691532] type=1403 audit(1205354634.730:2): policy loaded auid=4294967295 ses=4294967295<br>
[&nbsp;&nbsp;&nbsp; 0.990260] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br>[&nbsp;&nbsp;&nbsp; 1.373915] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br>[&nbsp;&nbsp;&nbsp; 2.802217] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br>
[&nbsp;&nbsp;&nbsp; 4.354764] SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 5.863940] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br><br>I&#39;ll leave this policy in place for the time being and test and see if anything happens.<br>
Thank you for the help.<br><br clear="all"><br>-- <br>Justin P. Mattock

------=_Part_9886_11893075.1205395548256--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
