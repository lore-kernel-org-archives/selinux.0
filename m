Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3UKQPI4006917
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 16:26:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3UKQEVf007164
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 20:26:14 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3UKQE4D007161
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 20:26:14 GMT
Subject: Re: SUDO package
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3EB02E78.3000905@redhat.com>
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
	 <200304181408.55003.russell@coker.com.au>  <3EA021A5.4020603@redhat.com>
	 <1051021175.14761.61.camel@moss-huskers.epoch.ncsc.mil>
	 <3EA5A040.40107@redhat.com>
	 <1051199603.20300.33.camel@moss-huskers.epoch.ncsc.mil>
	 <3EAFEECA.1090107@redhat.com>
	 <1051724624.1028.65.camel@moss-huskers.epoch.ncsc.mil>
	 <3EB01EC8.7070602@redhat.com>
	 <1051730417.1028.78.camel@moss-huskers.epoch.ncsc.mil>
	 <3EB02E78.3000905@redhat.com>
Content-Type: text/plain
Message-Id: <1051734374.1028.91.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Apr 2003 16:26:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-30 at 16:13, Daniel J Walsh wrote:
> Ok now I understand.  I can just go with the directory commands from 
> can_exec_any rule.
>     allow $1 { bin_t sbin_t lib_t etc_t }:dir r_dir_perms;
>     allow $1 { bin_t sbin_t }:lnk_file read;
> 
> in sudo.te which would satisfy my needs.  Probably do not need lib_t
> or etc_t.
> Is that what you had in mind?

Yes.  It might be a good idea to hide this set of types in a macro in
the global macros, so that people can install sudo.te on systems that
have different sets of types and sudo.te can just pick up the right set
using the macro.

> Not exactly an ideal behaviour.  
> 
> Consider 
> sudo -r sysadm_r /bin/sh 
> would be broken by this.

If you really mean 'sudo -r sysadm_r /bin/sh' (run in foreground), then
this is no different than newrole.  If you mean 'sudo -b -r sysadm_r
/bin/sh' (backgrounded), then that wouldn't work even aside from SELinux
issues.  It would be suspended immediately when it tried to access tty
input, and any output would be interleaved with the output from the
primary shell, which would make a mess.  Hence, it is already necessary
for either the user or the sudo program to redirect input and output if
backgrounding.  The man page for sudo notes that -b prevents the use of
job control for manipulating the process.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
