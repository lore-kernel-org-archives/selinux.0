From: "Gmail" <pag.maurizio@gmail.com>
To: <selinux@tycho.nsa.gov>
References: <008e01d0a431$3c777980$b5666c80$@gmail.com>	<557983AD.1040706@tycho.nsa.gov>	<00b901d0a449$0988c2f0$1c9a48d0$@gmail.com>	<55798C54.3010202@tycho.nsa.gov>	<CAHC9VhREz6MT_5LwznDQjrxiDvUnJdFoZBiGaQ08HpZxG80MGw@mail.gmail.com>	<CA+SaE3uO2_BY=mXOGbFa1ne5EdPL3PGMBneEjPEZSOprgcr8sQ@mail.gmail.com>
 <CAHC9VhT0itC0iG5JLM+HAMjLzBNCjGtpbD5WMLqSdFuXRtFeUQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT0itC0iG5JLM+HAMjLzBNCjGtpbD5WMLqSdFuXRtFeUQ@mail.gmail.com>
Subject: R: R: SELinux: Interface Labeling Problem
Date: Sat, 13 Jun 2015 11:02:25 +0200
Message-ID: <015901d0a5b7$ab6eade0$024c09a0$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/related;
 boundary="----=_NextPart_000_015A_01D0A5C8.6EF90480"
Cc: 'James Morris' <james.l.morris@oracle.com>,
 'Stephen Smalley' <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multipart message in MIME format.

------=_NextPart_000_015A_01D0A5C8.6EF90480
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_015B_01D0A5C8.6EF90480"


------=_NextPart_001_015B_01D0A5C8.6EF90480
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

 

In this mail, i'll describe with wich steps i resolved my problem with Netw=
ork Interface Labeling.

 

-          Problem: We need to block a specific domain (application, users =
or other) to use a specific network interface.

-          Question: How can i do? With NetLabel? SECMARK? I need to develo=
p a new policy? Is there a refpolicy like a template? Is not possible?

 

After some read on many blogs/books/SELinux site, i did a merge of these in=
formations, and i found a solution for my problem.

 

-          Environment Example: we have an environment where there are two =
network interface, the first for public network, the second for internal ne=
twork. And we don=E2=80=99t want a user called =E2=80=9Cmyuser=E2=80=9D (sy=
sadm_r) after login from public interface, can jump trough internal network=
 interface.

-          Solution step-by-step: 

1.       We need to create two new types, the first for internal interface,=
 and another for packet_internal_interface.

*  My policy is this: 

policy_module(telecom,1.0)

 

#I declare my types

type telecom_netif_mgmt_t;    #type for internal network interface

type telecom_netif_mgmt_packet_t; #type for packet of internal network inte=
rface

2.       After compile and install this policy, you have a new two types th=
at you can check with seinfo =E2=80=93t |grep <yourtype>

3.       Install this package (for redhat/centos/fedora):

*   yum =E2=80=93y install netlabel_tools   #is needed for manage Network L=
abeling

4.       Now you need to label your network internal interface with semanag=
e command:

*  semanage interface -a -t telecom_netif_mgmt_t eth0 #with this we label t=
he interface

*  semanage interface =E2=80=93l #with this we check it

*    we should see something like this

5.       Is moment to link this with Network Labeling trough netlabelctl co=
mmand:

*  netlabelctl unlbl add interface:eth0 address:10.23.130.131 label:system_=
u:object_r:telecom_netif_mgmt_packet_t:s0  #we are setting all unlabeled pa=
ckets flow for eth0 are labeled with telecom_netif_mgmt_packet_t

*         N.B.: address: 10.23.130.131 must be the static ip address of int=
ernal network interface

*  netlabelctl unlbl list #for check

*         you should must see this output: accept:on interface:eth0,address=
:10.23.130.131/32,label:"system_u:object_r:telecom_netif_mgmt_packet_t:s0"

6.       Now we must to allow domains that we need can use this interface l=
ike unconfined_t (default root user)

*  We need to modify our simple policy below with this delta:

policy_module(telecom,1.0)

 

#I declare my types

type telecom_netif_mgmt_t;    #type for internal network interface

type telecom_netif_mgmt_packet_t; #type for packet of internal network inte=
rface

 

        allow unconfined_t telecom_netif_mgmt_t : netif { tcp_recv tcp_send=
 udp_recv udp_send ingress egress } ; #This allow unconfined_t (root user f=
or example) to use internal network interface (egress, so the OUT traffic) =
=E2=80=93 for comodity i allow all permissions

allow unlabeled_t telecom_netif_mgmt_t : netif { tcp_recv tcp_send udp_recv=
 udp_send ingress egress};    # This allow  unlabeled_t (all response from =
=E2=80=93 to) to pass troughe  internal network interface (ingress, so the =
IN traffic) =E2=80=93 for comodity i allow all permissions

7.       So, now unconfined_t is allowed, but myuser_t (our myuser user)is =
not allowed, so we need only to try and see what happen:

*  While i launch a ping trough myuser (root restricted shell):

*         

*         We see also audit.log: 

*         

*         We can see that our specific domaind (telecom_sysadm_t) can=E2=80=
=99t use and jump in the internal network interface (eth0)

 

Problem SOLVED!

 

I hope that this mini guide, can help someone. 

If there are any improvement, that someone can give me, i=E2=80=99m here re=
ady to improve.

 

