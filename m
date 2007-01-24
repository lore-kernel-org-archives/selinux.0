Message-ID: <45B7BE11.8050705@redhat.com>
Date: Wed, 24 Jan 2007 15:14:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Fixes for chcat to work better in Large category environment.
Content-Type: multipart/mixed;
 boundary="------------060104070501060104030307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060104070501060104030307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Also fixes problem with creating wrong context, by execing semanage 
rather then using python bindings.

--------------060104070501060104030307
Content-Type: text/x-patch;
 name="policycoreutils-chcat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-chcat.patch"

--- nsapolicycoreutils/scripts/chcat	2006-11-16 17:14:27.000000000 -0500
+++ policycoreutils-1.34.1/scripts/chcat	2007-01-24 14:42:19.000000000 -0500
@@ -62,12 +62,20 @@
         for i in newcat[1:]:
             if i not in cats:
                 cats.append(i)
+
         new_serange = "%s-%s:%s" % (serange[0], top[0], string.join(cats, ","))
-        
+        if new_serange[-1:] == ":":
+            new_serange = new_serange[:-1]
+            
         if add_ind:
-            logins.add(u, user[0], new_serange)
+            cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
         else:
-            logins.modify(u, user[0], new_serange)
+            cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
+        rc = commands.getstatusoutput(cmd)
+        if rc[0] != 0:
+            print rc[1]
+            errors += 1
+
     return errors
         
 def chcat_add(orig, newcat, objects,login_ind):
@@ -133,11 +141,17 @@
                 cats.remove(i)
 
         new_serange = "%s-%s:%s" % (serange[0], top[0], string.join(cats, ","))
+        if new_serange[-1:] == ":":
+            new_serange = new_serange[:-1]
         
         if add_ind:
-            logins.add(u, user[0], new_serange)
+            cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
         else:
-            logins.modify(u, user[0], new_serange)
+            cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
+        rc = commands.getstatusoutput(cmd)
+        if rc[0] != 0:
+            print rc[1]
+            errors += 1
     return errors
         
 def chcat_remove(orig, newcat, objects, login_ind):
@@ -198,11 +212,17 @@
             user = seusers["__default__"]
         serange = user[1].split("-")
         new_serange = "%s-%s:%s" % (serange[0],newcat[0], string.join(newcat[1:], ","))
-        
+        if new_serange[-1:] == ":":
+            new_serange = new_serange[:-1]
+
         if add_ind:
-            logins.add(u, user[0], new_serange)
+            cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
         else:
-            logins.modify(u, user[0], new_serange)
+            cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
+        rc = commands.getstatusoutput(cmd)
+        if rc[0] != 0:
+            print rc[1]
+            errors += 1
     return errors
     
 def chcat_replace(newcat, objects, login_ind):

--------------060104070501060104030307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
