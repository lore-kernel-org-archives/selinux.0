Message-ID: <SNT139-w538F8D8118C077D8E94F34ABC00@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_de36cf93-dcd8-4979-bab2-0e38720e4bb4_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <qingtao.cao@windriver.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        <jmorris@namei.org>, <eparis@parisplace.org>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: [v2 PATCH 0/3] SELinux: separate socket type than its creator
Date: Wed, 2 Mar 2011 08:21:30 +0000
In-Reply-To: <1299044768-22058-1-git-send-email-qingtao.cao@windriver.com>
References: <1299044768-22058-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_de36cf93-dcd8-4979-bab2-0e38720e4bb4_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


- why the kernel needed patching
 
   Since syslogd_t runs at mls_systemhigh, both the /dev/log file and the
   unix_dgram_socket object bond to it are of mls_systemhigh, rendering that
   many application domains that have logging_send_syslog_msg() called and
   running at mls_systemlow such as klogd_t failed to "sendto" it with the
   following error message:
   
   type=1400 audit(1298535101.654:868): avc:  denied  { sendto } for  pid=385 comm="klogd" path="/dev/log" scontext=system_u:object_r:klogd_t:s0 tcontext=system_u:object_r:syslogd_t:s15:c0.c1023 tclass=unix_dgram_socket
   
   One possible solution is to add syslogd_t to the mlstrustedobject attribute
   since the unix_dgram_socket object inherits the creator's SID by default.
   However, the side effect of this approach is that syslogd_t is also the
   label for the entire syslogd's procfs entries.
   
- the overall design approach in the patch
   
   Had a socket had separate type than the creator's type then the socket type
   alone could be added to the mlstrustedobject attribute. For this purpose,
   security_transition_sid could be called to compute the socket SID on socket
   creation(in the wrapper function of socket_sockcreate_sid()).
   
   In order not to break labeled networking and network access control, socket
   should retain its creator's role and MLS attribute, both
   security_compute_sid and mls_compute_sid functions should handle a socket
   class in the same way as they do for the "process" class.
   
   In order to reduce future maintenance effort the genheaders program will
   help to auto-generate a function to decide if a class is of any socket
   class, by comparing the class kernel value among those SECCLASS_XXX macros
   for socket class.
   
   Last but not least, if security_compute_sid is called from userspace
   (by compute_create program) then the class policy value should be mapped
   to the relevant kernel value before above check.
   
- implementation details
   
   (Please refer to the patches themselves:-))
   
- testing results
   
   If socket type "syslogd_s_t" is defined and following type_transition rule
   is specified in logging.te:
       type_transition syslogd_t syslogd_t : unix_dgram_socket syslogd_s_t;
   
   Then with the help of dump_stack() and printk() we can see that the
   unix_dgram_socket object created by syslogd would have a different type but
   retains syslogd's user, role and attribute:
   
      Pid: 395, comm: syslogd Not tainted 2.6.34.8-WR4.2.0.0_standard #13
      Call Trace:
       [<c1247042>] socket_sockcreate_sid+0x52/0xc0
       [<c1247143>] selinux_socket_post_create+0x93/0x180
       [<c1240010>] security_socket_post_create+0x20/0x30
       [<c143bdb2>] __sock_create+0x252/0x3d0
       [<c1072234>] ? audit_syscall_exit+0x2d4/0x300
       [<c143bf97>] sock_create+0x37/0x50
       [<c143c1d6>] sys_socket+0x56/0xe0
       [<c143d38f>] sys_socketcall+0x8f/0x2f0
       [<c15254a1>] system_call_done+0x0/0x4
      tsec->sid: ab, context: system_u:system_r:syslogd_t:s15:c0.c1023
      socksid: af, context: system_u:system_r:syslogd_s_t:s15:c0.c1023
   
   On the command line we can see the socket security context got by the
   compute_create program retains the same role and MLS attribute as its
   creator rather than object_r and mls_systemlow as regular files:
   
      [root/sysadm_r/s0@~]# compute_create system_u:system_r:syslogd_t:s15:c0.c1023 system_u:system_r:syslogd_t:s15:c0.c1023 unix_stream_socket
      system_u:system_r:syslogd_t:s15:c0.c1023
      [root/sysadm_r/s0@~]# 
      [root/sysadm_r/s0@~]# compute_create system_u:system_r:syslogd_t:s15:c0.c1023 system_u:system_r:syslogd_t:s15:c0.c1023 unix_dgram_socket
      system_u:system_r:syslogd_s_t:s15:c0.c1023
      [root/sysadm_r/s0@~]#
 		 	   		  
