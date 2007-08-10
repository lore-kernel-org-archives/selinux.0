Subject: Re: wrong magic number (using old sources)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070810101003.128080@gmx.net>
References: <20070810101003.128080@gmx.net>
Content-Type: text/plain
Date: Fri, 10 Aug 2007 07:45:38 -0400
Message-Id: <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-10 at 12:10 +0200, selinux770@tortenboxer.de wrote:
> Hi everyone,
> 
> i try to integrate SELinux into my Nokia 770 Internet Tablet. For this
> I'm using some old sources which fit best to the architecture (no
> compile errors or missing components). My current state is, that
> everything seems to work fine. "sestatus" tells me selinux is enabled.

You should be able to use the latest selinux userland even if using an
older kernel; newer userlands can still generate older kernel policy
formats.

> But my problem is to compile a policy without error messages. It tells
> me, that loading fails because of a wrong magic number and I don't
> know where this error comes from.
> http://www.nsa.gov/selinux/list-archive/0206/2155.cfm tells me that it
> "Looks like your kernel doesn't have the same policy version as the
> database." I recompiled the kernel after making and make install the
> libraries... so I don't understand my error. A full log of the error
> is provided at the end of my mail.

Looks like the policy image is corrupted not just inconsistent with
kernel.

> What can be responsible for a wrong magic number? The python wrapper classes? The libraries? The policy source files i try to compile?
> 
> Thanks in advance for any help.
> 
> I'm using the following versions from the debian servers (original source packages, debian changes not included):
>  Apr 10  2006 checkpolicy_1.30.orig.tar.gz
>  Mar 23  2006 libselinux_1.30.orig.tar.gz
>  Apr 10  2006 libsemanage_1.6.orig.tar.gz
>  Mar 22  2006 libsepol_1.12.orig.tar.gz
>  Apr 10  2006 policycoreutils_1.30.orig.tar.gz
> 
> Don't fit these versions?

Those versions are consistent with one another.
Kernel version?  Policy version?

> 
> The error log:
> /usr/share/selinux/policy/beta1.0# make load
> Makefile:154: warning: overriding commands for target
> `/etc/selinux/./policy/policy.20'
> Makefile:149: warning: ignoring old commands for target
> `/etc/selinux/./policy/policy.20'
> ( cd domains/program/ ; for n in *.te ; do echo "define(\`$n')"; done
> ) > tmp/program_used_flags.te.tmp
> ( cd domains/misc/ ; for n in *.te ; do echo "define(\`$n')"; done )
> >> tmp/program_used_flags.te.tmp
> mv tmp/program_used_flags.te.tmp tmp/program_used_flags.te
> Building policy.conf ...
> m4  -Imacros -s flask/security_classes [... shortened by me ...]
>  > policy.conf.tmp
> Compiling policy ...
> /usr/bin/checkpolicy  -o /etc/selinux/./policy/policy.20 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 20) to
> /etc/selinux/./policy/policy.20
> Loading Policy ...
> /usr/sbin/load_policy /etc/selinux/./policy/policy.20
> /usr/sbin/load_policy:  Warning!  Policy file argument
> (/etc/selinux/./policy/policy.20) is no longer supported, installed
> policy is always loaded.  Continuing...
> libsepol.policydb_read: policydb magic number 0x8c007cff does not
> match expected magic number 0xf97cff8c or 0xf97cff8d
> libsepol.policydb_from_image: policy image is invalid
> libsepol.policydb_read: policydb magic number 0x8c8c7cff does not
> match expected magic number 0xf97cff8c or 0xf97cff8d
> libsepol.policydb_from_image: policy image is invalid
> touch tmp/load
> Building file contexts files...
> Validating file contexts files ...
> /usr/sbin/setfiles -q -c /etc/selinux/./policy/policy.20
> file_contexts/file_contexts
> libsepol.policydb_read: policydb magic number 0x8c007cff does not
> match expected magic number 0xf97cff8c or 0xf97cff8d
> libsepol.sepol_set_policydb_from_file: can't read binary policy: Success
> Error reading policy /etc/selinux/./policy/policy.20: Success
> make: *** [tmp/valid_fc] Error 1
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
