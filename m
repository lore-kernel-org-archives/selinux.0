Message-ID: <427640CB.80702@redhat.com>
Date: Mon, 02 May 2005 11:01:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: How should we handle automount.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Needs to be able to create/remove mounton arbitrary directories in 
arbitrary locations?

file_domain_auto_trans(automount_t, file_type, autofs_t, dir)  ????
Then how do we allow automount to delete the directory?

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
