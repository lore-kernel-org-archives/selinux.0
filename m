Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26534
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 14:10:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA24595
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 18:08:58 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id SAA24583 for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 18:08:51 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015243A6@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Haigh, Tom'" <tom_haigh@securecomputing.com>,
        linux-security-module@wirex.com,
        "'selinux@tycho.nsa.gov'"
	 <selinux@tycho.nsa.gov>
Subject: RE: Regarding the Type Enforcement Licensing Discussion
Date: Mon, 17 Jun 2002 13:10:39 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C2162A.495267D0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C2162A.495267D0
Content-Type: text/plain;
	charset="iso-8859-1"

Tom,
 
 
It seem that you post a similar message to the nl.linux.org mailing list in
Jan 2000. http://mail.nl.linux.org/securedistros/2000-01/msg00012.html
<http://mail.nl.linux.org/securedistros/2000-01/msg00012.html> 
 
Quote "When we have figured out just how to handle this, I will post the
resolution here." From the selinux mailing list, Jun 2002 
 
Quote "However, we want to avoid creating more confusion, so we are going to
take 
a little time to reflect before we respond."
 
 
I have clam down since my last post on this subject and I apologize
for the Flame. 
 
Questions:
Did you resolve this issue two years ago?
   If so, could you please post the results here.
Did the contract you accepted from the NSA resolve this issue?
   If so, could you please post the results here 

We really need to put this issue to bed. To prevent statements 
like 
 
"Our company will not be using the SELinux for clients because, our
management has determined the situation is to confusing and will not place
our business at risk.
 
Pamela Patterson
OpenDNS Crop
 "
 
Thanks,
Mark Westerman
 
>From you post 
http://mail.nl.linux.org/securedistros/2000-01/msg00012.html
<http://mail.nl.linux.org/securedistros/2000-01/msg00012.html> 
Secure Computing's Plans for Type Enforced Linux
 
 
 
     To: securedistros@nl.linux.org <mailto:securedistros@nl.linux.org>  
     Subject: Secure Computing's Plans for Type Enforced Linux 
     From: Tom Haigh < tom_haigh@securecomputing.com
<mailto:tom_haigh@securecomputing.com> > 
     Date: Fri, 21 Jan 2000 10:48:25 -0600 
     References: < CMM.0.90.4.948178145.neumann@chiron.csl.sri.com
<mailto:CMM.0.90.4.948178145.neumann@chiron.csl.sri.com> > <
200001191057.DAA21079@aztec.santafe.edu
<mailto:200001191057.DAA21079@aztec.santafe.edu> >
     < 3885FB0D.FC3BFC95@darpa.mil <mailto:3885FB0D.FC3BFC95@darpa.mil> > <
200001200629.XAA22118@aztec.santafe.edu
<mailto:200001200629.XAA22118@aztec.santafe.edu> > 
     Reply-To: securedistros@nl.linux.org
<mailto:securedistros@nl.linux.org>  
     Sender: owner-securedistros@nl.linux.org
<mailto:owner-securedistros@nl.linux.org>  
 
 
 
I just posted the following message to the open-source discussion group
at SRI.  It belongs here as well.
 
--Tom 
 
It is past time for me to jump into this discussion.  Secure Computing
is commited to being a responsible, contributing member of the open source 
community.  One of the conditions of accepting the contract from NSA was
that 
we be able to make the results of the contract available to the community.
I have 
appended a portion of a FAQ that we released internally on the topic.
 
I will also say that our legal folks are still looking at the best way
to do this. Needless to say, we are not excited about other vendors coming 
up with proprietary versions of type enforcement.  We believe that opening 
up the TE work to the broader community will be a win for all of us.  The 
proposals made by Brian Witten and Richard Stallman are very interesting 
to us, and I want to explore those more out of band with
anyone who is interested.
 
When we have figured out just how to handle this, I will post the
resolution here.  We appreciate the interest that you all have shown and 
the good suggestions that have been
made.  Thanks very much.
 
