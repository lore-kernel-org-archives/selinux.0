Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3IEP0ib009016
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 10:25:01 -0400
Received: from ba20-0105.ordina.nl (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3IEOuFl021491
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 14:24:57 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C781C5.0476442C"
Subject: RE: using cron in selinux policy ( a tip)
Date: Wed, 18 Apr 2007 16:22:38 +0200
Message-ID: <FBCF6D728F62D6448FEB5140F0EA07943BDD4B@BA12-0046.work.local>
References: <46253DA7.40003@us.ibm.com> <4626175D.7030808@redhat.com>
From: "Zwartsenberg, Remmolt" <remmolt.zwartsenberg@ordina.nl>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C781C5.0476442C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Daniel,
=20
RE: using cron in selinux policy
=20
In most unix kernels only the cron that is owned by 'root' of the server =
can emulate a real root process, and will thus be usable for a 'custom us=
er'. This of course depends on the UID/GID combination of the cron you ar=
e trying to use to submit your policy job to. This leads 2 the following =
options in my humble opinion:
=20

*=09
	use the cron that is owned by 'root' (probably against the local SE poli=
cy)
*=09
	create a cron that acts like being root showing the right UID/GID combin=
ation to WORLD (easy on BSD, more difficult on INTEL-platforms)=20

If this does not work for you, look at the file ownership of /usr/pacct a=
nd insert that UID/GID combination into your Policy List you expect to ex=
ecute your cron job.

Good Luck,

-rgz


________________________________

From: owner-selinux@tycho.nsa.gov on behalf of Daniel J Walsh
Sent: Wed 4/18/2007 3:04 PM
To: Michael C Thompson; Karl MacMillan; Joshua Brindle; Stephen Smalley; =
Christopher J. PeBenito; SE Linux
Subject: Re: using cron in selinux policy



Michael C Thompson wrote:
> Hey Dan,
>
> So, for some reason I can't schedule cron jobs with the custom user I
> wrote for our test execution. From what I've looked it, I think I need
> to call cron_per_role_template, but doing so causes the policy to fail
> to build, claiming abat_crond_t is being defined twice. I'm guessing
> calling cron_per_role_template explicitly is not the solution, and
> that the interfaces I need to be calling have probably changed.
>
> If you have a moment, can you please look help me look at this?
>
> Thanks,
> Mike
This looks to me like a compiler problem.

policy_module(testadm,1.0.0)

userdom_admin_user_template(testadm)
cron_per_role_template(testadm, testadm_t, testadm_r)

Causes the same problem.  I also got this to happen with
ethereal_per_role_template.  Compiler says that the type is defined
twice, even though I only see it once.  However there is a gen_requires
of the type before the declaration which might be causing the problem.

If I create a testadm.te file like above

make -f /usr/share/selinux/devel/Makefile
Compiling targeted test module
/usr/bin/checkmodule:  loading policy configuration from tmp/test.tmp
test.te:4:ERROR 'duplicate declaration of type/attribute' at token ';'
on line 102058:
        type testadm_crond_t;
#line 4
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/test.mod] Error 1




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
the words "unsubscribe selinux" without quotes as the message.


Disclaimer

Dit bericht met eventuele bijlagen is vertrouwelijk en uitsluitend bestem=
d voor de geadresseerde. Indien u niet de bedoelde ontvanger bent, wordt =
u verzocht de afzender te waarschuwen en dit bericht met eventuele bijlag=
en direct te verwijderen en/of te vernietigen. Het is niet toegestaan dit=
 bericht en eventuele bijlagen te vermenigvuldigen, door te sturen, openb=
aar te maken, op te slaan of op andere wijze te gebruiken. Ordina N.V. en=
/of haar groepsmaatschappijen accepteren geen verantwoordelijkheid of aan=
sprakelijkheid voor schade die voortvloeit uit de inhoud en/of de verzend=
ing van dit bericht.

This e-mail and any attachments are confidential and is solely intended f=
or the addressee only. If you are not the intended recipient, please noti=
fy the sender and delete and/or destroy this message and any attachments =
immediately. It is prohibited to copy, to distribute, to disclose or to u=
se this e-mail and any attachments in any other way. Ordina N.V. and/or i=
ts group companies do not accept any responsibility nor liability for any=
 damage resulting from the content of and/or the transmission of this mes=
sage.

------_=_NextPart_001_01C781C5.0476442C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: using cron in selinux policy</TITLE>=0A<=
META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.6000.16414" name=3DGENERATOR></HEAD>=0A<BODY=
>=0A<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hello Dani=
el,</FONT></DIV>=0A<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbs=
p;</DIV>=0A<DIV dir=3Dltr>RE: using cron in selinux policy</DIV>=0A<DIV d=
ir=3Dltr>&nbsp;</DIV>=0A<DIV dir=3Dltr>In most unix kernels only the cron=
 that is owned by 'root' of the server can emulate a real root process, a=
nd will thus be usable for a 'custom user'. This of course depends on the=
 UID/GID combination of the cron you are trying to use to submit your pol=
