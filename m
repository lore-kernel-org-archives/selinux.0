Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i920gNrT005983
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 20:42:23 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i920fE4L013082
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 00:41:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: policy patches
Date: Sat, 2 Oct 2004 10:42:15 +1000
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
References: <200409292354.15227.russell@coker.com.au> <200410020344.04225.russell@coker.com.au> <415DC1D7.9040109@redhat.com>
In-Reply-To: <415DC1D7.9040109@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410021042.15371.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2 Oct 2004 06:45, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Cleaned up patch with some of russells changes.
>
> chage has been updated to do a checkPasswdAccess(PASSWD__ROOTOK) now.

+allow getty_t initrc_devpts_t:chr_file { read write };

What is this for?

-# /usr/sbin/sendmail asks for w access to utmp, but it will operate
-# correctly without it.  Do not audit write and lock denials to utmp.
-allow sendmail_t initrc_var_run_t:file { getattr read };
-dontaudit sendmail_t initrc_var_run_t:file { lock write };
+# /usr/sbin/sendmail asks for w access to utmp
+allow sendmail_t initrc_var_run_t:file { getattr read lock write };

You missed my fix for this problem.

 allow $1_xserver_t device_t:dir create;
+allow $1_xserver_t device_t:dir { setattr };

Probably best to just merge the above two lines with { create setattr }.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
