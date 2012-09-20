From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: Alexandra Test <testalexandrainstitute@gmail.com>,
        Stephen Smalley
	<sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: seandroid 4.1.1
Date: Thu, 20 Sep 2012 14:48:14 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E383651A15A2@ALA-MBA.corp.ad.wrs.com>
References: <CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	<1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
	<1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3PuokYYQxCwf+SGga7UuguXBR14ZSneFMOfFQ-g0qX5btMA@mail.gmail.com>
	<1348149606.13835.21.camel@moss-pluto.epoch.ncsc.mil>
 <CAKi3Puo9rREhxm_CTEYaRJtZJKf2XdK=EO0-jjDE+cQ12g-Zrg@mail.gmail.com>
In-Reply-To: <CAKi3Puo9rREhxm_CTEYaRJtZJKf2XdK=EO0-jjDE+cQ12g-Zrg@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="_000_33006C99F5A5194A9B7A7715DFA3E383651A15A2ALAMBAcorpadwrs_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_33006C99F5A5194A9B7A7715DFA3E383651A15A2ALAMBAcorpadwrs_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Try using "adb shell dmesg" or "adb shell -c dmesg" or "adb shell su -c dme=
sg" or "adb shell su 0 -c dmesg"


From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On B=
ehalf Of Alexandra Test
Sent: Thursday, September 20, 2012 7:10 AM
To: Stephen Smalley
Cc: selinux@tycho.nsa.gov
Subject: Re: seandroid 4.1.1

effectively I have a problem with dmesg
is it possible I don't have the package installed?
this is the output....
adb shell su 0 dmsg
Usage: su [options] [LOGIN]

Options:
  -c, --command COMMAND         pass COMMAND to the invoked shell
  -h, --help                    display this help message and exit
  -, -l, --login                make the shell a login shell
  -s, --shell SHELL             use SHELL instead of the default in passwd
  -v, --version                 display version number and exit
  -V                            display version code and exit. this is
                                used almost exclusively by Superuser.apk
root@alexandra:~/new/external/sepolicy# adb shell su 0 dmesg
Usage: su [options] [LOGIN]

Options:
  -c, --command COMMAND         pass COMMAND to the invoked shell
  -h, --help                    display this help message and exit
  ...
what is wrong?


On Thu, Sep 20, 2012 at 4:00 PM, Stephen Smalley <sds@tycho.nsa.gov<mailto:=
sds@tycho.nsa.gov>> wrote:
On Thu, 2012-09-20 at 15:57 +0200, Alexandra Test wrote:
> I don't have any denials.
> If I change in enforcing mode with the wifi still connected, the wifi
> works.
> But if, in the enforcing mode, I disconnect it and try to reconnect
> it, it doesn't : he says "obtaining IP address", "connecting", "saved"
> at the end without being connected...
No avc: or SELinux: messages in dmesg output when it fails?

I suppose it could be hidden by a dontaudit rule.  You could try
stripping those from your policy and see if you get anything.

--
Stephen Smalley
National Security Agency


--_000_33006C99F5A5194A9B7A7715DFA3E383651A15A2ALAMBAcorpadwrs_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Try using &#8220;adb shel=
l dmesg&#8221; or &#8220;adb shell &#8211;c dmesg&#8221; or &#8220;adb shel=
l su &#8211;c dmesg&#8221; or &#8220;adb shell su 0 &#8211;c dmesg&#8221;<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> owner-se=
linux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
<b>On Behalf Of </b>Alexandra Test<br>
<b>Sent:</b> Thursday, September 20, 2012 7:10 AM<br>
<b>To:</b> Stephen Smalley<br>
<b>Cc:</b> selinux@tycho.nsa.gov<br>
<b>Subject:</b> Re: seandroid 4.1.1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">effectively I have a problem with dmesg<br>
is it possible I don't have the package installed? <br>
this is the output....<o:p></o:p></p>
<div style=3D"margin-left:60.0pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">adb shell su 0 dmsg<b=
r>
Usage: su [options] [LOGIN]<br>
<br>
Options:<br>
&nbsp; -c, --command COMMAND&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; pass COMMAND to the invoked shell<br>
&nbsp; -h, --help&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display this help =
message and exit<br>
&nbsp; -, -l, --login&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make the shell a login shell<br>
&nbsp; -s, --shell SHELL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; use SHELL instead of the default in passwd<br>
&nbsp; -v, --version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display version number and exit<b=
r>
&nbsp; -V&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; display version code and exit. this is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used almost exclusively by Superuser.a=
pk<br>
root@alexandra:~/new/external/sepolicy# adb shell su 0 dmesg <br>
Usage: su [options] [LOGIN]<br>
<br>
Options:<br>
&nbsp; -c, --command COMMAND&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; pass COMMAND to the invoked shell<br>
&nbsp; -h, --help&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display this help =
message and exit<br>
&nbsp; ...<o:p></o:p></p>
</div>
<p class=3D"MsoNormal">what is wrong?<o:p></o:p></p>
<div style=3D"margin-left:60.0pt">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">On Thu, Sep 20, 2012 at 4:00 PM, Stephen Smalley &lt=
;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</=
a>&gt; wrote:<o:p></o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">On Thu, 2012-09-20 at=
 15:57 &#43;0200, Alexandra Test wrote:<br>
&gt; I don't have any denials.<br>
&gt; If I change in enforcing mode with the wifi still connected, the wifi<=
br>
&gt; works.<br>
&gt; But if, in the enforcing mode, I disconnect it and try to reconnect<br=
>
&gt; it, it doesn't : he says &quot;obtaining IP address&quot;, &quot;conne=
cting&quot;, &quot;saved&quot;<br>
&gt; at the end without being connected...<o:p></o:p></p>
</div>
<p class=3D"MsoNormal">No avc: or SELinux: messages in dmesg output when it=
 fails?<br>
<br>
I suppose it could be hidden by a dontaudit rule. &nbsp;You could try<br>
stripping those from your policy and see if you get anything.<o:p></o:p></p=
>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
--<br>
Stephen Smalley<br>
National Security Agency<o:p></o:p></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_33006C99F5A5194A9B7A7715DFA3E383651A15A2ALAMBAcorpadwrs_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
