Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HF5OWt009798
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 11:05:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9HF5MmR019415
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:05:22 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9HF5Ljp019408 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:05:21 GMT
Subject: Re: Symlinks with wrong context after copy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <20031017141701.GA2002@suse.de>
References: <20031017133207.GA5665@suse.de>
	 <1066399798.31764.132.camel@moss-spartans.epoch.ncsc.mil>
	 <20031017141701.GA2002@suse.de>
Content-Type: text/plain
Message-Id: <1066403110.31764.190.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 17 Oct 2003 11:05:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-17 at 10:17, Thorsten Kukuk wrote:
> I tried the SELinux coreutils patch on our own coreutils and the
> RH binaries.

# rpm -q coreutils
coreutils-5.0-27.sel
# ls -Z /lib/ld*
-rwxr-xr-x  root     root     system_u:object_r:ld_so_t        /lib/ld-2.3.2.so
lrwxrwxrwx  root     root     system_u:object_r:lib_t          /lib/ld-linux.so.2 -> ld-2.3.2.so
# cp -dp /lib/ld* .
# ls -Z ld*
-rwxr-xr-x  root     root     sds:object_r:sysadm_home_dir_t   ld-2.3.2.so
lrwxr-xr-x  root     root     sds:object_r:sysadm_home_dir_t   ld-linux.so.2 ->
ld-2.3.2.so
# rm -f ld*
# cp -dpc /lib/ld* .
# ls -Z ld*
-rwxr-xr-x  root     root     system_u:object_r:ld_so_t        ld-2.3.2.so
lrwxr-xr-x  root     root     system_u:object_r:lib_t          ld-linux.so.2 ->
ld-2.3.2.so

Things to note:
1) I changed the type on the symlink via chcon -h before starting so
that we can clearly see whether the context is being preserved from the
symlink itself or if the symlink is being followed.
2) cp -dp does not preserve the security context on either file, as
expected; instead, the files end up in the default type, inheriting from
the parent directory.  Note that the EA-patched coreutils might give a
different behavior; I don't know myself.
3) cp -dpc preserves the context on both files, as expected.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
