Message-ID: <36282A1733C57546BE392885C0618592D39AF8@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Chad Hanson <chanson@TrustedCS.com>,
   "SE Linux (E-mail)"
	 <SELinux@tycho.nsa.gov>
Cc: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   "Daniel J Walsh (E-mail)" <dwalsh@redhat.com>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Subject: RE: [PATCH] MLS
Date: Wed, 19 Oct 2005 14:49:03 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5D4DD.C65D2060"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5D4DD.C65D2060
Content-Type: text/plain;
	charset="iso-8859-1"


> I have attached a patch which can be applied to Dan Walsh's 
> current MLS source rpm to update the MLS constraints and 
> provide comments for the MLS attributes.

I have fixed some incorrect comments missed in the initial reviews. The
attached version policy-20051019a.patch should be used instead of the
previous post

Thanks,
-Chad

 <<policy-20051019a.patch>> 

------_=_NextPart_000_01C5D4DD.C65D2060
Content-Type: application/octet-stream;
	name="policy-20051019a.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policy-20051019a.patch"

--- policy-1.27.1/attrib.te	2005-10-19 08:48:10.000000000 -0500=0A=
+++ policy-mls/attrib.te	2005-10-19 13:42:34.274724274 -0500=0A=
@@ -8,83 +8,125 @@=0A=
 # explicitly declared here, and can then be associated with =
particular=0A=
 # types in type declarations.  Attribute names can then be used =
throughout =0A=
 # the configuration to express the set of types that are associated =
with =0A=
-# the attribute.  Except for the MLS attributes, attributes have no =
implicit=0A=
-# meaning to SELinux.  The meaning of all other attributes are =
completely =0A=
-# defined through their usage within the configuration, but should be =
=0A=
-# documented here as comments preceding the attribute declaration.  =
=0A=
+# the attribute.  Attributes have no implicit meaning to SELinux.  =
The=0A=
+# meaning of all attributes are completely defined through their=0A=
+# usage within the configuration, but should be documented here as=0A=
+# comments preceding the attribute declaration.  =0A=
 =0A=
 #####################=0A=
 # Attributes for MLS:=0A=
 #=0A=
 =0A=
-# Read files and search directories that have a classification higher =
than=0A=
-# subject clearance=0A=
-attribute mlsfileread;=0A=
+# Common Terminology=0A=
+# 	MLS Range: low-high=0A=
+#		low referred to as "Effective Sensitivity Label (SL)"=0A=
+#		high referred to as "Clearance SL"=0A=
 =0A=
-# Read files and search directories with a classification higher than =
the=0A=
-# effective clearance but not higher than the clearance=0A=
-attribute mlsfilereadtoclr;=0A=
 =0A=
-# Write files and directories in situations where MLS normally denies =
writes=0A=
+#=0A=
+# File System MLS attributes/privileges=0A=
+#=0A=
+# Grant MLS read access to files not dominated by the process =
Effective SL=0A=
+attribute mlsfileread;=0A=
+# Grant MLS read access to files dominated by the process Clearance =
SL=0A=
+attribute mlsfilereadtoclr;=0A=
+# Grant MLS write access to files not equal to the Effective SL=0A=
 attribute mlsfilewrite;=0A=
-=0A=
-# Write files and directories where clearance of the subject dominates =
the=0A=
-# classification of the file/dir and the classification of the =
file/dir=0A=
-# dominates the effective clearance of the subject.=0A=
+# Grant MLS write access to files which dominate the process Effective =
SL=0A=
+# and are dominated by the process Clearance SL=0A=
 attribute mlsfilewritetoclr;=0A=
-=0A=
-# Increase the classification and/or effective classification of the =
object=0A=
-# regardless of the clearance of the subject.=0A=
+# Grant MLS ability to change file label to a new label which =
dominates=0A=
+# the old label  =0A=
 attribute mlsfileupgrade;=0A=
