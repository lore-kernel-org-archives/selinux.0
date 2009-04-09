Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n39FngKp009039
	for <selinux@tycho.nsa.gov>; Thu, 9 Apr 2009 11:49:42 -0400
Received: from qw-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n39Fngxd007559
	for <selinux@tycho.nsa.gov>; Thu, 9 Apr 2009 15:49:42 GMT
Received: by qw-out-1920.google.com with SMTP id 5so632345qwf.30
        for <selinux@tycho.nsa.gov>; Thu, 09 Apr 2009 08:49:42 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 9 Apr 2009 08:49:41 -0700
Message-ID: <dd18b0c30904090849k2cd2c33cp1a97072a2a8ddb88@mail.gmail.com>
Subject: git dbus not seeing selinux
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(not sure where to post this)
When trying to build the latest dbus
from cgit.freedesktop.org
during sh ./autogen.sh --enable-selinux
I get a:
checking for DBUS Flask permissions in selinux/av_permissions.h...no
configure: error: SElinux explicity required, and SELinux library not found

but I have /usr/include/selinux/*
and libselinux is in /lib/*
(don't see anything in /usr/lib/pkgconfig/*)

When compiling dbus-1.2.4
nothing of the sort(goes all the way)


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
