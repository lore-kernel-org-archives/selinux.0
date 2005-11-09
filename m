Message-ID: <36282A1733C57546BE392885C0618592E1C2F2@chaos.tcs.tcs-sec.com>
From: Jonathan Kim <jkim@TrustedCS.com>
To: dwalsh@redhat.com
Cc: SELinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
Subject: [PATCH] MLS Policy 
Date: Wed, 9 Nov 2005 11:04:21 -0500 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5E547.3F029620"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5E547.3F029620
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5E547.3F029620"


------_=_NextPart_001_01C5E547.3F029620
Content-Type: text/plain;
	charset="iso-8859-1"

The attached patch corrects an apparent typo in the base_can_network macro. 
With the patch applied, it will be possible to do "ssh or ping localhost",
for example.
 
Also, the NSA policy already contains the correct comments for all of the
MLS attributes in the file attrib.te, but the 'policy-20051021.patch' is
patching over these comments with older comments. 
The fix is to not patch that portion of the attrib.te file
 
Thank you

----------------------------------- 
Jonghoon Jonathan 
Secure Systems Engineer 

Trusted Computer Solutions 
121 W Goose Alley 
Urbana, IL  61801 

http://www.TrustedCS.com <http://www.trustedcs.com/>  

V:  217.384.0028  ext.16 
F:  217.384.0288 

 

------_=_NextPart_001_01C5E547.3F029620
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2800.1479" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2>The attached patch corrects an apparent typo in the 
base_can_network<SPAN class=047084815-09112005> </SPAN>macro. </FONT></DIV>
<DIV><FONT face=Arial size=2>With the patch applied, it will be possible to do 
"ssh or ping localhost", for example.</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>Also, the NSA policy already contains the correct 
comments for all of the MLS attributes in the file attrib.te, but the 
'policy-20051021.patch' is patching over these comments with older comments. 
</FONT></DIV>
<DIV><FONT face=Arial size=2>The fix is to not patch that portion of the 
attrib.te file</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><SPAN class=047084815-09112005><FONT face=Arial size=2>Thank 
you</FONT></SPAN></DIV>
<P><FONT face="Courier New" size=2>-----------------------------------</FONT> 
<BR><B><FONT face=Arial size=2>Jonghoon Jonathan</FONT></B> <BR><FONT face=Arial 
size=2>Secure Systems Engineer</FONT> </P>
<P><B><FONT face=Arial size=2>Trusted Computer Solutions</FONT></B> <BR><FONT 
face=Arial size=2>121 W Goose Alley</FONT> <BR><FONT face=Arial size=2>Urbana, 
IL&nbsp; 61801</FONT> </P>
<P><FONT face=Arial size=2><A href="http://www.trustedcs.com/" 
target=_blank>http://www.TrustedCS.com</A></FONT> </P>
<P><B><FONT face=Arial size=2>V:</FONT></B><FONT face=Arial size=2>&nbsp; 
217.384.0028&nbsp; ext.16</FONT> <BR><B><FONT face=Arial 
size=2>F:&nbsp;</FONT></B> <FONT face=Arial size=2>217.384.0288</FONT> </P>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C5E547.3F029620--

------_=_NextPart_000_01C5E547.3F029620
Content-Type: application/octet-stream;
	name="policy-mls-1.27.2.patch.netif"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policy-mls-1.27.2.patch.netif"

diff -Nur policy-1.27.2.orig/macros/network_macros.te =
policy-1.27.2/macros/network_macros.te=0A=
--- policy-1.27.2.orig/macros/network_macros.te	2005-11-08 =
15:07:10.000000000 -0600=0A=
+++ policy-1.27.2/macros/network_macros.te	2005-11-08 =
15:33:23.000000000 -0600=0A=
@@ -16,7 +16,7 @@=0A=
 # Allow the domain to send or receive using any network interface.=0A=
 # netif_type is a type attribute for all network interface types.=0A=
 #=0A=
-allow $1 netif_t:netif { $2_recv $2_send rawip_send rawip_recv };=0A=
+allow $1 netif_type:netif { $2_recv $2_send rawip_send rawip_recv =
};=0A=
 #=0A=
 # Allow the domain to send to or receive from any node.=0A=
 # node_type is a type attribute for all node types.=0A=

------_=_NextPart_000_01C5E547.3F029620--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
