Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1JCdDB2013800
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 07:39:13 -0500
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1JCeSnS013066
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2007 12:40:29 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <92F5A105-2A19-4AA0-956B-C9E963A762CC@sf-net.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Samba policy patch
Date: Mon, 19 Feb 2007 13:40:08 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While using samba and SELinux with Debian GNU/Linux (etch) the  
following files need to be labeled correctly:
/var/run/samba/gencache.tdb
/var/run/samba/share_info.tdb

Should also concern other distributions than Debian.

-Stefan

--- policy/modules/services/samba.fc  2007-02-17 11:40:46.000000000  
+0100
+++ /policy/modules/services/samba.fc      2007-02-19  
13:26:01.000000000 +0100
@@ -39,6 +39,8 @@
/var/run/samba/sessionid\.tdb  --      gen_context 
(system_u:object_r:smbd_var_run_t,s0)
/var/run/samba/smbd\.pid       --      gen_context 
(system_u:object_r:smbd_var_run_t,s0)
/var/run/samba/unexpected\.tdb --      gen_context 
(system_u:object_r:nmbd_var_run_t,s0)
+/var/run/samba/gencache\.tdb    --      gen_context 
(system_u:object_r:smbd_var_run_t,s0)
+/var/run/samba/share_info\.tdb  --      gen_context 
(system_u:object_r:smbd_var_run_t,s0)

/var/run/winbindd(/.*)?                        gen_context 
(system_u:object_r:winbind_var_run_t,s0)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
