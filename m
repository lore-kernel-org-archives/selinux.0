Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA3EGOEg024995
	for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2006 09:16:24 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA3DEiSB019259
	for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2006 13:14:44 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kA3DGPmx009058
	for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2006 08:16:25 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id kA3DGHlG028092
	for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2006 08:16:25 -0500
Received: from discovery.boston.redhat.com (discovery.boston.redhat.com [172.16.80.171])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kA3DGG1D010670
	for <selinux@tycho.nsa.gov>; Fri, 3 Nov 2006 08:16:16 -0500
From: Steve Grubb <sgrubb@redhat.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: rpmlint
Date: Fri, 3 Nov 2006 08:16:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611030816.22148.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Below is a patch that I am thinking about submitting to rpmlint. The main idea
of this patch is to catch places where people might be coding policy knowledge
into scripts. Chcon would require knowing some types in order to work. If the
types ever got changed, the script would break. Can anyone think of other
things we do not want to see in rpm scriplets?

-Steve


diff -ur rpmlint-0.78.orig/PostCheck.py rpmlint-0.78/PostCheck.py
--- rpmlint-0.78.orig/PostCheck.py	2006-11-01 11:13:04.000000000 -0500
+++ rpmlint-0.78/PostCheck.py	2006-11-01 12:26:49.000000000 -0500
@@ -38,6 +38,7 @@
 bracket_regex=re.compile('^[^#]*if.*[^ :\]]\]', re.MULTILINE)
 home_regex=re.compile('[^a-zA-Z]+~/|\${?HOME(\W|$)', re.MULTILINE)
 dangerous_command_regex=re.compile("(^|[;\|`]|&&|$\()\s*(?:\S*/s?bin/)?(cp|mv|ln|tar|rpm|chmod|chown|rm|cpio|install|perl|userdel|groupdel)\s", re.MULTILINE)
+selinux_regex=re.compile("(^|[;\|`]|&&|$\()\s*(?:\S*/s?bin/)?(chcon|runcon)\s", re.MULTILINE)
 single_command_regex=re.compile("^[ \n]*([^ \n]+)[ \n]*$")
 update_menu_regex=re.compile('update-menus', re.MULTILINE)
 tmp_regex=re.compile('\s(/var)?/tmp', re.MULTILINE)
@@ -139,6 +140,10 @@
                 res=dangerous_command_regex.search(script)
                 if res:
                     printWarning(pkg, 'dangerous-command-in-' + tag[2], res.group(2))
+                res=selinux_regex.search(script)
+                if res:
+                    printError(pkg, 'selinux-forbidden-command-in-' + tag[2], res.group(2))
+
                 if update_menu_regex.search(script):
                     menu_error=1
                     for f in files:

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
