Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l545tIZS028258
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 01:55:18 -0400
Received: from msp1.hitachi-sk.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l545tGxY023985
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 05:55:17 GMT
Received: from vs1.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l545t9Tf031617
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 14:55:10 +0900
Received: from gw2.hitachi-sk.co.jp (unknown [133.108.252.242])
	by vs1.hitachi-sk.co.jp (Postfix) with ESMTP id CF82E381D3
	for <selinux@tycho.nsa.gov>; Mon,  4 Jun 2007 14:55:09 +0900 (JST)
Received: (from root@localhost)
        by gw2.hitachi-sk.co.jp (unknown) id l545t9gI024910
        for selinux@tycho.nsa.gov; Mon, 4 Jun 2007 14:55:09 +0900
Received: from sms1.l-isa.hitachi-sk.co.jp (mlb.isa.hitachi-sk.co.jp [133.108.245.84])
	by dns1.hitachi-sk.co.jp (8.11.6/3.7W) with ESMTP id l545t9618692
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 14:55:09 +0900
Date: Mon, 4 Jun 2007 03:18:47 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: selinux@tycho.nsa.gov
Cc: ynakam@hitachisoft.jp
Subject: [patch] Bug in restorecon
Message-Id: <20070604031847.0ec6c158.ynakam@hitachisoft.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

I found a bug in restorecon in trunk.
restorecon to relative path does not work.
(such as restorecon -R .).
Path is expanded by realpath in restorecon, isn't it ?

Following is a fix.

Index: policycoreutils/setfiles/setfiles.c
===================================================================
--- policycoreutils/setfiles/setfiles.c (revision 2457)
+++ policycoreutils/setfiles/setfiles.c (working copy)
@@ -223,19 +223,19 @@
        /* fullname will be the real file that gets labeled
         * name will be what is matched in the policy */
        if (NULL != rootpath) {
-               if (0 != strncmp(rootpath, name, rootpathlen)) {
+               if (0 != strncmp(rootpath, fullname, rootpathlen)) {
                        fprintf(stderr, "%s:  %s is not located in %s\n",
-                               progname, name, rootpath);
+                               progname, fullname, rootpath);
                        return -1;
                }
-               name += rootpathlen;
+               fullname += rootpathlen;
        }
 
-       if (rootpath != NULL && name[0] == '\0')
+       if (rootpath != NULL && fullname[0] == '\0')
                /* this is actually the root dir of the alt root */
                return matchpathcon_index("/", sb->st_mode, con);
        else
-               return matchpathcon_index(name, sb->st_mode, con);
+               return matchpathcon_index(fullname, sb->st_mode, con);
 }
 
 void usage(const char *const name)


Regards,
Yuichi Nakamura


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
