Message-ID: <20041109105836.79902.qmail@web51503.mail.yahoo.com>
Date: Tue, 9 Nov 2004 02:58:36 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Issue on getting security context of socket and message
To: SELinux@tycho.nsa.gov
Cc: sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-950518661-1099997916=:46859"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-950518661-1099997916=:46859
Content-Type: text/plain; charset=us-ascii

Hi,
    In flask, as we know, sockets effectively serve as communication proxies for processes in the Flask control model. Consequently, sockets are labeled with the label of the creating process by default. Messages are associated with both the label of their sending socket and a separate message label. By default, this message label is the same as the sending socket label.
    Then how can we get the security context of socket and message respectively in linux kernel space and user space respectively (i.e. what functions and commands could we use to achieve our goal)? 
    And is messages here refer to packages in network?
    Thanks.


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 






			
---------------------------------
Do you Yahoo!?
 Check out the new Yahoo! Front Page. www.yahoo.com
--0-950518661-1099997916=:46859
Content-Type: text/html; charset=us-ascii

<DIV>Hi,</DIV>
<DIV>&nbsp;&nbsp;&nbsp; In flask, as we know, sockets effectively serve as communication proxies for processes in the Flask control model. Consequently, sockets are labeled with the label of the creating process by default. Messages are associated with both the label of their sending socket and a separate message label. By default, this message label is the same as the sending socket label.<BR>&nbsp;&nbsp;&nbsp; Then how can we get the security context of socket and message respectively in linux kernel space and user space respectively (i.e. what functions and commands could we use to achieve our goal)? <BR>&nbsp;&nbsp;&nbsp; And is messages here refer to packages in network?</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Thanks.</DIV><BR><BR><DIV>
<DIV>
<DIV>
<DIV>
<DIV>
<DIV>--<BR>Best Regards,<BR>Park Lee &lt;<A href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;YY=1156&amp;order=down&amp;sort=date&amp;pos=0"><FONT color=#003399>parklee_sel@yahoo.com</FONT></A>&gt; </DIV>
<DIV>&nbsp;</DIV></DIV></DIV></DIV></DIV></DIV><p>
	
		<hr size=1>Do you Yahoo!?<br> 
Check out the new Yahoo! Front Page. <a href="http://www.yahoo.com">www.yahoo.com</a>
--0-950518661-1099997916=:46859--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
