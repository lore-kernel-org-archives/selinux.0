Subject: Re: NFSv4.2 unlabeled_t on mountpoints
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <20160915071522.GA6893@meriadoc.perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <18456a4e-604b-79f9-d662-646332e37aae@tycho.nsa.gov>
Date: Thu, 15 Sep 2016 10:09:21 -0400
MIME-Version: 1.0
In-Reply-To: <20160915071522.GA6893@meriadoc.perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/15/2016 03:15 AM, Jason Zaman wrote:
> Hi All,
> 
> I have kerberized NFSv4 between my laptop and server and when I use
> vers=4.2 I cannot access the mount. It looks like the fcontext needs to
> be invalidated or re-checked or something but I'm not familiar with
> kernel internals so not sure how to fix it (If someone can point me to
> the place, I'd love to get my hands dirty).
> 
> Steps to repro:
> kinit works fine
> mount /home/jason/bregalad works fine, the fstab line is:
> bregalad.perfinion.com:/jason /home/jason/bregalad nfs4 noauto,users,vers=4.2,sec=krb5p,rw,intr,soft,timeo=100,_netdev,fsc 0 0
> 
> Once mounted as my normal user:
> $ ls -aldZ /home/jason/bregalad
> ls: cannot access /home/jason/bregalad: Permission denied
> 
> I get the following denial:
> type=AVC msg=audit(1473923050.591:1577): avc:  denied  { getattr } for  pid=7630 comm="ls" path="/home/jason/bregalad" dev="0:55" ino=4 scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0
> type=SYSCALL msg=audit(1473923050.591:1577): arch=c000003e syscall=6 success=no exit=-13 a0=399b2bc22f2 a1=7a03d6e960 a2=7a03d6e960 a3=7a02aa8d7b items=1 ppid=6440 pid=7630 auid=1000 uid=1000 gid=100 euid=1000 suid=1000 fsuid=1000 egid=100 sgid=100 fsgid=100 tty=pts3 ses=5 comm="ls" exe="/bin/ls" subj=staff_u:staff_r:staff_t:s0-s0:c0.c1023 key=(null)
> type=CWD msg=audit(1473923050.591:1577):  cwd="/home/jason"
> type=PATH msg=audit(1473923050.591:1577): item=0 name="/home/jason/bregalad" inode=4 dev=00:37 mode=040711 ouid=1000 ogid=100 rdev=00:00 obj=system_u:object_r:unlabeled_t:s0 nametype=NORMAL
> type=PROCTITLE msg=audit(1473923050.591:1577): proctitle=6C73002D46002D2D636F6C6F723D6175746F002D616C645A002F686F6D652F6A61736F6E2F62726567616C6164
> 
> If I ls with sysadm_t (which has permissions for unlabeled_t) then the
> fcontext swaps to what it should be and everything works after that as
> staff_t too. I have not had issues with other dirs/files inside the NFS
> mount, only the mountpoint has this issue. 
> 
> As root / sysadm_t: # ls -aldZ /home/jason/bregalad
> drwx--x--x. 50 jason users staff_u:object_r:user_home_dir_t:s0 84 Sep 13 22:38 /home/jason/bregalad/
> As jason / staff_t: $ ls -aldZ /home/jason/bregalad
> drwx--x--x. 50 jason users staff_u:object_r:user_home_dir_t:s0 84 Sep 13 22:38 /home/jason/bregalad/
> 
> $ uname -a
> Linux meriadoc 4.7.2-hardened-r1 #1 SMP PREEMPT Sat Sep 3 11:27:29 SGT 2016 x86_64 Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz GenuineIntel GNU/Linux
> I'm on gentoo hardened but dont think GRSec is responsible here. I also had the same problem back on 4.4.
> 
> Is there anything else that can help track this down?
> -- Jason

Maybe we need to add a call to security_inode_invalidate_secctx() in the
nfs code to invalidate the label on the mountpoint directory and force
SELinux to re-fetch it upon the next use?  Presently only gfs2 has been
updated to use that hook.  Technically, NFS should be using it whenever
the cached information may be invalid (e.g. label change on the server
from another client).
