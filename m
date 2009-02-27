MIME-Version: 1.0
Date: Fri, 27 Feb 2009 16:57:51 +0500
Message-ID: <e768086c0902270357w2b34b11rebd3e8a98c58877a@mail.gmail.com>
Subject: refpolicy compilation issue
From: "Kirill \"REDbyte\" Novikov" <redbyte.labs@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001636c5a435ac73640463e52dbe
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636c5a435ac73640463e52dbe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi there everyone!

I'm got a strange problem compiling latest refpolicy (as well as all other
versions), found nothing alike on the mailing lists, so maybe someone from
here would help me.

Policy compilation fails like this:

Creating refpolicy policy.conf
cat tmp/pre_te_files.conf tmp/all_attrs_types.conf tmp/global_bools.conf
tmp/only_te_rules.conf tmp/all_post.conf > policy.conf
Compiling refpolicy policy.23

WARNING: Policy version mismatch!  Is your OUTPUT_POLICY set correctly?

/usr/bin/checkpolicy policy.conf -o policy.23
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
policy/modules/services/amavis.te":11:ERROR 'syntax error' at token ':' on
line 7140:
        allow amavis_t init_t:process sigchld;
#line 11
checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.23] Error 1

I'm using latest development versions of SELinux stuff, available from
Tresys' trac. I have checked /selinux/policyvers and it contains 24 - but
latest policy version supported by checkpolicy 2.0.16 is 23. Have any ideas?

Regards,

Kirill Novikov,
EastLinux Team

--001636c5a435ac73640463e52dbe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi there everyone!<br><br>I&#39;m got a strange problem compiling latest re=
fpolicy (as well as all other versions), found nothing alike on the mailing=
 lists, so maybe someone from here would help me.<br><br>Policy compilation=
 fails like this:<br>
<br><span style=3D"font-family: courier new,monospace;">Creating refpolicy =
policy.conf</span><br style=3D"font-family: courier new,monospace;"><span s=
tyle=3D"font-family: courier new,monospace;">cat tmp/pre_te_files.conf tmp/=
all_attrs_types.conf tmp/global_bools.conf tmp/only_te_rules.conf tmp/all_p=
ost.conf &gt; policy.conf</span><br style=3D"font-family: courier new,monos=
pace;">
<span style=3D"font-family: courier new,monospace;">Compiling refpolicy pol=
icy.23</span><br style=3D"font-family: courier new,monospace;"><br style=3D=
"font-family: courier new,monospace;"><span style=3D"font-family: courier n=
ew,monospace;">WARNING: Policy version mismatch!=A0 Is your OUTPUT_POLICY s=
et correctly?</span><br style=3D"font-family: courier new,monospace;">
<br style=3D"font-family: courier new,monospace;"><span style=3D"font-famil=
y: courier new,monospace;">/usr/bin/checkpolicy policy.conf -o policy.23</s=
pan><br style=3D"font-family: courier new,monospace;"><span style=3D"font-f=
amily: courier new,monospace;">/usr/bin/checkpolicy:=A0 loading policy conf=
iguration from policy.conf</span><br style=3D"font-family: courier new,mono=
space;">
<span style=3D"font-family: courier new,monospace;">policy/modules/services=
/amavis.te&quot;:11:ERROR &#39;syntax error&#39; at token &#39;:&#39; on li=
ne 7140:</span><br style=3D"font-family: courier new,monospace;"><span styl=
e=3D"font-family: courier new,monospace;">=A0=A0=A0=A0=A0=A0=A0 allow amavi=
s_t init_t:process sigchld;</span><br style=3D"font-family: courier new,mon=
ospace;">
<span style=3D"font-family: courier new,monospace;">#line 11</span><br styl=
e=3D"font-family: courier new,monospace;"><span style=3D"font-family: couri=
er new,monospace;">checkpolicy:=A0 error(s) encountered while parsing confi=
guration</span><br style=3D"font-family: courier new,monospace;">
<span style=3D"font-family: courier new,monospace;">make: *** [policy.23] E=
rror 1</span><br style=3D"font-family: courier new,monospace;"><br>I&#39;m =
using latest development versions of SELinux stuff, available from Tresys&#=
39; trac. I have checked /selinux/policyvers and it contains 24 - but lates=
t policy version supported by checkpolicy 2.0.16 is 23. Have any ideas?<br>
<br>Regards,<br><br>Kirill Novikov,<br>EastLinux Team<br>

--001636c5a435ac73640463e52dbe--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
