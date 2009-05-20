Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4KAqdiL024280
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 06:52:39 -0400
Received: from m15-52.126.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n4KAqZmf021229
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 10:52:35 GMT
Date: Wed, 20 May 2009 18:52:32 +0800 (CST)
From: hechao55429 <hechao55429@126.com>
To: selinux <selinux@tycho.nsa.gov>
Message-ID: <12675062.1102781242816752701.JavaMail.coremail@bj126app52.126.com>
Subject: selinux policy  for gedit
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_294295_32101766.1242816752699"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_294295_32101766.1242816752699
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

hello everyone :
  I'm learning the selinux policy.I wrote a selinux policy module for gedit a few days ago .When I loaded the policy into the target policy runing on the fedora 10 and ran the gedit application , I encountered the following problems:
 
[root@localhost ~]# gedit
(gedit:2697): Pango-CRITICAL **: No fonts found:
This probably means that the fontconfig
library is not correctly configured. You may need to
edit the fonts.conf configuration file. More information
about fontconfig can be found in the fontconfig(3) manual
page and on http://fontconfig.org
(gedit:2697): Pango-WARNING **: failed to find shape engine, expect ugly output. engine-type='PangoRenderFc', script='han'
(gedit:2697): Pango-WARNING **: failed to find shape engine, expect ugly output. engine-type='PangoRenderFc', script='latin'
(gedit:2697): Pango-WARNING **: failed to find shape engine, expect ugly output. engine-type='PangoRenderFc', script='common'
(gedit:2697): Pango-CRITICAL **: _pango_engine_shape_covers: assertion `PANGO_IS_FONT (font)' failed
[root@localhost ~]# 
Here is a screenshot:



------=_Part_294295_32101766.1242816752699
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV>hello everyone :</DIV>
<DIV>&nbsp; I'm learning the selinux policy.I&nbsp;wrote a&nbsp;selinux pol=
icy module&nbsp;for gedit&nbsp;a few days&nbsp;ago&nbsp;.When&nbsp;I loaded=
&nbsp;the policy into the&nbsp;target policy runing on the fedora 10 and ra=
n the gedit application , I encountered the following problems:</DIV>
<DIV>&nbsp;</DIV>
<DIV>[root@localhost ~]# gedit</DIV>
<DIV>(gedit:2697): Pango-CRITICAL **: No fonts found:<BR>This probably mean=
s that the fontconfig<BR>library is not correctly configured. You may need =
to<BR>edit the fonts.conf configuration file. More information<BR>about fon=
tconfig can be found in the fontconfig(3) manual<BR>page and on <A href=3D"=
http://fontconfig.org">http://fontconfig.org</A></DIV>
<DIV>(gedit:2697): Pango-WARNING **: failed to find shape engine, expect ug=
ly output. engine-type=3D'PangoRenderFc', script=3D'han'</DIV>
<DIV>(gedit:2697): Pango-WARNING **: failed to find shape engine, expect ug=
ly output. engine-type=3D'PangoRenderFc', script=3D'latin'</DIV>
<DIV>(gedit:2697): Pango-WARNING **: failed to find shape engine, expect ug=
ly output. engine-type=3D'PangoRenderFc', script=3D'common'</DIV>
<DIV>(gedit:2697): Pango-CRITICAL **: _pango_engine_shape_covers: assertion=
 `PANGO_IS_FONT (font)' failed<BR>[root@localhost ~]# </DIV>
<DIV>Here is a screenshot:</DIV>
<DIV><BR><IMG src=3D"http://b17.photo.store.qq.com/http_imgload.cgi?/rurl4_=
b=3Dff9dac24587a3cd9e1b4dea9d08f9d7a3fc39815ce07dca43e719ee3633f375da0cf928=
0e2b0ad2ba5fb62e87df26fd9a60a2254e26cf6635c7fc43f43ab755f3cd097a92ac01ac18a=
d82213a042bb490e5a5eb9"><BR></DIV><br><!-- footer --><br><span title=3D"net=
easefooter"/><hr/>
<a href=3D"http://512.mail.163.com/mailstamp/stamp/dz/activity.do?from=3Dfo=
oter">=B4=A9=D4=BD=B5=D8=D5=F0=B4=F8 =BC=CD=C4=EE=E3=EB=B4=A8=B5=D8=D5=F0=
=D2=BB=D6=DC=C4=EA</a>
</span>
------=_Part_294295_32101766.1242816752699--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
