In-Reply-To: <20041111024502.22558.qmail@web51509.mail.yahoo.com>
To: Park Lee <parklee_sel@yahoo.com>
Cc: sds@epoch.ncsc.mil, SELinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: SELinux with IPSec - something going on ?
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OF39826BA1.1CE40A13-ON85256F49.00105562-85256F49.00108775@us.ibm.com>
Date: Wed, 10 Nov 2004 22:00:32 -0500
Content-Type: multipart/alternative; boundary="=_alternative 001083C185256F49_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 001083C185256F49_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Yes, this is the same idea.

We add the packet security context to the xfrm_state structure (sa) and 
authorize the socket's ability to send/receive these contexts to achieve 
the tuple.

Regards,
Trent.
------------------------------------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive, Hawthorne, NY 10532
(914) 784-7225, FAX (914) 784-7225




Park Lee <parklee_sel@yahoo.com>
11/10/2004 09:45 PM
 
        To:     Trent Jaeger/Watson/IBM@IBMUS
        cc:     sds@epoch.ncsc.mil, SELinux@tycho.nsa.gov
        Subject:        Re: SELinux with IPSec - something going on ?



On  Tue, 26 Oct 2004 at 11:23, Trent Jaeger wrote:
> We hook into the xfrm subsystem and/or use the xfrm data 
> structures to leverage IPSec security associations.
 
Then, what items should we add to IPsec security association? Is it still 
( source socket security context, destination socket security context, 
packet security context ) tuple as described in IMPLEMENTING MANDATORY 
NETWORK SECURITY IN A POLICY-FLEXIBLE SYSTEM (
http://www.cs.utah.edu/flux/papers/ajay-thesis-abs.html) .
 
Thank you.


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--=_alternative 001083C185256F49_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Yes, this is the same idea.</font>
<br>
<br><font size=2 face="sans-serif">We add the packet security context to
the xfrm_state structure (sa) and authorize the socket's ability to send/receive
these contexts to achieve the tuple.</font>
<br>
<br><font size=2 face="sans-serif">Regards,</font>
<br><font size=2 face="sans-serif">Trent.</font>
<br><font size=2 face="sans-serif">------------------------------------------------------------<br>
Trent Jaeger<br>
IBM T.J. Watson Research Center<br>
19 Skyline Drive, Hawthorne, NY 10532<br>
(914) 784-7225, FAX (914) 784-7225</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td>
<td><font size=1 face="sans-serif"><b>Park Lee &lt;parklee_sel@yahoo.com&gt;</b></font>
<p><font size=1 face="sans-serif">11/10/2004 09:45 PM</font>
<td><font size=1 face="Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;Trent Jaeger/Watson/IBM@IBMUS</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;sds@epoch.ncsc.mil, SELinux@tycho.nsa.gov</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;Re: SELinux with IPSec - something going
on ?</font></table>
<br>
<br>
<br>
<br><font size=3>On &nbsp;Tue, 26 Oct 2004 at 11:23, Trent Jaeger wrote:</font>
<br><font size=3>&gt;&nbsp;We hook into the xfrm subsystem and/or use the
xfrm data </font>
<br><font size=3>&gt; structures&nbsp;to leverage IPSec security associations.</font>
<br><font size=3>&nbsp;</font>
<br><font size=3>Then, what&nbsp;items should we add to IPsec security
association? Is it&nbsp;still ( source socket security context, destination
socket security context, packet security context ) tuple as described in
IMPLEMENTING MANDATORY NETWORK SECURITY IN A POLICY-FLEXIBLE SYSTEM (</font><a href="http://www.cs.utah.edu/flux/papers/ajay-thesis-abs.html"><font size=3 color=blue><u>http://www.cs.utah.edu/flux/papers/ajay-thesis-abs.html</u></font></a><font size=3>)
.</font>
<br><font size=3>&nbsp;</font>
<br><font size=3>Thank you.</font>
<br>
<br>
<br><font size=3>--</font>
<br><font size=3>Best Regards,</font>
<br><font size=3>Park Lee &lt;</font><a href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;amp;YY=1156&amp;amp;order=down&amp;amp;sort=date&amp;amp;pos=0"><font size=3 color=blue><u>parklee_sel@yahoo.com</u></font></a><font size=3>&gt;
</font>
<br><font size=3>&nbsp;</font>
<br>
<br><font size=3>__________________________________________________</font>
<br><font size=3>Do You Yahoo!?</font>
<br><font size=3>Tired of spam? &nbsp;Yahoo! Mail has the best spam protection
around </font>
<br><font size=3>http://mail.yahoo.com &nbsp;</font>
<br>
--=_alternative 001083C185256F49_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
