Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9EHKhrT029751
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 13:20:44 -0400 (EDT)
Received: from mproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9EHJVmT018959
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 17:19:32 GMT
Received: by mproxy.gmail.com with SMTP id 77so133416rnk
        for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 10:20:43 -0700 (PDT)
Message-ID: <fa8ec5d8041014102023ef42cd@mail.gmail.com>
Date: Thu, 14 Oct 2004 13:20:43 -0400
From: Kodungallur Varma <ramgwu@gmail.com>
Reply-To: Kodungallur Varma <ramgwu@gmail.com>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: policy compile fixes
In-Reply-To: <20041014113536.GC2540@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20041014113536.GC2540@jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

       when I "make load" a new policy I have the following sequence
in the console..

-------------------------------------------------
[root@sun policy]# make load
mkdir -p /etc/security/selinux
/usr/bin/checkpolicy -o /etc/security/selinux/policy.17 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
security:  5 users, 7 roles, 1244 types, 1 bools
security:  30 classes, 303377 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 17) to
/etc/security/selinux/policy.17
/usr/bin/checkpolicy -c 15 -o /etc/security/selinux/policy.15 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
security:  5 users, 7 roles, 1244 types, 1 bools
security:  30 classes, 303377 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 15) to
/etc/security/selinux/policy.15
warning: discarding booleans and conditional rules
/usr/bin/checkpolicy -c 16 -o /etc/security/selinux/policy.16 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
security:  5 users, 7 roles, 1244 types, 1 bools
security:  30 classes, 303377 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 16) to
/etc/security/selinux/policy.16
/usr/sbin/load_policy /etc/security/selinux/policy.`cat /selinux/policyvers`
Can't open '/etc/security/selinux/policy.18':  No such file or directory
make: *** [tmp/load] Error 2
----------------------------------------------------
the last two lines...why is it trying to open policy.18...I dont even
have it and in the last line it says error. is there some way to fix
it. thanx a lot..

Ram




On Thu, 14 Oct 2004 13:35:36 +0200, Thomas Bleher
<bleher@informatik.uni-muenchen.de> wrote:
> This patch fixes a few compile problems with latest policy:
>         consoletype.te: firstboot.te may not be there
>         cups.fc: cupsd_config only exists if hald.te is available
>         apache_macros.te: allow_ypbind is only declared if ypbind.te is
>                           available
> 
> Add a few file_contexts.
> 
> Conditionalize the file_type_auto_trans rule in apache.te, otherwise log
> files get created with the wrong context.
> 
> Add can_exec($1_ssh_t, { shell_exec_t bin_t }), it is needed for some
> programs like x11-ssh-askpass (and I suspect sftp_server).
> 
> Please apply.
> Thomas
> 
> --
> http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
> GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7
> 
> 
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
