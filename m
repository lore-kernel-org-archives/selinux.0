Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7C7QtHa018038
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2003 03:26:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7C7PaOD007511
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2003 07:25:37 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
	by jazzswing.ncsc.mil  with ESMTP id h7C7PaKO007508
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2003 07:25:36 GMT
Message-ID: <3F3896BD.5000307@diyab.net>
Date: Tue, 12 Aug 2003 03:26:53 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: SELinux on Slackware 9 with PAM
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,

      I just finished writing up a howto style document that explains 
how to install SELinux on Slackware 9 along with the installation of 
PAM.  Thus far you will be able to boot into enforcing mode with some 
minimal services like ssh but I have not tested much else.  So mainly 
all I have to do now is to try running some services and alter the 
policy as needed.  I would appreciate some feedback if anyone has time 
to look at it, suggestions always welcome.  Also I would be more than 
happy to add policy changes that anyone else who might be using 
slackware has made.

The document is available in plain text format here:
http://www.diyab.net/selinux/SELinux_on_Slackware9.txt

A PDF version is soon to follow.  Check my selinux page in a couple of 
days for the PDF version.
http://www.diyab.net/selinux/index.html

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
