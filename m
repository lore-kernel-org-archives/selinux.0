Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA09245
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 15:07:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0MK7DI09039
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 20:07:13 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-196.nas-smoothtransition.com [66.95.157.196] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h0MK79f09009 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 20:07:10 GMT
Received: from BATMAN ([66.200.42.3])
	by mx.nas-smoothtransition.com (8.11.4/8.9.3) with ESMTP id h0MK77n16715
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 15:07:08 -0500
From: "Frank Mayer" <mayerf@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: patch to sepcut tool
Date: Wed, 22 Jan 2003 15:07:02 -0500
Message-ID: <002f01c2c251$d7e258b0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0030_01C2C227.EF0C50B0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0030_01C2C227.EF0C50B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Attached is a patched to setools v0.6.1 which was included in last
week's selinux distribution.  This patch fixes a file handling bug in
sepcut (a basic policy browser/editor).  This patch will also be posted
on www.tresys.com/selinux for those of you who downloads setools from
there.  

To apply, copy the patch to selinux/tools, cd there, and do 'patch -p1 <
sepcut.patch' 

Frank

------=_NextPart_000_0030_01C2C227.EF0C50B0
Content-Type: application/octet-stream;
	name="sepct.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sepct.patch"

diff -ruN rel-0-6-1/setools/sepct/browser.tcl =
rel-0-6-1-patched/setools/sepct/browser.tcl=0A=
--- rel-0-6-1/setools/sepct/browser.tcl	Tue Dec 17 19:16:25 2002=0A=
+++ rel-0-6-1-patched/setools/sepct/browser.tcl	Wed Jan 22 14:58:58 2003=0A=
@@ -274,6 +274,7 @@=0A=
 	    	}=0A=
 	} else {=0A=
 		# no file current opened or was moved/removed=0A=
+		set curr_file ""=0A=
 		$text_c delete 0.0 end=0A=
 		Sepct::clear_fileStatus=0A=
 		Sepct_Browse::reset_dirtyState=0A=
diff -ruN rel-0-6-1/setools/sepct/db.tcl =
rel-0-6-1-patched/setools/sepct/db.tcl=0A=
--- rel-0-6-1/setools/sepct/db.tcl	Mon Dec 16 17:50:44 2002=0A=
+++ rel-0-6-1-patched/setools/sepct/db.tcl	Wed Jan 22 14:58:03 2003=0A=
@@ -290,25 +290,33 @@=0A=
 		puts stderr "Problem getting file info data for $oldfn"=0A=
 		return -1=0A=
 	}=0A=
+	# First, check if oldfn is in modlist =0A=
+	set rt [Sepct_db::getModFile_Data $oldfn old_data]=0A=
+	=0A=
+	if {$rt !=3D -1} {=0A=
+		# oldfn IS in mod list=0A=
+		Sepct_db::remove_from_mod_List $oldfn=0A=
+	}=0A=
+	=0A=
+	# Remove the file from its' parent node in the tree =0A=
 	if { [Sepct_db::remove_file $oldfn] =3D=3D -1 } {=0A=
 		puts stderr "Problem removing $oldfn"=0A=
 		return -1=0A=
 	}=0A=
+	=0A=
+	# Add the new file to parent node in the tree =0A=
 	if {[Sepct_db::add_file $newfn 0] =3D=3D -1 }  {=0A=
 		puts stderr "Problem adding $newfn"=0A=
 		return -1=0A=
 	}=0A=
 	=0A=
-	# now check if oldfn is in modlist and if so rename it to newfn=0A=
-	set rt [Sepct_db::getModFile_Data $oldfn old_data]=0A=
-	if {$rt !=3D -1 } {=0A=
-		# oldfn IS in mod list=0A=
-		Sepct_db::remove_from_mod_List $oldfn=0A=
+	# Add newfn to the modlist.=0A=
+	if {$rt !=3D -1} {=0A=
 		set cnt [Sepct_db::add_to_mod_List $newfn $old_data]=0A=
 	} else {=0A=
 		set cnt 0=0A=
 	}=0A=
-=0A=
+		=0A=
 	return $cnt=0A=
 }=0A=
 =0A=

------=_NextPart_000_0030_01C2C227.EF0C50B0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
