Subject: avc: denied with kernel module
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: nsa <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1099347144.9776.3.camel@jsingh>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 03:42:25 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am using a overlay-fs module .. and tried setting security context on
files and got this message ....

 avc:  denied  { associate } for  pid=1530 exe=/usr/sbin/setfiles
name=public_html dev=overlay_fs ino=42
scontext=site1-admin:object_r:httpd_site1_content_t
tcontext=system_u:object_r:unlabeled_t tclass=filesystem

setenforce 0 .. allows it (obviously ;-)

I understand the message .. but don't know the steps to avoid it.

Jaspreet




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
