In-Reply-To: <20041107183310.45274.qmail@web51506.mail.yahoo.com>
To: Park Lee <parklee_sel@yahoo.com>
Cc: jmorris@intercode.com.au, owner-selinux@tycho.nsa.gov,
   SELinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: SELinux with IPSec - something going on ?
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OF4BB0DB8A.13117788-ON85256F46.00529C24-85256F46.0052AC7A@us.ibm.com>
Date: Mon, 8 Nov 2004 10:03:01 -0500
Content-Type: multipart/alternative; boundary="=_alternative 0052A9F385256F46_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 0052A9F385256F46_=
Content-Type: text/plain; charset="US-ASCII"

Also this paper from the Linux Symposium: 
http://www.finux.org/Reprints/Reprint-Miyazawa-OLS2004.pdf
Regards,
Trent.
------------------------------------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive, Hawthorne, NY 10532
(914) 784-7225, FAX (914) 784-7225




Park Lee <parklee_sel@yahoo.com>
Sent by: owner-selinux@tycho.nsa.gov
11/07/2004 01:33 PM
 
        To:     Trent Jaeger/Watson/IBM@IBMUS
        cc:     jmorris@intercode.com.au, SELinux@tycho.nsa.gov
        Subject:        Re: SELinux with IPSec - something going on ?



On Tue, 26 Oct 2004 at 11:23, Trent Jaeger wrote:
>Linux 2.6 implements IPSec via a xfrm (pronounced 'transform') 
>subsystem (part of mainline kernel). 
>Basically, you can define 'protocols' that may transform packets upon 
>receipt or prior to send.  IPSec protocols for transform packets using 
>ah and esp are included in the kernel.   
>We hook into the xfrm subsystem and/or use the xfrm data structures 
>to leverage IPSec security associations.
 
I've search 'xfrm' through google, but I wouldn't find much usefull stuff 
about xfrm. would you please give me some hints on where can I find more 
information about xfrm ( such as the descriptions of  structures or 
functions of xfrm, its principles, etc.)
 
Thank you very much.
 


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 


Do you Yahoo!?
Check out the new Yahoo! Front Page. www.yahoo.com 

--=_alternative 0052A9F385256F46_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Also this paper from the Linux Symposium:
</font><a href="http://www.finux.org/Reprints/Reprint-Miyazawa-OLS2004.pdf"><font size=2 color=blue face="sans-serif">http://www.finux.org/Reprints/Reprint-Miyazawa-OLS2004.pdf</font>
<br><font size=2 color=blue face="sans-serif">Regards,</font></a>
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
<br><font size=1 face="sans-serif">Sent by: owner-selinux@tycho.nsa.gov</font>
<p><font size=1 face="sans-serif">11/07/2004 01:33 PM</font>
<td><font size=1 face="Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;Trent Jaeger/Watson/IBM@IBMUS</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;jmorris@intercode.com.au, SELinux@tycho.nsa.gov</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;Re: SELinux with IPSec - something going
on ?</font></table>
<br>
<br>
<br>
<br><font size=3>On Tue, 26 Oct 2004 at 11:23, Trent Jaeger wrote:</font>
<br><font size=3>&gt;Linux 2.6 implements IPSec via a xfrm (pronounced
'transform') </font>
<br><font size=3>&gt;subsystem (part of mainline kernel). </font>
<br><font size=3>&gt;Basically, you can define 'protocols' that may transform
packets upon </font>
<br><font size=3>&gt;receipt or prior to send.&nbsp; IPSec protocols for
transform packets using </font>
<br><font size=3>&gt;ah and esp are included in the kernel.&nbsp;&nbsp;
</font>
<br><font size=3>&gt;We hook into the xfrm subsystem and/or use the xfrm
data structures </font>
<br><font size=3>&gt;to leverage IPSec security associations.</font>
<br><font size=3>&nbsp;</font>
<br><font size=3>I've search 'xfrm' through google, but I wouldn't find
much usefull stuff about xfrm. would you please give me&nbsp;some hints
on where can I find more information about xfrm (&nbsp;such as&nbsp;the
descriptions of&nbsp; structures or functions of xfrm, its&nbsp;principles,
etc.)</font>
<br><font size=3>&nbsp;</font>
<br><font size=3>Thank you very much.</font>
<br><font size=3>&nbsp;</font>
<br>
<br>
<br><font size=3>--</font>
<br><font size=3>Best Regards,</font>
<br><font size=3>Park Lee &lt;</font><a href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;amp;YY=1156&amp;amp;order=down&amp;amp;sort=date&amp;amp;pos=0"><font size=3 color=blue><u>parklee_sel@yahoo.com</u></font></a><font size=3>&gt;
</font>
<br><font size=3>&nbsp;</font>
<br>
<hr>
<br>
<br><font size=3>Do you Yahoo!?</font>
<br><font size=3>Check out the new Yahoo! Front Page. </font><a href=http://www.yahoo.com><font size=3 color=blue><u>www.yahoo.com</u></font></a><font size=3>
</font>
<br>
--=_alternative 0052A9F385256F46_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
