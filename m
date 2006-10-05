Message-ID: <4525496E.4090209@trustedcs.com>
Date: Thu, 05 Oct 2006 13:05:34 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Daniel Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: [RFC PATCH 1/3] reference policy: add "context" security class
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Define a new security class "context" and its permission "translate" for
use by the context translation daemon.  The bit of policy added to the
setrans_translate_context interface only allows for translation of
domains and file_contexts.  You can see how this is bad if you try to
ls -Z /dev.  I don't have a trick to allow TE access to every type other
than grabbing some "big" attributes, then listing every remaining type.
That obviously does not work in the modular policy model anyway.  Any
ideas on how we could maybe handle that one? (assuming that anyone else
does not want TE restriction on the translations :))  How about a
privilege to use '*' or '~' in typesets...


---


diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
index 5d4f36a..1ef6041 100644
--- a/policy/flask/access_vectors
+++ b/policy/flask/access_vectors
@@ -632,3 +632,8 @@ class key
 	setattr
 	create
 }
+
+class context
+{
+	translate
+}
diff --git a/policy/flask/security_classes b/policy/flask/security_classes
index 57f49bc..53c0cf1 100644
--- a/policy/flask/security_classes
+++ b/policy/flask/security_classes
@@ -93,4 +93,6 @@ class packet
 # Kernel access key retention
 class key
 
+class context			# userspace
+
 # FLASK
diff --git a/policy/mls b/policy/mls
index 06085c5..325a2a5 100644
--- a/policy/mls
+++ b/policy/mls
@@ -617,4 +617,14 @@ mlsconstrain association { polmatch }
 	((( l1 dom l2 ) and ( h1 domby h2 )) or
 	 ( t2 == unlabeled_t ));
 
+
+
+
+#
+# MLS policy for the context class
+#
+
+mlsconstrain context translate
+	( h1 dom h2 );
+
 ') dnl end enable_mls
diff --git a/policy/modules/system/setrans.if b/policy/modules/system/setrans.if
index 9547503..d230770 100644
--- a/policy/modules/system/setrans.if
+++ b/policy/modules/system/setrans.if
@@ -22,4 +22,5 @@ interface(`setrans_translate_context',`
 	allow $1 setrans_var_run_t:sock_file rw_file_perms;
 	allow $1 setrans_var_run_t:dir search_dir_perms;
 	files_list_pids($1)
+	allow $1 { domain file_type }:context translate;
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