Sorry in advance, if this guide is not write with an optimal english.

 

Thanks,

 

Maurizio Pagani (LordFire in #SELinux)

 

              

 

-----Messaggio originale-----
Da: Paul Moore [mailto:paul@paul-moore.com] 
Inviato: venerd=C3=AC 12 giugno 2015 22:48
A: Maurizio Pagani
Cc: Stephen Smalley; James Morris; Daniel J Walsh; Dominick Grift; Sven Ver=
meulen; Eric Paris
Oggetto: Re: R: SELinux: Interface Labeling Problem

 

On Fri, Jun 12, 2015 at 4:34 PM, Maurizio Pagani < <mailto:pag.maurizio@gma=
il.com> pag.maurizio@gmail.com> wrote:

> Sure!!! That help!! However i solved yet my problem, but i though 

> "maybe i should must write a small guide/solution to list for share my pr=
oblem."

> 

> Right?

 

I'm glad to hear that you've resolved your problem, and I think a short des=
cription of your problem as well as how you solved it would be very welcome=
 on the list.

 

--

paul moore

 <http://www.paul-moore.com> www.paul-moore.com



---
Questa e-mail =C3=A8 stata controllata per individuare virus con Avast anti=
virus.
https://www.avast.com/antivirus

------=_NextPart_001_015B_01D0A5C8.6EF90480
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dutf-8"><meta name=3DGenerator content=3D"Microsoft=
 Word 15 (filtered medium)"><!--[if !mso]><style>v\:* {behavior:url(#defaul=
t#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
=2Eshape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Testo normale Carattere";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.TestonormaleCarattere
	{mso-style-name:"Testo normale Carattere";
	mso-style-priority:99;
	mso-style-link:"Testo normale";
	font-family:"Calibri",sans-serif;}
=2EMsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 2.0cm 2.0cm 2.0cm;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1350372604;
	mso-list-type:hybrid;
	mso-list-template-ids:-1422388516 1934007788 -199614706 68157445 68157441 =
68157443 68157445 68157441 68157443 68157445;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-weight:normal;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:=EF=82=A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DIT link=3D"#0563C1" v=
link=3D"#954F72"><div class=3DWordSection1><p class=3DMsoPlainText>Hi,<o:p>=
</o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainT=
ext>In this mail, i'll describe with wich steps i resolved my problem with =
Network Interface Labeling.<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbs=
p;</o:p></p><p class=3DMsoPlainText style=3D'margin-left:36.0pt;text-indent=
:-18.0pt;mso-list:l0 level1 lfo1'><![if !supportLists]><span style=3D'mso-l=
ist:Ignore'>-<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![endif]><b>Problem:</=
b> We need to block a specific domain (application, users or other) to use =
a specific network interface.<o:p></o:p></p><p class=3DMsoPlainText style=
=3D'margin-left:36.0pt;text-indent:-18.0pt;mso-list:l0 level1 lfo1'><![if !=
supportLists]><span style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "T=
imes New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </s=
pan></span><![endif]><b>Question:</b> How can i do? With NetLabel? SECMARK?=
 I need to develop a new policy? Is there a refpolicy like a template? Is n=
ot possible?<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>After some read on many blogs/books/SELinux site, i di=
d a merge of these informations, and i found a solution for my problem.<o:p=
></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlain=
Text style=3D'margin-left:36.0pt;text-indent:-18.0pt;mso-list:l0 level1 lfo=
1'><![if !supportLists]><span style=3D'mso-list:Ignore'>-<span style=3D'fon=
t:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; </span></span><![endif]><b>Environment Example</b>: we have an envir=
onment where there are two network interface, the first for public network,=
 the second for internal network. And we don=E2=80=99t want a user called =
=E2=80=9Cmyuser=E2=80=9D (sysadm_r) after login from public interface, can =
jump trough internal network interface.<o:p></o:p></p><p class=3DMsoPlainTe=
xt style=3D'margin-left:36.0pt;text-indent:-18.0pt;mso-list:l0 level1 lfo1'=
><![if !supportLists]><span style=3D'mso-list:Ignore'>-<span style=3D'font:=
7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; </span></span><![endif]><b>Solution</b> <b>step-by-step</b>: <o:p></o:=
p></p><p class=3DMsoPlainText style=3D'margin-left:72.0pt;text-indent:-18.0=
pt;mso-list:l0 level2 lfo1'><![if !supportLists]><span style=3D'mso-list:Ig=
nore'>1.<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; </span></span><![endif]>We need to create two new types, the=
 first for internal interface, and another for packet_internal_interface.<o=
:p></o:p></p><p class=3DMsoPlainText style=3D'margin-left:108.0pt;text-inde=
nt:-18.0pt;mso-list:l0 level3 lfo1'><![if !supportLists]><span style=3D'fon=
t-family:Wingdings'><span style=3D'mso-list:Ignore'>=C2=A7<span style=3D'fo=
nt:7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]>My policy=
 is this: <o:p></o:p></p><p class=3DMsoPlainText style=3D'margin-left:108.0=
