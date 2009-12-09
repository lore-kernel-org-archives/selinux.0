Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB9IGMDm007732
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 13:16:22 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nB9IFC76016997
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 18:15:12 GMT
Message-ID: <4B1FE96F.90201@redhat.com>
Date: Wed, 09 Dec 2009 13:16:15 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Zaina AFOULKI <zaina.afoulki@ensi-bourges.fr>
CC: selinux@tycho.nsa.gov
Subject: Re: Sample logs of alert types
References: <1f53dffb3e370e5bafc0c2ed98eed589.squirrel@webmail.ensi-bourges.fr>
In-Reply-To: <1f53dffb3e370e5bafc0c2ed98eed589.squirrel@webmail.ensi-bourges.fr>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/08/2009 10:04 AM, Zaina AFOULKI wrote:
> Hello,
> 
> We are trying to develop a graphical interface for SELinux alerts...
> We noticed that each log for a specific alert is different from the one of
> other types. For example:
> 
> type=AVC msg=audit(12/03/2007 12:44:48.301:140) : avc:  denied  { getattr
> } for  pid=2816 comm=vi path=/root/xorg.conf.new dev=sda1 ino=131104
> scontext=staff_u:staff_r:staff_sudo_t:s0
> tcontext=root:object_r:sysadm_home_t:s0 tclass=file
> 
> 
> type=SYSCALL msg=audit(12/03/2007 12:44:48.325:141) : arch=i386
> syscall=access success=yes exit=0 a0=88caaa8 a1=2 a2=1a4 a3=1 items=0
> ppid=2784 pid=2816 auid=gmarzot uid=root gid=root euid=root suid=root
> fsuid=root egid=root sgid=root fsgid=root tty=pts0 comm=vi exe=/bin/vi
> subj=staff_u:staff_r:staff_sudo_t:s0 key=(null)
> 
> Currently we know how the log looks like for the following types:
> DAEMON_START  ANOM_ABEND AVC CONFIG_CHANGE CRED_ACQ CRED_DISP DAEMON_END
> LOGIN MAC_STATUS SELINUX_ERR SYSCALL SYSTEM_RUNLEVEL SYSTEM_SHUTDOWN
> USER_ACCT USER_AUTH USER_AVC USER_CHAUTHTOK USER_CMD USER_END USER_ERR
> USER_LOGIN USER_ROLE_CHANGE USER_START
> 
> We really need to know the look of each alert in the log file.
> Is there a way we can get a sample of each log type?
> Your help will be greatly appreciated.
> 
> Thanks in advance,
> 
> 
I think this is more of an audit question.

Are you asking to see what an AVC audit message looks like?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