Tom Haigh, CTO
Secure Computing Corp.
2675 Long Lake Road
Roseville, MN 55343
651-628-2738
haigh@securecomputing.com <mailto:haigh@securecomputing.com> 
 
Question 5: What about the open source licensing?  What does this mean
for your Type Enforcement technology on Linux?
 
It is our intention to be an active, responsible member of the open source
community.
We will work with partners to develop new product offerings that will
benefit our
customers, our partners, and us.
Our modifications to Linux will consist of:
  - strong policy enforcement code which is in the kernel itself,
  - a flexible policy engine which is structured as a separate module
 
We will open source all the modifications to the kernel as well as deliver a
general-purpose security policy engine.  We are still defining the exact
functionality
of this engine, but it will support a broad set of basic applications,
it will be functional and it will be complete enough to enable the Linux
community
to develop other policy engines.  We hope that others will choose to enhance
this
engine and/or develop their own policy engines that are optimized for their
purposes.
 
Separately, we will use Linux and develop Linux policy engines for our
own products, such as Sidewinder.  These policy engines will remain
proprietary to
Secure Computing.
 

-----Original Message-----
From: Haigh, Tom [mailto:tom_haigh@securecomputing.com]
Sent: Friday, June 07, 2002 11:14 AM
To: linux-security-module@wirex.com; 'selinux@tycho.nsa.gov'
Subject: Regarding the Type Enforcement Licensing Discussion



We have been reviewing all the discussion on this topic, and it is obvious
that we are dealing with complex issues, which require some careful
consideration.  We would

like to set the record straight with a clear statement, and we will do that 
soon.  However, we want to avoid creating more confusion, so we are going to
take a little time to reflect before we respond.  My initial response was
intended to let people know that the licensing issues have not yet been
resolved.  I apologize for the confusion it has caused.  We want to be sure
that our next statement is both clear and definitive.    

Your insights, concerns and opinions are helpful to us, and they are an
important consideration as we think this through.  Thanks for your patience
and understanding.

Tom Haigh 


------_=_NextPart_001_01C2162A.495267D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<TITLE>Regarding the Type Enforcement Licensing Discussion</TITLE>

