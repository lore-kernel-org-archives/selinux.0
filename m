Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0AJHoRb006058
	for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 14:17:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0AJHniV014272
	for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 19:17:49 GMT
Received: from web15204.mail.bjs.yahoo.com (web15204.mail.cnb.yahoo.com [202.43.216.134])
        by jazzband.ncsc.mil  with SMTP id i0AJHk06014269 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 19:17:47 GMT
Message-ID: <20040110191734.66152.qmail@web15204.mail.bjs.yahoo.com>
Date: Sun, 11 Jan 2004 03:17:34 +0800 (CST)
From: =?gb2312?q?Park=20Lee?= <parklee_2004@yahoo.com.cn>
Subject: Questions about install SELinux in Fedora Core
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-405389744-1073762254=:64956"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-405389744-1073762254=:64956
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello:
 I want to install the 2.6 kernel with SELinux patch applied in Fedora Core.
 Yesterday(2004-01-10).I downloaded the Fedora Core's following ISO image files:
 yarrow-i386-disc1.iso 
 yarrow-i386-disc2.iso  
 yarrow-i386-disc3.iso 
from a mirror site of http://download.fedora.redhat.com/pub/fedora/linux/core/1/i386/iso/. After checked the MD5 checksums for the ISO images,I burn the ISO images to CD-Rs.and install them in my 
computer successfully.The version of Fedora Core is 2.4.22-1.2115.nptl .
 Then I downloaded the 2.6.0-test11 kernel with SELinux patch applied from www.nsa.gov/selinux. I read the Changes file in the directory of linux-2.6/Documentation/Changes for the minimum version numbers required.
 I found that the minimum version numbers required in the Changes file cann't be meet by the above Fedora Core in the following 3 software.
 They are(in the style of the Changes file):
 
 name          version      command    
 o  xfsprogs      2.1.0    # xfs_db -V
 o  quota-tools   3.09     # quota -V
 o  procps        3.1.13   # ps --version
 
When I execute the commands of the above lists in the Fedora Core.They looks like:
 
 # xfs_db -V
 -bash: xfs_db: command not found;
 # quota -V 
 Quota utilities version 3.06.
 Compiled with RPC Bugs to mvw@planets.elm.net, jack@suse.cz;
 # ps --version 
 procps version 2.0.17;
 
 Then,would you please tell me that can I ignore the above problems and install the 2.6 kernel with SELinux patch applied in the above Fedora Core successfully. 
 If not,which version of SELinux can I install successfully in the above Fedora Core.
 Thank you very much!
       Park Lee
      2004-1-11

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-405389744-1073762254=:64956
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>Hello:<BR>&nbsp;I want to install the 2.6 kernel with SELinux patch applied in Fedora Core.<BR>&nbsp;Yesterday(2004-01-10).I downloaded the Fedora Core's following ISO image files:<BR>&nbsp;yarrow-i386-disc1.iso <BR>&nbsp;yarrow-i386-disc2.iso&nbsp; <BR>&nbsp;yarrow-i386-disc3.iso <BR>from a mirror site of <A href="http://download.fedora.redhat.com/pub/fedora/linux/core/1/i386/iso/">http://download.fedora.redhat.com/pub/fedora/linux/core/1/i386/iso/</A>. After checked the MD5 checksums for the ISO images,I burn the ISO images to CD-Rs.and install them in my </DIV>
<DIV>computer successfully.The version of Fedora Core is 2.4.22-1.2115.nptl .<BR>&nbsp;Then I downloaded the 2.6.0-test11 kernel with SELinux patch applied from <A href="http://www.nsa.gov/selinux">www.nsa.gov/selinux</A>. I read the Changes file in the directory of linux-2.6/Documentation/Changes for the minimum version numbers required.<BR>&nbsp;I found that the minimum version numbers required in the Changes file cann't be meet by the above Fedora Core in the following 3 software.<BR>&nbsp;They are(in the style of the Changes file):<BR>&nbsp;<BR>&nbsp;name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; command&nbsp;&nbsp;&nbsp; <BR>&nbsp;o&nbsp; xfsprogs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.1.0&nbsp;&nbsp;&nbsp; # xfs_db -V<BR>&nbsp;o&nbsp; quota-tools&nbsp;&nbsp; 3.09&nbsp;&nbsp;&nbsp;&nbsp; # quota -V<BR>&nbsp;o&nbsp; procps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.1.13&nbsp;&nbsp; # ps --version</DIV>
<DIV>&nbsp;</DIV>
<DIV>When I execute the commands of the above lists in the Fedora Core.They looks like:<BR>&nbsp;<BR>&nbsp;# xfs_db -V<BR>&nbsp;-bash: xfs_db: command not found;<BR>&nbsp;# quota -V <BR>&nbsp;Quota utilities version 3.06.<BR>&nbsp;Compiled with RPC Bugs to <A href="mailto:mvw@planets.elm.net">mvw@planets.elm.net</A>, <A href="mailto:jack@suse.cz">jack@suse.cz</A>;<BR>&nbsp;# ps --version <BR>&nbsp;procps version 2.0.17;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;Then,would you please tell me that can I ignore the above problems and install the 2.6 kernel with SELinux patch applied in the above Fedora Core successfully. </DIV>
<DIV>&nbsp;If not,which version of SELinux can I install successfully in the above Fedora Core.<BR>&nbsp;Thank you very much!</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Park Lee<BR>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;2004-1-11</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-405389744-1073762254=:64956--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
