Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7TJrHrT000957
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 15:53:17 -0400 (EDT)
Received: from rwcrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7TJqTwc002122
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 19:52:30 GMT
Message-ID: <41323421.7050904@comcast.net>
Date: Sun, 29 Aug 2004 12:53:05 -0700
From: Tom London <selinux@comcast.net>
MIME-Version: 1.0
To: russell@coker.com.au
CC: fedora-selinux-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
References: <4130CF1B.3090909@comcast.net> <200408291737.17497.russell@coker.com.au>
In-Reply-To: <200408291737.17497.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell,

The following changes to udev.te seem needed....
(If udev shouldn't be reading file_contexts, then dontaudit?)

Please correct/improve,
   tom

--- /tmp/patches/udev.te        2004-08-29 11:35:48.000000000 -0700
+++ udev.te     2004-08-29 12:40:58.000000000 -0700
@@ -44,7 +44,9 @@

 # to read the file_contexts file
 allow udev_t { selinux_config_t default_context_t }:dir search;
-allow udev_t default_context_t:file { getattr read };
+allow udev_t { selinux_config_t default_context_t }:file { getattr read };
+allow udev_t file_context_t:dir { search };
+allow udev_t file_context_t:file { getattr read };

 allow udev_t policy_config_t:dir { search };
 allow udev_t proc_t:file { read };


Russell Coker wrote:

>On Sun, 29 Aug 2004 04:29, Tom London <selinux@comcast.net> wrote:
>  
>
>>Newest Rawhide updates (including udev-030-10, mkinitrd-4.1.8-1,
>>kernel-2.6.8-1.532, and selinux-policy-strict-1.17.5-2)
>>now boots in strict/enforcing.
>>    
>>
>
>I've attached a diff against the CVS policy as well as the .te and .fc files 
>for udev changes which fix this and address some other issues as well.
>
>Please try it out and let me know how it goes.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