-=0A=
-# Decrease the classification and/or effective classification of the =
object=0A=
-# regardless of the clearance of the subject.  NB An new label with =
an=0A=
-# incomparable effective classification and an equal classification =
is=0A=
-# considered a downgrade as is an incomparable classification=0A=
+# Grant MLS ability to change file label to a new label which is=0A=
+# dominated by or incomparable to the old label=0A=
 attribute mlsfiledowngrade;=0A=
 =0A=
-# Read network data with a lower effective classification than the =
effective=0A=
-# clearance of the process=0A=
+#=0A=
+# Network MLS attributes/privileges=0A=
+#=0A=
+# Grant MLS read access to packets not dominated by the process =
Effective SL=0A=
 attribute mlsnetread;=0A=
-=0A=
-# Read network data with a lower effective classification than the =
effective=0A=
-# clearance of the process when the classification of the process is =
higher=0A=
+# Grant MLS read access to packets dominated by the process Clearance =
SL=0A=
 attribute mlsnetreadtoclr;=0A=
-=0A=
-# Write network data with a higher effective classification or with =
a=0A=
-# classification higher than the clearance of the subject=0A=
+# Grant MLS write access to packets not equal to the Effective SL=0A=
 attribute mlsnetwrite;=0A=
-=0A=
-# Write network data where the clearance of the process dominates =
the=0A=
-# effective classification of the data and the effective =
classification of=0A=
-# the data dominates the effective clearance of the subject.=0A=
+# Grant MLS write access to packets which dominate the Effective SL=0A=
+# and are dominated by the process Clearance SL=0A=
 attribute mlsnetwritetoclr;=0A=
-=0A=
+# Grant MLS read access to packets from hosts or interfaces which =
dominate=0A=
+# or incomparable to the process Effective SL=0A=
+attribute mlsnetrecvall;=0A=
+# Grant MLS ability to change socket label to a new label which =
dominates=0A=
+# the old label  =0A=
 attribute mlsnetupgrade;=0A=
+# Grant MLS ability to change socket label to a new label which is=0A=
+# dominated by or incomparable to the old label=0A=
 attribute mlsnetdowngrade;=0A=
-attribute mlsnetrecvall;=0A=
 =0A=
+#=0A=
+# IPC MLS attributes/privileges=0A=
+#=0A=
+# Grant MLS read access to IPC objects not dominated by the process =
Effective SL=0A=
 attribute mlsipcread;=0A=
+# Grant MLS read access to IPC objects dominated by the process =
Clearance SL=0A=
 attribute mlsipcreadtoclr;=0A=
+# Grant MLS write access to IPC objects not equal to the process =
Effective SL=0A=
 attribute mlsipcwrite;=0A=
+# Grant MLS write access to IPC objects which dominate the process =
Effective SL=0A=
+# and are dominated by the process Clearance SL=0A=
 attribute mlsipcwritetoclr;=0A=
 =0A=
+#=0A=
+# Process MLS attributes/privileges=0A=
+#=0A=
+# Grant MLS read access to processes not dominated by the process =
Effective SL=0A=
 attribute mlsprocread;=0A=
+# Grant MLS read access to processes dominated by the process =
Clearance SL=0A=
 attribute mlsprocreadtoclr;=0A=
+# Grant MLS write access to processes not equal to the Effective SL=0A=
 attribute mlsprocwrite;=0A=
+# Grant MLS write access to processes which dominate the process =
Effective SL=0A=
+# and are dominated by the process Clearance SL=0A=
 attribute mlsprocwritetoclr;=0A=
+# Grant MLS ability to change Effective SL or Clearance SL of process =
to a=0A=
+# label dominated by the Clearance SL=0A=
 attribute mlsprocsetsl;=0A=
 =0A=
+#=0A=
+# X Window MLS attributes/privileges=0A=
+#=0A=
+# Grant MLS read access to X objects not dominated by the process =
Effective SL=0A=
 attribute mlsxwinread;=0A=
