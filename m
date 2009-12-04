Message-ID: <4B19926E.9080500@tycho.nsa.gov>
Date: Fri, 04 Dec 2009 17:51:26 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Tyler Durvik <phangbyte@gmail.com>
CC: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
Subject: Re: Tutorial on setting up SELinux / X Server
References: <a0e63a5b0912021922j38f0391doc6b90c4653678ae0@mail.gmail.com>	 <4B187D09.90508@tycho.nsa.gov> <a0e63a5b0912040759k6e3b96fclc2a30a9b82aa55f7@mail.gmail.com>
In-Reply-To: <a0e63a5b0912040759k6e3b96fclc2a30a9b82aa55f7@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------010600040509040902000700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010600040509040902000700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/04/2009 10:59 AM, Tyler Durvik wrote:
> I turned on the boolean:
>
> setsebool -P xserver_object_manager on
>
> and now I get the following in my Xorg.0.log file:
>
> SELinux: Invalid object class mapping, disabling SELinux support.
>
> Should I try the latest policy from oss.tresys.com?  Would the
> upstream reference policy fix this error?
>
> Thanks,
> Mark
>
>   

OK, that error is because the x_pointer and x_keyboard  object classes
haven't made it into F-12 policy yet.

You could try the upstream policy.  I'd recommend sticking with the
Fedora policy though, because I'm getting AVC's from upstream (at least
on rawhide) and upstream is not tuned for Fedora.  If you do compile
from upstream make sure to set the "init_upstart" boolean to true or
everything gets out of whack at boot time.

If you're willing to rebuild the F-12 policy, you can add the attached
patch which will fix the error above and allow the SELinux extension to
run.  As soon as I can get the rest of the new X policy ported I'll send
it to Dan.



-- 

Eamon Walsh 
National Security Agency


--------------010600040509040902000700
Content-Type: text/x-patch;
 name="policy-X1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policy-X1.patch"

diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
index 43c951f..6760c95 100644
--- a/policy/flask/access_vectors
+++ b/policy/flask/access_vectors
@@ -94,6 +94,33 @@ common database
 }
 
 #
+# Define a common prefix for pointer and keyboard access vectors.
+#
+
+common x_device
+{
+	getattr
+	setattr
+	use
+	read
+	write
+	getfocus
+	setfocus
+	bell
+	force_cursor
+	freeze
+	grab
+	manage
+	list_property
+	get_property
+	set_property
+	add
+	remove
+	create
+	destroy
+}
+
+#
 # Define the access vectors.
 #
 # class class_name [ inherits common_name ] { permission_name ... }
@@ -526,27 +553,7 @@ class x_client
 }
 
 class x_device
-{
-	getattr
-	setattr
-	use
-	read
-	write
-	getfocus
-	setfocus
-	bell
-	force_cursor
-	freeze
-	grab
-	manage
-	list_property
-	get_property
-	set_property
-	add
-	remove
-	create
-	destroy
-}
+inherits x_device
 
 class x_server
 {
@@ -803,3 +810,9 @@ class kernel_service
 
 class tun_socket
 inherits socket
+
+class x_pointer
+inherits x_device
+
+class x_keyboard
+inherits x_device
diff --git a/policy/flask/security_classes b/policy/flask/security_classes
index 2bd1bf6..fa65db2 100644
--- a/policy/flask/security_classes
+++ b/policy/flask/security_classes
@@ -121,4 +121,8 @@ class kernel_service
 
 class tun_socket
 
+# Still More SE-X Windows stuff
+class x_pointer			# userspace
+class x_keyboard		# userspace
+
 # FLASK

--------------010600040509040902000700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
