Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7TJWrrT000884
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 15:32:53 -0400 (EDT)
Received: from rwcrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7TJWpis003237
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 19:32:52 GMT
Message-ID: <41322F5E.90409@comcast.net>
Date: Sun, 29 Aug 2004 12:32:46 -0700
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

Thanks, but it didn't quite work. The following change to dbusd.te seems
to make graphical login work under strict/enforcing.

Please correct/improve... :)
   tom

--- /root/src.package/policy/domains/program/dbusd.te   2004-08-29 
11:38:27.000000000 -0700
+++ dbusd.te    2004-08-29 12:19:25.000000000 -0700
@@ -32,3 +32,7 @@

 # SE-DBus specific permissions
 allow { dbus_client_domain userdomain } { dbusd_t self }:dbus { send_msg };
+
+allow user_t etc_dbusd_t:dir { search };
+allow user_t etc_dbusd_t:file { getattr read };
+allow user_t user_t:netlink_selinux_socket { bind create };


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
>  
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
