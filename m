Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0PEYmS5025440
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 09:34:48 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0PEZkHd019450
	for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 14:35:47 GMT
Received: by wx-out-0506.google.com with SMTP id s17so552318wxc
        for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2007 06:35:45 -0800 (PST)
Message-ID: <45B8C039.10907@kaigai.gr.jp>
Date: Thu, 25 Jan 2007 23:35:37 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: busybox@busybox.net, selinux@tycho.nsa.gov
CC: rob@landley.net, dwalsh@redhat.com, russell@coker.com.au,
        busybox@kaigai.gr.jp
Subject: [PATCH 0/8] busybox -- libselinux utilities applets
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

The following patches provide utilities included in libselinux
package against to the latest busybox repository.
Any of them are fundamental one to use SELinux.

We are welcoming any comment, and hope to merge it into busybox.

NOTE: How to configure

All applets of them depend on CONFIG_SELINUX, so you have to
enable it by the following step on 'menuconfig'.

Busybox Settings  --->
  General Configuration  --->
    [*] Support NSA Security Enhanced Linux (CONFIG_SELINUX)

and, enable any checks under 'Selinux Utilities  --->'

[1/8] busybox-libselinux-01-common.patch
  The common part of libselinux package
  - modification of Makefile
  - add '-lselinux', if CONFIG_SELINUX enabled
    (It was never linked, so we could not build with SELinux
     support in busybox-1.4.0)
  - add selinux/Config.in and selinux/Kbuild
  - add usage.h and applets.h for the series of applets

[2/8] busybox-libselinux-02-getenforce.patch
  getenforce - get the current mode of SELinux.
  SELinux has two mode. 'Enforcing' is the one, it enables
  mandatory access control based on the security policy.
  The other is 'Permissive' mode. It enables to evaluate
  security policy and output audit messages, if violated.
  But mandatory access control was not done. It was used
  to debug policy.

[3/8] busybox-libselinux-03-selinuxenabled.patch
  selinuxenabled returns 0 as a command exit code,
  if SELinux is enabled.
  Typically, shell-scripts use it to decide whether
  SELinux is working, or not.

[4/8] busybox-libselinux-04-getsebool.patch
  getsebool reports the a particular or all SELinux
  boolean variable.
  SELinux boolean variable is a interface to configure
  the condition of security policy. We can enable or
  disable the part of the security policy via boolean
  variable.

[5/8] busybox-libselinux-05-avcstat.patch
  avcstat reports SELinux AVC(Access Vector Cache) statistics.
  AVC is a in-kernel data structure to accelerate SELinux's
  decision making.

[6/8] busybox-libselinux-06-togglesebool.patch
  togglesebool - flip the current value of a SELinux
  boolean variable.

[7/8] busybox-libselinux-07-matchpathcon.patch
  matchpathcon - get the default security context for
  the specified path from the file contexts configuration.
  Security context is a identifier for SELinux.
  Any files has a own security context, and SELinux use it
  to evaluate the attribute of the file.
  When we are setting up a system, we have to attach a security
  context for each files. so, we can obtain the most appropriate
  security context by using matchpathcon.

[8/8] busybox-libselinux-08-setenforce.patch
  setenforce - modify the mode SELinux is running in Enforcing
  mode or Permissive.

This project is originated from some of JPSEUG(Japan SELinux
User Group). Now, we are preparing to submit patches related
to SELinux like policycoreutils, '-Z' option support.
Please wait for a bit.

Thanks,
--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
