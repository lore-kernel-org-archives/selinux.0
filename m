Message-ID: <20041111024502.22558.qmail@web51509.mail.yahoo.com>
Date: Wed, 10 Nov 2004 18:45:02 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: SELinux with IPSec - something going on ? 
To: jaegert@us.ibm.com
Cc: sds@epoch.ncsc.mil, SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1990955755-1100141102=:22257"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1990955755-1100141102=:22257
Content-Type: text/plain; charset=us-ascii

On  Tue, 26 Oct 2004 at 11:23, Trent Jaeger wrote:
> We hook into the xfrm subsystem and/or use the xfrm data 
> structures to leverage IPSec security associations.
 
Then, what items should we add to IPsec security association? Is it still ( source socket security context, destination socket security context, packet security context ) tuple as described in IMPLEMENTING MANDATORY NETWORK SECURITY IN A POLICY-FLEXIBLE SYSTEM (http://www.cs.utah.edu/flux/papers/ajay-thesis-abs.html) .
 
Thank you.


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 






__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1990955755-1100141102=:22257
Content-Type: text/html; charset=us-ascii

<DIV>On  Tue, 26 Oct 2004 at 11:23, Trent Jaeger wrote:</DIV>
<DIV>&gt;&nbsp;We hook into the xfrm subsystem and/or use the xfrm data </DIV>
<DIV>&gt; structures&nbsp;to leverage IPSec security associations.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Then, what&nbsp;items should we add to IPsec security association? Is it&nbsp;still ( source socket security context, destination socket security context, packet security context ) tuple as described in IMPLEMENTING MANDATORY NETWORK SECURITY IN A POLICY-FLEXIBLE SYSTEM (<A href="http://www.cs.utah.edu/flux/papers/ajay-thesis-abs.html">http://www.cs.utah.edu/flux/papers/ajay-thesis-abs.html</A>) .</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you.</DIV><BR><BR><DIV>
<DIV>
<DIV>
<DIV>
<DIV>
<DIV>--<BR>Best Regards,<BR>Park Lee &lt;<A href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;YY=1156&amp;order=down&amp;sort=date&amp;pos=0"><FONT color=#003399>parklee_sel@yahoo.com</FONT></A>&gt; </DIV>
<DIV>&nbsp;</DIV></DIV></DIV></DIV></DIV></DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1990955755-1100141102=:22257--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
