Message-ID: <20041111041355.49748.qmail@web51509.mail.yahoo.com>
Date: Wed, 10 Nov 2004 20:13:55 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: SELinux with IPSec - something going on ?
To: Trent Jaeger <jaegert@us.ibm.com>
Cc: sds@epoch.ncsc.mil, SELinux@tycho.nsa.gov
In-Reply-To: <OF39826BA1.1CE40A13-ON85256F49.00105562-85256F49.00108775@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2099750849-1100146435=:49179"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-2099750849-1100146435=:49179
Content-Type: text/plain; charset=us-ascii

On Wed, 10 Nov 2004 at 22:00, Trent Jaeger wrote:
> Yes, this is the same idea. 
>
> We add the packet security context to the xfrm_state structure 
> (sa) and authorize the socket's ability to send/receive these 
> contexts to achieve the tuple. 

Thanks,
Do you only add packet security context to SA? 
 
But, On Tue, 09 Nov 2004 at 10:39, Mr. Stephen Smalley sds@epoch.ncsc.mil  wrote in the letter "Re: Issue on getting security context of socket and message " :
>  Remember that most of the LSM networking security fields and 
> hooks were rejected by the mainline kernel, so only limited
> support exists in the current SELinux and there is no message 
> labeling at all.
 
Then, Is SELinux now really support the packet security context for packet ? 
If it support, where could we store the packet security context, when it is associated with a package ? In the package itself ?   
And, as for the ( source socket security context, destination socket security context, packet security context ) tuple, we can obtain the security context of a socket via the security field of its associated inode. but how can we decide on the destination socket security context and the packet security context ?
 
Thanks a lot,


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 






			
---------------------------------
Do you Yahoo!?
 Check out the new Yahoo! Front Page. www.yahoo.com
--0-2099750849-1100146435=:49179
Content-Type: text/html; charset=us-ascii

<DIV>On Wed, 10 Nov 2004 at 22:00, Trent Jaeger wrote:</DIV>
<DIV>&gt; <FONT face=Tahoma>Yes, this is the same idea.</FONT> <BR>&gt;<BR><FONT face=Tahoma size=2>&gt; We add the packet security context to the xfrm_state structure </FONT></DIV>
<DIV><FONT face=Tahoma size=2>&gt; (sa) and authorize the socket's ability to send/receive these </FONT></DIV>
<DIV><FONT face=Tahoma size=2>&gt; contexts to achieve the tuple.</FONT> <BR></DIV>
<DIV>Thanks,</DIV>
<DIV>Do you only add packet security context to SA? </DIV>
<DIV>&nbsp;</DIV>
<DIV>But, On Tue, 09 Nov 2004 at 10:39, Mr. Stephen Smalley <A href="mailto:sds@epoch.ncsc.mil">sds@epoch.ncsc.mil</A>&nbsp; wrote in the letter "<A href="http://us.f515.mail.yahoo.com/ym/ShowLetter?MsgId=9227_8918738_1984043_1352_1020_0_6167_1988_3811131175&amp;Idx=63&amp;YY=81813&amp;inc=200&amp;order=down&amp;sort=date&amp;pos=0&amp;view=a&amp;head=b&amp;box=Inbox"><FONT color=#003399>Re: Issue on getting security context of socket and message </FONT></A>" :</DIV>
<DIV>&gt;&nbsp;&nbsp;Remember that most of the LSM networking security fields and </DIV>
<DIV>&gt; hooks were rejected by the mainline kernel, so only limited</DIV>
<DIV>&gt; support exists in the current SELinux and there is no message </DIV>
<DIV>&gt; labeling at all.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Then, Is SELinux now really support the packet security context for packet ? </DIV>
<DIV>If it support, where could we store the packet security context,&nbsp;when it is associated with a package ? In the package itself ? &nbsp;&nbsp;<BR>And, as for the ( source socket security context, destination socket security context, packet security context ) tuple, we can obtain the security context of a socket via the security field of its associated inode. but how can we decide on the destination socket security context and the packet security context ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks a lot,</DIV><BR><BR><DIV>
<DIV>
<DIV>
<DIV>
<DIV>
<DIV>--<BR>Best Regards,<BR>Park Lee &lt;<A href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;YY=1156&amp;order=down&amp;sort=date&amp;pos=0"><FONT color=#003399>parklee_sel@yahoo.com</FONT></A>&gt; </DIV>
<DIV>&nbsp;</DIV></DIV></DIV></DIV></DIV></DIV><p>
	
		<hr size=1>Do you Yahoo!?<br> 
Check out the new Yahoo! Front Page. <a href="http://www.yahoo.com">www.yahoo.com</a>
--0-2099750849-1100146435=:49179--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
