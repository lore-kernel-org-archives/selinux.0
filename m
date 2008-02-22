Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MGwPnX006650
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 11:58:25 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1MGwO29001460
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 16:58:24 GMT
Message-ID: <47BEFE89.4080201@manicmethod.com>
Date: Fri, 22 Feb 2008 11:55:37 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: segfault in semodule
References: <1203696668.2914.25.camel@localhost.localdomain>
In-Reply-To: <1203696668.2914.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> I added "allow-unknown = deny" in semanage.conf and ran semodule -R
>
> [root@dhcp231-146 ~]# semodule -R
> error parsing semanage configuration file: syntax error
> semodule:  Could not create semanage handle
> semodule: handle.c:123: semanage_is_connected: Assertion `sh != ((void *)0)' failed.
> Segmentation fault
>
> It was supposed to bail (allow-unknown is not a valid entry, it should
> be handle-unknown) but it wasn't supposed to segfault.  Maybe someone
> who knows this code can find/fix it really quickly, if not I'm sure I'll
> get to look at it when it gets to the top of my list in 10 or 12
> months  :)
>
> policycoreutils-2.0.43-2.fc9.x86_64
>   

This is totally untested but should fix it:

Index: trunk/policycoreutils/semodule/semodule.c
===================================================================
--- trunk/policycoreutils/semodule/semodule.c   (revision 2808)
+++ trunk/policycoreutils/semodule/semodule.c   (working copy)
@@ -285,7 +285,7 @@
        if (!sh) {
                fprintf(stderr, "%s:  Could not create semanage handle\n",
                        argv[0]);
-               goto cleanup;
+               goto cleanup_nohandle;
        }
 
        if (store) {
@@ -473,6 +473,8 @@
                }
        }
        semanage_handle_destroy(sh);
+
+      cleanup_nohandle:
        cleanup();
        exit(status);
 }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
