In-Reply-To: <20041028164024.1863.qmail@web51502.mail.yahoo.com>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: SELinux with IPSec - something going on ?
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OFBE1B8BEA.D23BAE2E-ON85256F3B.005C12BF-85256F3B.005C5B5F@us.ibm.com>
Date: Thu, 28 Oct 2004 12:48:46 -0400
Content-Type: multipart/alternative; boundary="=_alternative 005C59C385256F3B_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 005C59C385256F3B_=
Content-Type: text/plain; charset="US-ASCII"

We use IPSec Tools -- right now, some modest changes in userland tools 
indicate the sid of the security association.  Maybe this can be done 
another way, like relabeling files, so perhaps no userland changes are 
necessary at all.  Different userland tools should not be a big deal.

Regards,
Trent.
------------------------------------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive, Hawthorne, NY 10532
(914) 784-7225, FAX (914) 784-7225




Park Lee <parklee_sel@yahoo.com>
10/28/2004 12:40 PM
 
        To:     Trent Jaeger/Watson/IBM@IBMUS
        cc:     SELinux@tycho.nsa.gov
        Subject:        Re: SELinux with IPSec - something going on ?



Hi Trent,
 
on Tue, 26 Oct 2004 at 14:01, you wrote:

>As Openswan 2 uses the native IPSec implementation of the Linux 
>kernel (although it can use others), my impression is that using 
>Openswan should also be feasible. 
In addition to Openswan, there are other IPsec userland tools such as 
IPsec-Tools. Then, if we use the native IPsec implementation of the Linux 
kernel plus IPsec-Tools, Do you think it is feasible too?
 
Thanks again.
 


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--=_alternative 005C59C385256F3B_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">We use IPSec Tools -- right now, some
modest changes in userland tools indicate the sid of the security association.
&nbsp;Maybe this can be done another way, like relabeling files, so perhaps
no userland changes are necessary at all. &nbsp;Different userland tools
should not be a big deal.</font>
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
<p><font size=1 face="sans-serif">10/28/2004 12:40 PM</font>
<td><font size=1 face="Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;Trent Jaeger/Watson/IBM@IBMUS</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;SELinux@tycho.nsa.gov</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;Re: SELinux with IPSec - something going
on ?</font></table>
<br>
<br>
<br>
<br><font size=3>Hi Trent,</font>
<br><font size=3>&nbsp;</font>
<table width=100%>
<tr valign=top>
<td width=100%><font size=3>on Tue, 26 Oct 2004 at 14:01, you wrote:</font></table>
<br>
<br><font size=2>&gt;As Openswan 2 uses the native IPSec implementation
of the Linux </font>
<br><font size=2>&gt;kernel (although it can use others), my impression
is that using </font>
<br><font size=2>&gt;Openswan should also be feasible.</font><font size=3>
</font>
<br><font size=3>In&nbsp;addition to Openswan, there are other IPsec userland
tools such as IPsec-Tools. Then, if we use the native IPsec implementation
of the Linux kernel plus IPsec-Tools, Do you think it is feasible too?</font>
<br><font size=3>&nbsp;</font>
<br><font size=3>Thanks again.</font>
<br><font size=3>&nbsp;</font>
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
--=_alternative 005C59C385256F3B_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
