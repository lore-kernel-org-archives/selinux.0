Message-ID: <001a01c254ce$b3ca7020$0200a8c0@kevsta>
Reply-To: "jj012a1662" <jj012a1662@blueyonder.co.uk>
From: "jj012a1662" <jj012a1662@blueyonder.co.uk>
To: <SELinux@tycho.nsa.gov>
Subject: Re: Cant get linksys network card to work!
Date: Thu, 5 Sep 2002 12:23:46 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0017_01C254D7.1503D630"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C254D7.1503D630
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thankyou guys for the quick responce + help, but i am still unable to =
get my card to work. I have tried using the tulip driver/winbond(as far =
as i know xp uses the winbond driver(so device manager says so))

I also enabled DHCP support from make menuconfig as the selinux machine =
is going to be getting an IP off my DHCP server (which shares the =
Internet). After compiling everything seems to load OK. I run netconfig =
to try and set it to get an IP from my DHCP server...etc, but i am still =
unable to get the network to work.

I know that the network card is fully functional and their are not any =
faulty wiring as i am able to get it to work on all linux distro's that =
i have (suse,redhat 7.1/2/3,slackware)


Is there anything else which could be cuasing the problem?=20

Thankyou very much for your time.
Regards,
Kevin.j
  ----- Original Message -----=20
  From: david caplan=20
  To: jj012a1662=20
  Sent: Wednesday, September 04, 2002 11:49 AM
  Subject: RE: Cant get linksys network card to work!


  You need to build the kernel (this applies to any linux kernel, not =
just an selinux kernel) with the tulip driver built in or as a module.  =
You do this when you are configuring the kernel build through the =
configuration menus.  When you are in the kernel directory (e.g., for =
selinux when you are in the lsm-2.4 directory) and you do a "make =
xconfig", goto the "Network device support" section, then the "Ethernet =
(10 or 100Mbit)" subsection, and look about 2/3 of the way down the list =
for "DECchip Tulip (dc21x4x) PCI support".  Check either the 'y' or the =
'm', exit and rebuild the kernel.  That should work.  If it doesn't =
check the Linksys site to see if they provide more information for your =
card.  I've used Linksys cards before and that driver has always worked =
(of course, YMMV).

  good luck,
  david
    -----Original Message-----
    From: owner-selinux@tycho.nsa.gov =
[mailto:owner-selinux@tycho.nsa.gov]On Behalf Of jj012a1662
    Sent: Tuesday, September 03, 2002 2:52 PM
    To: SELinux@tycho.nsa.gov
    Subject: Cant get linksys network card to work!


    Hi all,

    I know this sounds like a stupid question, and feel like an idiot to =
ask about it...but i am unable to get my network card to work once i =
have SELinux kernel compiled. My Network card is a 10baseT linksys =
etherPCI lan card II, A friend of mine said that my card uses the =
tuplip.c driver, is there any way to get this card to work?


    Thankyou for your time.

    Regards,
    Kevin.j

------=_NextPart_000_0017_01C254D7.1503D630
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2><STRONG><U>Thankyou</U></STRONG> guys =
for the quick=20
responce + help, but i am still unable to get my card to work. I have =
tried=20
using the tulip driver/winbond(as far as i know xp uses the winbond =
driver(so=20
device manager says so))<BR><BR>I also enabled <STRONG>DHCP</STRONG> =
support=20
from make menuconfig as the selinux machine is going to be getting an IP =
off my=20
DHCP server (which shares the Internet). After compiling everything =
seems to=20
load OK. I run netconfig to try and set it to get an <STRONG>IP</STRONG> =
from my=20
<STRONG>DHCP</STRONG> server...etc, but i am still unable to get the =
network to=20
work.<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I know that the network card is fully =
functional=20
and their are not any faulty wiring as i am able to get it to work on =
all linux=20
distro's that i have (<STRONG>suse,redhat=20
7.1/2/3,slackware</STRONG>)</FONT></DIV>
<DIV><FONT size=3D2></FONT><FONT face=3DArial>&nbsp;</DIV>
<DIV><BR><FONT size=3D2>Is there anything else which could be cuasing =
the problem?=20
</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Thankyou very much for your=20
time.<BR>Regards,<BR>Kevin.j</FONT></FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Ddac@tresys.com href=3D"mailto:dac@tresys.com">david =
caplan</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Djj012a1662@blueyonder.co.uk=20
  href=3D"mailto:jj012a1662@blueyonder.co.uk">jj012a1662</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, September 04, =
2002 11:49=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> RE: Cant get linksys =
network=20
  card to work!</DIV>
  <DIV><BR></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D974123310-04092002>You=20
  need to build the kernel (this applies to any linux kernel, not just =
an=20
  selinux kernel) with the tulip driver built in or as a module.&nbsp; =
You do=20
  this when you are configuring the kernel build through the =
configuration=20
  menus.&nbsp; When you are in the kernel directory (e.g., for selinux =
when you=20
  are in the lsm-2.4 directory) and you do a "make xconfig", goto the =
"Network=20
  device support" section, then the "Ethernet (10 or 100Mbit)" =
subsection, and=20
  look about 2/3 of the way down the list for "DECchip Tulip (dc21x4x) =
PCI=20
  support".&nbsp; Check either the 'y' or the 'm', exit and rebuild the=20
  kernel.&nbsp; That should work.&nbsp; If it doesn't check the Linksys =
site to=20
  see if they provide more information for your card.&nbsp; I've used =
Linksys=20
  cards before and that driver has always worked (of course,=20
  YMMV).</SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D974123310-04092002></SPAN></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D974123310-04092002>good=20
  luck,</SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D974123310-04092002>david</SPAN></FONT></DIV>
  <BLOCKQUOTE dir=3Dltr=20
  style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
    <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
    size=3D2>-----Original Message-----<BR><B>From:</B>=20
    owner-selinux@tycho.nsa.gov =
[mailto:owner-selinux@tycho.nsa.gov]<B>On Behalf=20
    Of </B>jj012a1662<BR><B>Sent:</B> Tuesday, September 03, 2002 2:52=20
    PM<BR><B>To:</B> SELinux@tycho.nsa.gov<BR><B>Subject:</B> Cant get =
linksys=20
    network card to work!<BR><BR></FONT></DIV>
    <DIV><FONT face=3DArial size=3D2>Hi all,<BR><BR>I know this sounds =
like a stupid=20
    question, and feel like an idiot to ask about it...but i am unable =
to get my=20
    network card to work once i have SELinux kernel compiled. My Network =
card is=20
    a 10baseT linksys etherPCI lan card II, A friend of mine said that =
my card=20
    uses the tuplip.c driver, is there any way to get this card to=20
    work?<BR><BR><BR>Thankyou for your=20
    =
time.<BR><BR>Regards,<BR>Kevin.j</FONT></DIV></BLOCKQUOTE></BLOCKQUOTE></=
FONT></DIV></BODY></HTML>

------=_NextPart_000_0017_01C254D7.1503D630--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
