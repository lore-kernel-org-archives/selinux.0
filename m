Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9DJBjWt014996
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 15:11:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9DJBd0p020490
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 19:11:39 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
	by jazzswing.ncsc.mil  with ESMTP id h9DJBbr7020487
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 19:11:38 GMT
Message-ID: <3F8AEBBE.7070602@ipen.br>
Date: Mon, 13 Oct 2003 16:15:26 -0200
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov,
   =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?=
 <monteiro@ipen.br>
Subject: avc: denied messages
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Helo.

When system boot process is running up a lot of messages "avc: denied" 
are displayed, in permissive mode e enforcing mode. In permissive mode, 
for all the messages "avc: denied" the boot process is completed and the 
login prompt is showed. However, in enforcing mode, it displayed the 
messages "avc: denied", but also displayed others messages: "INIT: Id 
"runlevel number" respawning too fast: disable for 5 minutes", "INIT: no 
more processes left in this runlevel"; and stop the boot process.
Please, how I resolve this ?

PS. I appended the line "/.journal <<none>>" in the file_context file, 
because one error message is displayed when compiling the rules.

thanks.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
