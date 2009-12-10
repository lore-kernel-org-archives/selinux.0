Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBAHu3aN020068
	for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2009 12:56:03 -0500
Received: from cp-out12.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBAHsjwl003745
	for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2009 17:54:47 GMT
Subject: Re: Sample logs of alert types
From: Guido Trentalancia <guido@trentalancia.com>
To: Zaina AFOULKI <zaina.afoulki@ensi-bourges.fr>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1f53dffb3e370e5bafc0c2ed98eed589.squirrel@webmail.ensi-bourges.fr>
References: 
	 <1f53dffb3e370e5bafc0c2ed98eed589.squirrel@webmail.ensi-bourges.fr>
Content-Type: text/plain
Date: Thu, 10 Dec 2009 18:55:46 +0100
Message-Id: <1260467746.2868.34.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As Daniel Walsh already explained to you, these are AUDIT_AVC messages.
The different types of messages are defined in the lib/msg_typetab.h
within the audit source (http://people.redhat.com/sgrubb/audit/).

If you grab that package and filter lib/msg_typetab.h through grep and
then awk, you get the following list (which I am quoting here for your
convenience since it's not very long):

"LIST"
"USER"
"LOGIN"
"LIST_RULES"
"TTY_GET"
"TTY_SET"
"USER_AUTH"
"USER_ACCT"
"USER_MGMT"
"CRED_ACQ"
"CRED_DISP"
"USER_START"
"USER_END"
"USER_AVC"
"USER_CHAUTHTOK"
"USER_ERR"
"CRED_REFR"
"USYS_CONFIG"
"USER_LOGIN"
"USER_LOGOUT"
"ADD_USER"
"DEL_USER"
"ADD_GROUP"
"DEL_GROUP"
"DAC_CHECK"
"CHGRP_ID"
"TEST"
"TRUSTED_APP"
"USER_SELINUX_ERR"
"USER_CMD"
"USER_TTY"
"CHUSER_ID"
"GRP_AUTH"
"SYSTEM_BOOT"
"SYSTEM_SHUTDOWN"
"SYSTEM_RUNLEVEL"
"DAEMON_START"
"DAEMON_END"
"DAEMON_ABORT"
"DAEMON_CONFIG"
"DAEMON_ROTATE"
"DAEMON_RESUME"
"DAEMON_ACCEPT"
"DAEMON_CLOSE"
"SYSCALL"
"PATH"
"IPC"
"SOCKETCALL"
"CONFIG_CHANGE"
"SOCKADDR"
"CWD"
"EXECVE"
"IPC_SET_PERM"
"MQ_OPEN"
"MQ_SENDRECV"
"MQ_NOTIFY"
"MQ_GETSETATTR"
"KERNEL_OTHER"
"FD_PAIR"
"OBJ_PID"
"TTY"
"EOE"
"BPRM_FCAPS"
"CAPSET"
"AVC"
"SELINUX_ERR"
"AVC_PATH"
"MAC_POLICY_LOAD"
"MAC_STATUS"
"MAC_CONFIG_CHANGE"
"MAC_UNLBL_ALLOW"
"MAC_CIPSOV4_ADD"
"MAC_CIPSOV4_DEL"
"MAC_MAP_ADD"
"MAC_MAP_DEL"
"MAC_IPSEC_ADDSA"
"MAC_IPSEC_DELSA"
"MAC_IPSEC_ADDSPD"
"MAC_IPSEC_DELSPD"
"MAC_IPSEC_EVENT"
"MAC_UNLBL_STCADD"
"MAC_UNLBL_STCDEL"
"ANOM_PROMISCUOUS"
"ANOM_ABEND"
"INTEGRITY_DATA"
"INTEGRITY_METADATA"
"INTEGRITY_STATUS"
"INTEGRITY_HASH"
"INTEGRITY_PCR"
"INTEGRITY_RULE"
"APPARMOR"
"APPARMOR_AUDIT"
"APPARMOR_ALLOWED"
"APPARMOR_DENIED"
"APPARMOR_HINT"
"APPARMOR_STATUS"
"APPARMOR_ERROR"
"KERNEL"
"ANOM_LOGIN_FAILURES"
"ANOM_LOGIN_TIME"
"ANOM_LOGIN_SESSIONS"
"ANOM_LOGIN_ACCT"
"ANOM_LOGIN_LOCATION"
"ANOM_MAX_DAC"
"ANOM_MAX_MAC"
"ANOM_AMTU_FAIL"
"ANOM_RBAC_FAIL"
"ANOM_RBAC_INTEGRITY_FAIL"
"ANOM_CRYPTO_FAIL"
"ANOM_ACCESS_FS"
"ANOM_EXEC"
"ANOM_MK_EXEC"
"ANOM_ADD_ACCT"
"ANOM_DEL_ACCT"
"ANOM_MOD_ACCT"
"ANOM_ROOT_TRANS"
"RESP_ANOMALY"
"RESP_ALERT"
"RESP_KILL_PROC"
"RESP_TERM_ACCESS"
"RESP_ACCT_REMOTE"
"RESP_ACCT_LOCK_TIMED"
"RESP_ACCT_UNLOCK_TIMED"
"RESP_ACCT_LOCK"
"RESP_TERM_LOCK"
"RESP_SEBOOL"
"RESP_EXEC"
"RESP_SINGLE"
"RESP_HALT"
"USER_ROLE_CHANGE"
"ROLE_ASSIGN"
"ROLE_REMOVE"
"LABEL_OVERRIDE"
"LABEL_LEVEL_CHANGE"
"USER_LABELED_EXPORT"
"USER_UNLABELED_EXPORT"
"DEV_ALLOC"
"DEV_DEALLOC"
"FS_RELABEL"
"USER_MAC_POLICY_LOAD"
"CRYPTO_TEST_USER"
"CRYPTO_PARAM_CHANGE_USER"
"CRYPTO_LOGIN"
"CRYPTO_LOGOUT"
"CRYPTO_KEY_USER"
"CRYPTO_FAILURE_USER"
"CRYPTO_REPLAY_USER"

So, the above are all possible AVC denial (or grant) messages that you
can get from audit version 1.7.16.

You might also want to look at the audit_log_user_avc_message.3 manual
page and at the definition of int audit_log_user_avc_message() (where
you will find how the message will actually look like in term of the
string which is dumped in your logfiles).

Hope it helps, but this is really out of the scope of this mailing list
I think.

On Tue, 2009-12-08 at 16:04 +0100, Zaina AFOULKI wrote:
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



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
