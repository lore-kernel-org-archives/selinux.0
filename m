Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA23954
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 15:55:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA13012
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 20:53:23 GMT
Received: from pandora.snu.edu ([204.126.2.1])
        by jazzband.ncsc.mil  with SMTP id UAA13005 for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 20:53:22 GMT
Message-Id: <sddba22a.030@atlas.snu.edu>
Date: Wed, 20 Nov 2002 14:54:18 -0600
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <russell@coker.com.au>, <bam@snoopy.apana.org.au>, <selinux@tycho.nsa.gov>,
        <jabiru_croc@yahoo.com>
Subject: Re: SELinux distro building
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

much closer
i used --with-lsm=/usr/src/linux-2.4.19-selinux because it was looking
in ../../.. for lsm-2.4, instead of just ../ (i dunno)
anyway, it compiled almost everything then i got this error
(if you prefer i can pipe the entire compile to a file and attach..
Thanks


rm -f libsecure.a
ar cru libsecure.a accept_secure.o avc_enforcing.o avc_toggle.o chsid.o
chsidfs.o connect_secure.o context.o execle_secure.o execlp_secure.o
execl_secure.o execve_secure.o execvp_secure.o execv_secure.o fchsid.o
fchsidfs.o fstatfs_secure.o fstat_secure.o get_default_type.o
getosecsid.o getpeername_secure.o getsecsid.o get_sid_list.o
getsockname_secure.o get_user_sid.o helpers.o ichsid.o lchsid.o
listen_secure.o lstat_secure.o mkdir_secure.o mknod_secure.o
msgget_secure.o msgrcv_secure.o msgsid.o msgsnd_secure.o open_secure.o
popen_secure.o query_user_sid.o recvfrom_secure.o recvmsg_secure.o
security.o security_change_sid.o security_compute_av.o
security_context_to_sid.o security_get_sids.o security_get_user_sids.o
security_load_policy.o security_member_sid.o security_mls.o
security_notify_perm.o security_sid_to_context.o
security_transition_sid.o semget_secure.o semsid.o sendmsg_secure.o
sendto_secure.o shmget_secure.o shmsid.o socket_secure.o statfs_secure.o
stat_secure.o symlink_secure.o 
ranlib libsecure.a
make[3]: Leaving directory
`/root/selinux-new/selinux-small-2002102211/libsecure/src'
Making all in test
make[3]: Entering directory
`/root/selinux-new/selinux-small-2002102211/libsecure/test'
gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../libsecure/include  -Wall 
-g -O2 -c avc_enforcing.c
avc_enforcing.c: In function `main':
avc_enforcing.c:8: warning: implicit declaration of function `printf'
avc_enforcing.c:12: warning: implicit declaration of function
`avc_enforcing'
avc_enforcing.c:21: warning: implicit declaration of function `perror'
/bin/sh ../../libtool --mode=link gcc  -g -O2  -o avc_enforcing 
avc_enforcing.o  ../../libsecure/src/libsecure.a 
mkdir .libs
gcc -g -O2 -o avc_enforcing avc_enforcing.o 
../../libsecure/src/libsecure.a
gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../libsecure/include  -Wall 
-g -O2 -c avc_toggle.c
avc_toggle.c: In function `main':
avc_toggle.c:8: warning: implicit declaration of function `printf'
avc_toggle.c:12: warning: implicit declaration of function
`avc_toggle'
avc_toggle.c:21: warning: implicit declaration of function `perror'
/bin/sh ../../libtool --mode=link gcc  -g -O2  -o avc_toggle 
avc_toggle.o  ../../libsecure/src/libsecure.a 
gcc -g -O2 -o avc_toggle avc_toggle.o  ../../libsecure/src/libsecure.a
gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../../libsecure/include  -Wall 
-g -O2 -c chsid.c
In file included from chsid.c:1:
../../libsecure/include/fs_secure.h:9:31: linux/flask/flask.h: No such
file or directory
In file included from chsid.c:1:
../../libsecure/include/fs_secure.h:14: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:18: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:23: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:27: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:30: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:34: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:37: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:40: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:43: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:47: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:53: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:56: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:59: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:90: parse error before
"security_id_t"
../../libsecure/include/fs_secure.h:94: parse error before
"security_id_t"
In file included from chsid.c:2:
../../libsecure/include/ss.h:4:34: linux/flask/syscalls.h: No such file
or directory
../../libsecure/include/ss.h:5:31: linux/flask/flask.h: No such file or
directory
In file included from chsid.c:2:
../../libsecure/include/ss.h:16: warning: `struct security_response'
declared inside parameter list
../../libsecure/include/ss.h:16: warning: its scope is only this
definition or declaration, which is probably not what you want
../../libsecure/include/ss.h:16: warning: `struct security_query'
declared inside parameter list
../../libsecure/include/ss.h:18: parse error before "ssid"
../../libsecure/include/ss.h:23: parse error before "ssid"
../../libsecure/include/ss.h:28: parse error before "ssid"
../../libsecure/include/ss.h:33: parse error before "ssid"
../../libsecure/include/ss.h:38: parse error before "sid"
../../libsecure/include/ss.h:42: warning: type defaults to `int' in
declaration of `security_context_t'
../../libsecure/include/ss.h:42: parse error before "scontext"
../../libsecure/include/ss.h:47: parse error before "__u32"
../../libsecure/include/ss.h:49: parse error before '*' token
../../libsecure/include/ss.h:52: parse error before "fromsid"
../../libsecure/include/ss.h:64: parse error before
"string_to_security_class"
../../libsecure/include/ss.h:64: warning: type defaults to `int' in
declaration of `string_to_security_class'
../../libsecure/include/ss.h:64: warning: data definition has no type
or storage class
../../libsecure/include/ss.h:66: parse error before "tclass"
chsid.c: In function `main':
chsid.c:7: `security_id_t' undeclared (first use in this function)
chsid.c:7: (Each undeclared identifier is reported only once
chsid.c:7: for each function it appears in.)
chsid.c:7: parse error before "sid"
chsid.c:11: warning: implicit declaration of function `printf'
chsid.c:15: `sid' undeclared (first use in this function)
chsid.c:17: warning: implicit declaration of function `strlen'
chsid.c:20: warning: implicit declaration of function `perror'
make[3]: *** [chsid.o] Error 1
make[3]: Leaving directory
`/root/selinux-new/selinux-small-2002102211/libsecure/test'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory
`/root/selinux-new/selinux-small-2002102211/libsecure'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory
`/root/selinux-new/selinux-small-2002102211'
make: *** [all-recursive-am] Error 2

>>> Brian May <bam@snoopy.apana.org.au> 11/19/02 07:37PM >>>
On Wed, Nov 13, 2002 at 07:29:03PM +1100, Brian May wrote:

I have updated this file:

>
<URL:http://www.microcomaustralia.com.au/debian/selinux-small-2002102211.tar.gz>

It should now be able to include the LSM include files correctly.

Also, the configure script will now do a simple check to ensure that
the
LSM directory given is correct.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing
list.
If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
