Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBULx5G8024950
	for <selinux@tycho.nsa.gov>; Wed, 30 Dec 2009 16:59:05 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id nBUM1bQx001086
	for <selinux@tycho.nsa.gov>; Wed, 30 Dec 2009 22:01:37 GMT
Date: Wed, 30 Dec 2009 16:59:03 -0500
Subject: Re: newrole: double free or corruption
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C7613757.B1597%csellers@tresys.com>
In-Reply-To: <4B3B5F71.8000108@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/30/09 9:10 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
> 
> -------- Original Message --------
> Subject: newrole: double free or corruption
> Date: Mon, 28 Dec 2009 18:29:02 -0500
> From: Andy Warner <warner@rubix.com>
> To: fedora-selinux-list@redhat.com
> 
> Got the following output from using the newrole command on Fedora 12.
> Not sure where to properly report such bugs.
> 
> If it helps, the rubix_remote_client_r role transition should fail (as
> it does) as there are no role transition rules for it. The role is
> associated with the current SELinux user.
> 
> I believe my system just updated to the newest newrole package.
> [warner@Fedora12-Dev ~]$ yum info policycoreutils
> Loaded plugins: presto, refresh-packagekit
> Installed Packages
> Name       : policycoreutils
> Arch       : i686
> Version    : 2.0.78
> Release    : 3.fc12
> Size       : 3.3 M
> Repo       : installed
>> From repo  : updates
> 
> Error output from newrole follows:
> 
> [warner@Fedora12-Dev ~]$ newrole -r rubix_remote_client_r
> Password:
> failed to exec shell
> : Permission denied
> *** glibc detected *** newrole: double free or corruption (out):
> 0x01726138 ***
> ======= Backtrace: =========
> /lib/libc.so.6(-0xff836d9f)[0x233261]
> /lib/libselinux.so.1(freecon+0x1e)[0x9fd42e]
> newrole(main+0x6eb)[0x119d6b]
> /lib/libc.so.6(__libc_start_main+0xe6)[0x1dbbb6]
> newrole(+0x16f1)[0x1186f1]
> ======= Memory map: ========
> 00117000-0011d000 r-xp 00000000 fd:00 126525     /usr/bin/newrole
> 0011d000-0011e000 r--p 00005000 fd:00 126525     /usr/bin/newrole
> 0011e000-0011f000 rw-p 00006000 fd:00 126525     /usr/bin/newrole
> 0011f000-00135000 r-xp 00000000 fd:00 56679      /lib/libpthread-2.11.so
> 00135000-00136000 r--p 00015000 fd:00 56679      /lib/libpthread-2.11.so
> 00136000-00137000 rw-p 00016000 fd:00 56679      /lib/libpthread-2.11.so
> 00137000-00139000 rw-p 00000000 00:00 0
> 001a5000-001c3000 r-xp 00000000 fd:00 56677      /lib/ld-2.11.so
> 001c3000-001c4000 r--p 0001d000 fd:00 56677      /lib/ld-2.11.so
> 001c4000-001c5000 rw-p 0001e000 fd:00 56677      /lib/ld-2.11.so
> 001c5000-00333000 r-xp 00000000 fd:00 56678      /lib/libc-2.11.so
> 00333000-00334000 ---p 0016e000 fd:00 56678      /lib/libc-2.11.so
> 00334000-00336000 r--p 0016e000 fd:00 56678      /lib/libc-2.11.so
> 00336000-00337000 rw-p 00170000 fd:00 56678      /lib/libc-2.11.so
> 00337000-0033a000 rw-p 00000000 00:00 0
> 0055f000-00560000 r-xp 00000000 00:00 0          [vdso]
> 005f6000-005fa000 r-xp 00000000 fd:00 1331       /lib/libattr.so.1.1.0
> 005fa000-005fb000 rw-p 00003000 fd:00 1331       /lib/libattr.so.1.1.0
> 0062d000-00638000 r-xp 00000000 fd:00 10441      /lib/libnss_files-2.11.so
> 00638000-00639000 r--p 0000a000 fd:00 10441      /lib/libnss_files-2.11.so
> 00639000-0063a000 rw-p 0000b000 fd:00 10441      /lib/libnss_files-2.11.so
> 008a3000-008a5000 r-xp 00000000 fd:00 15448      /lib/libpam_misc.so.0.82.0
> 008a5000-008a6000 rw-p 00001000 fd:00 15448      /lib/libpam_misc.so.0.82.0
> 00928000-0092c000 r-xp 00000000 fd:00 1332       /lib/libcap.so.2.16
> 0092c000-0092d000 rw-p 00003000 fd:00 1332       /lib/libcap.so.2.16
> 00992000-00995000 r-xp 00000000 fd:00 56684      /lib/libdl-2.11.so
> 00995000-00996000 r--p 00002000 fd:00 56684      /lib/libdl-2.11.so
> 00996000-00997000 rw-p 00003000 fd:00 56684      /lib/libdl-2.11.so
> 009f3000-00a0f000 r-xp 00000000 fd:00 56687      /lib/libselinux.so.1
> 00a0f000-00a10000 r--p 0001b000 fd:00 56687      /lib/libselinux.so.1
> 00a10000-00a11000 rw-p 0001c000 fd:00 56687      /lib/libselinux.so.1
> 00c8b000-00c97000 r-xp 00000000 fd:00 15447      /lib/libpam.so.0.82.1
> 00c97000-00c98000 rw-p 0000b000 fd:00 15447      /lib/libpam.so.0.82.1
> 00e6f000-00e85000 r-xp 00000000 fd:00 15446      /lib/libaudit.so.1.0.0
> 00e85000-00e86000 r--p 00015000 fd:00 15446      /lib/libaudit.so.1.0.0
> 00e86000-00e87000 rw-p 00016000 fd:00 15446      /lib/libaudit.so.1.0.0
> 00ea9000-00ec6000 r-xp 00000000 fd:00 51325
> /lib/libgcc_s-4.4.2-20091027.so.1
> 00ec6000-00ec7000 rw-p 0001c000 fd:00 51325
> /lib/libgcc_s-4.4.2-20091027.so.1
> 00f05000-00f0c000 r-xp 00000000 fd:00 56680      /lib/librt-2.11.so
> 00f0c000-00f0d000 r--p 00006000 fd:00 56680      /lib/librt-2.11.so
> 00f0d000-00f0e000 rw-p 00007000 fd:00 56680      /lib/librt-2.11.so
> 01724000-017a9000 rw-p 00000000 00:00 0          [heap]
> b7627000-b7827000 r--p 00000000 fd:00 12545
> /usr/lib/locale/locale-archive
> b7827000-b782a000 rw-p 00000000 00:00 0
> b783b000-b7842000 r--s 00000000 fd:00 10739
> /usr/lib/gconv/gconv-modules.cache
> b7842000-b7843000 rw-p 00000000 00:00 0
> bfcce000-bfce3000 rw-p 00000000 00:00 0          [stack]
> [warner@Fedora12-Dev ~]$
> 
> 
Double free indeed. We free both old_context and new_context when we're done
with them and then again in the cleanup code. I think we can drop the first
freecon set and just free in cleanup:

diff --git a/policycoreutils/newrole/newrole.c
b/policycoreutils/newrole/newrole.c
index 03982c3..d191be6 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1338,8 +1338,6 @@ int main(int argc, char *argv[])
     if (transition_to_caller_uid())
         goto err_close_pam_session;
 #endif
-    freecon(old_context);
-    freecon(new_context);
 
     /* Handle environment changes */
     if (restore_environment(preserve_environment, old_environ, &pw)) {

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
