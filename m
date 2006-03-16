Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2GM2m4a026510
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 17:02:49 -0500
Received: from authusersmtp.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2GM1A3h013833
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 22:01:10 GMT
Message-ID: <4419E07F.4090508@cornell.edu>
Date: Thu, 16 Mar 2006 17:02:39 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux ML <selinux@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Bug in the semanage user management code or genhomedircon?
References: <20060316204512.GB30979@hydrogenium.cip.ifi.lmu.de>
In-Reply-To: <20060316204512.GB30979@hydrogenium.cip.ifi.lmu.de>
Content-Type: multipart/mixed;
 boundary="------------090909030406000106040709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090909030406000106040709
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit


> What am I doing wrong?
>   
Can you let me know what you see with the following policycoreutils 
patch, when you try the same thing (do semanage user -l, should show the 
labeling prefix for each user). Dan, you can merge if you want to - I 
don't know if the alignment is ok - are you trying to fit within 
80-columns or something like that?

P.S. I see those get_all() functions being used outside seobject.py (in 
chcat), which doesn't seem like a good idea - breaks encapsulation, and 
adding things like I just did will cause damage.


--------------090909030406000106040709
Content-Type: text/x-patch;
 name="semanage.prefix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.prefix.diff"

diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-03-08 12:16:06.000000000 -0500
+++ new/policycoreutils/semanage/seobject.py	2006-03-16 16:56:37.000000000 -0500
@@ -549,7 +549,7 @@ class seluserRecords(semanageRecords):
 				raise ValueError("Could not list roles for user %s" % name)
 
 			roles = string.join(rlist, ' ');
-			ddict[semanage_user_get_name(u)] = (semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
+			ddict[semanage_user_get_name(u)] = (semanage_user_get_prefix(u), semanage_user_get_mlslevel(u), semanage_user_get_mlsrange(u), roles)
 
 		return ddict
 
@@ -559,10 +559,10 @@ class seluserRecords(semanageRecords):
 		keys.sort()
 		if is_mls_enabled == 1:
 			if heading:
-				print "\n%-15s %-10s %-30s" % ("", "MLS/", "MLS/")
-				print "%-15s %-10s %-30s %s\n" % ("SELinux User", "MCS Level", "MCS Range", "SELinux Roles")
+				print "\n%-15s %-10s %-10s %-30s" % ("", "Labeling", "MLS/", "MLS/")
+				print "%-15s %-10s %-10s %-30s %s\n" % ("SELinux User", "Prefix", "MCS Level", "MCS Range", "SELinux Roles")
 			for k in keys:
-				print "%-15s %-10s %-30s %s" % (k, translate(ddict[k][0]), translate(ddict[k][1]), ddict[k][2])
+				print "%-15s %-10s %-10s %-30s %s" % (k, ddict[k][0], translate(ddict[k][1]), translate(ddict[k][2]), ddict[k][3])
 		else:
 			if heading:
 				print "%-15s %s\n" % ("SELinux User", "SELinux Roles")

--------------090909030406000106040709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