+# Grant MLS read access to X objects dominated by the process =
Clearance SL=0A=
 attribute mlsxwinreadtoclr;=0A=
+# Grant MLS write access to X objects not equal to the process =
Effective SL=0A=
 attribute mlsxwinwrite;=0A=
+# Grant MLS write access to X objects which dominate the process =
Effective SL=0A=
+# and are dominated by the process Clearance SL=0A=
 attribute mlsxwinwritetoclr;=0A=
-attribute mlsxwinupgrade;=0A=
-attribute mlsxwindowngrade;=0A=
+# Grant MLS read access to X properties not dominated by=0A=
+# the process Effective SL=0A=
+attribute mlsxwinreadproperty;=0A=
+# Grant MLS write access to X properties not equal to the process =
Effective SL=0A=
+attribute mlsxwinwriteproperty;=0A=
+# Grant MLS read access to X colormaps not dominated by=0A=
+# the process Effective SL=0A=
+attribute mlsxwinreadcolormap;=0A=
+# Grant MLS write access to X colormaps not equal to the process =
Effective SL=0A=
+attribute mlsxwinwritecolormap;=0A=
+# Grant MLS write access to X xinputs not equal to the process =
Effective SL=0A=
+attribute mlsxwinwritexinput;=0A=
 =0A=
+# Grant MLS read/write access to objects which internally arbitrate =
MLS=0A=
 attribute mlstrustedobject;=0A=
 =0A=
+#=0A=
+# Both of the following attributes are needed for a range transition =
to succeed=0A=
+#=0A=
+# Grant ability for the current domain to change SL upon process =
transition=0A=
 attribute privrangetrans;=0A=
+# Grant ability for the new process domain to change SL upon process =
transition=0A=
 attribute mlsrangetrans;=0A=
 =0A=
 #########################=0A=
--- policy-1.27.1/mls	2005-10-19 08:48:10.811313382 -0500=0A=
+++ policy-mls/mls	2005-10-19 08:45:00.351868012 -0500=0A=
@@ -492,7 +560,8 @@=0A=
 mlsconstrain window { addchild create destroy chstack chproplist =
chprop setattr setfocus move chselection chparent ctrllife transparent =
clientcomevent }=0A=
 	(( l1 eq l2 ) or=0A=
 	 (( t1 =3D=3D mlsxwinwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 =
)) or=0A=
-	 ( t1 =3D=3D mlsxwinwrite ));=0A=
+	 ( t1 =3D=3D mlsxwinwrite ) or=0A=
+	 ( t2 =3D=3D mlstrustedobject ));=0A=
 =0A=
 # these access vectors have no MLS restrictions=0A=
 # window { map unmap }=0A=
@@ -530,12 +599,14 @@=0A=
 mlsconstrain colormap { list read getattr }=0A=
 	(( l1 dom l2 ) or=0A=
 	 (( t1 =3D=3D mlsxwinreadtoclr ) and ( h1 dom l2 )) or=0A=
+	 ( t1 =3D=3D mlsxwinreadcolormap ) or=0A=
 	 ( t1 =3D=3D mlsxwinread ));=0A=
 =0A=
 # the colormap "write" ops (implicit single level)=0A=
 mlsconstrain colormap { create free install uninstall store setattr =
}=0A=
 	(( l1 eq l2 ) or=0A=
 	 (( t1 =3D=3D mlsxwinwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 =
)) or=0A=
+	 ( t1 =3D=3D mlsxwinwritecolormap ) or=0A=
 	 ( t1 =3D=3D mlsxwinwrite ));=0A=
 =0A=
 =0A=