pt'>policy_module(telecom,1.0)<o:p></o:p></p><p class=3DMsoPlainText style=
=3D'margin-left:108.0pt'><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText style=
=3D'margin-left:108.0pt'><b>#I declare my types<o:p></o:p></b></p><p class=
=3DMsoPlainText style=3D'margin-left:108.0pt'>type telecom_netif_mgmt_t;=C2=
=A0=C2=A0=C2=A0 <b>#type for internal network interface</b><o:p></o:p></p><=
p class=3DMsoPlainText style=3D'margin-left:108.0pt'>type telecom_netif_mgm=
t_packet_t; <b>#type for packet of internal network interface<o:p></o:p></b=
></p><p class=3DMsoPlainText style=3D'margin-left:72.0pt;text-indent:-18.0p=
t;mso-list:l0 level2 lfo1'><![if !supportLists]><span style=3D'mso-list:Ign=
ore'>2.<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; </span></span><![endif]>After compile and install this policy=
, you have a new two types that you can check with seinfo =E2=80=93t |grep =
&lt;yourtype&gt;<o:p></o:p></p><p class=3DMsoPlainText style=3D'margin-left=
:72.0pt;text-indent:-18.0pt;mso-list:l0 level2 lfo1'><![if !supportLists]><=
span style=3D'mso-list:Ignore'>3.<span style=3D'font:7.0pt "Times New Roman=
"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![endif]>Install thi=
s package (for redhat/centos/fedora):<o:p></o:p></p><p class=3DMsoPlainText=
 style=3D'margin-left:108.0pt;text-indent:-18.0pt;mso-list:l0 level3 lfo1'>=
<![if !supportLists]><span style=3D'font-family:Wingdings'><span style=3D'm=
so-list:Ignore'>=C2=A7<span style=3D'font:7.0pt "Times New Roman"'>&nbsp; <=
/span></span></span><![endif]>=C2=A0yum =E2=80=93y install netlabel_tools=
=C2=A0=C2=A0 <b>#is needed for manage Network Labeling</b><o:p></o:p></p><p=
 class=3DMsoPlainText style=3D'margin-left:72.0pt;text-indent:-18.0pt;mso-l=
ist:l0 level2 lfo1'><![if !supportLists]><span style=3D'mso-list:Ignore'>4.=
<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; </span></span><![endif]>Now you need to label your network internal =
interface with semanage command:<o:p></o:p></p><p class=3DMsoPlainText styl=
e=3D'margin-left:108.0pt;text-indent:-18.0pt;mso-list:l0 level3 lfo1'><![if=
 !supportLists]><span style=3D'font-family:Wingdings'><span style=3D'mso-li=
st:Ignore'>=C2=A7<span style=3D'font:7.0pt "Times New Roman"'>&nbsp; </span=
></span></span><![endif]>semanage interface -a -t telecom_netif_mgmt_t eth0=
 <b>#with this we label the interface<o:p></o:p></b></p><p class=3DMsoPlain=
