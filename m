Message-ID: <20040608043054.58295.qmail@web51505.mail.yahoo.com>
Date: Mon, 7 Jun 2004 21:30:54 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Is SIDs no longer used?
To: sds@epoch.ncsc.mil
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1849098909-1086669054=:57405"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1849098909-1086669054=:57405
Content-Type: text/plain; charset=us-ascii

Dear sir,
 
       In <<Configuring the SELinux Policy>>, there was something about SIDs:
 
"In order to better encapsulate security contexts and to provide greater
efficiency, the policy enforcement code of SELinux typically handles security identifiers (SIDs) rather than security contexts."
 
        But in <<Getting Started with SE Linux HOWTO: the new SE Linux>>, I saw the following:
 
"SIDs and PSIDs no longer used
SIDs (Security Identifiers) were used in the old SE Linux in the interface to the kernel (from userspace). PSIDs (Persistent SIDs) were used in the kernel code for  mapping files to contexts for files and directories on disk. In the new SE Linux, the extended attributes contain the context so SIDs and PSIDs are no longer necessary."
 
        Then, I want to ask: Is SIDs really no longer used? If it's true, What does the policy enforcement code of SELinux typically handle?
 
Thank you!
 
Respectfully yours,
Park Lee
2004-06-08


		
---------------------------------
Do you Yahoo!?
Friends.  Fun. Try the all-new Yahoo! Messenger
--0-1849098909-1086669054=:57405
Content-Type: text/html; charset=us-ascii

<DIV>Dear sir,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In &lt;&lt;Configuring the SELinux Policy&gt;&gt;, there was something about SIDs:</DIV>
<DIV>&nbsp;</DIV>
<DIV>"In order to better encapsulate security contexts and to provide greater<BR>efficiency, the policy enforcement code of SELinux typically handles security identifiers (SIDs) rather than security contexts."</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; But in &lt;&lt;Getting Started with SE Linux HOWTO: the new SE Linux&gt;&gt;, I saw the following:</DIV>
<DIV>&nbsp;</DIV>
<DIV>"SIDs and PSIDs no longer used<BR>SIDs (Security Identifiers) were used in the old SE Linux in the interface to the kernel (from userspace). PSIDs (Persistent SIDs) were used in the kernel code for&nbsp; mapping files to contexts for files and directories on disk. In the new SE Linux, the extended attributes contain the context so SIDs and PSIDs are no longer necessary."</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Then, I want to ask: Is SIDs really no longer used? If it's true, What does the policy enforcement code of SELinux typically handle?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you!</DIV>
<DIV>&nbsp;</DIV>
<DIV>Respectfully yours,</DIV>
<DIV>Park Lee<BR>2004-06-08<BR></DIV><p>
		<hr size=1><font face=arial size=-1>Do you Yahoo!?<br>Friends.  Fun. <a href="http://messenger.yahoo.com/">Try the all-new Yahoo! Messenger</a>
--0-1849098909-1086669054=:57405--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
