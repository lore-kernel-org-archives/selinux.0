Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5JOSIi002385
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 14:24:28 -0500 (EST)
Received: from e1.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5JN8gk010175
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 19:23:08 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.10/NS PXFA) with ESMTP id iA5JOV9C497976
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 14:24:31 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iA5JOVTR269472
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 14:24:31 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.12.11) with ESMTP id iA5JOUDF030018
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 14:24:30 -0500
Received: from d01ml605.pok.ibm.com (d01ml605.pok.ibm.com [9.56.227.91])
	by d01av04.pok.ibm.com (8.12.11/8.12.11) with ESMTP id iA5JOUSE030000
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 14:24:30 -0500
In-Reply-To: <20041105090423.51837.qmail@web51504.mail.yahoo.com>
To: Park Lee <parklee_sel@yahoo.com>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: SELinux with IPSec - something going on ?
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OF71AE8A22.99DB5AEE-ON85256F43.006A5367-85256F43.006A9C97@us.ibm.com>
Date: Fri, 5 Nov 2004 14:24:29 -0500
Content-Type: multipart/alternative; boundary="=_alternative 006A9AD585256F43_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 006A9AD585256F43_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

There are kernel and user-space parts, and the user-space parts may differ 
depend on infrastructure (we use ipsec-tools). 

We have submitted some kernel network control integrated with SELinux to 
Stephen and James Morris, and we are addressing comments.  Plan to revise 
soon -- then we can discuss further work.

Regards,
Trent.
------------------------------------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive, Hawthorne, NY 10532
(914) 784-7225, FAX (914) 784-7225




Park Lee <parklee_sel@yahoo.com>
11/05/2004 04:04 AM
 
        To:     selinux@tycho.nsa.gov, Trent Jaeger/Watson/IBM@IBMUS
        cc: 
        Subject:        Re: SELinux with IPSec - something going on ?



Hi,
 
I also intend to do some work on Integrating IPSEC with network mandatory 
controls. I'd like to know how many parts this work may include? what 
these parts respectively are? and what about the workload for doing it?
 
Thanks.


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--=_alternative 006A9AD585256F43_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">There are kernel and user-space parts,
and the user-space parts may differ depend on infrastructure (we use ipsec-tools).
&nbsp;</font>
<br>
<br><font size=2 face="sans-serif">We have submitted some kernel network
control integrated with SELinux to Stephen and James Morris, and we are
addressing comments. &nbsp;Plan to revise soon -- then we can discuss further
work.</font>
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
<p><font size=1 face="sans-serif">11/05/2004 04:04 AM</font>
<td><font size=1 face="Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;selinux@tycho.nsa.gov, Trent Jaeger/Watson/IBM@IBMUS</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;Re: SELinux with IPSec - something going
on ?</font></table>
<br>
<br>
<br>
<br><font size=3>Hi,</font>
<br><font size=3>&nbsp;</font>
<br><font size=3>I&nbsp;also intend to do some work on&nbsp;Integrating
IPSEC with network mandatory controls. I'd like&nbsp;to know&nbsp;how many&nbsp;parts&nbsp;this
work may include?&nbsp;what these parts&nbsp;respectively&nbsp;are? and
what about the workload for doing it?</font>
<br><font size=3>&nbsp;</font>
<br><font size=3>Thanks.</font>
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
--=_alternative 006A9AD585256F43_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