<META content=3D"MSHTML 5.50.4913.1100" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D341034417-17062002>Tom,<BR>&nbsp;<BR>&nbsp;<BR>It seem that you =
post a=20
similar message to the nl.linux.org mailing list in<BR>Jan 2000. <A=20
href=3D"http://mail.nl.linux.org/securedistros/2000-01/msg00012.html">ht=
tp://mail.nl.linux.org/securedistros/2000-01/msg00012.html</A></SPAN></F=
ONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D341034417-17062002></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D341034417-17062002>Quote=20
"When we have figured out just how to handle this, I will post =
the<BR>resolution=20
here." From the selinux mailing list, Jun 2002 <BR>&nbsp;<BR>Quote =
"However, we=20
want to avoid creating more confusion, so we are going to take <BR>a =
little time=20
to reflect before we respond."<BR>&nbsp;<BR>&nbsp;<BR>I have clam down =
since my=20
last post on this subject and I apologize<BR>for the Flame.=20
<BR>&nbsp;<BR>Questions:<BR>Did you resolve this issue two years=20
ago?<BR>&nbsp;&nbsp; If so, could you please post the results =
here.<BR>Did the=20
contract you accepted from the NSA resolve this issue?<BR>&nbsp;&nbsp; =
If so,=20
could you please post the results here&nbsp;<BR></DIV></SPAN></FONT>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D341034417-17062002>We=20
really need to put this issue to bed. To prevent statements =
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D341034417-17062002>like=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D341034417-17062002></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D341034417-17062002>"Our=20
company will not be using the SELinux for clients because, =
our<BR>management has=20
determined the situation is to confusing and will not place<BR>our =
business at=20
risk.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D341034417-17062002>Pamela=20
Patterson<BR>OpenDNS Crop</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D341034417-17062002>&nbsp;"</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D341034417-17062002></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D341034417-17062002>Thanks,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D341034417-17062002>Mark=20
Westerman</DIV></SPAN></FONT>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D341034417-17062002></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D341034417-17062002>From=20
you post </SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><A=20
href=3D"http://mail.nl.linux.org/securedistros/2000-01/msg00012.html">ht=
tp://mail.nl.linux.org/securedistros/2000-01/msg00012.html</A></FONT></D=
IV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>Secure Computing's =
Plans for Type=20
Enforced Linux</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; To: <A=20
href=3D"mailto:securedistros@nl.linux.org">securedistros@nl.linux.org</A=
>=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp; Subject: Secure Computing's Plans for Type =
Enforced=20
Linux <BR>&nbsp;&nbsp;&nbsp;&nbsp; From: Tom Haigh &lt;<A=20
href=3D"mailto:tom_haigh@securecomputing.com">tom_haigh@securecomputing.=
com</A>&gt;=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp; Date: Fri, 21 Jan 2000 10:48:25 -0600=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp; References: &lt;<A=20
href=3D"mailto:CMM.0.90.4.948178145.neumann@chiron.csl.sri.com">CMM.0.90=
.4.948178145.neumann@chiron.csl.sri.com</A>&gt;=20
&lt;<A=20
href=3D"mailto:200001191057.DAA21079@aztec.santafe.edu">200001191057.DAA=
21079@aztec.santafe.edu</A>&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
&lt;<A=20
href=3D"mailto:3885FB0D.FC3BFC95@darpa.mil">3885FB0D.FC3BFC95@darpa.mil<=
/A>&gt;=20
&lt;<A=20
href=3D"mailto:200001200629.XAA22118@aztec.santafe.edu">200001200629.XAA=
22118@aztec.santafe.edu</A>&gt;=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp; Reply-To: <A=20
href=3D"mailto:securedistros@nl.linux.org">securedistros@nl.linux.org</A=
>=20
<BR>&nbsp;&nbsp;&nbsp;&nbsp; Sender: <A=20
href=3D"mailto:owner-securedistros@nl.linux.org">owner-securedistros@nl.=
linux.org</A>=20
</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>I just posted the =
following message=20
to the open-source discussion group<BR>at SRI.&nbsp; It belongs here as =

well.</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>--Tom </FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>It is past time for me =
to jump into=20
this discussion.&nbsp; Secure Computing</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>is commited to<SPAN=20
class=3D341034417-17062002> </SPAN>being a responsible, contributing =
member of the=20
open source </FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>community.&nbsp;<SPAN=20
class=3D341034417-17062002> </SPAN>One of the<SPAN =
class=3D341034417-17062002>=20
</SPAN>conditions of accepting the contract from NSA was that =
</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>we be able to<SPAN=20
class=3D341034417-17062002> </SPAN>make the results<SPAN =
class=3D341034417-17062002>=20
</SPAN>of the contract available to the community.&nbsp; I have =
</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>appended a =
portion<SPAN=20
class=3D341034417-17062002> </SPAN>of a FAQ that we<SPAN =
class=3D341034417-17062002>=20
</SPAN>released internally on the topic.</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>I will also say that =
our legal folks=20
are still looking at the best way</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>to do this.<SPAN=20
class=3D341034417-17062002> </SPAN>Needless to say, we are not excited =
about other=20
vendors coming </FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>up with<SPAN=20
class=3D341034417-17062002> </SPAN>proprietary<SPAN =
class=3D341034417-17062002>=20
</SPAN>versions of type enforcement.&nbsp; We believe that opening =
</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>up the TE work to<SPAN =

