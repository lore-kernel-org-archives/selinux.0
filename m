Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0FJMZRb004802
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 14:22:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0FJMWiV007116
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 19:22:32 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
        by jazzband.ncsc.mil  with ESMTP id i0FJMR06007070 for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 19:22:31 GMT
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id i0FJNexY014536
	for selinux@tycho.nsa.gov; Thu, 15 Jan 2004 17:23:40 -0200
Received: from ipen.br ([10.0.12.47])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id i0FJNdK3014529
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 17:23:39 -0200
Message-ID: <4006E894.3040705@ipen.br>
Date: Thu, 15 Jan 2004 17:23:00 -0200
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: run_init
Content-Type: multipart/alternative;
 boundary="------------040507060709060207030301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------040507060709060207030301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Helo.

I am with problems when running the run_init utility.

*# run_init /etc/init.d/apache start
Authenticating root.
Password:
execvp: File or directory not found.
#*

The script apache in the /etc/init.d exist.
If running:

*# /etc/init.d/apache start
Starting web server: ok*
#

Thanks.


-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil


--------------040507060709060207030301
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Helo.<br>
<br>
I am with problems when running the run_init utility.<br>
<br>
<b># run_init /etc/init.d/apache start<br>
Authenticating root.<br>
Password:<br>
execvp: File or directory not found.<br>
#</b><br>
<br>
The script apache in the /etc/init.d exist.<br>
If running:<br>
<br>
<b># /etc/init.d/apache start<br>
Starting web server: ok</b><br>
#<br>
<br>
Thanks.<br>
<br>
<br>
<pre class="moz-signature" cols="$mailwrapcol">-- 
Carlos Anisio Monteiro  <a class="moz-txt-link-rfc2396E" href="mailto:monteiro@ipen.br">&lt;monteiro@ipen.br&gt;</a>
IPEN/CNEN-SP
Sao Paulo - Brasil
</pre>
</body>
</html>

--------------040507060709060207030301--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
