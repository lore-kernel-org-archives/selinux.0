Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i75HJtrT006796
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 13:19:56 -0400 (EDT)
Received: from web51503.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i75HJLn4021784
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 17:19:21 GMT
Message-ID: <20040805171955.71973.qmail@web51503.mail.yahoo.com>
Date: Thu, 5 Aug 2004 10:19:55 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: How to use other LSM modules
To: sds@epoch.ncsc.mil
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2073650624-1091726395=:69804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-2073650624-1091726395=:69804
Content-Type: text/plain; charset=us-ascii

Dear sir,
 
On Wed, 28 Jul 2004 15:00:31,  you wrote:
 
>SELinux needs to be built-in; it requires early initialization in order
>to track all kernel objects and apply security labels to them.  
>Security subsystem is too tightly coupled to the core kernel anyway to >usefully deal with it as a separate "module"; the LSM API is too large >and tightly coupled to the core kernel, and is not guaranteed any >stability even within the stable kernel series.  We attempted to support >SELinux as a loadable module for a while during the development of >LSM, but gave it up in 2002 in response to feedback from core kernel >developers. 

Do you mean that SELinux is not implemented as a LSM module as it was described in <<Implementing SELinux as a Linux Security Module>>? 
Has this situation change now? and what about the capability module?
 
Thanks!
 
Park Lee
 

		
---------------------------------
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
--0-2073650624-1091726395=:69804
Content-Type: text/html; charset=us-ascii

<DIV>Dear sir,</DIV>
<DIV>&nbsp;</DIV>
<DIV>On Wed, 28 Jul 2004 15:00:31, &nbsp;you wrote:</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;SELinux needs to be built-in; it requires early initialization in order<BR>&gt;to track all kernel objects and apply security labels to them.&nbsp; <BR>&gt;Security subsystem is too tightly coupled to the core kernel anyway to &gt;usefully deal with it as a separate "module"; the LSM API is too large &gt;and tightly coupled to the core kernel, and is not guaranteed any &gt;stability&nbsp;even within the stable kernel series.&nbsp; We attempted to support &gt;SELinux as a loadable module for a while during the development of &gt;LSM, but&nbsp;gave it up in 2002 in response to feedback from core kernel &gt;developers. <BR></DIV>
<DIV>Do you mean that SELinux is not implemented as a LSM module as it was described in &lt;&lt;Implementing SELinux as a Linux Security Module&gt;&gt;?&nbsp;</DIV>
<DIV>Has this situation&nbsp;change now? and what about the capability module?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks!</DIV>
<DIV>&nbsp;</DIV>
<DIV>Park Lee</DIV>
<DIV>&nbsp;</DIV><p>
		<hr size=1>Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/mail_us/taglines/10/*http://promotions.yahoo.com/new_mail/static/efficiency.html">New and Improved Yahoo! Mail</a> - Send 10MB messages!
--0-2073650624-1091726395=:69804--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
