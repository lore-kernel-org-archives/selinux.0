MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CCEFF6.AA3D5F08"
Subject: SE Android Issue Compiling Kernel for the Emulator
Date: Mon, 20 Feb 2012 09:39:58 -0800
Message-ID: <99E44A153A242A488492D7FE003CD99D0487B864@bb-corp-ex3.corp.cubic.cub>
From: "Fullen, Jason" <jason.fullen@cubic.com>
To: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CCEFF6.AA3D5F08
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I am having a problem getting SE Android to compile using Mac OS X 10.6
Snow Leopard. First off, I have successfully built and run AOSP, using
the Mac, on the emulator. I have also built and installed Ice Cream
Sandwich on the Nexus S phone. So I can pretty much guarantee that my
build environment has been configured correctly.=20

=20

I followed the directions on the SE Android wiki and put the
local_manifest.xml file into my .repo directory and then ran "repo sync
-j1" again. My next step was to use the following four commands from the
SE Android wiki to compile the necessary kernel for the emulator:

=20

export PREFIX=3D/path/to/your/aospclone

cd $PREFIX/kernel/goldfish

make ARCH=3Darm goldfish_armv7_defconfig

make ARCH=3Darm
CROSS_COMPILE=3D$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/a=
r
m-eabi-

=20

Everything went fine with the first "make" command but the second "make"
command that cross compiles with something in that Linux x86 directory
failed with the following error:

=20

Imaginuity3:goldfish jfullen$ make ARCH=3Darm
CROSS_COMPILE=3D$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/a=
r
m-eabi-

/Volumes/SEAndroid/WORKING_DIRECTORY/prebuilt/linux-x86/toolchain/arm-ea
bi-4.4.3/bin/arm-eabi-gcc:
/Volumes/SEAndroid/WORKING_DIRECTORY/prebuilt/linux-x86/toolchain/arm-ea
bi-4.4.3/bin/arm-eabi-gcc: cannot execute binary file

  CHK     include/linux/version.h

make[1]: `include/asm-arm/mach-types.h' is up to date.

  CHK     include/linux/utsrelease.h

  SYMLINK include/asm -> include/asm-arm

  CC      kernel/bounds.s

/bin/sh:
/Volumes/SEAndroid/WORKING_DIRECTORY/prebuilt/linux-x86/toolchain/arm-ea
bi-4.4.3/bin/arm-eabi-gcc: cannot execute binary file

make[1]: *** [kernel/bounds.s] Error 126

=20

I was kind of confused by the "Cannot Execute Binary File" error. I
manually checked and confirmed that I had "read and execute" privileges
so my user account should have had sufficient privileges to execute that
binary file. Has anyone successfully built SE Android using a Mac and
seen this error? If so, how did you get around this error? Otherwise,
does anyone have any insight into how this problem might be solved?

=20

Thanks in advance,

=20

-Jason

=20


------_=_NextPart_001_01CCEFF6.AA3D5F08
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Hello,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I am having =
a problem getting SE Android to compile using Mac OS X 10.6 Snow =
Leopard. First off, I have successfully built and run AOSP, using the =
Mac, on the emulator. I have also built and installed Ice Cream Sandwich =
on the Nexus S phone. So I can pretty much guarantee that my build =
environment has been configured correctly. <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I followed =
the directions on the SE Android wiki and put the =
&nbsp;local_manifest.xml file into my .repo directory and then ran =
&#8220;repo sync &#8211;j1&#8221; again. My next step was to use the =
following four commands from the SE Android wiki to compile the =
necessary kernel for the emulator:<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal =
style=3D'line-height:13.2pt;background:white'><span =
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>export =
PREFIX=3D/path/to/your/aospclone<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'line-height:13.2pt;background:white'><span =
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>cd =
$PREFIX/kernel/goldfish<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'line-height:13.2pt;background:white'><span =
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>make =
ARCH=3Darm goldfish_armv7_defconfig<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'line-height:13.2pt;background:white'><span =
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>make =
ARCH=3Darm =
CROSS_COMPILE=3D$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/a=
rm-eabi-<o:p></o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Everything =
went fine with the first &#8220;make&#8221; command but the second =
&#8220;make&#8221; command that cross compiles with something in that =
Linux x86 directory failed with the following error:<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Helvetica","sans-serif"'>Imaginuit=
y3:goldfish jfullen$ make ARCH=3Darm =
CROSS_COMPILE=3D$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/a=
rm-eabi-</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Helvetica","sans-serif"'>/Volumes/=
SEAndroid/WORKING_DIRECTORY/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/b=
in/arm-eabi-gcc: =
/Volumes/SEAndroid/WORKING_DIRECTORY/prebuilt/linux-x86/toolchain/arm-eab=
i-4.4.3/bin/arm-eabi-gcc: cannot execute binary =
file</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Helvetica","sans-serif"'>&nbsp; =
CHK&nbsp;&nbsp;&nbsp;&nbsp; =
include/linux/version.h</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Helvetica","sans-serif"'>make[1]: =
`include/asm-arm/mach-types.h' is up to date.</span><o:p></o:p></p><p =
class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Helvetica","sans-serif"'>&nbsp; =
CHK&nbsp;&nbsp;&nbsp;&nbsp; =
include/linux/utsrelease.h</span><o:p></o:p></p><p =
class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Helvetica","sans-serif"'>&nbsp; =
SYMLINK include/asm -&gt; include/asm-arm</span><o:p></o:p></p><p =
class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Helvetica","sans-serif"'>&nbsp; =
CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel/bounds.s</span><o:p></o:p></p><p =
class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Helvetica","sans-serif"'>/bin/sh: =
/Volumes/SEAndroid/WORKING_DIRECTORY/prebuilt/linux-x86/toolchain/arm-eab=
i-4.4.3/bin/arm-eabi-gcc: cannot execute binary =
file</span><o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"Helvetica","sans-serif"'>make[1]: =
*** [kernel/bounds.s] Error 126</span><o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I was kind =
of confused by the &#8220;Cannot Execute Binary File&#8221; error. I =
manually checked and confirmed that I had &#8220;read and execute&#8221; =
privileges so my user account should have had sufficient privileges to =
execute that binary file. Has anyone successfully built SE Android using =
a Mac and seen this error? If so, how did you get around this error? =
Otherwise, does anyone have any insight into how this problem might be =
solved?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks in advance,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span =
style=3D'font-size:10.5pt;font-family:Consolas'>-Jason<o:p></o:p></span><=
/p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------_=_NextPart_001_01CCEFF6.AA3D5F08--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
