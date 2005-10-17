Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9HFdtNs029244
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 11:39:55 -0400 (EDT)
Received: from deep.phpwebhosting.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j9HFb9SN011994
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 15:37:10 GMT
Message-ID: <43538CDF.9030208@cobalt-financial.com>
Date: Mon, 17 Oct 2005 11:37:03 +0000
From: Unix Admin <unix@cobalt-financial.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Kernel woes  (summary)
References: <43537A09.5080005@cobalt-financial.com> <4353B628.6090801@redhat.com>
In-Reply-To: <4353B628.6090801@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:

> restorecon  /dev/log
>
> should fix this.  But how did it happen?  Are you using udev?
>
> Dan
>
restorecon didn't work.

Oct 17 10:40:31 odin kernel: post_create:  setxattr failed, rc=28 
(dev=sda1 ino=8339468)
Oct 17 10:40:31 odin kernel: audit(1129560031.871:0): avc:  denied  { 
connectto } for  pid=3823 comm=httpd path=/dev/log 
scontext=root:system_r:httpd_t tcontext=user_u:system_r:unconfined_t 
tclass=unix_stream_socket

I removed mod_security rules to minimize any potential security errors. 
Checked my permissions for the apache directory, still no dice. Rebooted 
forced fsck (reboot -F) ...

Checked disk space and I notice two volumes were not mounted so I 
mounted them, removed unecessary files
and voila. Got it working. Thanks to Stephen Smalley at the National 
Security Agency for pointing out simple error numbers ;)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
