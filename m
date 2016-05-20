Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4KIC1ZD015993
 for <selinux@tycho.nsa.gov>; Fri, 20 May 2016 14:12:01 -0400
Received: from apxexsophos02.apex.local (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 9B4E225794B_73F536AB
 for <selinux@tycho.nsa.gov>; Fri, 20 May 2016 18:11:54 +0000 (GMT)
Received: from APXEXCASHT01.APEX.LOCAL (apxexcasht01 [10.1.60.50])
 by apxexsophos02.apex.local (Sophos Email Appliance) with ESMTP id
 8A844254D08_73F536AF
 for <selinux@tycho.nsa.gov>; Fri, 20 May 2016 18:11:54 +0000 (GMT)
From: "Jesse M. Bacon" <jesse.bacon@ce.apexsystemsinc.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: libsepol will not compile
Date: Fri, 20 May 2016 18:11:52 +0000
Message-ID: <1463767911810.39859@ce.apexsystemsinc.com>
Content-Type: multipart/alternative;
 boundary="_000_146376791181039859ceapexsystemsinccom_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_146376791181039859ceapexsystemsinccom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Tycho,


I am having an issue with SELinux.  We have servers currently deployed with=
 Red Hat Enterprise Linux on them and they required enhanced access control=
s.  I have already recommended that we use SELinux to increase the security=
 of our access controls for users and files.  I am attempting to work throu=
gh a book on SELinux in order to make recommendations about how it can be l=
everaged on these systems.  The book exercises lead me to an example where =
I am running "chcat -l -- +Salaries myuser".


RHEL 6.7 is unable to create the security context.  I am in mls mode.   I g=
rabbed a source version of the most recent build of SELinux so that I could=
 build libsepol and semanage from source and see if that made a difference.=
  I found that RedHat had a bug report where semanage is faulty within thei=
r distribution and that a patch had been issued and everything but it looks=
 like the patch is for Fedora.



Reference:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1048524


The latest version of SELinux requires a compiler in excess of what ships w=
ith RHEL 6.7.  I upgraded to the 6.1 version of gcc and installed all the d=
ependencies and crossed my fingers and ran make.  Unfortunately libsepol ca=
nnot compile because:

"""

util.c:127: error: 'low_bit' may be used uninitialized in this function

"""

I can't get any of it to compile even when I set the LIBDIR to lib64 and ru=
n make with --disable-multilib.


Forgive me, I'm a beginner, I've never written a driver or kernel module, a=
nd I don't know what that means.  The RedHat guide for SELinux provides a g=
ist for MLS.  I can work through that and will.  I am concerned that there =
will be no way to get this running given the OS and the documentation and a=
 clean source build.


In order to get e more current version of SELinux and gcc I will have to go=
 to RHEL7.  RHEL7 features grub2 and I still have to figure out how to audi=
t that at boot time and additionally there is a use after free vulnerabilit=
y that has me worried about access control credentials getting snooped.  I =
can't let that happen and RedHat says the vulnerability does not affect RHE=
L 6.7.  That I believe, is a separate issue.


There are a lot of appliances affected by this, I will need help writing co=
nfiguration scripts to get them all into MLS mode and enforcing.


Please forgive me if this isn't proper forum for this.


My system is unable to create the MLS context when I run the chcat -l comma=
nd using the RedHat supplied packages

"""

libsepol.mls_from_string:  invalid MLS context s0-s0:Salaries (No such file=
 or directory)

"""


The contents of my /etc/selinux/mls/setrans.conf is as follows:

# Uncomment the following to disable translation libary
# disable=3D1
#
# Objects can be labeled with one of 16 levels and be categorized with 0-10=
23
# categories defined by the admin.
# Objects can be in more than one category at a time.
# Users can modify this table to translate the MLS labels for different pur=
pose.
#
# Assumptions: using below MLS labels.
#  SystemLow
#  SystemHigh
#  Unclassified
#  Secret with compartments A and B.
#
# SystemLow and SystemHigh
s0=3DSystemLow
s15:c0.c1023=3DSystemHigh
s0-s15:c0.c1023=3DSystemLow-SystemHigh
s0:c102=3DContracts
s0:c103=3DSalaries
s0-s0:c1.c127=3DFinanceData
# Unclassified level
s1=3DUnclassified

# Secret level with compartments
s2=3DSecret
s2:c0=3DA
s2:c1=3DB

# ranges for Unclassified
s0-s1=3DSystemLow-Unclassified
s1-s2=3DUnclassified-Secret
s1-s15:c0.c1023=3DUnclassified-SystemHigh

# ranges for Secret with compartments
s0-s2=3DSystemLow-Secret
s0-s2:c0=3DSystemLow-Secret:A
s0-s2:c1=3DSystemLow-Secret:B
s0-s2:c0,c1=3DSystemLow-Secret:AB
s1-s2:c0=3DUnclassified-Secret:A
s1-s2:c1=3DUnclassified-Secret:B
s1-s2:c0,c1=3DUnclassified-Secret:AB
s2-s2:c0=3DSecret-Secret:A
s2-s2:c1=3DSecret-Secret:B
s2-s2:c0,c1=3DSecret-Secret:AB
s2-s15:c0.c1023=3DSecret-SystemHigh
s2:c0-s2:c0,c1=3DSecret:A-Secret:AB
s2:c0-s15:c0.c1023=3DSecret:A-SystemHigh
s2:c1-s2:c0,c1=3DSecret:B-Secret:AB
s2:c1-s15:c0.c1023=3DSecret:B-SystemHigh
s2:c0,c1-s15:c0.c1023=3DSecret:AB-SystemHigh

?sincerely,

Jesse Bacon


This e-mail communication (including any attachments) may contain confident=
ial information intended solely for the use of the intended recipient. If y=
ou are not the intended recipient, you should immediately stop reading this=
 message and delete it from your system. Any unauthorized reading, distribu=
tion, copying or other use of this communication (or its attachments) is st=
rictly prohibited.

--_000_146376791181039859ceapexsystemsinccom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!-- p { margin-top: 0px; m=
argin-bottom: 0px; }--></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Tycho,<br>
</p>
<p><br>
</p>
<p>I am having an issue with SELinux. &nbsp;We have servers currently deplo=
yed with Red Hat Enterprise Linux on them and they required enhanced access=
 controls. &nbsp;I have already recommended that we use SELinux to increase=
 the security of our access controls for users
 and files. &nbsp;I am attempting to work through a book on SELinux in orde=
r to make recommendations about how it can be leveraged on these systems. &=
nbsp;The book exercises lead me to an example where I am running &quot;chca=
t -l -- &#43;Salaries myuser&quot;.<br>
</p>
<p><br>
</p>
<p>RHEL 6.7 is unable&nbsp;to create the security context. &nbsp;I am in ml=
s mode. &nbsp;&nbsp;I grabbed a source version of the most recent build of =
SELinux so that I could build libsepol and semanage from source and see if =
that made a difference. &nbsp;I found that RedHat had a&nbsp;bug
 report where semanage is faulty within their distribution and that a patch=
 had been issued and everything but it looks like the patch is for Fedora.<=
/p>
<p>&nbsp;<br>
</p>
<p>Reference:<br>
</p>
<p><a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1048524">https:=
//bugzilla.redhat.com/show_bug.cgi?id=3D1048524</a><br>
</p>
<p><br>
</p>
<p>The latest version of SELinux requires a compiler in excess of what ship=
s with RHEL 6.7. &nbsp;I upgraded to the 6.1 version of&nbsp;gcc and instal=
led all the dependencies and crossed my fingers and ran make. &nbsp;Unfortu=
nately&nbsp;libsepol cannot compile because:<br>
</p>
<p>&quot;&quot;&quot;</p>
<p>util.c:127: error: 'low_bit' may be used uninitialized in this function<=
br>
</p>
<p>&quot;&quot;&quot;<br>
</p>
<p>I can't get any of it to compile even when I set the LIBDIR to lib64 and=
 run make with --disable-multilib.<br>
</p>
<p><br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">Forgive me, I'm a beginner, I've never written a driver or kernel mo=
dule, and I don't know what that means. &nbsp;The RedHat guide for SELinux =
provides a gist for MLS. &nbsp;I can work through
 that and will. &nbsp;I am concerned that there will be no way to get this =
running given the OS and the documentation and a clean source build. &nbsp;=
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;"><br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">In order to get e more current version of SELinux and gcc I will hav=
e to go to RHEL7. &nbsp;RHEL7 features grub2 and I still have to figure out=
 how to audit that at boot time and additionally
 there is a use after free vulnerability that has me worried about access c=
ontrol credentials getting snooped. &nbsp;I can't let that happen and RedHa=
t says the vulnerability does not affect RHEL 6.7. &nbsp;That I believe, is=
 a separate&nbsp;issue.&nbsp;</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;"><br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">There are a lot of appliances affected by this, I will need help wri=
ting configuration scripts to get them all into MLS mode and enforcing.<br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;"><br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">Please forgive me if this isn't proper forum for this. &nbsp; &nbsp;=
 &nbsp;<br>
</p>
<p><br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">My system is unable to create the MLS context when I run the chcat -=
l&nbsp;command using the RedHat supplied packages<br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">&quot;&quot;&quot;</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">libsepol.mls_from_string: &nbsp;invalid MLS context s0-s0:Salaries (=
No such file or directory)<br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">&quot;&quot;&quot;<br>
</p>
<p><br>
</p>
<p>The contents of my /etc/selinux/mls/setrans.conf is as follows:<br>
</p>
<div><br>
</div>
<div># Uncomment the following to disable translation libary</div>
<div># disable=3D1</div>
<div>#</div>
<div># Objects can be labeled with one of 16 levels and be categorized with=
 0-1023</div>
<div># categories defined by the admin.<br>
</div>
<div># Objects can be in more than one category at a time.</div>
<div># Users can modify this table to translate the MLS labels for differen=
t purpose.</div>
<div>#</div>
<div># Assumptions: using below MLS labels.</div>
<div># &nbsp;SystemLow</div>
<div># &nbsp;SystemHigh</div>
<div># &nbsp;Unclassified</div>
<div># &nbsp;Secret with compartments A and B.</div>
<div>#</div>
<div># SystemLow and SystemHigh</div>
<div>s0=3DSystemLow</div>
<div>s15:c0.c1023=3DSystemHigh</div>
<div>s0-s15:c0.c1023=3DSystemLow-SystemHigh</div>
<div>s0:c102=3DContracts</div>
<div>s0:c103=3DSalaries</div>
<div>s0-s0:c1.c127=3DFinanceData</div>
<div># Unclassified level</div>
<div>s1=3DUnclassified</div>
<div><br>
</div>
<div># Secret level with compartments</div>
<div>s2=3DSecret</div>
<div>s2:c0=3DA</div>
<div>s2:c1=3DB</div>
<div><br>
</div>
<div># ranges for Unclassified</div>
<div>s0-s1=3DSystemLow-Unclassified</div>
<div>s1-s2=3DUnclassified-Secret</div>
<div>s1-s15:c0.c1023=3DUnclassified-SystemHigh</div>
<div><br>
</div>
<div># ranges for Secret with compartments</div>
<div>s0-s2=3DSystemLow-Secret</div>
<div>s0-s2:c0=3DSystemLow-Secret:A</div>
<div>s0-s2:c1=3DSystemLow-Secret:B</div>
<div>s0-s2:c0,c1=3DSystemLow-Secret:AB</div>
<div>s1-s2:c0=3DUnclassified-Secret:A</div>
<div>s1-s2:c1=3DUnclassified-Secret:B</div>
<div>s1-s2:c0,c1=3DUnclassified-Secret:AB</div>
<div>s2-s2:c0=3DSecret-Secret:A</div>
<div>s2-s2:c1=3DSecret-Secret:B</div>
<div>s2-s2:c0,c1=3DSecret-Secret:AB</div>
<div>s2-s15:c0.c1023=3DSecret-SystemHigh</div>
<div>s2:c0-s2:c0,c1=3DSecret:A-Secret:AB</div>
<div>s2:c0-s15:c0.c1023=3DSecret:A-SystemHigh</div>
<div>s2:c1-s2:c0,c1=3DSecret:B-Secret:AB</div>
<div>s2:c1-s15:c0.c1023=3DSecret:B-SystemHigh</div>
<div>s2:c0,c1-s15:c0.c1023=3DSecret:AB-SystemHigh</div>
<div><br>
&#8203;sincerely,<br>
</div>
<div><br>
</div>
<div>Jesse Bacon<br>
</div>
<p><br>
</p>
<i><span style=3D"font-size:7.5pt;font-family:&quot;Verdana&quot;,&quot;san=
s-serif&quot;;
color:#3E69A7">This e-mail communication (including any attachments) may co=
ntain confidential information intended solely for the use of the intended =
recipient. If you are not the intended
 recipient, you should immediately stop reading this message and delete it =
from your system. Any unauthorized reading, distribution, copying or other =
use of this communication (or its attachments) is strictly prohibited.</spa=
n></i>
<h5></h5>
</body>
</html>

--_000_146376791181039859ceapexsystemsinccom_--
