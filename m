Message-ID: <36282A1733C57546BE392885C061859201512DB1@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joy Latten <latten@us.ibm.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, paul.moore@hp.com,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: RE: ipsec and getpeercon()
Date: Fri, 1 Sep 2006 15:34:46 -0400 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6CDFD.AE8F88A0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C6CDFD.AE8F88A0
Content-Type: text/plain;
	charset="iso-8859-1"

Actually this must be coming out of netlabel. In selinux_netlbl_sock_graft()
I see
 
        sksec->nlbl_state = NLBL_REQUIRE;
        sksec->peer_sid = sksec->sid;
        sksec->sclass = isec->sclass;
 
        /* Try to set the NetLabel on the socket to save time later, if we
fail
         * here we will pick up the pieces in later calls to
         * selinux_netlbl_inode_permission(). */
        selinux_netlbl_socket_setsid(sock, sksec->sid);

and selinux_netlbl_socket_getpeersec_stream returns peer_sid set above and
the xfrm version of getpeersec never gets invoked.

-----Original Message-----
From: Joy Latten [mailto:latten@us.ibm.com]
Sent: Friday, September 01, 2006 11:05 AM
To: Venkat Yekkirala
Cc: Joshua Brindle; paul.moore@hp.com; Stephen Smalley;
selinux@tycho.nsa.gov
Subject: RE: ipsec and getpeercon()



Venkat Yekkirala <vyekkirala@TrustedCS.com> wrote on 09/01/2006 08:16:32 AM:

> > Ok, aside from the bug I'm apparently experiencing (Joy is 
> > looking in to
> > it) I think I have misunderstood what getpeercon() is suppose 
> > to do over
> > ipsec. I was under the impression it would act like getpeercon() over
> > unix stream sockets and get the context of the application on 
> > the other
> > side of the socket but that is apparently not what getpeercon() for
> > ipsec does.
> 
> It should indeed return the peer's context when using ipsec as well.
> I would consider the current behaviour as a bug. Joy is looking but
> I will try to take a look as well.

Ok, I looked at the code, and yes, in the hook, if the socket class is
tcp_socket, 
the dst for the socket is examined for a xfrm (in other words, an SA). If
there is a 
xfrm, the context in the xfrm is used. Otherwise, we return -ENOPROTOOPT. 

So yes, it is assumed that the context in the SA associated with the
destination 
is the peer's context. I have always viewed labeled SAs as meaning, I want
to restrict 
access to this socket/traffic stream to this context. 
  
Joy 
  



------_=_NextPart_001_01C6CDFD.AE8F88A0
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2800.1561" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=716422819-01092006>Actually this&nbsp;must be coming out of netlabel. In 
selinux_netlbl_sock_graft() I see</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=716422819-01092006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=716422819-01092006>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
sksec-&gt;nlbl_state = 
NLBL_REQUIRE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sksec-&gt;peer_sid = 
sksec-&gt;sid;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sksec-&gt;sclass = 
isec-&gt;sclass;</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=716422819-01092006>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Try to 
set the NetLabel on the socket to save time later, if we 
fail<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * here we will pick up 
the pieces in later calls to<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
* selinux_netlbl_inode_permission(). 
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
selinux_netlbl_socket_setsid(sock, sksec-&gt;sid);<BR></SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=716422819-01092006>and 
selinux_netlbl_socket_getpeersec_stream returns peer_sid set above 
and</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=716422819-01092006>the 
xfrm version of getpeersec never gets invoked.</DIV></SPAN></FONT>
<BLOCKQUOTE 
style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px solid">
  <DIV class=OutlookMessageHeader dir=ltr align=left><FONT face=Tahoma 
  size=2>-----Original Message-----<BR><B>From:</B> Joy Latten 
  [mailto:latten@us.ibm.com]<BR><B>Sent:</B> Friday, September 01, 2006 11:05 
  AM<BR><B>To:</B> Venkat Yekkirala<BR><B>Cc:</B> Joshua Brindle; 
  paul.moore@hp.com; Stephen Smalley; selinux@tycho.nsa.gov<BR><B>Subject:</B> 
  RE: ipsec and getpeercon()<BR><BR></FONT></DIV><BR><TT><FONT size=2>Venkat 
  Yekkirala &lt;vyekkirala@TrustedCS.com&gt; wrote on 09/01/2006 08:16:32 
  AM:<BR><BR>&gt; &gt; Ok, aside from the bug I'm apparently experiencing (Joy 
  is <BR>&gt; &gt; looking in to<BR>&gt; &gt; it) I think I have misunderstood 
  what getpeercon() is suppose <BR>&gt; &gt; to do over<BR>&gt; &gt; ipsec. I 
  was under the impression it would act like getpeercon() over<BR>&gt; &gt; unix 
  stream sockets and get the context of the application on <BR>&gt; &gt; the 
  other<BR>&gt; &gt; side of the socket but that is apparently not what 
  getpeercon() for<BR>&gt; &gt; ipsec does.<BR>&gt; <BR>&gt; It should indeed 
  return the peer's context when using ipsec as well.<BR>&gt; I would consider 
  the current behaviour as a bug. Joy is looking but<BR>&gt; I will try to take 
  a look as well.<BR></FONT></TT><BR><TT><FONT size=2>Ok, I looked at the code, 
  and yes, in the hook, if the socket class is tcp_socket,</FONT></TT> 
  <BR><TT><FONT size=2>the dst for the socket is examined for a xfrm (in other 
  words, an SA). If there is a </FONT></TT><BR><TT><FONT size=2>xfrm, the 
  context in the xfrm is used. Otherwise, we return -ENOPROTOOPT.</FONT></TT> 
  <BR><BR><TT><FONT size=2>So yes, it is assumed that the context in the SA 
  associated with the destination </FONT></TT><BR><TT><FONT size=2>is the peer's 
  context. I have always viewed labeled SAs as meaning, I want to restrict 
  </FONT></TT><BR><TT><FONT size=2>access to this socket/traffic stream to this 
  context.</FONT></TT> <BR><TT><FONT size=2>&nbsp;</FONT></TT> <BR><TT><FONT 
  size=2>Joy</FONT></TT> <BR><TT><FONT size=2>&nbsp;</FONT></TT> 
<BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C6CDFD.AE8F88A0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