@@ -549,12 +620,14 @@=0A=
 mlsconstrain property { read }=0A=
 	(( l1 dom l2 ) or=0A=
 	 (( t1 =3D=3D mlsxwinreadtoclr ) and ( h1 dom l2 )) or=0A=
+	 ( t1 =3D=3D mlsxwinreadproperty ) or=0A=
 	 ( t1 =3D=3D mlsxwinread ));=0A=
 =0A=
 # the property "write" ops (implicit single level)=0A=
 mlsconstrain property { create free write }=0A=
 	(( l1 eq l2 ) or=0A=
 	 (( t1 =3D=3D mlsxwinwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 =
)) or=0A=
+	 ( t1 =3D=3D mlsxwinwriteproperty ) or=0A=
 	 ( t1 =3D=3D mlsxwinwrite ));=0A=
 =0A=
 =0A=
@@ -590,16 +663,14 @@=0A=
 # MLS policy for the xinput class=0A=
 #=0A=
 =0A=
-# the xinput "read" ops (implicit single level)=0A=
-mlsconstrain xinput { lookup getattr mousemotion }=0A=
-	(( l1 dom l2 ) or=0A=
-	 (( t1 =3D=3D mlsxwinreadtoclr ) and ( h1 dom l2 )) or=0A=
-	 ( t1 =3D=3D mlsxwinread ));=0A=
+# these access vectors have no MLS restrictions=0A=
+# xinput ~{ relabelinput setattr }=0A=
 =0A=
 # the xinput "write" ops (implicit single level)=0A=
-mlsconstrain xinput { setattr setfocus warppointer activegrab =
passivegrab ungrab bell relabelinput }=0A=
+mlsconstrain xinput { setattr relabelinput }=0A=
 	(( l1 eq l2 ) or=0A=
 	 (( t1 =3D=3D mlsxwinwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 =
)) or=0A=
+	 ( t1 =3D=3D mlsxwinwritexinput ) or=0A=
 	 ( t1 =3D=3D mlsxwinwrite ));=0A=
 =0A=
 =0A=
@@ -609,17 +680,8 @@=0A=
 # MLS policy for the xserver class=0A=
 #=0A=
 =0A=
-# the xserver "read" ops (implicit single level)=0A=
-mlsconstrain xserver { gethostlist getfontpath getattr screensaver =
}=0A=
-	(( l1 dom l2 ) or=0A=
-	 (( t1 =3D=3D mlsxwinreadtoclr ) and ( h1 dom l2 )) or=0A=
-	 ( t1 =3D=3D mlsxwinread ));=0A=
-=0A=
-# the xserver "write" ops (implicit single level)=0A=
-mlsconstrain xserver { sethostlist setfontpath grab ungrab screensaver =
}=0A=
-	(( l1 eq l2 ) or=0A=
-	 (( t1 =3D=3D mlsxwinwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 =
)) or=0A=
-	 ( t1 =3D=3D mlsxwinwrite ));=0A=
+# these access vectors have no MLS restrictions=0A=
+# xserver *=0A=
 =0A=
 =0A=
 =0A=
@@ -628,17 +690,8 @@=0A=
 # MLS policy for the xextension class=0A=
 #=0A=
 =0A=
-# the xextension "read" ops (implicit single level)=0A=
-mlsconstrain xextension query=0A=
-	(( l1 dom l2 ) or=0A=
-	 (( t1 =3D=3D mlsxwinreadtoclr ) and ( h1 dom l2 )) or=0A=
-	 ( t1 =3D=3D mlsxwinread ));=0A=
-=0A=
-# the xextension "write" ops (implicit single level)=0A=
-mlsconstrain xextension use=0A=
-	(( l1 eq l2 ) or=0A=
-	 (( t1 =3D=3D mlsxwinwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 =
)) or=0A=
-	 ( t1 =3D=3D mlsxwinwrite ));=0A=
+# these access vectors have no MLS restrictions=0A=
+# xextension { query use }=0A=
 =0A=
 =0A=
 #=0A=

------_=_NextPart_000_01C5D4DD.C65D2060--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
