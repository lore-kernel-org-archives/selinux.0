Message-ID: <20041110054928.87820.qmail@web51501.mail.yahoo.com>
Date: Tue, 9 Nov 2004 21:49:28 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Issue on getting security context of socket and message
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1100014761.408.112.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-173125847-1100065768=:87626"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-173125847-1100065768=:87626
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Nov 2004 at 10:39, Stephen Smalley wrote:
>       Remember that most of the LSM networking security
> fields and hooks were rejected by the mainline kernel, so only limited
> support exists in the current SELinux and there is no message  
> labeling at all.
 
       Thanks,
 
       Does that means that if we now want to integrate IPsec, we just can't add a 'package security context' into the security association?
      
        How can we get the SID of a socket and set SID and security context  to a socket respectively in linux kernel space and user space respectively (that is, what functions and commands could we use to achieve our goal)? 

         And,
         In <<Integrating Flexible Support for Security Policies into the Linux Operating System>> (February 2001), It says:
         "When the network component receives a message from the network, the SID of the message is initially set to a default message SID associated with the receiving network interface. This default message SID is computed by the security server.
         Each message is also associated with the SID of its source socket and the desired SID for its destination socket. By default, the desired SID for the destination socket of a message is set to the any socket initial SID. When a message is received from the network, the source socket SID of the message is initially set to the default message SID for the receiving network interface."
    
     But in initial_sid_contexts, it says something like this:
    "...
     # any_socket is no longer used.
     sid any_socket  system_u:object_r:unlabeled_t
     ...
     # netmsg is no longer used.
     sid netmsg system_u:object_r:unlabeled_t
     ..."
 
     Then, 
     1) Now, I know because there is no message labeling at all, netmsg is thus no longer used and when the network component  receives a message from the network, no SID will be set for the message. Am I right? 
     2) Is each message now still associated with the SID of its source socket and the desired SID for its destination socket? If it is, then what SID should be set to the destination socket associated with a message by default? 
     3) How to set the SID to the source socket and destination socket associated with the message based on a security context? need we transfer the security context to SID ourself and set it manually? and also how to get the SID and security context of them? 
 
      I appologize for so many questions.
 
      Thank you.
 


 


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 






			
---------------------------------
Do you Yahoo!?
 Check out the new Yahoo! Front Page. www.yahoo.com
--0-173125847-1100065768=:87626
Content-Type: text/html; charset=us-ascii

<DIV>On Tue, 09 Nov 2004 at 10:39, Stephen Smalley wrote:</DIV>
<DIV>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Remember that most of the LSM networking security</DIV>
<DIV>&gt; fields and hooks were rejected by the mainline kernel, so only limited</DIV>
<DIV>&gt; support exists in the current SELinux and there is no message&nbsp; </DIV>
<DIV>&gt; labeling at all.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thanks,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Does that means that if we now want to integrate IPsec, we just can't add a 'package security context' into the security association?</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; How can we get&nbsp;the SID of a socket and set SID and security&nbsp;context&nbsp; to a socket&nbsp;respectively in linux kernel space and user space respectively (that is,&nbsp;what functions and commands could we use to achieve our goal)? <BR></DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; And,</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In &lt;&lt;Integrating Flexible Support for Security Policies into the Linux Operating System&gt;&gt; (February 2001), It says:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "When the network component receives a message from the network, the SID of the message is initially set to a default message SID associated with the receiving network interface. This default message SID is computed by the security server.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Each message is also associated with the SID of its source socket and the desired SID for its destination socket. By default, the desired SID for the destination socket of a message is set to the any socket initial SID. When a message is received from the network, the source socket SID of the message is initially set to the default message SID for the receiving network interface."</DIV>
<DIV>&nbsp;&nbsp;&nbsp; </DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;But in initial_sid_contexts, it says something like this:<BR>&nbsp;&nbsp;&nbsp; "...<BR>&nbsp;&nbsp;&nbsp;&nbsp; # any_socket is no longer used.<BR>&nbsp;&nbsp;&nbsp;&nbsp; sid any_socket &nbsp;system_u:object_r:unlabeled_t<BR>&nbsp;&nbsp;&nbsp;&nbsp; ...<BR>&nbsp;&nbsp;&nbsp;&nbsp; # netmsg is no longer used.<BR>&nbsp;&nbsp;&nbsp;&nbsp; sid netmsg&nbsp;system_u:object_r:unlabeled_t<BR>&nbsp;&nbsp;&nbsp;&nbsp; ..."<BR>&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp; Then, <BR>&nbsp;&nbsp;&nbsp;&nbsp; 1) Now, I know because there is no message labeling at all,&nbsp;netmsg is thus no longer used and&nbsp;when the network component  receives a message from the network,&nbsp;no SID&nbsp;will be&nbsp;set for the message. Am I right?&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; 2) Is each message&nbsp;now still&nbsp;associated with the SID of its source socket and the desired SID for its destination socket? If it is, then&nbsp;what SID&nbsp;should&nbsp;be set to the destination socket associated with a message by default?&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3) How to set the SID to the source socket and destination socket associated with the message based on a security context? need we transfer the security context to SID ourself and set it manually? and also how to get the SID and security context of them? </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I appologize for so many questions.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thank you.<BR>&nbsp;<BR></DIV>
<DIV><BR>&nbsp;</DIV><BR><BR><DIV>
<DIV>
<DIV>
<DIV>
<DIV>
<DIV>--<BR>Best Regards,<BR>Park Lee &lt;<A href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;YY=1156&amp;order=down&amp;sort=date&amp;pos=0"><FONT color=#003399>parklee_sel@yahoo.com</FONT></A>&gt; </DIV>
<DIV>&nbsp;</DIV></DIV></DIV></DIV></DIV></DIV><p>
	
		<hr size=1>Do you Yahoo!?<br> 
Check out the new Yahoo! Front Page. <a href="http://www.yahoo.com">www.yahoo.com</a>
--0-173125847-1100065768=:87626--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
