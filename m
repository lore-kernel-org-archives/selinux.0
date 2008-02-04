Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14K91i1011499
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 15:09:01 -0500
Received: from rv-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m14K8tg3014760
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 20:09:00 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1496069rvb.54
        for <selinux@tycho.nsa.gov>; Mon, 04 Feb 2008 12:08:37 -0800 (PST)
Message-ID: <207608340802041208y44962ac0u98a3b0753f74b7ec@mail.gmail.com>
Date: Mon, 4 Feb 2008 20:08:36 +0000
From: "Eoin Ryan" <ryaneoin@gmail.com>
To: selinux@tycho.nsa.gov
Subject: How to contribute: policy?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6518_15779534.1202155716891"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_6518_15779534.1202155716891
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey All

I'm on a mission to run a personal server using the strict policy, mainly as
a learning exercise.  I've just come across what seems to be an error in the
policy, so I thought a good way to contribute might be to submit bug reports
as I work to configure the system for mail/web/etc.  Is this the correct
place/way to submit such problems?

The following was generated after the root user (logged in as sysadm_r)
executed the newaliases command on RHEL5, 2.6.18-53.1.6.el5 kernel and
strict policy version 21.

type=SELINUX_ERR msg=audit(1202153863.549:5631): security_compute_sid:
invalid context root:system_r:sysadm_mail_t:s0-s0:c0.c1023 for
scontext=root:sysadm_r:sysadm_mail_t:s0-s0:c0.c1023tcontext=system_u:object_r:postfix_master_exec_t:s0
tclass=process
type=SYSCALL msg=audit(1202153863.549:5631): arch=40000003 syscall=11
success=no exit=-13 a0=9577200 a1=9577220 a2=9577328 a3=9577200 items=0
ppid=23001 pid=23917 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
fsgid=0 tty=pts2 comm="newaliases" exe="/usr/sbin/sendmail.postfix"
subj=root:sysadm_r:sysadm_mail_t:s0-s0:c0.c1023 key=(null)

Regards
Eoin

------=_Part_6518_15779534.1202155716891
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey All<br><br>I&#39;m on a mission to run a personal server using the strict policy, mainly as a learning exercise.&nbsp; I&#39;ve just come across what seems to be an error in the policy, so I thought a good way to contribute might be to submit bug reports as I work to configure the system for mail/web/etc.&nbsp; Is this the correct place/way to submit such problems?<br>
<br>The following was generated after the root user (logged in as sysadm_r) executed the newaliases command on RHEL5, 2.6.18-53.1.6.el5 kernel and strict policy version 21.<br><br>type=SELINUX_ERR msg=audit(1202153863.549:5631): security_compute_sid:&nbsp; invalid context root:system_r:sysadm_mail_t:s0-s0:c0.c1023 for scontext=root:sysadm_r:sysadm_mail_t:s0-s0:c0.c1023 tcontext=system_u:object_r:postfix_master_exec_t:s0 tclass=process<br>
type=SYSCALL msg=audit(1202153863.549:5631): arch=40000003 syscall=11 success=no exit=-13 a0=9577200 a1=9577220 a2=9577328 a3=9577200 items=0 ppid=23001 pid=23917 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts2 comm=&quot;newaliases&quot; exe=&quot;/usr/sbin/sendmail.postfix&quot; subj=root:sysadm_r:sysadm_mail_t:s0-s0:c0.c1023 key=(null)<br>
<br>Regards<br>Eoin<br>

------=_Part_6518_15779534.1202155716891--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
