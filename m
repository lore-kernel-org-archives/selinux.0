Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h542YYI4020283
	for <selinux@tycho.nsa.gov>; Tue, 3 Jun 2003 22:34:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h542Wess025099
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 02:32:40 GMT
Received: from smtp-out.comcast.net (smtp-out.comcast.net [24.153.64.115])
	by jazzswing.ncsc.mil  with ESMTP id h542WehY025096
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 02:32:40 GMT
Received: from comcast.net (pcp830001pcs.nrockv01.md.comcast.net [68.50.129.6])
 by mtaout02.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with ESMTP id <0HFX000BIR1YQH@mtaout02.icomcast.net> for
 selinux@tycho.nsa.gov; Tue, 03 Jun 2003 22:32:23 -0400 (EDT)
Date: Tue, 03 Jun 2003 22:34:46 -0400
From: John Wolff <jrwolff@comcast.net>
Subject: Re: Compaq DL-360
In-reply-to: <200306041135.09286.russell@coker.com.au>
To: Russell Coker <russell@coker.com.au>
Cc: Brian May <bam@snoopy.apana.org.au>, selinux@tycho.nsa.gov
Message-id: <3EDD5AC6.5030401@comcast.net>
MIME-version: 1.0
Content-type: text/html; charset=us-ascii
References: <3ED7C88A.7060209@comcast.net>
 <20030601223130.GA29681@snoopy.apana.org.au> <3EDD2991.5050609@comcast.net>
 <200306041135.09286.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Russell Coker wrote:<br>
<blockquote type="cite"
 cite="mid200306041135.09286.russell@coker.com.au">
  <pre wrap="">On Wed, 4 Jun 2003 09:04, John Wolff wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Kmod:  failed to exec /sbin/modprobe -s -k block-major-72, errno=2
 VFS:   Cannot open root device "4802<a class="moz-txt-link-rfc2396E" href="or48:02Pleaseappendacorrect">" or 48:02
 Please append a correct "</a>root=" boot option
 Kernel panic:  VFS:  Unable tomount root fs on 48:02
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It seems that you are using a Compaq Intelligent Drive Array and you failed to 
either compile the driver into the kernel or put it on the initrd.

It's probably easiest for you to just compile the driver into the kernel.

  </pre>
</blockquote>
I think that it is on the list.&nbsp; That is, the Smart2 driver is selected
with a "*" in the configurator.&nbsp; What else should I be doing?<br>
<br>
jc<br>
</body>
</html>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
