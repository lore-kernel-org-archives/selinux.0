Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i919DVrT029973
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 05:13:32 -0400 (EDT)
Received: from web51503.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i919CQ4L029048
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 09:12:26 GMT
Message-ID: <20041001091332.34378.qmail@web51503.mail.yahoo.com>
Date: Fri, 1 Oct 2004 02:13:32 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: purpose of the staff_r role?
To: ram25@gwu.edu
Cc: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1804137939-1096622012=:33690"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1804137939-1096622012=:33690
Content-Type: text/plain; charset=us-ascii

Thu, 30 Sep 2004 18:54 Kodungallur Varma wrote:
 
>I am pretty new to selinux. I was setting up a selinux machine. I 
>installed the OS and I installed the latest packages policy packages 
>with the 'yum' command. I later rebooted with the enforcing=0 option 
>during the boot. I later 'make relabel' ed it. I rebooted the machine >again with the enforcing=0 mode and checked the /var/log/messages >for avc:access denied messages. there are too many of them and I >just dont know how to fix them. any help on this would be excellent. 

After installed the packages policy packages, You'd better reboot in singleuser mode, and then try 'make relabel'.
 
Hope this helps,
 
Park Lee

		
---------------------------------
Do you Yahoo!?
vote.yahoo.com - Register online to vote today!
--0-1804137939-1096622012=:33690
Content-Type: text/html; charset=us-ascii

<DIV>Thu, 30 Sep 2004 18:54 Kodungallur Varma wrote:</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;I am pretty new to selinux. I was setting up a selinux machine. I <BR>&gt;installed the OS and I installed the latest packages policy packages <BR>&gt;with the 'yum' command. I later rebooted with the enforcing=0 option <BR>&gt;during the boot. I later 'make relabel' ed it. I rebooted the machine &gt;again with the enforcing=0 mode and checked the /var/log/messages &gt;for avc:access denied messages. there are too many of them and I &gt;just dont know how to fix them. any help on this would be excellent. <BR></DIV>
<DIV>After installed the packages policy packages, You'd better reboot in singleuser mode, and then try 'make relabel'.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Hope this helps,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Park Lee</DIV><p>
		<hr size=1>Do you Yahoo!?<br><a
href="http://vote.yahoo.com">vote.yahoo.com</a> - Register online to vote today!
--0-1804137939-1096622012=:33690--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
