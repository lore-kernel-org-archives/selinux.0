Subject: Re: Help with an SELinux AVC event...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: "Tomas, Gregg A (IS)" <Gregg.Tomas@ngc.com>, selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D02DF4964@de01exm68.ds.mot.com>
References: 
	 <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com>
	 <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D02DF4964@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Thu, 07 Jan 2010 15:43:51 -0500
Message-Id: <1262897031.2821.88.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-07 at 15:37 -0500, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I have a C application task called "sswd" on my Linux system, that
> opens up the /var/log/audit/audit.log file every 5 seconds, and checks
> to see if there are any new AVC denies.
> 
> I have had this same task doing the same thing for the last few years
> on a Linux system running selinux. And I have never seen these events
> in audit.log before complaining about the sswd task... I used to use
> older selinux packages, and ran the Fedora Core 7 'strict' policy
> together with some custom policies.
> 
> Recently we upgraded our SELinux packages to the very latest (similar
> to Fedora 12), and we are using Refpolicy as a base policy.
> 
> In the /var/log/audit/audit.log file, I see the following event pop up
> every 5 seconds, and I am guessing its because "sswd" tries to open up
> the audit.log file every 5 seconds for reading.
> 
> 1. Can you help me understand what this event is really saying?
> 2. I have already taken the audit.log file, and used audit2allow to
> generate any allow rules necessary, but it didnt help to get rid of
> this particular event.
> 3. Can I add any specific policy allow lines or transition rules in my
> custom policy files to get rid of this repeated event ?
> 
> Thanks in advance.
> 
> The event that pops up every 5 seconds in audit.log is:
> 
> type=SYSCALL msg=audit(1262874266.422:260): arch=14 syscall=5
> success=yes exit=24 a0=1002b9e4 a1=0 a2=1b6 a3=1b6 items=1 ppid=2463
> pid=2794 auid=4294967295 uid=0 gid=601 euid=0 suid=0 fsuid=0 egid=601
> sgid=601 fsgid=601 tty=(none) ses=4294967295 comm="sswd"
> exe="/usr/app/bin/sswd" subj=system_u:system_r:init_t:s0-s15:c0.c255
> key="LOG_audit"
> type=CWD msg=audit(1262874266.422:260):  cwd="/data"
> type=PATH msg=audit(1262874266.422:260): item=0
> name="/var/log/audit/audit.log" inode=2061 dev=fd:07 mode=0100600
> ouid=0 ogid=0 rdev=00:00
> obj=system_u:object_r:auditd_log_t:s15:c0.c255

That's your audit configuration (/etc/audit/audit.rules), not SELinux.
You have an audit rule that says to log all access to the audit log
file, presumably copied from the sample audit rules for the CAPP or LSPP
configurations.  Looks like this in audit.rules:
-w /var/log/audit/ -k LOG_audit

I think you'd be better off using audispd to dispatch audit events to
your program rather than directly reading audit.log yourself.
> 
> root@hapWibbSc2:/var/log/audit# ps -eZ | grep sswd
> system_u:system_r:init_t:s0-s15:c0.c255 2781 ? 00:00:00 sswd
> 
> root@hapWibbSc2:/var/log/audit# cd /usr/app/bin
> root@hapWibbSc2:/usr/app/bin# ls -l sswd
> -rwxrwxr-x 1 root root 217204 Jan  1 07:49 sswd
> 
> root@hapWibbSc2:/usr/app/bin# cd /var/log/audit/
> root@hapWibbSc2:/var/log/audit#
> root@hapWibbSc2:/var/log/audit# ls -lZ
> -rw-------  root root system_u:object_r:auditd_log_t:s15:c0.c255
> audit.log
> 
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
