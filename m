Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2TGoXDo006665
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 11:50:33 -0500 (EST)
Received: from mail.mvalent.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2TGnXcn026019
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 16:49:33 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: setools-1.5.1
Date: Tue, 29 Mar 2005 11:49:33 -0500
Message-ID: <E6E16A6D4277CD459BBDE6713766033CFB7E64@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I tried updating my machine to setools-1.5.1 and it failed.
I had switch permissive mode and did emerge setools.
Here is my output:

make[1]: Leaving directory
`/var/tmp/portage/setools-1.5.1/work/setools-1.5.1/libseaudit'
cd libsefs; make libsefs libsefsso
env: tclsh: No such file or directory
env: tclsh: No such file or directory
make[1]: Entering directory
`/var/tmp/portage/setools-1.5.1/work/setools-1.5.1/libsefs'
gcc  -Wall -O2 -mcpu=i686 -fomit-frame-pointer -fforce-addr -fPIC
-DLIBSELINUX -I. -I../libapol -c fsdata.c
ar cr libsefs.a fsdata.o 
gcc   -shared -o libsefs.so.1.1 fsdata.o -Wl,-soname,libsefs.so.1 
make[1]: Leaving directory
`/var/tmp/portage/setools-1.5.1/work/setools-1.5.1/libsefs'
cd seuser; make seuser 
env: tclsh: No such file or directory
env: tclsh: No such file or directory
make[1]: Entering directory
`/var/tmp/portage/setools-1.5.1/work/setools-1.5.1/seuser'
gcc  -Wall -O2 -mcpu=i686 -fomit-frame-pointer -fforce-addr -fPIC
-DLIBSELINUX -DSEUSERCMD_VERSION_STRING='"1.3"' -c seuser_cmd.c
gcc  -o seuser seuser_cmd.o ../libseuser/libseuser.a
../libapol/libapol.a  -lfl -lm -lselinux
seuser_cmd.o(.text+0xdcb): In function `main':
: warning: the use of `tempnam' is dangerous, better use `mkstemp'
../libseuser/libseuser.a(seuser_db.o)(.text+0x196f): In function
`seuser_read_conf_info':
: undefined reference to `selinux_policy_root'
../libseuser/libseuser.a(seuser_db.o)(.text+0x19c9): In function
`seuser_read_conf_info':
: undefined reference to `selinux_policy_root'
../libseuser/libseuser.a(seuser_db.o)(.text+0x1a1f): In function
`seuser_read_conf_info':
: undefined reference to `selinux_policy_root'
../libseuser/libseuser.a(seuser_db.o)(.text+0x1a46): In function
`seuser_read_conf_info':
: undefined reference to `selinux_file_context_path'
../libapol/libapol.a(policy-io.o)(.text+0x85b): In function
`search_binary_policy_file':
: undefined reference to `selinux_binary_policy_path'
../libapol/libapol.a(policy-io.o)(.text+0x8c9): In function
`search_binary_policy_file':
: undefined reference to `selinux_binary_policy_path'
../libapol/libapol.a(policy-io.o)(.text+0xa0f): In function
`search_binary_policy_file':
: undefined reference to `selinux_binary_policy_path'
../libapol/libapol.a(policy-io.o)(.text+0xaf8): In function
`search_policy_src_file':
: undefined reference to `selinux_policy_root'
collect2: ld returned 1 exit status
make[1]: *** [seuser] Error 1
make[1]: Leaving directory
`/var/tmp/portage/setools-1.5.1/work/setools-1.5.1/seuser'
make: *** [seuser] Error 2
 
!!! ERROR: app-admin/setools-1.5.1 failed.
!!! Function src_compile, Line 66, Exitcode 2
!!! command line tools compile failed
!!! If you need support, post the topmost build error, NOT this status
message.
 
ftp root #

Thanks,
James



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
