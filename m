Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6LJ2MSm030984
	for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2010 15:02:24 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6LJ1M93007795
	for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2010 19:01:27 GMT
Received: by mail-iw0-f181.google.com with SMTP id 42so8550750iwn.12
        for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2010 12:02:22 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 21 Jul 2010 14:02:22 -0500
Message-ID: <AANLkTimEWDwZd2VnEgv-ybnCQc0p3j7t-exi77e-G4YW@mail.gmail.com>
Subject: [RFC PATCH 3/4] mcstrans: manpages
From: Xavier Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=002215048e7713d998048bea716e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--002215048e7713d998048bea716e
Content-Type: text/plain; charset=ISO-8859-1

SELinux Project contribution of mcstrans. mcstrans is a userland package
specific to SELinux which allows system administrators to define sensitivity
levels and categories and provides a daemon for their translation into human
readable form. This version is a merge of Joe Nalls git tree (
http://github.com/joenall/mcstrans) and patches supplied by Dan Walsh and
others at RedHat.

Manpages.

---


 Makefile            |   10 ++++
 man8/mcs.8          |   30 ++++++++++++++
 man8/mcstransd.8    |   25 ++++++++++++
 man8/setrans.conf.8 |  106
++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+)

diff --git a/policycoreutils/mcstrans/man/Makefile
b/policycoreutils/mcstrans/man/Makefile
new file mode 100644
index 0000000..f07ec96
--- /dev/null
+++ b/policycoreutils/mcstrans/man/Makefile
@@ -0,0 +1,10 @@
+# Installation directories.
+MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
+
+install:
+    mkdir -p $(MAN8DIR)
+    install -m 644 man8/*.8 $(MAN8DIR)
+
+clean:
+    -rm -f *~ \#*
+    -rm -f man8/*~ man8/\#*
diff --git a/policycoreutils/mcstrans/man/man8/mcs.8
b/policycoreutils/mcstrans/man/man8/mcs.8
new file mode 100644
index 0000000..6954e0c
--- /dev/null
+++ b/policycoreutils/mcstrans/man/man8/mcs.8
@@ -0,0 +1,30 @@
+.TH  "mcs"  "8"  "8 Sep 2005" "dwalsh@redhat.com" "mcs documentation"
+
+.SH "NAME"
+mcs \- Multi-Category System
+
+.SH "DESCRIPTION"
+MCS (Multiple Category System) allows users to label files on their
+system within administrator defined categories.  It then uses SELinux
+Mandatory Access Control to protect those files.   MCS is a discretionary
+model to allow users to mark their data with additional tags that further
+restrict access.  The only mandatory aspect is authorizing users for
+categories by defining their clearance in policy.  However, MCS is similar
+to MLS and exercises the same code paths and share the same support
+infrastructure.  They just differ in their specific configuration.
+
+
+The
+.I /etc/selinux/{SELINUXTYPE}/setrans.conf configuration file translates
the labels on disk to human
+readable form.   Administrators can define any labels they want in this
file.
+Certain applications like printing and auditing will use these labels to
+identify the files.  By setting a category on a file you will prevent
+other applications/services from having access to the files.
+.p
+Examples of file lables would be PatientRecord, CompanyConfidential etc.
+
+.SH "SEE ALSO"
+selinux(8), chcon(1)
+
+.SH FILES
+/etc/selinux/{SELINUXTYPE}/setrans.conf
diff --git a/policycoreutils/mcstrans/man/man8/mcstransd.8
b/policycoreutils/mcstrans/man/man8/mcstransd.8
new file mode 100644
index 0000000..4c63965
--- /dev/null
+++ b/policycoreutils/mcstrans/man/man8/mcstransd.8
@@ -0,0 +1,25 @@
+.TH "mcstransd" "8" "16 Oct 2009" "dwalsh@redhat.com" "mcs documentation"
+.SH "NAME"
+mcstransd \- MCS (Multiple Category System) daemon.  Translates SELinux
MCS/MLS labels to human readable form.
+
+.SH "SYNOPSIS"
+.B mcstransd
+.P
+
+.SH "DESCRIPTION"
+This manual page describes the
+.BR mcstransd
+program.
+.P
+This daemon reads /etc/selinux/{SELINUXTYPE}/setrans.conf configuration
file, and communicates with libselinux via a socket in /var/run/setrans.
+
+.SH "AUTHOR"
+This man page was written by Dan Walsh <dwalsh@redhat.com>.
+The program was originally written by Dan Walsh <dwalsh@redhat.com>.
+The program was enhanced/rwwritten by Joe Nall <joe@nall.com>.
+
+.SH "FILES"
+/etc/selinux/{SELINUXTYPE}/setrans.conf
+
+.SH "SEE ALSO"
+.BR mcs (8),
diff --git a/policycoreutils/mcstrans/man/man8/setrans.conf.8
b/policycoreutils/mcstrans/man/man8/setrans.conf.8
new file mode 100644
index 0000000..100913c
--- /dev/null
+++ b/policycoreutils/mcstrans/man/man8/setrans.conf.8
@@ -0,0 +1,106 @@
+.TH "setrans.conf" "8" "13 July 2010" "txtoth@gmail.com" "setrans.conf
documentation"
+.SH "NAME"
+setrans.conf \- translation configuration file for MCS/MLS SELinux systems
+
+.SH "DESCRIPTION"
+The
+.I /etc/selinux/{SELINUXTYPE}/setrans.conf
+configuration file specifies the way that SELinux MCS/MLS labels are
translated into human
+readable form by the mcstransd daemon.  The default policies support 16
sensitivity levels (s0 through s15) and 1024 categories (c0 through c1023).
Multiple categories can be separated with commas (c0,c1,c3,c5) and a range
of categories can be shortened using dot notation (c0.c3,c5).
+
+.SS "Keywords"
+
+.TP
+Base\fR
+once a base is declared subsequent sensitivity label definitions will have
all modifiers applied to them during translation.
+Sensitivity labels defined before the base declaration are immediately
cached and no modifiers will be applied these are used as direct
translations.
+
+.TP
+Default\fR
+defines the category bit range that will be used for inverse bits.
+
+.TP
+Domain\fR
+creates a new domain with the supplied name.
+
+.TP
+Include\fR
+read and process the contents of the specified configuration file.
+
+.TP
+Join\fR
+defines a character used to separate members of a modifier group when more
than one is specified (ex. USA/AUS).
+
+.TP
+ModifierGroup\fR
+a means of grouping category bit definitions by how they modify the
sensitivity label.
+
+.TP
+Prefix\fR
+word(s) that may proceed member(s) of a modifier group (ex. REL USA).
+
+.TP
+Suffix\fR
+word(s) that may follow member(s) of a modifier group (ex. USA EYES ONLY).
+
+.TP
+Whitrespace\fR
+defines the set of acceptable white space characters that may be used in
label being translated.
+
+.SS "Sensitivity Level Definition Examples"
+
+.TP
+s0=SystemLow\fR
+defines a translation of s0 (the lowest sensitivity level) with no
categories to SystemLow.
+
+.TP
+s15:c0.c1023=SystemHigh\fR
+defines a translation of s15:c0.c1023 to SystemHigh. c0.c1023 is shorthand
for all categories. A colon separates the sensitivity level and categories.
+
+.TP
+s0\-s15:c0.c1023=SystemLow\-SystemHigh\fR
+defines a range translation of of s0\-s15:c0.c1023 to
SystemLow\-SystemHigh. The two range components are separated by a dash.
+
+.TP
+s0:c0=PatientRecord\fR
+defines a translation of sensitivity s0 with category c0 to PatientRecord.
+
+.TP
+s0:c1=Accounting\fR
+defines a translation of sensitivity s0 with category c1 to Accounting.
+
+.TP
+s2:c1,c2,c3=Confidential3Categories
+.TP
+s2:c1.c3=Confidential3Categories\fR
+both define a translation of sensitivity s2 with categories c1, c2 and c3
to Confidential3Categories.
+
+.TP
+s5=TopSecret\fR
+defines a translation of sensitivity s5 with no categories to TopSecret.
+
+.SS "Constraint Examples"
+
+.TP
+c0!c1
+if category bits 0 and 1 are both set the constraint will fail and the
original context will be returned.
+
+.TP
+c5.c9>c1
+if category bits 5 through 9 are set bit 1 must also be set or the
constraint will fail and the original context will be returned.
+
+.TP
+s1!c5,c9
+if categroy bits 5 and 9 are set and the sensitivity level is s1 the
constraint will fail and the original context will be returned.
+
+.SH "AUTHOR"
+    Written by Joe Nall <joe@nall.com>.
+    Updated by Ted X. Toth <txtoth@gmail.com>.
+
+.SH "SEE ALSO"
+selinux(8), mcs(8), mls(8), chcon(1)
+
+.SH "FILES"
+/etc/selinux/{SELINUXTYPE}/setrans.conf
+.br
+/usr/share/mcstrans/examples

--002215048e7713d998048bea716e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>SELinux Project contribution of mcstrans. mcstrans is a userland packag=
e specific to SELinux which allows system administrators to define sensitiv=
ity levels and categories and provides a daemon for their translation into =
human readable form. This version is a merge of Joe Nalls git tree (<a href=
=3D"http://github.com/joenall/mcstrans" target=3D"_blank">http://github.com=
/joenall/mcstrans</a>) and patches supplied by Dan Walsh and others at RedH=
at.<br>

<br>Manpages.<br><br>---<br><br><br>=A0Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 10 ++++<br>=A0man8/mcs.8=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =
30 ++++++++++++++<br>=A0man8/mcstransd.8=A0=A0=A0 |=A0=A0 25 ++++++++++++<b=
r>=A0man8/setrans.conf.8 |=A0 106 +++++++++++++++++++++++++++++++++++++++++=
+++++++++++<br>

=A04 files changed, 171 insertions(+)<br><br>diff --git a/policycoreutils/m=
cstrans/man/Makefile b/policycoreutils/mcstrans/man/Makefile<br>new file mo=
de 100644<br>index 0000000..f07ec96<br>--- /dev/null<br>+++ b/policycoreuti=
ls/mcstrans/man/Makefile<br>

@@ -0,0 +1,10 @@<br>+# Installation directories.<br>+MAN8DIR ?=3D $(DESTDIR=
)/usr/share/man/man8<br>+<br>+install:<br>+=A0=A0=A0 mkdir -p $(MAN8DIR)<br=
>+=A0=A0=A0 install -m 644 man8/*.8 $(MAN8DIR)<br>+<br>+clean:<br>+=A0=A0=
=A0 -rm -f *~ \#*<br>

+=A0=A0=A0 -rm -f man8/*~ man8/\#*<br>diff --git a/policycoreutils/mcstrans=
/man/man8/mcs.8 b/policycoreutils/mcstrans/man/man8/mcs.8<br>new file mode =
100644<br>index 0000000..6954e0c<br>--- /dev/null<br>+++ b/policycoreutils/=
mcstrans/man/man8/mcs.8<br>

@@ -0,0 +1,30 @@<br>+.TH=A0 &quot;mcs&quot;=A0 &quot;8&quot;=A0 &quot;8 Sep=
 2005&quot; &quot;<a href=3D"mailto:dwalsh@redhat.com" target=3D"_blank">dw=
alsh@redhat.com</a>&quot; &quot;mcs documentation&quot;<br>+<br>+.SH &quot;=
NAME&quot;<br>
+mcs \- Multi-Category System<br>
+<br>+.SH &quot;DESCRIPTION&quot;<br>+MCS (Multiple Category System) allows=
 users to label files on their <br>+system within administrator defined cat=
egories.=A0 It then uses SELinux<br>+Mandatory Access Control to protect th=
ose files.=A0=A0 MCS is a discretionary <br>

+model to allow users to mark their data with additional tags that further =
<br>+restrict access.=A0 The only mandatory aspect is authorizing users for=
 <br>+categories by defining their clearance in policy.=A0 However, MCS is =
similar <br>

+to MLS and exercises the same code paths and share the same support <br>+i=
nfrastructure.=A0 They just differ in their specific configuration.<br>+<br=
>+<br>+The<br>+.I /etc/selinux/{SELINUXTYPE}/setrans.conf configuration fil=
e translates the labels on disk to human<br>

+readable form.=A0=A0 Administrators can define any labels they want in thi=
s file.<br>+Certain applications like printing and auditing will use these =
labels to <br>+identify the files.=A0 By setting a category on a file you w=
ill prevent <br>

+other applications/services from having access to the files.<br>+.p<br>+Ex=
amples of file lables would be PatientRecord, CompanyConfidential etc.<br>+=
<br>+.SH &quot;SEE ALSO&quot;<br>+selinux(8), chcon(1)<br>+<br>+.SH FILES<b=
r>

+/etc/selinux/{SELINUXTYPE}/setrans.conf <br>diff --git a/policycoreutils/m=
cstrans/man/man8/mcstransd.8 b/policycoreutils/mcstrans/man/man8/mcstransd.=
8<br>new file mode 100644<br>index 0000000..4c63965<br>--- /dev/null<br>

+++ b/policycoreutils/mcstrans/man/man8/mcstransd.8<br>@@ -0,0 +1,25 @@<br>=
+.TH &quot;mcstransd&quot; &quot;8&quot; &quot;16 Oct 2009&quot; &quot;<a h=
ref=3D"mailto:dwalsh@redhat.com" target=3D"_blank">dwalsh@redhat.com</a>&qu=
ot; &quot;mcs documentation&quot;<br>

+.SH &quot;NAME&quot;<br>+mcstransd \- MCS (Multiple Category System) daemo=
n.=A0 Translates SELinux MCS/MLS labels to human readable form.<br>+<br>+.S=
H &quot;SYNOPSIS&quot;<br>+.B mcstransd <br>+.P<br>+<br>+.SH &quot;DESCRIPT=
ION&quot;<br>

+This manual page describes the<br>+.BR mcstransd<br>+program.<br>+.P<br>+T=
his daemon reads /etc/selinux/{SELINUXTYPE}/setrans.conf configuration file=
, and communicates with libselinux via a socket in /var/run/setrans.<br>

+<br>+.SH &quot;AUTHOR&quot;<br>+This man page was written by Dan Walsh &lt=
;<a href=3D"mailto:dwalsh@redhat.com" target=3D"_blank">dwalsh@redhat.com</=
a>&gt;.<br>+The program was originally written by Dan Walsh &lt;<a href=3D"=
mailto:dwalsh@redhat.com" target=3D"_blank">dwalsh@redhat.com</a>&gt;.<br>

+The program was enhanced/rwwritten by Joe Nall &lt;<a href=3D"mailto:joe@n=
all.com" target=3D"_blank">joe@nall.com</a>&gt;.<br>+<br>+.SH &quot;FILES&q=
uot;<br>+/etc/selinux/{SELINUXTYPE}/setrans.conf <br>+<br>+.SH &quot;SEE AL=
SO&quot;<br>
+.BR mcs (8),<br>
diff --git a/policycoreutils/mcstrans/man/man8/setrans.conf.8 b/policycoreu=
tils/mcstrans/man/man8/setrans.conf.8<br>new file mode 100644<br>index 0000=
000..100913c<br>--- /dev/null<br>+++ b/policycoreutils/mcstrans/man/man8/se=
trans.conf.8<br>

@@ -0,0 +1,106 @@<br>+.TH &quot;setrans.conf&quot; &quot;8&quot; &quot;13 J=
uly 2010&quot; &quot;<a href=3D"mailto:txtoth@gmail.com" target=3D"_blank">=
txtoth@gmail.com</a>&quot; &quot;setrans.conf documentation&quot;<br>+.SH &=
quot;NAME&quot;<br>

+setrans.conf \- translation configuration file for MCS/MLS SELinux systems=
<br>+<br>+.SH &quot;DESCRIPTION&quot;<br>+The<br>+.I /etc/selinux/{SELINUXT=
YPE}/setrans.conf<br>+configuration file specifies the way that SELinux MCS=
/MLS labels are translated into human<br>

+readable form by the mcstransd daemon.=A0 The default policies support 16 =
sensitivity levels (s0 through s15) and 1024 categories (c0 through c1023).=
 Multiple categories can be separated with commas (c0,c1,c3,c5) and a range=
 of categories can be shortened using dot notation (c0.c3,c5).<br>

+<br>+.SS &quot;Keywords&quot;<br>+<br>+.TP<br>+Base\fR<br>+once a base is =
declared subsequent sensitivity label definitions will have all modifiers a=
pplied to them during translation.<br>+Sensitivity labels defined before th=
e base declaration are immediately cached and no modifiers will be applied =
these are used as direct translations. <br>

+<br>+.TP<br>+Default\fR<br>+defines the category bit range that will be us=
ed for inverse bits.<br>+<br>+.TP<br>+Domain\fR<br>+creates a new domain wi=
th the supplied name.<br>+<br>+.TP<br>+Include\fR<br>+read and process the =
contents of the specified configuration file.<br>

+<br>+.TP<br>+Join\fR<br>+defines a character used to separate members of a=
 modifier group when more than one is specified (ex. USA/AUS).<br>+<br>+.TP=
<br>+ModifierGroup\fR<br>+a means of grouping category bit definitions by h=
ow they modify the sensitivity label.<br>

+<br>+.TP<br>+Prefix\fR<br>+word(s) that may proceed member(s) of a modifie=
r group (ex. REL USA).<br>+<br>+.TP<br>+Suffix\fR<br>+word(s) that may foll=
ow member(s) of a modifier group (ex. USA EYES ONLY).<br>+<br>+.TP<br>
+Whitrespace\fR<br>
+defines the set of acceptable white space characters that may be used in l=
abel being translated.<br>+<br>+.SS &quot;Sensitivity Level Definition Exam=
ples&quot;<br>+<br>+.TP <br>+s0=3DSystemLow\fR<br>+defines a translation of=
 s0 (the lowest sensitivity level) with no categories to SystemLow.<br>

+<br>+.TP <br>+s15:c0.c1023=3DSystemHigh\fR<br>+defines a translation of s1=
5:c0.c1023 to SystemHigh. c0.c1023 is shorthand for all categories. A colon=
 separates the sensitivity level and categories.<br>+<br>+.TP <br>+s0\-s15:=
c0.c1023=3DSystemLow\-SystemHigh\fR<br>

+defines a range translation of of s0\-s15:c0.c1023 to SystemLow\-SystemHig=
h. The two range components are separated by a dash.<br>+<br>+.TP <br>+s0:c=
0=3DPatientRecord\fR<br>+defines a translation of sensitivity s0 with categ=
ory c0 to PatientRecord.<br>

+<br>+.TP <br>+s0:c1=3DAccounting\fR<br>+defines a translation of sensitivi=
ty s0 with category c1 to Accounting.<br>+<br>+.TP <br>+s2:c1,c2,c3=3DConfi=
dential3Categories<br>+.TP <br>+s2:c1.c3=3DConfidential3Categories\fR<br>+b=
oth define a translation of sensitivity s2 with categories c1, c2 and c3 to=
 Confidential3Categories.<br>

+<br>+.TP <br>+s5=3DTopSecret\fR<br>+defines a translation of sensitivity s=
5 with no categories to TopSecret.<br>+<br>+.SS &quot;Constraint Examples&q=
uot;<br>+<br>+.TP<br>+c0!c1<br>+if category bits 0 and 1 are both set the c=
onstraint will fail and the original context will be returned.<br>

+<br>+.TP<br>+c5.c9&gt;c1<br>+if category bits 5 through 9 are set bit 1 mu=
st also be set or the constraint will fail and the original context will be=
 returned.<br>+<br>+.TP<br>+s1!c5,c9<br>+if categroy bits 5 and 9 are set a=
nd the sensitivity level is s1 the constraint will fail and the original co=
ntext will be returned.<br>

+<br>+.SH &quot;AUTHOR&quot;<br>+=A0=A0=A0 Written by Joe Nall &lt;<a href=
=3D"mailto:joe@nall.com" target=3D"_blank">joe@nall.com</a>&gt;.<br>+=A0=A0=
=A0 Updated by Ted X. Toth &lt;<a href=3D"mailto:txtoth@gmail.com" target=
=3D"_blank">txtoth@gmail.com</a>&gt;.<br>
+=A0=A0=A0 <br>+.SH &quot;SEE ALSO&quot;<br>
+selinux(8), mcs(8), mls(8), chcon(1)<br>+<br>+.SH &quot;FILES&quot;<br>+/e=
tc/selinux/{SELINUXTYPE}/setrans.conf<br>+.br<br>+/usr/share/mcstrans/examp=
les<br><br>

--002215048e7713d998048bea716e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