class=3D341034417-17062002> </SPAN>the broader<SPAN =
class=3D341034417-17062002>=20
</SPAN>community will be a win for all of us.&nbsp; The </FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>proposals made by =
Brian<SPAN=20
class=3D341034417-17062002> </SPAN>Witten and Richard<SPAN=20
class=3D341034417-17062002> </SPAN>Stallman are very interesting =
</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>to us, and I want to =
explore those=20
more<SPAN class=3D341034417-17062002> </SPAN>out of band with<BR>anyone =
who is=20
interested.</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>When we have figured =
out just how to=20
handle this, I will post the<BR>resolution here.&nbsp; We<SPAN=20
class=3D341034417-17062002> </SPAN>appreciate the interest that you all =
have shown=20
and </FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>the good =
suggestions<SPAN=20
class=3D341034417-17062002> </SPAN>that have been<BR>made.&nbsp; Thanks =
very=20
much.</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>Tom Haigh, =
CTO<BR>Secure Computing=20
Corp.<BR>2675 Long Lake Road<BR>Roseville, MN =
55343<BR>651-628-2738<BR><A=20
href=3D"mailto:haigh@securecomputing.com">haigh@securecomputing.com</A><=
/FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>Question 5: What about =
the open=20
source licensing?&nbsp; What does this mean<BR>for your Type<SPAN=20
class=3D341034417-17062002> </SPAN>Enforcement technology on =
Linux?</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>It is our intention to =
be an active,=20
responsible member of the open<SPAN class=3D341034417-17062002> =
</SPAN>source=20
community.<BR>We will work with partners to develop new product =
offerings that=20
will<SPAN class=3D341034417-17062002> </SPAN>benefit our<BR>customers, =
our=20
partners, and us.<BR>Our modifications to Linux will consist =
of:<BR>&nbsp; -=20
strong policy enforcement code which is in the kernel itself,<BR>&nbsp; =
- a=20
flexible policy engine which is structured as a separate =
module</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>We will open source =
all the=20
modifications to the kernel as well as<SPAN class=3D341034417-17062002> =

</SPAN>deliver a<BR>general-purpose security policy engine.&nbsp; We =
are still=20
defining the exact<SPAN class=3D341034417-17062002> =
</SPAN>functionality<BR>of=20
this engine, but it will support a broad set of basic =
applications,<BR>it will=20
be<SPAN class=3D341034417-17062002> </SPAN>functional and it will be =
complete=20
enough to enable the Linux community<BR>to develop<SPAN=20
class=3D341034417-17062002> </SPAN>other policy engines.&nbsp; We hope =
that others=20
will choose to enhance this<BR>engine and/or<SPAN =
class=3D341034417-17062002>=20
</SPAN>develop their own policy engines that are optimized for their=20
purposes.</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>Separately, we will =
use Linux and=20
develop Linux policy engines for our<BR>own products,<SPAN=20
class=3D341034417-17062002> </SPAN>such as Sidewinder.&nbsp; These =
policy engines=20
will remain proprietary to<BR>Secure Computing.</FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> Haigh, Tom=20
  [mailto:tom_haigh@securecomputing.com]<BR><B>Sent:</B> Friday, June =
07, 2002=20
  11:14 AM<BR><B>To:</B> linux-security-module@wirex.com;=20
  'selinux@tycho.nsa.gov'<BR><B>Subject:</B> Regarding the Type =
Enforcement=20
  Licensing Discussion<BR><BR></FONT></DIV>
  <P><FONT size=3D2>We have been reviewing all the discussion on this =
topic, and=20
  it is obvious that we are dealing with complex issues, which require =
some=20
  careful consideration.&nbsp; We would</FONT></P>
  <P><FONT size=3D2>like to set the record straight with a clear =
statement, and we=20
  will do that</FONT> <BR><FONT size=3D2>soon.&nbsp; However, we want =
to avoid=20
  creating more confusion, so we are going to take a little time to =
reflect=20
  before we respond.&nbsp; My initial response was intended to let =
people know=20
  that the licensing issues have not yet been resolved.&nbsp; I =
apologize for=20
  the confusion it has caused.&nbsp; We want to be sure that our next =
statement=20
  is both clear and definitive.&nbsp;&nbsp;&nbsp; </FONT></P>
  <P><FONT size=3D2>Your insights, concerns and opinions are helpful to =
us, and=20
  they are an important consideration as we think this through.&nbsp; =
Thanks for=20
  your patience and understanding.</FONT></P>
  <P><FONT size=3D2>Tom Haigh</FONT> </P></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C2162A.495267D0--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
