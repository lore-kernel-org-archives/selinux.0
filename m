MIME-Version: 1.0
From: Nick Kralevich <nnk@google.com>
Date: Fri, 11 Nov 2016 09:51:42 -0800
Message-ID: <CAFJ0LnGZ-f1UUK+yJevWKu=En5CK3s8ywaef_jju4ZFuU+LonA@mail.gmail.com>
Subject: checkpolicy dontaudit compiler bug?
To: SELinux <Selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

(apologies if you received this message twice. I believe the first
message got stuck in a moderation queue somewhere)

I'm trying to hunt down what appears to be a weird checkpolicy bug.

On Android, we have a special SELinux domain called "su". This domain
is intended to be used during debugging and is always in permissive
mode. To avoid generating a huge number of denials, we use a number of
"dontaudit" rules to suppress SELinux denials.

See https://android.googlesource.com/platform/system/sepolicy/+/0e1cbf568a9cc3dd0b26ead68a79d1f22dcb3add/private/su.te

Specifically, the following dontaudit rule is in that file:

  dontaudit su self:capability_class_set *;

which expands out to:

  dontaudit su self:{ capability capability2 } *;

However, on one device in particular ("marlin"), we find that this
dontaudit rule is ineffective. It appears that the checkpolicy
compiler is ignoring the dontaudit statement.

$ sesearch --dontaudit -s su -c capability,capability2 /tmp/marlin.sepolicy
dontaudit su su:capability sys_module;
dontaudit su su:capability2 { mac_admin mac_override wake_alarm
block_suspend syslog audit_read };

However, this isn't happening on the other device ("bullhead"), which
is compiled with a very similar policy:

$ sesearch --dontaudit -s su -c capability,capability2 /tmp/bullhead.sepolicy
dontaudit su su:capability { setuid setfcap sys_chroot
net_bind_service sys_nice mknod fsetid kill net_admin sys_rawio
audit_control sys_pacct sys_resource sys_ptrace dac_read_search
sys_boot sys_admin audit_write net_raw setgid sys_time lease
dac_override net_broadcast linux_immutable fowner sys_tty_config
setpcap sys_module ipc_lock chown ipc_owner };
dontaudit su su:capability2 { mac_admin mac_override wake_alarm
block_suspend syslog audit_read };

Steps to reproduce:

1) Download the following files and place them in /tmp

  http://kralevich.com/bullhead.policy.conf
  http://kralevich.com/marlin.policy.conf

2) Run the following commands to compile the policy:

  checkpolicy -M -c 30 -o /tmp/bullhead.sepolicy /tmp/bullhead.policy.conf
  checkpolicy -M -c 30 -o /tmp/marlin.sepolicy /tmp/marlin.policy.conf

3) Verify the dontaudit rules by running sesearch

  sesearch --dontaudit -s su -c capability,capability2 /tmp/marlin.sepolicy
  sesearch --dontaudit -s su -c capability,capability2 /tmp/bullhead.sepolicy

Expected: the output from the sesearch command above is identical for
each device.

Actual: the output from the sesearch command differs.

If anyone has any insight into this bug I'd appreciate it.

-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
