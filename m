Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n31EAm6q021239
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:10:48 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n31EAlrT018111
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 14:10:48 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n31EAj6f026422
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:10:45 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n31EAjPM025458
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:10:46 -0400
Received: from dhcp-100-2-12.bos.redhat.com (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n31EAiqW023639
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 10:10:44 -0400
Message-ID: <49D375E3.3010800@redhat.com>
Date: Wed, 01 Apr 2009 10:10:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: patch to policycoreutils
Content-Type: multipart/mixed;
 boundary="------------080805090404010300010700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080805090404010300010700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Multiple patches to policycoreutils.

First added /root/.ssh and /root/.ssh/*  to allow people to place keys 
in /root directory and have them labeled by restorcond

Fix transaction handling in semanage so you can update multiple records 
simultaniously.

Clean up permissive domains creation in semanage so it does not leave 
crap in /var/lib/selinux


--------------080805090404010300010700
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.16 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/restorecond/restorecond.conf policycoreutils-2.0.62/restorecond/restorecond.conf
--- nsapolicycoreutils/restorecond/restorecond.conf	2009-02-18 16:44:47.000000000 -0500
+++ policycoreutils-2.0.62/restorecond/restorecond.conf	2009-02-23 11:32:21.000000000 -0500
@@ -5,3 +5,7 @@
 /var/run/utmp
 /var/log/wtmp
 ~/*
+/root/.ssh
+/root/.ssh/*
+
+
diff --exclude-from=exclude --exclude=sepolgen-1.0.16 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-2.0.62/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2009-02-18 16:44:47.000000000 -0500
+++ policycoreutils-2.0.62/scripts/fixfiles	2009-02-19 10:07:49.000000000 -0500
@@ -122,7 +122,7 @@
 fi
 if [ ! -z "$RPMFILES" ]; then
     for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -i -f - 2>&1 >> $LOGFILE
+	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -R -i -f - 2>&1 >> $LOGFILE
     done
     exit $?
 fi
diff --exclude-from=exclude --exclude=sepolgen-1.0.16 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/semanage policycoreutils-2.0.62/semanage/semanage
--- nsapolicycoreutils/semanage/semanage	2009-02-18 16:44:47.000000000 -0500
+++ policycoreutils-2.0.62/semanage/semanage	2009-03-12 09:22:45.000000000 -0400
@@ -464,10 +464,10 @@
                       else:
                              fd = open(input, 'r')
                       trans = seobject.semanageRecords(store)
-                      trans.begin()
+                      trans.start()
                       for l in fd.readlines():
                              process_args(mkargv(l))
-                      trans.commit()
+                      trans.finish()
                else:
                       process_args(sys.argv[1:])
 			
diff --exclude-from=exclude --exclude=sepolgen-1.0.16 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-2.0.62/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2008-11-14 17:10:15.000000000 -0500
+++ policycoreutils-2.0.62/semanage/seobject.py	2009-03-31 08:54:25.000000000 -0400
@@ -281,15 +281,20 @@
                global handle
                       
                if handle != None:
-                      self.transaction = True
                       self.sh = handle
                else:
                       self.sh=get_handle(store)
-                      self.transaction = False
+               self.transaction = False
 
         def deleteall(self):
                raise ValueError(_("Not yet implemented"))
 
+        def start(self):
+               if self.transaction:
+                      raise ValueError(_("Semanage transaction already in progress"))
+               self.begin()
+               self.transaction = True
+
         def begin(self):
                if self.transaction:
                       return
@@ -303,6 +308,12 @@
                if rc < 0:
                       raise ValueError(_("Could not commit semanage transaction"))
 
+        def finish(self):
+               if not self.transaction:
+                      raise ValueError(_("Semanage transaction not in progress"))
+               self.transaction = False
+               self.commit()
+
 class permissiveRecords(semanageRecords):
 	def __init__(self, store):
                semanageRecords.__init__(self, store)
@@ -328,6 +339,7 @@
 
 
 	def add(self, type):
+               import glob
                name = "permissive_%s" % type
                dirname = "/var/lib/selinux"
                os.chdir(dirname)
@@ -351,16 +363,19 @@
                fd.close()
 
                rc = semanage_module_install(self.sh, data, len(data));
-               if rc < 0:
-			raise ValueError(_("Could not set permissive domain %s (module installation failed)") % name)
-
-               self.commit()
+               if rc >= 0:
+                      self.commit()
 
                for root, dirs, files in os.walk("tmp", topdown=False):
                       for name in files:
                              os.remove(os.path.join(root, name))
                       for name in dirs:
                              os.rmdir(os.path.join(root, name))
+               os.removedirs("tmp")
+               for i in glob.glob("permissive_%s.*" % type):
+                      os.remove(i)
+               if rc < 0:
+			raise ValueError(_("Could not set permissive domain %s (module installation failed)") % name)
 
 	def delete(self, name):
                for n in name.split():

--------------080805090404010300010700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
