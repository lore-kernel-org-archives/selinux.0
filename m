Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7CIYU39030170
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 14:34:30 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7CIYTcG020609
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 18:34:29 GMT
Cc: selinux@tycho.nsa.gov
Message-Id: <660E036C-3778-4D06-B32F-26CFC8D36603@redhat.com>
From: Gunnar Hellekson <gunnar.hellekson@redhat.com>
To: Cooper David Ctr 14WS/P3I <david.cooper.ctr@afccc.af.mil>
In-Reply-To: <C1DF76B68C82E64590F9448D012FB21884F567@exchange.afccc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Nagios and RHEL 5
Date: Tue, 12 Aug 2008 14:34:14 -0400
References: <C1DF76B68C82E64590F9448D012FB21884F567@exchange.afccc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On  8-Aug-2008, at 1:47 PM, Cooper David Ctr 14WS/P3I wrote:
> -----------------------------------------------------------------
> Messages LOG: /var/log/messages
>
> When I start Nagios I immediately get the following in /var/log/ 
> messages
> (from ICMP Checks):
> 13:04:27 mini-rhel setroubleshoot: SELinux is preventing ping (ping_t)
> "read write" to /usr/local/nagios/var/spool/checkresults/checkVcGBxh
> (usr_t).
>
> If I force a re-schedule of something (say PING):
> 13:07:02 mini-rhel setroubleshoot: SELinux is preventing cmd.cgi
> (httpd_sys_script_t) "getattr" to /usr/local/nagios/var/rw/nagios.cmd
> (usr_t).
>
> Plus I get : "Error: Could not stat() command file
> '/usr/local/nagios/var/rw/nagios.cmd'!" in the browser interface.
>
> ------------------------------------------------------------------
> Audit LOG: /var/log/audit/audit.log  (same as above but in audit.log)
>
> type=AVC msg=audit(1218215558.890:3854): avc:  denied  { read write }
> for  pid=1403 comm="ping"
> path="/usr/local/nagios/var/spool/checkresults/checkcDARIP" dev=dm-0
> ino=394381 scontext=user_u:system_r:ping_t:s0
> tcontext=user_u:object_r:usr_t:s0 tclass=file type=SYSCALL
> msg=audit(1218215558.890:3854): arch=40000003 syscall=11 success=yes
> exit=0 a0=932fa70 a1=932fb08 a2=bf99b804 a3=932fb08 items=0 ppid=1402
> pid=1403 auid=502 uid=501 gid=501 euid=0 suid=0 fsuid=0 egid=501
> sgid=501 fsgid=501 tty=(none) ses=86 comm="ping" exe="/bin/ping"
> subj=user_u:system_r:ping_t:s0 key=(null)
>
> and
>
> type=AVC msg=audit(1218215748.753:3865): avc:  denied  { getattr } for
> pid=1462 comm="cmd.cgi" path="/usr/local/nagios/var/rw/nagios.cmd"
> dev=dm-0 ino=393524 scontext=user_u:system_r:httpd_sys_script_t:s0
> tcontext=user_u:object_r:usr_t:s0 tclass=fifo_file type=SYSCALL
> msg=audit(1218215748.753:3865): arch=40000003 syscall=195 success=no
> exit=-13 a0=807eae0 a1=bfc81280 a2=3d7ff4 a3=3 items=0 ppid=5390
> pid=1462 auid=502 uid=48 gid=48 euid=48 suid=48 fsuid=48 egid=48  
> sgid=48
> fsgid=48 tty=(none) ses=2 comm="cmd.cgi"
> exe="/usr/local/nagios/sbin/cmd.cgi"
> subj=user_u:system_r:httpd_sys_script_t:s0 key=(null)

So Nagios does some strange things, from the targeted policy's point  
of view.

I'm not smart enough to give you the exact policy change required, but  
I do know that cmd.cgi writes to the nagios.cmd fifo to push commands  
onto the Nagios server queue. This is exactly the kind of thing you  
don't want a CGI doing, usually, so you'll likely have to alter the  
standard CGI policies to allow this. This is required only if you want  
to use the web interface to manipulate the server.

Likewise, you'll need to give ping permission to write to the result  
logs in $NAGIOS_ROOT/var/spool.

Have you considered running the system in Permissive mode and pushing  
the audit logs through audit2allow to get you started with a Nagios  
policy?

g

-- 
Gunnar Hellekson, RHCE
Lead Architect, Red Hat Government





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
