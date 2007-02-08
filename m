Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l186rCWm021113
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 01:53:12 -0500
Received: from msp1.hitachi-sk.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l186sJX2023156
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 06:54:20 GMT
Received: from vs2.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l186s8DZ005429
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 15:54:08 +0900
Date: Thu, 8 Feb 2007 15:54:17 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: busybox@busybox.net, selinux@tycho.nsa.gov
Cc: russell@coker.com.au, rob@landley.net, busybox@kaigai.gr.jp,
        vda.linux@googlemail.com, ynakam@hitachisoft.jp
Subject: [PATCH 0/6] busybox -- SELinux option support for coreutils
Message-Id: <20070208155417.8d62937f.ynakam@hitachisoft.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

The following patches provide SELinux options(like -Z) to coreutils 
We imported SELinux options from coreutils 5.97(included in Fedora Core6).
You have to enable CONFIG_SELINUX to use following feature.
Any of them are fundamental one to use SELinux.
We are welcoming any comment, and hope to merge it into busybox.


[1/6] busybox-coreutils-common-01.patch
 - usage.h for SELinux options

[2/6] busybox-coreutils-02-copy.patch
  - cp: -Z,-c option support. 
      -c option: security context is preserved during file copy.
      -Z option: security context can be set during file copy.
  - mv 
    In SELinux, it is recommended to preserve security context 
    when file is moved. By this patch, file context is preserved 
    during file move.
  - install
    When file is copied by install, security context of installed file 
    becomes different from value configured in file_contexts file.
    By this patch, security context is set according to file_contexts file.

[3/6] busybox-coreutils-03-mk.patch
 - -Z option support for mkdir, mkfifo, mknod. 
    By -Z, security context for created file can be set.

[4/6] busybox-coreutils-04-stat.patch
 - -Z option support for stat. Security context of file is shown by -Z option.

[5/6]  busybox-coreutils-05-ls.patch
 - -Z option support for ls. Security context of file is shown by -Z option.
   In current busybox, -k/-K shows security context. However, they are replaced by -Z option in recent coreutils, so -Z have to be added by this patch.

[6/6] busybox-coreutils-06-id.patch
 - -Z option support for id. Security context of process is shown by -Z option.


This project is originated from some of JPSEUG(Japan SELinux User Group). 
Now, we are preparing to submit more patches to support SELinux commands/options.

Regards,

Yuichi Nakamura
Hitachi Software
SELinux Policy Editor: http://seedit.sourceforge.net/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
