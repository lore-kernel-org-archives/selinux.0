Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1NDFejI008718
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 08:15:41 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1NDE7AM022721
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 13:14:11 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 2E0F5C4C097
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 14:15:27 +0100 (CET)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 02109-04-3 for <selinux@tycho.nsa.gov>;
	Thu, 23 Feb 2006 14:15:23 +0100 (CET)
Received: from wintermute.xmldesign.de (p549A434B.dip0.t-ipconnect.de [84.154.67.75])
	by legolas.drinsama.de (Postfix) with ESMTP id 06AC3C4C08E
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 14:15:09 +0100 (CET)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id 3CF932343D8
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 14:15:08 +0100 (CET)
Subject: libselinux CVS doesn't honor DESTDIR
From: Erich Schubert <erich@debian.org>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 23 Feb 2006 14:15:06 +0100
Message-Id: <1140700506.10547.6.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,
libselinux CVS doesn't honor $(DESTDIR). Here's the patch
(I'm not sure it's perfect, but thats how the makefile of libsemanage
looks like. ;-) )

--- src/Makefile~	2006-02-23 04:24:45.000000000 +0100
+++ src/Makefile	2006-02-23 14:04:30.000000000 +0100
@@ -1,5 +1,5 @@
 # Installation directories.
-PREFIX ?= /usr
+PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include

Thanks.

On a side note: libselinux CVS is required for current semanage, due to
the fix in the swig interface in
http://cvs.sourceforge.net/viewcvs.py/selinux/nsa/selinux-usr/libselinux/src/selinuxswig.i?r1=1.1&r2=1.2
Which is not in the latest libselinux release.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
 Nothing prevents happiness like the memory of happiness. --- A. Gide //\
     Das größte Hindernis beim Erkennen der Wahrheit ist nicht die    V_/_
        Falschheit, sondern die Halbwahrheit. --- L. N. Tolstoi



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
