Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h53N6KI4019790
	for <selinux@tycho.nsa.gov>; Tue, 3 Jun 2003 19:06:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h53N4xtV028386
	for <selinux@tycho.nsa.gov>; Tue, 3 Jun 2003 23:04:59 GMT
Received: from smtp-out.comcast.net (smtp-out.comcast.net [24.153.64.116])
        by jazzband.ncsc.mil  with ESMTP id h53N4xal028383 for <selinux@tycho.nsa.gov>; Tue, 3 Jun 2003 23:04:59 GMT
Received: from comcast.net (pcp830001pcs.nrockv01.md.comcast.net [68.50.129.6])
 by mtaout04.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with ESMTP id <0HFX006Q2HBO5W@mtaout04.icomcast.net> for
 selinux@tycho.nsa.gov; Tue, 03 Jun 2003 19:02:14 -0400 (EDT)
Date: Tue, 03 Jun 2003 19:04:49 -0400
From: John Wolff <jrwolff@comcast.net>
Subject: Re: Compaq DL-360
In-reply-to: <20030601223130.GA29681@snoopy.apana.org.au>
To: Brian May <bam@snoopy.apana.org.au>
Cc: selinux@tycho.nsa.gov
Message-id: <3EDD2991.5050609@comcast.net>
MIME-version: 1.0
Content-type: text/html; charset=us-ascii
References: <3ED7C88A.7060209@comcast.net>
 <20030601223130.GA29681@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Brian May wrote:<br>
<blockquote type="cite"
 cite="mid20030601223130.GA29681@snoopy.apana.org.au">
  <pre wrap="">On Fri, May 30, 2003 at 05:09:30PM -0400, John Wolff wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">the boot sequence gets to the point where the OS attempts to mount the 
SCSI drives.  I have downloaded and installed the latest drivers from 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Was the kernel able to mount the root filesystem?

Did the kernel panic include any text messages like "Cannot mount root"?

Reading your E-Mail, it is not very clear precisely when it crashes.
  </pre>
</blockquote>
ok, there error I get is:<br>
<br>
<a class="moz-txt-link-freetext" href="Kmod:&nbsp;">Kmod:&nbsp;</a> failed to exec /sbin/modprobe -s -k block-major-72, errno=2<br>
<a class="moz-txt-link-freetext" href="VFS:&nbsp;&nbsp;">VFS:&nbsp;&nbsp;</a>  Cannot open root device "4802" or 48:02<br>
Please append a correct "root=" boot option<br>
Kernel <a class="moz-txt-link-freetext" href="panic:&nbsp;">panic:&nbsp;</a> <a class="moz-txt-link-freetext" href="VFS:&nbsp;">VFS:&nbsp;</a> Unable tomount root fs on 48:02<br>
<br>
jc<br>
</body>
</html>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
