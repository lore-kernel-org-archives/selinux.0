Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0T0SdgN020458
	for <selinux@tycho.nsa.gov>; Thu, 28 Jan 2010 19:28:39 -0500
Received: from web110407.mail.gq1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o0T0SV24002764
	for <selinux@tycho.nsa.gov>; Fri, 29 Jan 2010 00:28:31 GMT
Message-ID: <533612.81219.qm@web110407.mail.gq1.yahoo.com>
Date: Thu, 28 Jan 2010 16:28:37 -0800 (PST)
From: Gregg Tomas <java_gregg@yahoo.com>
Subject: Stopping COTS from accessing root directory
To: selinux@tycho.nsa.gov
Cc: Gregg Tomas <java_gregg@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1970902887-1264724917=:81219"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1970902887-1264724917=:81219
Content-Type: text/plain; charset=us-ascii

Hello Everyone,

Bare with me, I am fairly new to SELinux policy writing.

How do you write a rule to stop an application from accessing the root (/) directory? 
I am running Open Office (openoffice_exec_t) and whenever I open the open dialog (From the menubar, File
-> Open) , on the top right of the open dialog, there are 3 buttons.
The left most button is the "up one level" button. If you click and
hold your mouse left button down on it, a sub menu appears and display
a menu item called Workplace. If I click on it, it will bring you to root directory (/). I am trying to prevent that. I have a neverallow rule in my test.te:
neverallow openoffice_exec_t root_t:dir { search }; 
However, it still transitions there after I touch /.autorelabel and reboot.

Thanks.


      
--0-1970902887-1264724917=:81219
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">Hello Everyone,<br><br>Bare with me, I am fairly new to SELinux policy writing.<br><br>How do you write a rule to stop an application from accessing the root (/) directory? <br>I am running <span class="yshortcuts" id="lw_1264724815_8">Open Office</span> (openoffice_exec_t) and whenever I open the open dialog (From the menubar, <span class="yshortcuts" id="lw_1264724815_9">File</span>
-&gt; Open) , on the top right of the open dialog, there are 3 buttons.
The left most button is the "up one level" button. If you click and
hold your mouse left button down on it, a sub menu appears and display
a menu item called Workplace. If I click on it, it will bring you to <span class="yshortcuts" id="lw_1264724815_10">root directory</span> (/). I am trying to prevent that. I have a neverallow rule in my test.te:<br>neverallow openoffice_exec_t root_t:dir { search }; <br>However, it still transitions there after I touch /.autorelabel and reboot.<br><br>Thanks.</td></tr></table><br>

      
--0-1970902887-1264724917=:81219--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
