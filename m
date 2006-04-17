Subject: modules.conf "stability" by sorting entries in "make conf"
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-pny2mqJ3egmlo6GPwyjK"
Date: Mon, 17 Apr 2006 19:42:36 +0200
Message-Id: <1145295756.8014.35.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pny2mqJ3egmlo6GPwyjK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
attached is a tiny patch to refpolicy/support/segenxml.py
which will sort module files before processing, so when you create a
"modules.conf" file via "make conf", the entries will be sorted.

Right now, the ordering depends on your filesystem, which makes diffs
(and especially merging) between modules.conf files unnecessary hard.

P.S.
Since sourceforge anon CVS is still broken, you can grab the current CVS
via Debians subversion (thanks to Christopher for giving me RO access to
the 'real' sourceforge.net cvs via ssh), or browse it at
http://svn.debian.org/wsvn/selinux/refpolicy/branches/upstream/
The upstream branch is the unmodified checkout from CVS; the CVS dirs
are there intentionally, but not up to date (since I want to keep them
pointing to SF anon cvs, so anyone can update this branch). I guess CVS
will be smart enough to merge identical changes once sourceforge anon
cvs is updated again; so you should be able to run "cvs up" again
afterwards.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     Which is worse: ignorance or apathy? Who knows? Who cares?     //\
            Es lohnt sich nicht, die Augen aufzumachen,             V_/_
                   wenn der Kopf im Sand steckt.

--=-pny2mqJ3egmlo6GPwyjK
Content-Disposition: attachment; filename=refpolicy-modules-sort.diff
Content-Type: text/x-patch; name=refpolicy-modules-sort.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: support/segenxml.py
===================================================================
--- support/segenxml.py	(Revision 87)
+++ support/segenxml.py	(Arbeitskopie)
@@ -214,7 +214,9 @@
 	
 	# For each module file in the layer, add its XML.
 	for directory in directories:
-		for module in glob.glob("%s/*.if" % directory):
+		modules = glob.glob("%s/*.if" % directory)
+		modules.sort()
+		for module in modules:
 			layer_buf += getModuleXML(module)
 
 	layer_buf.append("</layer>\n")

--=-pny2mqJ3egmlo6GPwyjK--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
