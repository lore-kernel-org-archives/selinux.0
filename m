Message-ID: <419373C8.8050701@redhat.com>
Date: Thu, 11 Nov 2004 09:14:32 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: How come security_get_boolean_pending returns true when a boolean
 is on.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

getsebool -a
mozilla_writehome --> active: 1 pending: 1
named_write_master_zones --> active: 0 pending: 0
nfs_export_all_ro --> active: 0 pending: 0
nfs_export_all_rw --> active: 0 pending: 0
read_default_t --> active: 1 pending: 1
run_ssh_inetd --> active: 0 pending: 0
secure_mode --> active: 0 pending: 0
spamassasin_can_network --> active: 0 pending: 0
ssh_sysadm_login --> active: 1 pending: 1
staff_read_sysadm_file --> active: 1 pending: 1

Shouldn't this be
staff_read_sysadm_file --> active: 1 pending: 0

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
