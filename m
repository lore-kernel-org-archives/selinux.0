Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0HLH3Rb015449
	for <selinux@tycho.nsa.gov>; Sat, 17 Jan 2004 16:17:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0HLFsxr015240
	for <selinux@tycho.nsa.gov>; Sat, 17 Jan 2004 21:15:54 GMT
Received: from mutemail.com ([24.244.170.124])
	by jazzswing.ncsc.mil  with SMTP id i0HLFcYc015234
	for <selinux@tycho.nsa.gov>; Sat, 17 Jan 2004 21:15:53 GMT
Date: Sat, 17 Jan 2004 13:14:22 -0800
From: Bill McCarty <bmccarty@pt-net.net>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: RHEL 3 policy and policy-sources RPMs
Message-ID: <222304176.1074345262@[192.168.0.100]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

(1) I'm setting up another SELinux host on RHEL3, in addition to the one I 
successfully set up a few days back. I downloaded RPMs from 
people.redhat.com, but find that prelink.te and several other TE files 
(rpm.te, slocate.te) have syntax errors that prevent me from successfully 
making the policy. For instance:

ERROR 'syntax error' at token '-' on line 102125:


> allow prelink_t {root_dir_type file_type -shadow_t} :{ file dir lnk_file
> } { getattr read}; /usr/bin/checkpolicy:  error(s) encountered while
> parsing configuration

It appears that an unwanted dash has been introduced. Unfortunately, after 
deleting the offending dashes, I ran into other problems:

> security:  3 users, 5 roles, 1066 types
> security:  30 classes, 134765 rules
> assertion on line 130825 violated by allow rpm_t shadow_t:file {
> relabelfrom relabelto }; assertion on line 130824 violated by allow
> prelink_t shadow_t:file { read }; assertion on line 130824 violated by
> allow rpm_t shadow_t:file { relabelfrom relabelto }; assertion on line
> 130824 violated by allow locate_t shadow_t:file { read }; make: ***
> [/etc/security/selinux/policy.15] Error 1

As a temporary expedient, I changed the relevant lines of assert.te to:

neverallow ~{ auth auth_write } shadow_t:file ~{ getattr read relabelfrom 
relabelto };
neverallow ~auth_write shadow_t:file ~{ read getattr lock ioctl relabelfrom 
relabelto};

After these changes, the policy compiles. I don't yet know how well it 
works.

Obviously, I understand that this policy is under active development and I 
don't want to seem to whine about such problems. But, are there better or 
worse times for users to work with it <g>? If so, I'd like to get in sync.

(2) Also, I'm curious why some policy source files are found in both the 
policy and policy-sources RPMs.

Thanks, in any case, to Daniel and other who're working on this policy!

Cheers,

---------------------------------------------------
Bill McCarty

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