Text style=3D'margin-left:108.0pt;text-indent:-18.0pt;mso-list:l0 level3 lf=
o1'><![if !supportLists]><span style=3D'font-family:Wingdings'><span style=
=3D'mso-list:Ignore'>=C2=A7<span style=3D'font:7.0pt "Times New Roman"'>&nb=
sp; </span></span></span><![endif]>semanage interface =E2=80=93l <b>#with t=
his we check it<o:p></o:p></b></p><p class=3DMsoPlainText style=3D'margin-l=
eft:108.0pt;text-indent:-18.0pt;mso-list:l0 level3 lfo1'><![if !supportList=
s]><span style=3D'font-family:Wingdings'><span style=3D'mso-list:Ignore'>=
=C2=A7<span style=3D'font:7.0pt "Times New Roman"'>&nbsp; </span></span></s=
pan><![endif]><span style=3D'mso-fareast-language:IT'><img width=3D586 heig=
ht=3D68 id=3D"Immagine_x0020_1" src=3D"cid:image001.png@01D0A5C4.83DBAF50">=
</span><b>=C2=A0=C2=A0we should see something like this<o:p></o:p></b></p><=
p class=3DMsoPlainText style=3D'margin-left:72.0pt;text-indent:-18.0pt;mso-=
list:l0 level2 lfo1'><![if !supportLists]><span style=3D'mso-list:Ignore'>5=
=2E<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; </span></span><![endif]>Is moment to link this with Network Label=
ing trough <b>netlabelctl</b> command:<b><o:p></o:p></b></p><p class=3DMsoP=
lainText style=3D'margin-left:108.0pt;text-indent:-18.0pt;mso-list:l0 level=
3 lfo1'><![if !supportLists]><span style=3D'font-family:Wingdings'><span st=
yle=3D'mso-list:Ignore'>=C2=A7<span style=3D'font:7.0pt "Times New Roman"'>=
&nbsp; </span></span></span><![endif]>netlabelctl unlbl add interface:eth0 =
address:10.23.130.131 label:system_u:object_r:telecom_netif_mgmt_packet_t:s=
0=C2=A0 <b>#we are setting all unlabeled packets flow for eth0 are labeled =
with telecom_netif_mgmt_packet_t</b><o:p></o:p></p><p class=3DMsoPlainText =
style=3D'margin-left:144.0pt;text-indent:-18.0pt;mso-list:l0 level4 lfo1'><=
![if !supportLists]><span style=3D'font-family:Symbol'><span style=3D'mso-l=
ist:Ignore'>=C2=B7<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><b>N.B.=
: address: 10.23.130.131 must be the static ip address of internal network =
interface</b><o:p></o:p></p><p class=3DMsoPlainText style=3D'margin-left:10=
8.0pt;text-indent:-18.0pt;mso-list:l0 level3 lfo1'><![if !supportLists]><sp=
an style=3D'font-family:Wingdings'><span style=3D'mso-list:Ignore'>=C2=A7<s=
pan style=3D'font:7.0pt "Times New Roman"'>&nbsp; </span></span></span><![e=
ndif]>netlabelctl unlbl list <b>#for check<o:p></o:p></b></p><p class=3DMso=
PlainText style=3D'margin-left:144.0pt;text-indent:-18.0pt;mso-list:l0 leve=
l4 lfo1'><![if !supportLists]><span style=3D'font-family:Symbol'><span styl=
e=3D'mso-list:Ignore'>=C2=B7<span style=3D'font:7.0pt "Times New Roman"'>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endi=
f]><b>you should must see this output:</b> accept:on interface:eth0,address=
:10.23.130.131/32,label:&quot;system_u:object_r:telecom_netif_mgmt_packet_t=
:s0&quot;<b><o:p></o:p></b></p><p class=3DMsoPlainText style=3D'margin-left=
:72.0pt;text-indent:-18.0pt;mso-list:l0 level2 lfo1'><![if !supportLists]><=
span style=3D'mso-list:Ignore'>6.<span style=3D'font:7.0pt "Times New Roman=
"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![endif]>Now we must=
 to allow domains that we need can use this interface like unconfined_t (de=
fault root user)<o:p></o:p></p><p class=3DMsoPlainText style=3D'margin-left=
:108.0pt;text-indent:-18.0pt;mso-list:l0 level3 lfo1'><![if !supportLists]>=
<span style=3D'font-family:Wingdings'><span style=3D'mso-list:Ignore'>=C2=
=A7<span style=3D'font:7.0pt "Times New Roman"'>&nbsp; </span></span></span=
><![endif]>We need to modify our simple policy below with this delta:<o:p><=
/o:p></p><p class=3DMsoPlainText style=3D'margin-left:108.0pt'>policy_modul=
e(telecom,1.0)<o:p></o:p></p><p class=3DMsoPlainText style=3D'margin-left:1=
08.0pt'><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText style=3D'margin-left:1=
08.0pt'><b>#I declare my types<o:p></o:p></b></p><p class=3DMsoPlainText st=
yle=3D'margin-left:108.0pt'>type telecom_netif_mgmt_t;=C2=A0=C2=A0=C2=A0 <b=
>#type for internal network interface</b><o:p></o:p></p><p class=3DMsoPlain=
Text style=3D'margin-left:108.0pt'>type telecom_netif_mgmt_packet_t; <b>#ty=
pe for packet of internal network interface<o:p></o:p></b></p><p class=3DMs=
oPlainText style=3D'margin-left:108.0pt'><b><o:p>&nbsp;</o:p></b></p><p cla=
ss=3DMsoPlainText style=3D'margin-left:90.0pt'>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 allow unconfined_t telecom_netif_mgmt_t : netif { tcp_recv =
tcp_send udp_recv udp_send ingress egress } ; <b>#This allow unconfined_t (=
root user for example) to use internal network interface (egress, so the OU=
T traffic) =E2=80=93 for comodity i allow all permissions</b><o:p></o:p></p=
><p class=3DMsoPlainText style=3D'margin-left:90.0pt;text-indent:16.2pt'> a=
llow unlabeled_t telecom_netif_mgmt_t : netif { tcp_recv tcp_send udp_recv =
udp_send ingress egress};=C2=A0=C2=A0=C2=A0 <b># This allow =C2=A0unlabeled=
_t (all response from =E2=80=93 to) to pass troughe=C2=A0 internal network =
interface (ingress, so the IN traffic) =E2=80=93 for comodity i allow all p=
ermissions<o:p></o:p></b></p><p class=3DMsoPlainText style=3D'margin-left:7=
2.0pt;text-indent:-18.0pt;mso-list:l0 level2 lfo1'><![if !supportLists]><sp=
an style=3D'mso-list:Ignore'>7.<span style=3D'font:7.0pt "Times New Roman"'=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><![endif]>So, now uncon=
fined_t is allowed, but myuser_t (our myuser user)is not allowed, so we nee=
d only to try and see what happen:<o:p></o:p></p><p class=3DMsoPlainText st=
yle=3D'margin-left:108.0pt;text-indent:-18.0pt;mso-list:l0 level3 lfo1'><![=
if !supportLists]><span style=3D'font-family:Wingdings'><span style=3D'mso-=
list:Ignore'>=C2=A7<span style=3D'font:7.0pt "Times New Roman"'>&nbsp; </sp=
an></span></span><![endif]><b>While i launch a ping trough myuser (root res=
tricted shell):<o:p></o:p></b></p><p class=3DMsoPlainText style=3D'margin-l=
eft:144.0pt;text-indent:-18.0pt;mso-list:l0 level4 lfo1'><![if !supportList=
s]><span style=3D'font-family:Symbol'><span style=3D'mso-list:Ignore'>=C2=
=B7<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span style=3D'mso-far=
east-language:IT'><img width=3D850 height=3D139 id=3D"Immagine_x0020_3" src=
=3D"cid:image003.png@01D0A5C6.DD2A50F0"></span><o:p></o:p></p><p class=3DMs=
oPlainText style=3D'margin-left:144.0pt;text-indent:-18.0pt;mso-list:l0 lev=
el4 lfo1'><![if !supportLists]><span style=3D'font-family:Symbol'><span sty=
le=3D'mso-list:Ignore'>=C2=B7<span style=3D'font:7.0pt "Times New Roman"'>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![end=
if]><b>We see also audit.log: <o:p></o:p></b></p><p class=3DMsoPlainText st=
yle=3D'margin-left:144.0pt;text-indent:-18.0pt;mso-list:l0 level4 lfo1'><![=
if !supportLists]><span style=3D'font-family:Symbol'><span style=3D'mso-lis=
t:Ignore'>=C2=B7<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span sty=
le=3D'mso-fareast-language:IT'><img width=3D1664 height=3D33 id=3D"Immagine=
_x0020_2" src=3D"cid:image002.png@01D0A5C6.4231EC20"></span><o:p></o:p></p>=
<p class=3DMsoPlainText style=3D'margin-left:144.0pt;text-indent:-18.0pt;ms=
o-list:l0 level4 lfo1'><![if !supportLists]><span style=3D'font-family:Symb=
ol;color:red'><span style=3D'mso-list:Ignore'>=C2=B7<span style=3D'font:7.0=
pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </sp=
an></span></span><![endif]><b><u><span style=3D'color:red'>We can see that =
our specific domaind (telecom_sysadm_t) can=E2=80=99t use and jump in the i=
nternal network interface (eth0)<o:p></o:p></span></u></b></p><p class=3DMs=
oPlainText><b><u><span style=3D'color:red'><o:p><span style=3D'text-decorat=
ion:none'>&nbsp;</span></o:p></span></u></b></p><p class=3DMsoPlainText>Pro=
blem SOLVED!<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>I hope that this mini guide, can help someone. <o:p></=
o:p></p><p class=3DMsoPlainText>If there are any improvement, that someone =
can give me, i=E2=80=99m here ready to improve.<o:p></o:p></p><p class=3DMs=
oPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>Sorry in advance, i=
f this guide is not write with an optimal english.<o:p></o:p></p><p class=
=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>Thanks,<o:p></=
o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainTex=
t>Maurizio Pagani (LordFire in #SELinux)<o:p></o:p></p><p class=3DMsoPlainT=
ext><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></p><p=
 class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><span st=
yle=3D'mso-fareast-language:IT'>-----Messaggio originale-----<br>Da: Paul M=
oore [mailto:paul@paul-moore.com] <br>Inviato: venerd=C3=AC 12 giugno 2015 =
22:48<br>A: Maurizio Pagani<br>Cc: Stephen Smalley; James Morris; Daniel J =
Walsh; Dominick Grift; Sven Vermeulen; Eric Paris<br>Oggetto: Re: R: SELinu=
x: Interface Labeling Problem</span></p><p class=3DMsoPlainText><o:p>&nbsp;=
</o:p></p><p class=3DMsoPlainText>On Fri, Jun 12, 2015 at 4:34 PM, Maurizio=
 Pagani &lt;<a href=3D"mailto:pag.maurizio@gmail.com"><span style=3D'color:=
windowtext;text-decoration:none'>pag.maurizio@gmail.com</span></a>&gt; wrot=
e:<o:p></o:p></p><p class=3DMsoPlainText>&gt; Sure!!! That help!! However i=
 solved yet my problem, but i though <o:p></o:p></p><p class=3DMsoPlainText=
>&gt; &quot;maybe i should must write a small guide/solution to list for sh=
are my problem.&quot;<o:p></o:p></p><p class=3DMsoPlainText>&gt;<o:p>&nbsp;=
</o:p></p><p class=3DMsoPlainText>&gt; Right?<o:p></o:p></p><p class=3DMsoP=
lainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>I'm glad to hear that=
 you've resolved your problem, and I think a short description of your prob=
lem as well as how you solved it would be very welcome on the list.<o:p></o=
:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText=
>--<o:p></o:p></p><p class=3DMsoPlainText>paul moore<o:p></o:p></p><p class=
=3DMsoPlainText><a href=3D"http://www.paul-moore.com"><span style=3D'color:=
windowtext;text-decoration:none'>www.paul-moore.com</span></a><o:p></o:p></=
p></div>
<br /><br />
<hr style=3D'border:none; color:#909090; background-color:#B0B0B0; height: =
1px; width: 99%;' />
<table style=3D'border-collapse:collapse;border:none;'>
	<tr>
		<td style=3D'border:none;padding:0px 15px 0px 8px'>
			<a href=3D"https://www.avast.com/antivirus">
				<img border=3D0 src=3D"http://static.avast.com/emails/avast-mail-stamp.=
png" alt=3D"Avast logo" />
			</a>
		</td>
		<td>
			<p style=3D'color:#3d4d5a; font-family:"Calibri","Verdana","Arial","Helv=
etica"; font-size:12pt;'>
				Questa e-mail =C3=A8 stata controllata per individuare virus con Avast =
antivirus.
				<br><a href=3D"https://www.avast.com/antivirus">www.avast.com</a>
			</p>
		</td>
	</tr>
</table>
<br />
</body></html>
------=_NextPart_001_015B_01D0A5C8.6EF90480--

------=_NextPart_000_015A_01D0A5C8.6EF90480
Content-Type: image/png;
	name="image001.png"
Content-Transfer-Encoding: base64
Content-ID: <image001.png@01D0A5C4.83DBAF50>

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
kPY5YYQuIAACIAACIAACINAXAbN666sGlAsCtQTKp7ZW8vKqqbYcJAABEAABEAABEAABEAABEAAB
EAABEAABEAABEAABEAABEAABEAABEAABEAABEOiWgAotMQHB9Nvvw+xxtvIc9suvS5e+reg5+afP
b7Lix/O7FTZQWvh71PuoPhw+vo/aUUcSAWMs+v4L/R5Jk29fJ1WAxCAAAkdFIPTL5aWvdoo/tNgN
fxN9n2omfRH1jO+X2ifz06qr8gvx7W8C7Mp/uirntAwBaUFgPwT46s3780LW+9/0S0O0nrMF8t41
phd8+7wPTEvlaCGFqd5Ddvb3S+3Hb06vFnKI8GKten9hZ/5TtAr3fjt1n5wBie9AnJ5TQeKTIKB/
G0tfBiaHN31XmqNFZPXW/J4nSmlugfvGfWBStub1UmLvrPk87pc6CX87gJBhlw3dGyf8X3mo411p
/sML8t9vh9XbATwBVf4YAurGgOJH+/m1aPYIxy9Vul7uvo2j7/vAQgIm1Hsy90t92xgowCYQvTeu
G/9Jv98OJgIBEPg+AfdCHLqJZmdd1ykq2Dg7k06tpUXY9yWSJaTdB9ZFrcn3PIUq7ft+qS6U/YFl
iOuXetQ77j/79+ceVUXRIHAaBGh4oxN365ozuh4pcBd2HxspHd0H1oI17pdqAe2Us4i7sT33+bW8
Ny7Bf/jeZPB+O889iKdMGbKDwBERoNASJ65exYX4fgVQHH5XrzFSNyul3/Nk6vjWfWDeLwbosv33
ip3h/VJH5FVHK4r/Pr+yr8sQj678J3YfHmFKu47waLlCMBAAARAAARAAARAAARAAARAAARAAARAA
ARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAA
ARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAA
ARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAA
ARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARAAARDYC4HL
+fPb29ti4q9MfsqfUIq9CIlKQOCHE5gsqBE+zy/DGHhbPatWqjufqNqn6hdkUK9ewtA/pdPteHyZ
P3saANXhbxbCAtJ96J9n1XROtVFA7l4IhFpAL5W1LXT+3Hs/3zeHFuVT79S72m0tUpsvWV+hbW2x
nSdIlTM1vV/g9PHlH14QMfo7Hcgi8/X1bOW+FJ/sltePG/XJLdsOpzKLfk1D2vPFy2z1IVJTmbdf
M5kBDwgcBwFasChHz/OcbWfk6sr58/Udd139l2wF4fRGH9MAqu1Ivsnz3WAwopayZPf3I7vJVKnI
HLJMas6UXEmmksp3pk752shpfUQ9H3vdju+lxqYYK3G5cG8/IMqXtcpi1mzMnoiO1WmU+4eQqWW9
JMcTexD9ja1FRS9bGKf8sJyy43ng8sluSDxJeol8Ls/WdtztRiMJzlI2vb+V3XPZEyyjSDV11101
QI382rxk3Ww6HeW7HRuN/H4bsYvX8DXp6/xZt1PuhK3GF3u6w1d/1nQgtHrT+x72XImqN5shB5pW
hJoW3oNA2Ve5CysmJcelrk3tOwTT8+7Pszfhb0diP4Wn5rtI/P/BzQ+rNzall2WTpThb/6LJFruQ
1gxXHBQUn3i3Il3FTTF2P1AIrkYKe88zeVYuxZfkJwsLokcvMcw05mzRc1Zvof4tpJefZys7akvZ
vpTa3+ox2rMqbd7NhuU3m9Qijaolqm+q3cPpPXYPtbsW48svam3jwWD6V+3e8mnCYBg4WTM95G6p
pkcfXxn6TRA4CQIfq9escPT7EXdhJfbmcTu+VT4/WYy3L3LPIZg+MEsNtqN8rXYxdu/f3s3YPF7T
Y+2KUPvNitZIgm0el9lYD3a6nZIyT+vhVaRhB/uBydVwrSv8WM2uaWFrLY1STU9LELU/tHm01Kjo
FSo3tb9K1SvCM92Ou6VS0fSTqfKn8o2k98pP8rDCP7mT5KaAdH3ThfXYPa3dRav8xQg8rWpLT+st
xcHwt1Vb9pWuLXKAQH8EZFsSD+0TWrsUq1d2I8aE+Q17NZ13ML1HxC7bUVcE8uyzcVHHKL9P+FQ5
U9M3BtYy4bHJU1bjOJYroXaXPL78ovneezYNH8YOL+S2h72SDxh287JmKjWb3E6z709VW3oQsoGA
h4Abc2BPv+QCzlq68aHOiVEoTdeq7SLejtIsokqnbRp15KWzVzZzPlbboRya5UOLrW0xQA+mD8UG
7OX8oaZFhuR33jsdQUL/EEXg35xk7PucE/WK8UwzYqib7Kq/7UQaWtZvmVnuz2/kSWHtk2r3UHrv
Znt5OCraXYvxRYSWlI5S6S/rFNScKauX+qSQ/83UibM+8zRHsu7hdy0vJACBfgnYIRWe+A7u6qwI
n4o2Cj6I6FiLkqO7VdxlNzIqgFK9X1F4hg6siLUPcxpfHPXLuBcxenlCS8qn91ZYigoREBmduARV
mHVYH1PZ1qskeYCDz5Amqfy0TMAfYtCUswnEsWs2NYRM79eryvOziKNpbMem/aRDwsPT5abJlZWK
RizZ0lT9UGtHXsIjrp5m//5RwYYhfRPsbrlt1ew+f460U4wv/XaRKP1sCbhBHGerqFbMPsM/f22h
YQMCZ+YSavXWQHEkAYHzJGBPj3/ApoOlbiSU/DxNDa38BKwvwBRfDAMqEAABEAABEACB4ySA1dtx
2gVSnTWBynddC21PfPV4rnqFnPHY9D2UPIeqt66TwPBWRwifg0AfBP4LFIoW2QdtlAkCIAACILAn
At7hLTTm7UkmVAMCZ0WAvveGBwRAAARAAATOjcD/PRDdIcfnC1IAAAAASUVORK5CYII=

------=_NextPart_000_015A_01D0A5C8.6EF90480
Content-Type: image/png;
	name="image002.png"
Content-Transfer-Encoding: base64
Content-ID: <image002.png@01D0A5C6.4231EC20>

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

------=_NextPart_000_015A_01D0A5C8.6EF90480
Content-Type: image/png;
	name="image003.png"
Content-Transfer-Encoding: base64
Content-ID: <image003.png@01D0A5C6.DD2A50F0>

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
fOZXOnVWj9wrcDkdFnPrlFo9zoshf+vE7jfhvujvik8v0XbxVkxu5Ot5et1fvuoI1LulcktsPryg
1JEiaIlYj3w7cvHg3Xr4IIwPZYkoY1D8R770x1f9pQkEv13cqvluqlevN3lW6ckTxnp9Y21u5tpR
sl08LftXjhmayi3Kx42NJEtvnL6LyIpxWz2uh4ozURmuDeiwHNEuCsT9YEOdQBpQNXzo9zKH2v5A
TdbUX7zfKZC56glb9rRkLv+gHJN++6V/vySnrnZ3CSGNl7VddEgx2exXfTbSbrbtgk9lprtuGwvt
PoGwcdlbWfCjnIQtmid5G1SqyidMczW5TJPISTZx99WGRBAAARA4XwJJZt++8SyeaFrxnWYTe8O/
uqzVqzShxrNJ8fatd+duqSzU7WLNhHlK1qta6mf+U53jciq9/SpoYte7TPqywdopq0w9W5W9eGPX
Asr0miWAdlSieXbpLqvjk6UTN3PJqiYTm/oCmZfN7lnGSh8MWeUFE1tzMC5LGkbu/1I+Qr6vW42E
/j/Oj0VzUdwZ+czWd4HpXZmZVkYWZA63vYLyx1e2vYizHe5tS0E+EAABEACBLAKtzD6yn/rSVJAX
OcnW3DKL3VfJ9IYNZyb1s6BH/yVlJMcav6T3SFzkWCJ7xHP1ZdVMCbmlpV/aRTbuM6Fn9Fp9FBPH
1DCKlu67+XsT5UHkN/8OizonZAOf/Op1kkM6/CquPtVafPOIXgrHZ+p9S6yQHrMaPlkqqn0etKxw
uaP/S9pbNKEFYvqiDUJJTuCSUlu2pqrp/kzmb+vrw/eQkVOwrXs2T4XVK2MXKsv4hhUfXnbpm/RX
Q6itG6XhYCe7+QcXG/jmY1VOTEuzNaQkn8a7Z576+dPl59FBahAAARAAAU2gfktHeYW93UDh79Jo
vk/lWWHOPgwup/8mJlZpyZz6l1bO+dHZNEC5P67INWg2mugbTqvqXRfiVrDgaBdwtqp4G0bc+2Yr
CZlB/YK2CKi9p3rrQza3rK0MXpVkPbz6+lUzLRXippyWvHja3+C4PG37qj0rsmpBCLK80E9xDiJL
dUuHqBrf1sIeZl+3tS5YVSgT/FWVzQYOsz/DsKDdG59T9iw2f9A8L83EUpUFObFrwYk4SRtVyAx0
PkDynhZyo4m8eEG1bkC7/0O1Ixvd1hVXk96Wu7ETzVKWpGH3r1TCa7p6WnS7sjJlOcI0dD4KiKbI
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
GhaVUeefzaRUDd6s64b+EDAVLh381Dje+feZUpJG6WYzGAzEEHPEq4pbpqFmqUuvymh69CQMOiQB
ARAAgV9IQB/g8gur9quq5B/g8quq9r3KHAjMt4v5tgAHU/XAo+8xRG4QAAEQAIFzIQCz71Raujwx
dyp671XPbxwal6vXt/h3pKezVcpf5ZBbGaQHARAAARA4TwIw+86z3VFrEAABEAABEACBcyPw3S0d
58YL9QUBEAABEAABEACBEyUAs+9EGw5qgwAIgAAIgAAIgEAeAZh9ebyQGgRAAARAAARAAAROlADM
vhNtOKgNAiAAAiAAAiAAAnkEYPbl8UJqEAABEAABEAABEDhRAklmHwUg1bHXT7SaXO3ZO3t/+Xn9
CeY7aSKUuZyyQ4Yszq08HRfy3SjGuUXWpj/M8SVH0k86JQdhIAACIAACICAInNUBLrOfNvu4zTdT
PY9sPjL+ftzsm74wHb7uuIfEJXs5VPP9eD857paAdiAAAiAAAqdKgAdn+5///b9Jb7dcFpPJo6zH
8o7JmKRkmjxP+D92S6ajpqmbIniUqvZ8xFaaADlL5O0lRTmdeBnlT27iGmxkjqjgnDu2Y+z2VqSl
d/8zUzE7d2wkbkolw/o46Tdzxq7Z45OQsGObnlCG4tDfcyFGq3C5wln43XqRMjfsVjEuV92Wq5WJ
1SuxvkRN8pEXWZwqLNaOLenvJ7ZgDkyRhhDJgF/BdpdynHhcKv6VjJQlQ20pMaW4YZVmlpWlTvXE
VAdT/EPt6ykvRYmqKQ5CZ1k7t5em9x9RYYtC9RMHXUV93AABEAABEACB0yQgvX30Ln83x/7TK/Dd
8wDR+7U0ySs9VdJL5P5K71rlvhJCSrn49JkvOcbMlck9ZNrNQ/KnlyoT10Hfj+lDJZr0dvJO6Mb1
HCt9zGRrTbkd1GscnSunellWpFVTvWr4B/lUvYwmWY23r9ruuXrWjQkBX9V0rLpNrH2VZVbx9nmz
5A7e3P4T7ienOaKhNQiAAAiAAAjECNi1fZu5juy+ZU9LdtU080dOEenh235p4ZdsyJS7iAkhpetx
xEaOX7CmVbYLVkzUGjjy4sy1q2/YY5NndZ+7IXvWPA3oM2b9pXJbUlmPd9xrqK6d1nNj/ZS8LrFy
O6pXuMrErbDOVFJoXlhrNVAvISXMP8Lnqs9G2stIdaRWkN7cvKuVnjVFkHNO+SNXojlIfrx9s1TN
6z81/SSrVCQGARAAARAAgeMmYMy+XfHZsabWHGwlWNqI/H80DyvdPFtW0OyeuZ9sRGaVHyjXz9++
XkSY7OL9XQfhsz/1u23fn+o/e+QD0SAAAiAAAiDwPQLG7OtNHqZG1N8h+zCL9dIL2LI1zRfrSdjp
dTln+iSvO9nHpRRK1EeRs6d4xV2Gxms5vtGLAuM1CpfbVb227M3Xn4DwuWOS37fcSDtyzrXxxjEW
41O6r8rVHC5kk+kp7yie7vSMFZHXvkJK/0L8hybu763UvP6T30/SxwRSggAIgAAIgMDxEOBbOv78
+TN9eekXtEVDrWM3S+PNPgajMS29/9T7PPgOAMbexetWZXGWxu9oSnXtzF3qXREpWzrc/Q0k3M1S
/alOHzJljDWwYZsB35ZBevFNIRs2+uC/mo0FVJ3iWu8jERW25XZUL5Lp6m+2UHhbVfTWCrOvosTZ
bIMI8Pflu1UIlyutPY3I1DfY7vxDwN1y0aSn2QNU7e4l+ZZDRP9So/O2k3PWjj7uFqKs/sPrVe0n
/oaY4xmx0AQEQAAEQAAE2hPQWzq6P6CtuiGgvZbHlPO31uuYGEMXEAABEAABEACB7gmYA1yE6N3I
PfKjXWnuwRnfl9ZOh33k+q312gcryAQBEAABEAABEDhGAmd1XPMxNgB0AgEQAAEQAAEQAIGDEEgK
znYQTVAICIAACIAACIAACIDAHgnA7NsjXIgGARAAARAAARAAgeMhALPveNoCmoAACIAACIAACIDA
HgnA7NsjXIgGARAAARAAARAAgeMhALPveNoCmoAACIAACIAACIDAHgnA7NsjXIgGARAAARAAARAA
geMhALPveNoCmoAACIAACIAACIDAHgnA7NsjXIgGARAAARAAARAAgeMhALPveNoCmoAACIAACIAA
CIDAHgnA7NsjXIgGARAAARAAARAAgeMhALPveNoCmoAACIAACIAACIDAHgnA7NsjXIgGARAAARAA
ARAAgeMhALPveNoCmoAACIAACIAACIDAHgnA7NsjXIgGARAAARAAARAAgeMhALPveNoCmoAACIAA
CIAACIDAHgnA7NsjXIgGARAAARAAARAAgeMhALPveNoCmoAACIAACIAACIDAHgnA7NsjXIgGARAA
ARAAARAAgeMhALPveNoCmoAACIAACIAACIDAHgnA7NsjXIgGARAAARAAARAAgeMhALPveNoCmoAA
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
p/Fb0x0fegAAAABJRU5ErkJggg==

------=_NextPart_000_015A_01D0A5C8.6EF90480--
