Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5C6YSrT009378
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 02:34:28 -0400 (EDT)
Received: from web51509.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5C6YQEu003958
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 02:34:26 -0400 (EDT)
Message-ID: <20040612063426.65218.qmail@web51509.mail.yahoo.com>
Date: Fri, 11 Jun 2004 23:34:26 -0700 (PDT)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Regular Expression Problem
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1398554720-1087022066=:64728"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1398554720-1087022066=:64728
Content-Type: text/plain; charset=us-ascii

Hi,
 
In the file_contexts file, I found some regular expressions. I studied them for a while, but still can't understand them well.
 
For example:  /var(/.*)
 
As I know: '.' stands for any character;
Let's suppose '.' now stands for character 'a'. 
then '/var(/.*)' can mean:
'/var/a','/var/aa','/var/aaa','/var/aaaa','/var/aaaaa', ... ...
 
But now, If I have a file or directory named 'abc' in directory '/var' (i.e., 
/var/abc). How can it match '/var(/.*)' ?
 
 
Thank you.

Park Lee


		
---------------------------------
Do you Yahoo!?
Friends.  Fun. Try the all-new Yahoo! Messenger
--0-1398554720-1087022066=:64728
Content-Type: text/html; charset=us-ascii

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>In the file_contexts file, I found some regular expressions. I studied them for a while, but still can't understand them well.</DIV>
<DIV>&nbsp;</DIV>
<DIV>For example:&nbsp; /var(/.*)</DIV>
<DIV>&nbsp;</DIV>
<DIV>As I know: '.' stands for any character;<BR>Let's suppose '.' now stands for character 'a'. <BR>then '/var(/.*)' can mean:</DIV>
<DIV>'/var/a','/var/aa','/var/aaa','/var/aaaa','/var/aaaaa', ... ...</DIV>
<DIV>&nbsp;</DIV>
<DIV>But now, If I have a file or directory named 'abc' in directory '/var' (i.e., </DIV>
<DIV>/var/abc). How can it match '/var(/.*)' ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you.</DIV>
<DIV><BR>Park Lee<BR></DIV><p>
		<hr size=1>Do you Yahoo!?<br>Friends.  Fun. <a href="http://messenger.yahoo.com/">Try the all-new Yahoo! Messenger</a>
--0-1398554720-1087022066=:64728--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
