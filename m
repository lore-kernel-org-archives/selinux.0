Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4JL5KxZ011360
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2011 17:05:20 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4JL5JpE013501
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2011 21:05:19 GMT
Received: by iwn38 with SMTP id 38so3122896iwn.12
        for <selinux@tycho.nsa.gov>; Thu, 19 May 2011 14:05:19 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 19 May 2011 14:05:18 -0700
Message-ID: <BANLkTi=KPssQQitdX7gQnJbtE7WByxgBgQ@mail.gmail.com>
Subject: selinux_inode_init_security() initialises XATTR_SELINUX_SUFFIX and
 not XATTR_NAME_SELINUX?
From: Sam Gandhi <samgandhi9@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello SeLinux Experts,

Looking at the latest SELinux code I see that in function
selinux_inode_init_security() the initial XATTR is initialised as
XATTR_SELINUX_SUFFIX ("security.selinux"), where as all the
subsequence searches are done with XATTR_NAME_SELINUX.  Unfortunately
I don't understand why initialisation is done with
XATTR_SELINUX_SUFFIX ("selinux")

Should we be making following change to the code?

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8fb2488..c8d14d5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2566,7 +2566,7 @@ static int selinux_inode_init_security(struct
inode *inode, struct inode *dir,
                return -EOPNOTSUPP;

        if (name) {
-               namep = kstrdup(XATTR_SELINUX_SUFFIX, GFP_NOFS);
+               namep = kstrdup(XATTR_NAME_SELINUX, GFP_NOFS);
                if (!namep)
                        return -ENOMEM;
                *name = namep;



-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
