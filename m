Message-ID: <1343399960.17570.52.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Could we set them as "mlstrustedsubject"?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <bill.c.roberts@gmail.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        "Craig, Robert P."
 <rpcraig@tycho.ncsc.mil>
Date: Fri, 27 Jul 2012 10:39:20 -0400
In-Reply-To: <CAO-4OdGJhr3H7Q8uJz0JWgEekHqo=K8gS3aU_si__f4y5dzPxQ@mail.gmail.com>
References: 
	<CAO-4OdGJhr3H7Q8uJz0JWgEekHqo=K8gS3aU_si__f4y5dzPxQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-XftdcNPMIzARZ1yPX1Cl"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XftdcNPMIzARZ1yPX1Cl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-07-26 at 14:25 -0700, Haiqing Jiang wrote:
> Hi, all
> 
> 
> Currently I am testing Android CTS in SEAndroid. I find several
> denials are related to MLS constraints. The key-signed apps, like
> "platform_app", "release_app",
> "browser_app", "shared_app" and "media_app", need to open
> app_data_file. But because of MLS, they cannot do that. So, could we
> sign them as mlstrusted? 
> Currently only daemons are set "mlstrustedsubject". Do you have any
> ideas? Or the better solutions to solve the denials? 

This would mean that SELinux would no longer be enforcing per-app
process and file isolation for the platform (where by platform, I mean
any of the apps signed by build keys, i.e. platform|release|shared|
media) apps.  You would be back to relying on DAC for per-app separation
among the platform apps.

Further, I don't think that this change alone would solve the general
problem, as the platform app data files will still be labeled with
per-app categories and thus I expect you'll see the same problems arise
for the third party apps trying to access files created by the platform
apps (passed to them by open file descriptor for private files or by
pathname for shared prefs over Binder IPC).

So I think in addition to making them mlstrustedsubjects, we would need
to introduce a new file type for the platform app data files, make that
type a mlstrustedobject, assign that type to the platform apps in
seapp_contexts, and remove levelFromUid=true from those entries.  That
still means that SELinux will no longer be enforcing per-app isolation
for the platform apps, only for third party apps, but now the third
party apps can be allowed to read/write files created by the platform
apps and passed to them over Binder IPC.  Attached is a patch that
demonstrates this approach.  It only defines a single new file type for
all of the platform apps; we could alternatively introduce a separate
type per domain, but that only makes sense if they don't end up needing
access to each other's data types.  Truly testing this patch requires
testing some third party apps, not just the platform apps, as you won't
see any MLS restrictions come into play now without third party apps.

-- 
Stephen Smalley
National Security Agency

--=-XftdcNPMIzARZ1yPX1Cl
Content-Disposition: attachment; filename="sepolicy-platformapp.patch"
Content-Type: text/x-patch; name="sepolicy-platformapp.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/app.te b/app.te
index 0866e95..df0f5df 100644
--- a/app.te
+++ b/app.te
@@ -8,6 +8,7 @@
 #
 type platform_app, domain;
 app_domain(platform_app)
+platform_app_domain(platform_app)
 # Access the network.
 net_domain(platform_app)
 # Access bluetooth.
@@ -30,6 +31,7 @@ allow platform_app apk_tmp_file:file rw_file_perms;
 # Apps signed with the media key.
 type media_app, domain;
 app_domain(media_app)
+platform_app_domain(media_app)
 # Access the network.
 net_domain(media_app)
 # Read logs.
@@ -45,9 +47,11 @@ allow media_app sdcard:file create_file_perms;
 # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
 allow media_app qtaguid_proc:file rw_file_perms;
 allow media_app qtaguid_device:chr_file r_file_perms;
+
 # Apps signed with the shared key.
 type shared_app, domain;
 app_domain(shared_app)
+platform_app_domain(shared_app)
 # Access the network.
 net_domain(shared_app)
 # Access bluetooth.
@@ -58,6 +62,7 @@ allow shared_app log_device:chr_file read;
 # Apps signed with the release key (testkey in AOSP).
 type release_app, domain;
 app_domain(release_app)
