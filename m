Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BG30rT024929
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 12:03:00 -0400 (EDT)
Received: from web51502.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i8BG279R023558
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 16:02:07 GMT
Message-ID: <20040911160301.54915.qmail@web51502.mail.yahoo.com>
Date: Sat, 11 Sep 2004 09:03:01 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Type or domain for module utility?
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-937436075-1094918581=:52861"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-937436075-1094918581=:52861
Content-Type: text/plain; charset=us-ascii

Hi,
 Today, I'm rereading the article <<A Security Policy Configuration for the Security-Enhanced Linux>>. I found in the paragraph of the second goal of the security policy configuration in subsection 2, It says:
 
The second goal is to protect the integrity of the kernel. The policy configuration defines distinct types for the boot files,......, module utilities, ......  .It defines separate domains for the module utilities, .......  .It only allows a small set of privileged domains to transition 
to he module utility domains.
 
Then, does it means that the policy configuration defines both type and domain for module utility?
Is there some thing wrong?
 
Thanks,


--
Best Regards,
Park Lee <parklee_sel@yahoo.com> 
 






		
---------------------------------
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
--0-937436075-1094918581=:52861
Content-Type: text/html; charset=us-ascii

<DIV>Hi,<BR>&nbsp;Today, I'm rereading the article &lt;&lt;A Security Policy Configuration for the Security-Enhanced Linux&gt;&gt;. I found in the paragraph of the second goal of the security policy configuration in subsection 2, It says:</DIV>
<DIV>&nbsp;</DIV>
<DIV>The second goal is to protect the integrity of the kernel. The policy configuration <STRONG>defines distinct types</STRONG> for the boot files,......, <STRONG>module utilities</STRONG>, ......&nbsp; .It <STRONG>defines separate domains for the module utilities</STRONG>, .......&nbsp; .It only allows a small set of privileged domains to transition </DIV>
<DIV>to he module utility domains.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Then, does it means that the policy configuration defines both type and domain for module utility?</DIV>
<DIV>Is there some thing wrong?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks,</DIV><BR><BR><DIV>
<DIV>
<DIV>
<DIV>
<DIV>
<DIV>--<BR>Best Regards,<BR>Park Lee &lt;<A href="http://us.f515.mail.yahoo.com/ym/Compose?To=parklee_sel@yahoo.com&amp;YY=1156&amp;order=down&amp;sort=date&amp;pos=0"><FONT color=#003399>parklee_sel@yahoo.com</FONT></A>&gt; </DIV>
<DIV>&nbsp;</DIV></DIV></DIV></DIV></DIV></DIV><p>
		<hr size=1>Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/mail_us/taglines/100/*http://promotions.yahoo.com/new_mail/static/efficiency.html">New and Improved Yahoo! Mail</a> - 100MB free storage!
--0-937436075-1094918581=:52861--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
