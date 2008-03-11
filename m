Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2B52mZM030767
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 01:02:48 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2B52blM003248
	for <selinux@tycho.nsa.gov>; Tue, 11 Mar 2008 05:02:47 GMT
Received: by wf-out-1314.google.com with SMTP id 28so2360195wfc.30
        for <selinux@tycho.nsa.gov>; Mon, 10 Mar 2008 22:02:37 -0700 (PDT)
Message-ID: <dd18b0c30803102202i15fa5b28m2b05b597dee12adc@mail.gmail.com>
Date: Tue, 11 Mar 2008 05:02:37 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: 2.6.25-rc5
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_261_21722861.1205211757298"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_261_21722861.1205211757298
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello
 I've updated to 2.6.25-rc5 and am noticing new security cleasses in
SELinux, also the new POSIX option is nice.


[    1.011576] SELinux:8192 avtab hash slots allocated. Num of rules:201978
[    1.042271] SELinux:8192 avtab hash slots allocated. Num of rules:201978
[    1.073362] security:  7 users, 7 roles, 2613 types, 88 bools
[    1.073364] security:  67 classes, 201978 rules
[    1.074502] security:  class peer not defined in policy
[    1.074504] security:  class capability2 not defined in policy
[    1.074522] security:  permission recvfrom in class node not defined in
policy
[    1.074524] security:  permission sendto in class node not defined in
policy
[    1.074529] security:  permission ingress in class netif not defined in
policy
[    1.074531] security:  permission egress in class netif not defined in
policy                     <----new
[    1.074567] security:  permission setfcap in class capability not defined
in policy
[    1.074579] security:  permission flow_in in class packet not defined in
policy
[    1.074581] security:  permission flow_out in class packet not defined in
policy
[    1.074583] security:  permission forward_in in class packet not defined
in policy
[    1.074585] security:  permission forward_out in class packet not defined
in policy
[    1.074702] SELinux:  Completing initialization.
[    1.074703] SELinux:  Setting up existing superblocks.
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
[    0.521501] SELinux: policy loaded with handle_unknown=deny
[    0.521508] type=1403 audit(1205185017.730:2): policy loaded
auid=4294967295 ses=4294967295
[    0.905424] SELinux: initialized (dev tmpfs, type tmpfs), uses transition
SIDs
[    0.908987] SELinux: initialized (dev tmpfs, type tmpfs), uses transition
SIDs
[    1.395365] SELinux: initialized (dev tmpfs, type tmpfs), uses transition
SIDs
[    4.206622] SELinux: initialized (dev usbfs, type usbfs), uses
genfs_contexts
[    7.345932] SELinux: initialized (dev tmpfs, type tmpfs), uses transition
SIDs

Overall SELinux seems to be running smoothly
regards;
               Justin P. Mattock

------=_Part_261_21722861.1205211757298
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello<br>&nbsp;I&#39;ve updated to 2.6.25-rc5 and am noticing new security cleasses in SELinux, also the new POSIX option is nice.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>[&nbsp;&nbsp;&nbsp; 1.011576] SELinux:8192 avtab hash slots allocated. Num of rules:201978<br>
[&nbsp;&nbsp;&nbsp; 1.042271] SELinux:8192 avtab hash slots allocated. Num of rules:201978<br>[&nbsp;&nbsp;&nbsp; 1.073362] security:&nbsp; 7 users, 7 roles, 2613 types, 88 bools<br>[&nbsp;&nbsp;&nbsp; 1.073364] security:&nbsp; 67 classes, 201978 rules<br>[&nbsp;&nbsp;&nbsp; 1.074502] security:&nbsp; class peer not defined in policy<br>
[&nbsp;&nbsp;&nbsp; 1.074504] security:&nbsp; class capability2 not defined in policy<br>[&nbsp;&nbsp;&nbsp; 1.074522] security:&nbsp; permission recvfrom in class node not defined in policy<br>[&nbsp;&nbsp;&nbsp; 1.074524] security:&nbsp; permission sendto in class node not defined in policy<br>
[&nbsp;&nbsp;&nbsp; 1.074529] security:&nbsp; permission ingress in class netif not defined in policy<br>[&nbsp;&nbsp;&nbsp; 1.074531] security:&nbsp; permission egress in class netif not defined in policy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;----new <br>[&nbsp;&nbsp;&nbsp; 1.074567] security:&nbsp; permission setfcap in class capability not defined in policy<br>
[&nbsp;&nbsp;&nbsp; 1.074579] security:&nbsp; permission flow_in in class packet not defined in policy<br>[&nbsp;&nbsp;&nbsp; 1.074581] security:&nbsp; permission flow_out in class packet not defined in policy<br>[&nbsp;&nbsp;&nbsp; 1.074583] security:&nbsp; permission forward_in in class packet not defined in policy<br>
[&nbsp;&nbsp;&nbsp; 1.074585] security:&nbsp; permission forward_out in class packet not defined in policy<br>[&nbsp;&nbsp;&nbsp; 1.074702] SELinux:&nbsp; Completing initialization.<br>[&nbsp;&nbsp;&nbsp; 1.074703] SELinux:&nbsp; Setting up existing superblocks.<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev sda1, type ext3), uses xattr<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev devpts, type devpts), uses transition SIDs<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev pipefs, type pipefs), uses task SIDs<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev sockfs, type sockfs), uses task SIDs<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev proc, type proc), uses genfs_contexts<br>
[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts<br>[&nbsp;&nbsp;&nbsp; 1.080008] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts<br>
[&nbsp;&nbsp;&nbsp; 0.521501] SELinux: policy loaded with handle_unknown=deny<br>[&nbsp;&nbsp;&nbsp; 0.521508] type=1403 audit(1205185017.730:2): policy loaded auid=4294967295 ses=4294967295<br>[&nbsp;&nbsp;&nbsp; 0.905424] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br>
[&nbsp;&nbsp;&nbsp; 0.908987] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br>[&nbsp;&nbsp;&nbsp; 1.395365] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br>[&nbsp;&nbsp;&nbsp; 4.206622] SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts<br>
[&nbsp;&nbsp;&nbsp; 7.345932] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs<br><br>Overall SELinux seems to be running smoothly <br>regards;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Justin P. Mattock<br><br><br><br><br><br>&nbsp;<br>

------=_Part_261_21722861.1205211757298--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
