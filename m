Subject: Re: selinux_check_passwd_access() behaviour when passwd class does
 not exist
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux@tycho.nsa.gov
In-Reply-To: <4AF02C79.30806@redhat.com>
References: <1257201838.24413.20.camel@tesla.lan>
	 <4AF02C79.30806@redhat.com>
Content-Type: text/plain
Date: Tue, 03 Nov 2009 21:29:04 +0100
Message-Id: <1257280144.3005.86.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 03/11/2009 08.13 -0500, Daniel J Walsh wrote:

> I am not sure,  I think it could be argued that this function should not be in libselinux at all, since it hard codes policy into the library.
> 
> I think you need to start setting the errno if you are going to change the function ENOSUPP for this error versus EPERM for the other error, and then all users (passwd?) of the function need to change to look at the errno.
> 

Or if the intent is just to remove the hard-coded word "passwd" from the
libselinux code, then it is possible to use SECCLASS_PASSWD defined in
flask.h as follows:

--- libselinux/src/checkAccess.c.orig   2009-11-03 21:11:21.000000000
+0100
+++ libselinux/src/checkAccess.c        2009-11-03 21:13:44.000000000
+0100
@@ -17,13 +17,9 @@ int selinux_check_passwd_access(access_v
                struct av_decision avd;
                int retval;
 
-               passwd_class = string_to_security_class("passwd");
-               if (passwd_class == 0)
-                       return 0;
-
                retval = security_compute_av_raw(user_context,
                                                     user_context,
-                                                    passwd_class,
+                                                    SECCLASS_PASSWD,
                                                     requested,
                                                     &avd);

This solution shortens the code and also avoids the issue that might
arise if such a security object class is not defined, because the
library simply won't compile...

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
