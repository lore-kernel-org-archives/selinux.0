Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6DHmWh9005319
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2013 13:48:32 -0400
Received: by mail-we0-f172.google.com with SMTP id q56so8964957wes.17
        for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2013 10:48:27 -0700 (PDT)
Date: Sat, 13 Jul 2013 19:48:03 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Andy Ruch <adruch2002@yahoo.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: AVC for unlabeled_t on cgroup
Message-ID: <20130713174723.GA5347@siphos.be>
References: <1373567937.10428.YahooMailNeo@web163406.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1373567937.10428.YahooMailNeo@web163406.mail.gq1.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 11, 2013 at 11:38:57AM -0700, Andy Ruch wrote:
> I'm implementing a restrictive policy for RHEL 6.3 based on CLIP. I've enabled the cgroup module but I'm still seeing the AVC below. This is just one of a dozen similar AVC's for different inodes. When I look at the /cgroup after the system boots, everything has a cgroup_t label. Where would the unlabeled_t be coming from?
> 
> 
> 
> type=SYSCALL msg=audit(07/11/2013 17:25:38.885:7) : arch=x86_64 syscall=mount success=yes exit=0 a0=7f57846ac4c1 a1=7f57848b03c0 a2=7f57846ac4c1 a3=0 items=0 ppid=1177 pid=1178 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=cgconfigparser exe=/sbin/cgconfigparser subj=system_u:system_r:cgconfig_t:s0 key=(null) 
> 
> type=AVC msg=audit(07/11/2013 17:25:38.885:7) : avc:  denied  { search } for  pid=1178 comm=cgconfigparser name=/ dev=cgroup ino=12518 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir 

The cgroup_t label might be put on it afterwards (check your udev rules and
scripts to see if they don't relabel files), but my guess is that the
directory is marked as unlabeled_t and that cgroup file system is mounted on
top of it later. Once it is mounted, you see the context of the files (and
directories) in the mounted file system, which is cgroup_t.

Try bindmounting root elsewhere and see what the label is of the directory.

Also, the process cgconfigparser is running as kernel_t, which we probably
don't want. The kernel is probably configured to trigger that script
somewhere (or through another script) and because there is no transition
defined, the script remains running as kernel_t.

For instance, in Gentoo, we have a script that is called after the last task
is removed from a control group; we mark that script as a specific exec
script (openrc_cgroup_release_exec_t here) and have a transition from
kernel_t to openrc_cgroup_release_t upon execution.

This is through cgroup's notify_on_release implementation (release agent).
Perhaps the cgconfigparser is also executed through a cgroup feature by the
kernel?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
