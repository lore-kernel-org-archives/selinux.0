Message-ID: <457DC233.2070100@redhat.com>
Date: Mon, 11 Dec 2006 15:40:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Patch to fix newrole/more problem where more fails because terminal
 is not open correctly
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' 
--exclude='*.pot' -N -u -r nsapolicycoreutils/newrole/newrole.c 
policycoreutils-1.33.6/newrole/newrole.c
--- nsapolicycoreutils/newrole/newrole.c        2006-11-29 
17:11:18.000000000 -0500
+++ policycoreutils-1.33.6/newrole/newrole.c    2006-12-08 
10:34:48.000000000 -0500
@@ -1120,10 +1120,10 @@
        fd = open(ttyn, O_RDONLY);
        if (fd != 0)
                goto err_close_pam;
-       fd = open(ttyn, O_WRONLY);
+       fd = open(ttyn, O_RDWR);
        if (fd != 1)
                goto err_close_pam;
-       fd = open(ttyn, O_WRONLY);
+       fd = open(ttyn, O_RDWR);
        if (fd != 2)
                goto err_close_pam;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
