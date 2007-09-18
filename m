Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8IHdPHA017314
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 13:39:25 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8IHdN9X025605
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 17:39:23 GMT
Received: by an-out-0708.google.com with SMTP id c38so338332ana
        for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 10:39:23 -0700 (PDT)
Message-ID: <f71a82820709181039s6aeac4eaq404542de3148c411@mail.gmail.com>
Date: Wed, 19 Sep 2007 02:39:23 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: [PATCH] fstools.te needs corecmd_exec_bin
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have attached usb hdd on my strict machine and typed
mkfs -c /dev/sdb
and error saying cannot execute /sbin/badblocks.
I always use -c with mkfs command so I added
this line to fstools.te.


Index: policy/modules/system/fstools.te
===================================================================
--- policy/modules/system/fstools.te    (revision 2422)
+++ policy/modules/system/fstools.te    (working copy)
@@ -119,6 +119,9 @@
 corecmd_read_bin_pipes(fsadm_t)
 corecmd_read_bin_sockets(fsadm_t)

+# for mkfs -c
+corecmd_exec_bin(fsadm_t)
+
 domain_use_interactive_fds(fsadm_t)

 files_list_home(fsadm_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
