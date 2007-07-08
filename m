Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l688Z282032486
	for <selinux@tycho.nsa.gov>; Sun, 8 Jul 2007 04:35:02 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l688Z08T027239
	for <selinux@tycho.nsa.gov>; Sun, 8 Jul 2007 08:35:00 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <B850829A-A7A6-4B2A-B6A2-51EE83B6DC48@sf-net.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: SELinux user root
Date: Sun, 8 Jul 2007 10:35:02 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Like from the RHEL4 manuel (http://www.redhat.com/docs/manuals/ 
enterprise/RHEL-4-Manual/selinux-guide/rhlcommon-section-0038.html)  
the SELinux user root exists only for legacy reasons:

# root is retained as a separate user identity simply as a
# compatibility measure with the "strict" policy.  It could
# be dropped and mapped to user_u but this allows existing
# file contexts that have "root" as the user identity to
# remain valid.

   user root roles { user_r sysadm_r system_r };

But if I try to modify the login context of root to use user_u I get  
the following error:

$ semanage login -m -s user_u root

libsemanage.validate_handler: MLS range s0-s15:c0.c1023 for Unix user  
root exceeds allowed range s0 for SELinux user user_u
libsemanage.validate_handler: seuser mapping [root -> (user_u, s0- 
s15:c0.c1023)] is invalid
libsemanage.dbase_llist_iterate: could not iterate over records
/usr/sbin/semanage: Could not modify login mapping for root

I'm not really sure how to interprete this message. I would guess  
it's because user_u has only a valid MLS range SystemLow and root has  
a SystemLow-SystemHigh range. But why could this be a problem?

The system I'm testing this is a CentOS5 with a MLS policy installed.


cheers,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
