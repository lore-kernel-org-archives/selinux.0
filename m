Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAE5CR0p005578
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2008 00:12:28 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAE5AeCP014859
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2008 05:10:40 GMT
Message-ID: <491D0889.2010709@redhat.com>
Date: Fri, 14 Nov 2008 15:11:37 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Daniel Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: user guide draft: "Allowing Access: audit2allow"
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following is a draft for the "Allowing Access: audit2allow" section. 
I'm sure there are better examples somewhere that can be used...

Allowing Access: audit2allow

The example in this section should not be used, as the example denial 
can be solved with correct labeling. The example shown is used only to 
demonstrate the use of audit2allow.

 From the audit2allow(1) manual page: "audit2allow - generate SELinux 
policy allow rules from logs of denied operations"[1]. After analyzing 
denials as per Section 7.3.7, “sealert Messages”, and if no label 
changes or Booleans allowed access, use audit2allow to create a local 
policy module. After access is denied by SELinux, running the 
audit2allow command presents Type Enforcement rules that allow the 
previously denied access. The following example demonstrates a denial 
and the associated system call logged to /var/log/audit/audit.log:

type=AVC msg=audit(1226270358.848:238): avc:  denied  { write } for 
pid=13349 comm="certwatch" name="cache" dev=dm-0 ino=218171 
scontext=system_u:system_r:certwatch_t:s0 
tcontext=system_u:object_r:var_t:s0 tclass=dir

type=SYSCALL msg=audit(1226270358.848:238): arch=40000003 syscall=39 
success=no exit=-13 a0=39a2bf a1=3ff a2=3a0354 a3=94703c8 items=0 
ppid=13344 pid=13349 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 
egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="certwatch" 
exe="/usr/bin/certwatch" subj=system_u:system_r:certwatch_t:s0 key=(null)

In this example, certwatch (comm="certwatch") was denied write access ({ 
write }) to a directory labeled with the var_t type 
(tcontext=system_u:object_r:var_t:s0). With such a denial logged, 
running audit2allow with the -w option produces a human-readable 
description of why access was denied. The audit2allow tool accesses 
/var/log/audit/audit.log, and as such, must be run as the Linux root user:

# audit2allow -w -a
type=AVC msg=audit(1226270358.848:238): avc:  denied  { write } for 
pid=13349 comm="certwatch" name="cache" dev=dm-0 ino=218171 
scontext=system_u:system_r:certwatch_t:s0 
tcontext=system_u:object_r:var_t:s0 tclass=dir
	Was caused by:
		Missing type enforcement (TE) allow rule.

	You can use audit2allow to generate a loadable module to allow this access.

As shown, access was denied due to a missing Type Enforcement rule. Run 
the audit2allow -a command to view the Type Enforcement rule that allows 
the denied access:

# audit2allow -a


#============= certwatch_t ==============
allow certwatch_t var_t:dir write;

To use this rule, run the audit2allow -a -M mycertwatch command as the 
Linux root user to create custom module. The -M option creates a Type 
Enforcement file (.te) with the name specified with -M, in your current 
working directory:

# audit2allow -a -M mycertwatch

******************** IMPORTANT ***********************
To make this policy package active, execute:

semodule -i mycertwatch.pp

# ls
mycertwatch.pp  mycertwatch.te

Also, audit2allow compiles the Type Enforcement rule into a policy 
package (.pp). To install the module, run the /usr/sbin/semodule -i 
mycertwatch.pp command as the Linux root user.

If you have multiple denials from multiple processes, but only want to 
create a custom policy for a single process, use the grep command to 
narrow down the input for audit2allow. The following example 
demonstrates using grep to only send denials related to certwatch 
through audit2allow:

# grep certwatch /var/log/audit/audit.log | audit2allow -M mycertwatch2
******************** IMPORTANT ***********************
To make this policy package active, execute:

semodule -i mycertwatch2.pp

Refer to Dan Walsh's "Using audit2allow to build policy modules. 
Revisited."[2] blog entry for further information about using 
audit2allow to build policy modules.

<important>
Modules created with audit2allow may allow more access than required. It 
is recommended that policy created with audit2allow be posted to an 
SELinux list, such as fedora-selinux-list, for review. If you believe 
their is a bug in policy, create a bug in Red Hat Bugzilla.
</important>

Thanks.


[1] From the audit2allow(1) manual page, as shipped with the 
policycoreutils package in Fedora 10.

[2] <http://danwalsh.livejournal.com/24750.html>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