icy job to. This leads 2 the following options in my humble opinion:</DIV=
>=0A<DIV dir=3Dltr>&nbsp;</DIV>=0A<UL dir=3Dltr>=0A<LI>=0A<DIV>use the cr=
on that is owned by 'root' (probably against the local SE policy)</DIV></=
LI>=0A<LI>=0A<DIV>create a cron that acts like being root showing the rig=
ht UID/GID&nbsp;combination&nbsp;to WORLD (easy on BSD, more difficult on=
 INTEL-platforms)&nbsp;</DIV></LI></UL>=0A<P>If this does not work for yo=
u, look at the file ownership of /usr/pacct and insert that UID/GID combi=
nation into your Policy List you expect to execute your cron job.</P>=0A<=
P>Good Luck,</P>=0A<P>-rgz</P>=0A<DIV dir=3Dltr><BR></DIV>=0A<DIV dir=3Dl=
tr>=0A<HR tabIndex=3D-1>=0A</DIV>=0A<DIV dir=3Dltr><FONT face=3DTahoma si=
ze=3D2><B>From:</B> owner-selinux@tycho.nsa.gov on behalf of Daniel J Wal=
sh<BR><B>Sent:</B> Wed 4/18/2007 3:04 PM<BR><B>To:</B> Michael C Thompson=
; Karl MacMillan; Joshua Brindle; Stephen Smalley; Christopher J. PeBenit=
o; SE Linux<BR><B>Subject:</B> Re: using cron in selinux policy<BR></FONT=
><BR></DIV>=0A<DIV>=0A<P><FONT size=3D2>Michael C Thompson wrote:<BR>&gt;=
 Hey Dan,<BR>&gt;<BR>&gt; So, for some reason I can't schedule cron jobs =
with the custom user I<BR>&gt; wrote for our test execution. From what I'=
ve looked it, I think I need<BR>&gt; to call cron_per_role_template, but =
doing so causes the policy to fail<BR>&gt; to build, claiming abat_crond_=
t is being defined twice. I'm guessing<BR>&gt; calling cron_per_role_temp=
late explicitly is not the solution, and<BR>&gt; that the interfaces I ne=
ed to be calling have probably changed.<BR>&gt;<BR>&gt; If you have a mom=
ent, can you please look help me look at this?<BR>&gt;<BR>&gt; Thanks,<BR=
>&gt; Mike<BR>This looks to me like a compiler problem.<BR><BR>policy_mod=
ule(testadm,1.0.0)<BR><BR>userdom_admin_user_template(testadm)<BR>cron_pe=
r_role_template(testadm, testadm_t, testadm_r)<BR><BR>Causes the same pro=
blem.&nbsp; I also got this to happen with<BR>ethereal_per_role_template.=
&nbsp; Compiler says that the type is defined<BR>twice, even though I onl=
y see it once.&nbsp; However there is a gen_requires<BR>of the type befor=
e the declaration which might be causing the problem.<BR><BR>If I create =
a testadm.te file like above<BR><BR>make -f /usr/share/selinux/devel/Make=
file<BR>Compiling targeted test module<BR>/usr/bin/checkmodule:&nbsp; loa=
ding policy configuration from tmp/test.tmp<BR>test.te:4:ERROR 'duplicate=
 declaration of type/attribute' at token ';'<BR>on line 102058:<BR>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type testadm_crond_t;<BR>#line 4<BR>=
/usr/bin/checkmodule:&nbsp; error(s) encountered while parsing configurat=
ion<BR>make: *** [tmp/test.mod] Error 1<BR><BR><BR><BR><BR>--<BR>This mes=
sage was distributed to subscribers of the selinux mailing list.<BR>If yo=
u no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<=
BR>the words "unsubscribe selinux" without quotes as the message.<BR></FO=
NT></P></DIV>Disclaimer<br><br>Dit bericht met eventuele bijlagen is vert=
rouwelijk en uitsluitend bestemd voor de geadresseerde. Indien u niet de =
bedoelde ontvanger bent, wordt u verzocht de afzender te waarschuwen en d=
it bericht met eventuele bijlagen direct te verwijderen en/of te vernieti=
gen. Het is niet toegestaan dit bericht en eventuele bijlagen te vermenig=
vuldigen, door te sturen, openbaar te maken, op te slaan of op andere wij=
ze te gebruiken. Ordina N.V. en/of haar groepsmaatschappijen accepteren g=
een verantwoordelijkheid of aansprakelijkheid voor schade die voortvloeit=
 uit de inhoud en/of de verzending van dit bericht.<br><br>This e-mail an=
d any attachments are confidential and is solely intended for the address=
ee only. If you are not the intended recipient, please notify the sender =
and delete and/or destroy this message and any attachments immediately. I=
t is prohibited to copy, to distribute, to disclose or to use this e-mail=
 and any attachments in any other way. Ordina N.V. and/or its group compa=
nies do not accept any responsibility nor liability for any damage result=
ing from the content of and/or the transmission of this message.</BODY></=
HTML>=

------_=_NextPart_001_01C781C5.0476442C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
