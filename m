Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9GLwbWt006185
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 17:58:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9GLwamR023290
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 21:58:36 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
        by jazzband.ncsc.mil  with ESMTP id h9GLwZjp023287 for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 21:58:35 GMT
Received: (from root@localhost)
	by baitaca.ipen.br (8.12.9/8.12.9) id h9GLwkEY023231
	for selinux@tycho.nsa.gov; Thu, 16 Oct 2003 18:58:46 -0300
Received: from ipen.br ([10.0.12.47])
	by baitaca.ipen.br (8.12.9/8.12.9) with ESMTP id h9GLwgY8023212
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 18:58:43 -0300
Message-ID: <3F8EEA16.8090908@ipen.br>
Date: Thu, 16 Oct 2003 16:57:26 -0200
From: Carlos Anisio Monteiro <monteiro@ipen.br>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: process context
Content-Type: multipart/alternative;
 boundary="------------090409020509000508040305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------090409020509000508040305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

The system have many process running in the following context: 
system_u:system_r:kernel_t (see example below).

 PID CONTEXT                                  COMMAND
    1 system_u:system_r:kernel_t               init [2]
    2 system_u:system_r:kernel_t               [ksoftirqd/0]
    3 system_u:system_r:kernel_t               [events/0]
    7 system_u:system_r:kernel_t               [kswapd0]
    8 system_u:system_r:kernel_t               [aio/0]
    9 system_u:system_r:kernel_t               [kseriod]
   33 system_u:system_r:kernel_t               [kjournald]
  250 system_u:system_r:kernel_t               /sbin/syslogd
  253 system_u:system_r:kernel_t               /sbin/klogd
  262 system_u:system_r:kernel_t               /usr/sbin/inetd
  346 system_u:system_r:kernel_t               sendmail: MTA: accepting 
connections
  373 system_u:system_r:kernel_t               /usr/sbin/cron
  378 system_u:system_r:kernel_t               /sbin/getty 38400 tty2
  379 system_u:system_r:kernel_t               /sbin/getty 38400 tty3

This is happen in the time of boot.

Is this correct? Any process, p.ex. init, syslogd, klogd, shouldn't they 
running in the proper context?
P.ex.:
init - system_u:system_r:init_t
klogd - system_u:system_r:klogd_t
cron - system_u:system_r:cron_t

If yes. How I resolve ???

thanks.

-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil


--------------090409020509000508040305
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Hi.<br>
 <br>
 The system have many process running in the following context: system_u:system_r:kernel_t
(see example below).<br>
 <br>
 &nbsp;<font face="Courier New, Courier, monospace"><small>PID CONTEXT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
COMMAND<br>
 &nbsp;&nbsp;&nbsp; 1 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init [2]<br>
 &nbsp;&nbsp;&nbsp; 2 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ksoftirqd/0]<br>
 &nbsp;&nbsp;&nbsp; 3 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [events/0]<br>
 &nbsp;&nbsp;&nbsp; 7 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [kswapd0]<br>
 &nbsp;&nbsp;&nbsp; 8 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [aio/0]<br>
 &nbsp;&nbsp;&nbsp; 9 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [kseriod]<br>
 &nbsp;&nbsp; 33 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [kjournald]<br>
 &nbsp; 250 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/syslogd<br>
 &nbsp; 253 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/klogd<br>
 &nbsp; 262 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/sbin/inetd<br>
 &nbsp; 346 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sendmail: MTA: accepting
connections<br>
 &nbsp; 373 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/sbin/cron<br>
 &nbsp; 378 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/getty 38400 tty2<br>
 &nbsp; 379 system_u:system_r:kernel_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /sbin/getty 38400 tty3</small></font><br>
 <br>
 This is happen in the time of boot.<br>
 <br>
 Is this correct? Any process, p.ex. init, syslogd, klogd, shouldn't they
running in the proper context?<br>
 P.ex.: <br>
 init - system_u:system_r:init_t<br>
 klogd - system_u:system_r:klogd_t<br>
 cron - system_u:system_r:cron_t<br>
 <br>
 If yes. How I resolve ???<br>
 <br>
 thanks.<br>
<br>
<pre class="moz-signature" cols="$mailwrapcol">-- 
Carlos Anisio Monteiro  <a class="moz-txt-link-rfc2396E" href="mailto:monteiro@ipen.br">&lt;monteiro@ipen.br&gt;</a>
IPEN/CNEN-SP
Sao Paulo - Brasil
</pre>
</body>
</html>

--------------090409020509000508040305--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
