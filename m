Message-ID: <420BD28E.6090006@redhat.com>
Date: Thu, 10 Feb 2005 16:30:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Modifications to the local.users file
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You made changes to the local.users file to no longer run m4 on it. 
We were doing that to get the ifdef(direct_sysadm_daemon) comment right
I think you need these comments for the user to have an idea of how to 
configure this
file.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
