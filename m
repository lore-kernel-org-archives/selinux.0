Message-ID: <20041107183310.45274.qmail@web51506.mail.yahoo.com>
Date: Sun, 7 Nov 2004 10:33:09 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: SELinux with IPSec - something going on ?
To: jaegert@us.ibm.com
Cc: jmorris@intercode.com.au, SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-177921852-1099852389=:35640"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-177921852-1099852389=:35640
Content-Type: text/plain; charset=us-ascii

On Tue, 26 Oct 2004 at 11:23, Trent Jaeger wrote:
>Linux 2.6 implements IPSec via a xfrm (pronounced 'transform') 
>subsystem (part of mainline kernel). 
>Basically, you can define 'protocols' that may transform packets upon 
>receipt or prior to send.  IPSec protocols for transform packets using 
>ah and esp are included in the kernel.   
>We hook into the xfrm subsystem and/or use the xfrm data structures 
>to leverage IPSec security associations.
 
I've search 'xfrm' through google, but I wouldn't find much usefull stuff about xfrm. would you please give me some hints on where can I find more information about xfrm ( such as the descriptions of  structures or functions of xfrm, its principles, etc.)
 
Thank you very much.
 


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 






			
---------------------------------
Do you Yahoo!?
 Check out the new Yahoo! Front Page. www.yahoo.com
--0-177921852-1099852389=:35640
Content-Type: text/html; charset=us-ascii

<DIV>On Tue, 26 Oct 2004 at 11:23, Trent Jaeger wrote:</DIV>
<DIV>&gt;Linux 2.6 implements IPSec via a xfrm (pronounced 'transform') </DIV>
<DIV>&gt;subsystem (part of mainline kernel). </DIV>
<DIV>&gt;Basically, you can define 'protocols' that may transform packets upon </DIV>
<DIV>&gt;receipt or prior to send.&nbsp; IPSec protocols for transform packets using </DIV>
<DIV>&gt;ah and esp are included in the kernel.&nbsp;&nbsp; </DIV>
<DIV>&gt;We hook into the xfrm subsystem and/or use the xfrm data structures </DIV>
<DIV>&gt;to leverage IPSec security associations.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I've search 'xfrm' through google, but I wouldn't find much usefull stuff about xfrm. would you please give me&nbsp;some hints on where can I find more information about xfrm (&nbsp;such as&nbsp;the descriptions of&nbsp; structures or functions of xfrm, its&nbsp;principles, etc.)</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you very much.</DIV>
<DIV>&nbsp;</DIV><BR><BR><DIV>
<DIV>
<DIV>
<DIV>
<DIV>
<DIV>--<BR>Best Regards,<BR>Park Lee &lt;<A href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;YY=1156&amp;order=down&amp;sort=date&amp;pos=0"><FONT color=#003399>parklee_sel@yahoo.com</FONT></A>&gt; </DIV>
<DIV>&nbsp;</DIV></DIV></DIV></DIV></DIV></DIV><p>
	
		<hr size=1>Do you Yahoo!?<br> 
Check out the new Yahoo! Front Page. <a href="http://www.yahoo.com">www.yahoo.com</a>
--0-177921852-1099852389=:35640--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
