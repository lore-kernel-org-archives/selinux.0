Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA10758
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 14:40:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA01887
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 18:39:46 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id SAA01875
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 18:39:40 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA22132
	for <selinux@tycho.nsa.gov>; Wed, 25 Jul 2001 14:40:31 -0400 (EDT)
Message-ID: <DBF2F9C6F6BAD211BB1B00A0C99D97024D5BB2@dns-205.dhcp-77.nai.com>
From: "Smalley, Stephen" <Stephen_Smalley@nai.com>
To: "'Eric Peters'" <eric@peters.org>, SELinux@tycho.nsa.gov
Subject: RE: verbose make relabel/RedHat 7.1 install
Date: Tue, 24 Jul 2001 20:31:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


With the current SELinux release on RH7.1, I would suggest starting with a
development kernel
(CONFIG_FLASK_DEVELOP) in permissive mode (not toggled into enforcing mode
via avc_toggle),
because the example policy configuration in that release is based on
RH6.1/6.2.  Actually,
I would recommend starting with a development kernel in permissive mode in
general, because the particulars
of your system may require customization of the policy before transitioning
to an operational
kernel.  Naturally, if you are in permissive mode, you'll be able to perform
this relabel despite the
access denial.

The fix to the policy configuration in this case could take either of two
forms:  authorize
the transition (i.e. add an 'allow sbin_t fsadm_exec_t:file transition;'
rule to the policy
configuration) or eliminate the ambiguity from file_contexts (i.e. add an
explicit rule for
/sbin/fsck.ext2 to system_u:object_r:fsadm_exec_t).  However, you'll
encounter other policy
and file_contexts issues in RH7.1.  

With our new LSM-based SELinux prototype, we've adjusted the policy and
file_contexts configurations
for RH7.1.  That new LSM-based SELinux prototype should be available soon on
the NSA web site. 

-----Original Message-----
From: Eric Peters [mailto:eric@peters.org]
Sent: Tuesday, July 24, 2001 7:47 PM
To: SELinux@tycho.nsa.gov
Subject: verbose make relabel/RedHat 7.1 install


So I'm using RedHat 7.1 - fresh system install and after I
tools/build-kernel tools/build-apps, install-kernel and install-apps, get
lilo setup n crap I login and I get the option to get in via sysadm_r and
sysadm_t so I do that then cd /usr/local/build/slinux/policy, and wallah:
 
# make relabel
[ .... ]
./setfiles:    labeling files under /
./setfiles:    conflicting specifications for /sbin/e2fsck and
/sbin/fsck.ext3, using system_u:object_r:fsadm_exec_t
avc: denied { transition } for pid = 728
exe=/usr/local/build/slinux/policy/setfiles path=/sbin/e2fsck dev=03:01
ino=109997
    scontext=system_u:object_r:sbin_t
    tcontext=system_u:object_r:fsadm_exec_t
    tclass=file
./setfiles:    unable to relable /sbin/e2fsck to
system_u:object_r:fsadm_exec_t
make: *** [relabel] Error 1
#
 
 
I havn't touched the file_context file or pretty much anything other than
the three files in /www/security/ and the one users file
 
Any suggestions?
 
Thanks
 
Eric


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
