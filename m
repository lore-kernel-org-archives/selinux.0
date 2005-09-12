From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com, SELinux List <SELinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: disable setenforce
Date: Mon, 12 Sep 2005 16:52:48 +1000
Cc: Todd Merritt <tmerritt@email.arizona.edu>
References: <1126283594.20003.17.camel@hive.ccit.arizona.edu>
In-Reply-To: <1126283594.20003.17.camel@hive.ccit.arizona.edu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LXSJDxws/AyIoaJ"
Message-Id: <200509121652.59242.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_LXSJDxws/AyIoaJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 10 September 2005 02:33, Todd Merritt <tmerritt@email.arizona.edu> 
wrote:
> I can't find where I read this now, could somebody please tell me what I
> need to add/remove from the strict policy to disallow running of the
> setenforce command (but still allow changing enforcement mode via
> rebooting) ?

I've attached a patch against the latest rawhide policy (which should also 
work against the latest FC4 policy).

This patch adds a new boolean named secure_mode_policyload to cover loading 
policy, setting boolean states, and setting enforcing mode.  It also adds a 
new boolean named secure_mode_insmod to control module loading.

NB  Setting secure_mode_policyload to default to 1 at boot time will work, but 
that means policy can only be loaded once at boot (should be able to install 
new policy and reboot the machine though).  Setting secure_mode_insmod at 
boot will probably make the boot process fail for all non-trivial machines, 
the initial values of booleans are set before modules for devices such as 
Ethernet cards.  Setting secure_mode_insmod after the boot process is 
completed might be a good idea if you have no plans to use USB or 
Cardbus/PCMCIA, there have been exploits which relied on the ability to trick 
the system into loading modules (EG the ptrace exploit).

We could probably do with more work in this area, but the patch I have 
attached works reasonably well and adds usefully to the secure_mode 
functionality so I believe it's worthy of inclusion.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_LXSJDxws/AyIoaJ
Content-Type: text/x-diff;
  charset="utf-8";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- macros/global_macros.te.orig	2005-09-12 16:22:12.000000000 +1000
+++ macros/global_macros.te	2005-09-12 16:23:37.000000000 +1000
@@ -699,8 +699,10 @@
 allow $1 domain:msg  { send receive };
 
 # Access the security API.
+if (!secure_mode) {
 allow $1 security_t:security *;
 auditallow $1 security_t:security { load_policy setenforce setbool };
+}dnl end if !secure_mode
 
 # Perform certain system operations that lacked individual capabilities.
 allow $1 kernel_t:system *;
--- macros/core_macros.te.orig	2005-09-12 16:14:59.000000000 +1000
+++ macros/core_macros.te	2005-09-12 16:33:15.000000000 +1000
@@ -306,8 +306,10 @@
 # Access selinuxfs.
 allow $1 security_t:dir { read search getattr };
 allow $1 security_t:file { getattr read write };
+if (!secure_mode) {
 allow $1 security_t:security setenforce;
 auditallow $1 security_t:security setenforce;
+}dnl end if !secure_mode
 ')
 
 ##################################
@@ -326,8 +328,10 @@
 # Access selinuxfs.
 allow $1 security_t:dir { read search getattr };
 allow $1 security_t:file { getattr read write };
+if (!secure_mode) {
 allow $1 security_t:security setbool;
 auditallow $1 security_t:security setbool;
+}dnl end if !secure_mode
 ')
 
 ##################################
@@ -367,8 +371,10 @@
 # Access selinuxfs.
 allow $1 security_t:dir { read search getattr };
 allow $1 security_t:file { getattr read write };
+if (!secure_mode) {
 allow $1 security_t:security load_policy;
 auditallow $1 security_t:security load_policy;
+}dnl end if !secure_mode
 ')
 
 #################################

--Boundary-00=_LXSJDxws/AyIoaJ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