+platform_app_domain(release_app)
 # Access the network.
 net_domain(release_app)
 # Access bluetooth.
@@ -70,10 +75,19 @@ allow release_app log_device:chr_file read;
 # A domain for com.android.browser.
 type browser_app, domain;
 app_domain(browser_app)
+platform_app_domain(browser_app)
 # Access the network.
 net_domain(browser_app)
 
 #
+# Rules for platform app domains.
+#
+
+# App sandbox file accesses.
+allow platformappdomain platform_app_data_file:dir create_dir_perms;
+allow platformappdomain platform_app_data_file:notdevfile_class_set create_file_perms;
+
+#
 # Untrusted apps.
 #
 type untrusted_app, domain;
@@ -132,6 +146,9 @@ allow appdomain surfaceflinger:unix_stream_socket { read write setopt };
 allow appdomain app_data_file:dir create_dir_perms;
 allow appdomain app_data_file:notdevfile_class_set create_file_perms;
 
+# Read/write data files created by the platform apps.
+allow appdomain platform_app_data_file:file rw_file_perms;
+
 # lib subdirectory of /data/data dir is system-owned.
 allow appdomain system_data_file:dir r_dir_perms;
 
diff --git a/attributes b/attributes
index 1016ec6..ef4a170 100644
--- a/attributes
+++ b/attributes
@@ -58,3 +58,6 @@ attribute bluetoothdomain;
 
 # All domains used for binder service domains.
 attribute binderservicedomain;
+
+# Allow domains used for platform (signed by build key) apps.
+attribute platformappdomain;
diff --git a/file.te b/file.te
index 9af8ca5..132f9ea 100644
--- a/file.te
+++ b/file.te
@@ -51,6 +51,7 @@ type nfc_data_file, file_type, data_file_type;
 type camera_calibration_file, file_type, data_file_type;
 # /data/data subdirectories - app sandboxes
 type app_data_file, file_type, data_file_type;
+type platform_app_data_file, file_type, data_file_type, mlstrustedobject;
 # Default type for anything under /cache
 type cache_file, file_type, mlstrustedobject;
 # Default type for anything under /efs
diff --git a/seapp_contexts b/seapp_contexts
index 502206a..088937b 100644
--- a/seapp_contexts
+++ b/seapp_contexts
@@ -33,8 +33,8 @@ user=system domain=system_app type=system_data_file
 user=nfc domain=nfc type=nfc_data_file
 user=radio domain=radio type=radio_data_file
 user=app_* domain=untrusted_app type=app_data_file levelFromUid=true
-user=app_* seinfo=platform domain=platform_app levelFromUid=true
-user=app_* seinfo=shared domain=shared_app levelFromUid=true
-user=app_* seinfo=media domain=media_app levelFromUid=true
-user=app_* seinfo=release domain=release_app levelFromUid=true
-user=app_* seinfo=release name=com.android.browser domain=browser_app levelFromUid=true
+user=app_* seinfo=platform domain=platform_app type=platform_app_data_file
+user=app_* seinfo=shared domain=shared_app type=platform_app_data_file
+user=app_* seinfo=media domain=media_app type=platform_app_data_file
+user=app_* seinfo=release domain=release_app type=platform_app_data_file
+user=app_* seinfo=release name=com.android.browser domain=browser_app type=platform_app_data_file
diff --git a/te_macros b/te_macros
index 9146e22..6354496 100644
--- a/te_macros
+++ b/te_macros
@@ -109,6 +109,14 @@ tmpfs_domain($1)
 ')
 
 #####################################
+# platform_app_domain(domain)
+# Allow permissions specific to platform apps.
+define(`platform_app_domain', `
+typeattribute $1 platformappdomain;
+typeattribute $1 mlstrustedsubject;
+')
+
+#####################################
 # net_domain(domain)
 # Allow a base set of permissions required for network access.
 define(`net_domain', `

--=-XftdcNPMIzARZ1yPX1Cl--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
