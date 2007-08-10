Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AAA4B8020826
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 06:10:04 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7AAA37C026636
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 10:10:03 GMT
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 Aug 2007 12:10:03 +0200
From: selinux770@tortenboxer.de
Message-ID: <20070810101003.128080@gmx.net>
MIME-Version: 1.0
Subject: wrong magic number (using old sources)
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi everyone,

i try to integrate SELinux into my Nokia 770 Internet Tablet. For this I'm using some old sources which fit best to the architecture (no compile errors or missing components). My current state is, that everything seems to work fine. "sestatus" tells me selinux is enabled.

But my problem is to compile a policy without error messages. It tells me, that loading fails because of a wrong magic number and I don't know where this error comes from. http://www.nsa.gov/selinux/list-archive/0206/2155.cfm tells me that it "Looks like your kernel doesn't have the same policy version as the database." I recompiled the kernel after making and make install the libraries... so I don't understand my error. A full log of the error is provided at the end of my mail.

What can be responsible for a wrong magic number? The python wrapper classes? The libraries? The policy source files i try to compile?

Thanks in advance for any help.

I'm using the following versions from the debian servers (original source packages, debian changes not included):
 Apr 10  2006 checkpolicy_1.30.orig.tar.gz
 Mar 23  2006 libselinux_1.30.orig.tar.gz
 Apr 10  2006 libsemanage_1.6.orig.tar.gz
 Mar 22  2006 libsepol_1.12.orig.tar.gz
 Apr 10  2006 policycoreutils_1.30.orig.tar.gz

Don't fit these versions?

The error log:
/usr/share/selinux/policy/beta1.0# make load
Makefile:154: warning: overriding commands for target
`/etc/selinux/./policy/policy.20'
Makefile:149: warning: ignoring old commands for target
`/etc/selinux/./policy/policy.20'
( cd domains/program/ ; for n in *.te ; do echo "define(\`$n')"; done
) > tmp/program_used_flags.te.tmp
( cd domains/misc/ ; for n in *.te ; do echo "define(\`$n')"; done )
>> tmp/program_used_flags.te.tmp
mv tmp/program_used_flags.te.tmp tmp/program_used_flags.te
Building policy.conf ...
m4  -Imacros -s flask/security_classes [... shortened by me ...]
 > policy.conf.tmp
Compiling policy ...
/usr/bin/checkpolicy  -o /etc/selinux/./policy/policy.20 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 20) to
/etc/selinux/./policy/policy.20
Loading Policy ...
/usr/sbin/load_policy /etc/selinux/./policy/policy.20
/usr/sbin/load_policy:  Warning!  Policy file argument
(/etc/selinux/./policy/policy.20) is no longer supported, installed
policy is always loaded.  Continuing...
libsepol.policydb_read: policydb magic number 0x8c007cff does not
match expected magic number 0xf97cff8c or 0xf97cff8d
libsepol.policydb_from_image: policy image is invalid
libsepol.policydb_read: policydb magic number 0x8c8c7cff does not
match expected magic number 0xf97cff8c or 0xf97cff8d
libsepol.policydb_from_image: policy image is invalid
touch tmp/load
Building file contexts files...
Validating file contexts files ...
/usr/sbin/setfiles -q -c /etc/selinux/./policy/policy.20
file_contexts/file_contexts
libsepol.policydb_read: policydb magic number 0x8c007cff does not
match expected magic number 0xf97cff8c or 0xf97cff8d
libsepol.sepol_set_policydb_from_file: can't read binary policy: Success
Error reading policy /etc/selinux/./policy/policy.20: Success
make: *** [tmp/valid_fc] Error 1

-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
