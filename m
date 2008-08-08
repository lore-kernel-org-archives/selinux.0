Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78HlwTH022651
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 13:47:58 -0400
Received: from cyberguard2.afccc.af.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78HlnvK001332
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 17:47:49 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Nagios and RHEL 5
Date: Fri, 8 Aug 2008 13:47:58 -0400
Message-ID: <C1DF76B68C82E64590F9448D012FB21884F567@exchange.afccc.mil>
From: "Cooper David Ctr 14WS/P3I" <david.cooper.ctr@afccc.af.mil>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm just starting to learn about SELinux and I'm having issues with
Nagios on Red Hat Enterprise 5.2

I was wondering if anyone has dealt with or been successful in
generating a policy that works with Nagios.


Setup:

[install is in /usr/local/nagios (from tar ball)]
[SELinux = Enforcing/Targeted]
[Nagios 3.0.3 and nagios-plugins-1.4.12] 
[RHEL 5.2 - 2.6.18-92.1.10.el5]

I've ran the following to reset everything back to the way the Nagios
Quickstart guide mentions.

#restorecon -R -v /usr/local/nagios/
#chcon -R -t httpd_sys_content_t /usr/local/nagios/sbin/ 
#chcon -R -t httpd_sys_content_t /usr/local/nagios/share/

-----------------------------------------------------------------
Messages LOG: /var/log/messages

When I start Nagios I immediately get the following in /var/log/messages
(from ICMP Checks):
13:04:27 mini-rhel setroubleshoot: SELinux is preventing ping (ping_t)
"read write" to /usr/local/nagios/var/spool/checkresults/checkVcGBxh
(usr_t).

If I force a re-schedule of something (say PING):
13:07:02 mini-rhel setroubleshoot: SELinux is preventing cmd.cgi
(httpd_sys_script_t) "getattr" to /usr/local/nagios/var/rw/nagios.cmd
(usr_t).

Plus I get : "Error: Could not stat() command file
'/usr/local/nagios/var/rw/nagios.cmd'!" in the browser interface.

------------------------------------------------------------------
Audit LOG: /var/log/audit/audit.log  (same as above but in audit.log)

type=AVC msg=audit(1218215558.890:3854): avc:  denied  { read write }
for  pid=1403 comm="ping"
path="/usr/local/nagios/var/spool/checkresults/checkcDARIP" dev=dm-0
ino=394381 scontext=user_u:system_r:ping_t:s0
tcontext=user_u:object_r:usr_t:s0 tclass=file type=SYSCALL
msg=audit(1218215558.890:3854): arch=40000003 syscall=11 success=yes
exit=0 a0=932fa70 a1=932fb08 a2=bf99b804 a3=932fb08 items=0 ppid=1402
pid=1403 auid=502 uid=501 gid=501 euid=0 suid=0 fsuid=0 egid=501
sgid=501 fsgid=501 tty=(none) ses=86 comm="ping" exe="/bin/ping"
subj=user_u:system_r:ping_t:s0 key=(null)

and

type=AVC msg=audit(1218215748.753:3865): avc:  denied  { getattr } for
pid=1462 comm="cmd.cgi" path="/usr/local/nagios/var/rw/nagios.cmd"
dev=dm-0 ino=393524 scontext=user_u:system_r:httpd_sys_script_t:s0
tcontext=user_u:object_r:usr_t:s0 tclass=fifo_file type=SYSCALL
msg=audit(1218215748.753:3865): arch=40000003 syscall=195 success=no
exit=-13 a0=807eae0 a1=bfc81280 a2=3d7ff4 a3=3 items=0 ppid=5390
pid=1462 auid=502 uid=48 gid=48 euid=48 suid=48 fsuid=48 egid=48 sgid=48
fsgid=48 tty=(none) ses=2 comm="cmd.cgi"
exe="/usr/local/nagios/sbin/cmd.cgi"
subj=user_u:system_r:httpd_sys_script_t:s0 key=(null)

-------------------------------------------------------------------


Thank you for taking a look.


David,





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
