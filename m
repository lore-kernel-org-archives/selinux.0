Message-ID: <415C4E36.3020303@redhat.com>
Date: Thu, 30 Sep 2004 14:19:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Out of curiosity looking for suid apps without special context on
 FC3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These are the files that do not have special context associated with 
them but are suid on FC3. 

/sbin/pwdb_chkpwd->system_u:object_r:sbin_t
/usr/lib/mc/cons.saver->system_u:object_r:lib_t
/usr/lib/mgetty+sendfax/faxq-helper->system_u:object_r:lib_t
/usr/lib/amanda/amqde->system_u:object_r:lib_t
/usr/lib/cyrus-imapd/deliver->system_u:object_r:bin_t
/usr/bin/kgrantpty->system_u:object_r:bin_t
/usr/bin/newvc->system_u:object_r:bin_t
/usr/bin/afppasswd->system_u:object_r:bin_t
/usr/bin/kon->system_u:object_r:bin_t
/usr/bin/nwsfind->system_u:object_r:bin_t
/usr/bin/fliccd->system_u:object_r:bin_t
/usr/bin/rcp->system_u:object_r:bin_t
/usr/bin/uustat->system_u:object_r:bin_t
/usr/bin/ncplogin->system_u:object_r:bin_t
/usr/bin/cu->system_u:object_r:bin_t
/usr/bin/sperl5.8.5->system_u:object_r:bin_t
/usr/bin/uucp->system_u:object_r:bin_t
/usr/bin/lppasswd->system_u:object_r:bin_t
/usr/bin/uux->system_u:object_r:bin_t
/usr/bin/ncpmap->system_u:object_r:bin_t
/usr/bin/rlogin->system_u:object_r:bin_t
/usr/bin/uuname->system_u:object_r:bin_t
/usr/bin/kpac_dhcp_helper->system_u:object_r:bin_t
/usr/bin/rsh->system_u:object_r:bin_t
/usr/sbin/exim->system_u:object_r:sbin_t
/usr/sbin/userisdnctl->system_u:object_r:sbin_t
/usr/sbin/uucico->system_u:object_r:sbin_t
/usr/sbin/uuxqt->system_u:object_r:sbin_t

# Asks for suid but seems to work.
/usr/bin/newgrp->system_u:object_r:bin_t

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