--_de36cf93-dcd8-4979-bab2-0e38720e4bb4_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'>
- why the kernel needed patching<br>&nbsp;<br>&nbsp;&nbsp; Since syslogd_t runs at mls_systemhigh, both the /dev/log file and the<br>&nbsp;&nbsp; unix_dgram_socket object bond to it are of mls_systemhigh, rendering that<br>&nbsp;&nbsp; many application domains that have logging_send_syslog_msg() called and<br>&nbsp;&nbsp; running at mls_systemlow such as klogd_t failed to "sendto" it with the<br>&nbsp;&nbsp; following error message:<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; type=1400 audit(1298535101.654:868): avc:&nbsp; denied&nbsp; { sendto } for&nbsp; pid=385 comm="klogd" path="/dev/log" scontext=system_u:object_r:klogd_t:s0 tcontext=system_u:object_r:syslogd_t:s15:c0.c1023 tclass=unix_dgram_socket<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; One possible solution is to add syslogd_t to the mlstrustedobject attribute<br>&nbsp;&nbsp; since the unix_dgram_socket object inherits the creator's SID by default.<br>&nbsp;&nbsp; However, the side effect of this approach is that syslogd_t is also the<!
 br>&nbsp;&nbsp; label for the entire syslogd's procfs entries.<br>&nbsp;&nbsp; <br>- the overall design approach in the patch<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; Had a socket had separate type than the creator's type then the socket type<br>&nbsp;&nbsp; alone could be added to the mlstrustedobject attribute. For this purpose,<br>&nbsp;&nbsp; security_transition_sid could be called to compute the socket SID on socket<br>&nbsp;&nbsp; creation(in the wrapper function of socket_sockcreate_sid()).<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; In order not to break labeled networking and network access control, socket<br>&nbsp;&nbsp; should retain its creator's role and MLS attribute, both<br>&nbsp;&nbsp; security_compute_sid and mls_compute_sid functions should handle a socket<br>&nbsp;&nbsp; class in the same way as they do for the "process" class.<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; In order to reduce future maintenance effort the genheaders program will<br>&nbsp;&nbsp; help to auto-generate a f!
 unction to decide if a class is of any socket<br>&nbsp;&nbsp; class, b
y comparing the class kernel value among those SECCLASS_XXX macros<br>&nbsp;&nbsp; for socket class.<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; Last but not least, if security_compute_sid is called from userspace<br>&nbsp;&nbsp; (by compute_create program) then the class policy value should be mapped<br>&nbsp;&nbsp; to the relevant kernel value before above check.<br>&nbsp;&nbsp; <br>- implementation details<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; (Please refer to the patches themselves:-))<br>&nbsp;&nbsp; <br>- testing results<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; If socket type "syslogd_s_t" is defined and following type_transition rule<br>&nbsp;&nbsp; is specified in logging.te:<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; type_transition syslogd_t syslogd_t : unix_dgram_socket syslogd_s_t;<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; Then with the help of dump_stack() and printk() we can see that the<br>&nbsp;&nbsp; unix_dgram_socket object created by syslogd would have a different type but<br>&nbsp;&nbsp; retains!
  syslogd's user, role and attribute:<br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pid: 395, comm: syslogd Not tainted 2.6.34.8-WR4.2.0.0_standard #13<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Call Trace:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&lt;c1247042&gt;] socket_sockcreate_sid+0x52/0xc0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&lt;c1247143&gt;] selinux_socket_post_create+0x93/0x180<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&lt;c1240010&gt;] security_socket_post_create+0x20/0x30<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&lt;c143bdb2&gt;] __sock_create+0x252/0x3d0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&lt;c1072234&gt;] ? audit_syscall_exit+0x2d4/0x300<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&lt;c143bf97&gt;] sock_create+0x37/0x50<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&lt;c143c1d6&gt;] sys_socket+0x56/0xe0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&lt;c143d38f&gt;] sys_socketcall+0x8f/0x2f0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&lt;c15254a1&gt;] system_call_done+0x!
 0/0x4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tsec-&gt;sid: ab, context: sys
tem_u:system_r:syslogd_t:s15:c0.c1023<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socksid: af, context: system_u:system_r:syslogd_s_t:s15:c0.c1023<br>&nbsp;&nbsp; <br>&nbsp;&nbsp; On the command line we can see the socket security context got by the<br>&nbsp;&nbsp; compute_create program retains the same role and MLS attribute as its<br>&nbsp;&nbsp; creator rather than object_r and mls_systemlow as regular files:<br>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [root/sysadm_r/s0@~]# compute_create system_u:system_r:syslogd_t:s15:c0.c1023 system_u:system_r:syslogd_t:s15:c0.c1023 unix_stream_socket<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_u:system_r:syslogd_t:s15:c0.c1023<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [root/sysadm_r/s0@~]# <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [root/sysadm_r/s0@~]# compute_create system_u:system_r:syslogd_t:s15:c0.c1023 system_u:system_r:syslogd_t:s15:c0.c1023 unix_dgram_socket<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_u:system_r:syslogd_s_t:s15:c0.c1023<br>&nbsp;&nbs!
 p;&nbsp;&nbsp;&nbsp; [root/sysadm_r/s0@~]#<br> 		 	   		  </body>
</html>
--_de36cf93-dcd8-4979-bab2-0e38720e4bb4_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
