Message-ID: <4E8C8137.20208@redhat.com>
Date: Wed, 05 Oct 2011 12:09:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: I am trying an experiment of making allow_ptrace boolean actually
 do something useful.
References: <4E8C7DCA.3020003@redhat.com>
In-Reply-To: <4E8C7DCA.3020003@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/05/2011 11:54 AM, Daniel J Walsh wrote:
> The idea is, if you turn this boolean off, no domains will be
> allowed to sys_ptrace or ptrace.
> 
> In doing this, I have noticed that the simplest ps -eZ command 
> generates an access violation.
> 
> allow sysadm_t self:capability sys_ptrace;
> 
> 
> # ps PID TTY          TIME CMD 2123 pts/1    00:00:00 sudo 2127
> pts/1    00:00:05 sh 4095 pts/1    00:00:00 ps sh-4.2# aud
> 
> 
> #============= sysadm_t ============== allow sysadm_t
> self:capability sys_ptrace;
> 
> To me this looks like we are being too strict on the sys_ptrace 
> cabability checking, which I believe is a bug in the kernel.
> 
> 
> If I go into /proc/PID directory of domain with a different UID, I
> get the following, permission denieds:
> 
> cat: auxv: Permission denied cat: cwd: Permission denied cat:
> environ: Permission denied cat: exe: Permission denied cat: io:
> Permission denied cat: maps: Permission denied cat: numa_maps:
> Permission denied cat: pagemap: Permission denied cat: root:
> Permission denied cat: smaps: Permission denied cat: cwd:
> Permission denied
> 
> Are all these really needed?  Is knowing a processes current
> working directory the same as executing
> 
> gdb -p PID
> 
> 
> ???
> 
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 

More info. Turns out ps is looking at all /proc/PID/stat and
/proc/PID/status.  It looks like the avc is created if you cat
/proc/PID/stat, without generating a permission denied.  (I would bet
there are a ton of sys_ptrace allowed or dont audited just because a
root process runs ps.


# clearlogs
# aud
<no matches>
# cat /proc/26041/stat
26041 (kworker/1:0) S 2 0 0 0 -1 2216722528 0 0 0 0 0 105 0 0 20 0 1 0
9433742 0 0 18446744073709551615 0 0 0 0 0 0 0 2147483647 0
18446744073709551615 0 0 17 1 0 0 0 0 0
# aud
allow sysadm_t self:capability sys_ptrace;

- ----
time->Wed Oct  5 12:01:49 2011
type=SYSCALL msg=audit(1317830509.811:148661): arch=c000003e syscall=0
success=yes exit=171 a0=3 a1=2074000 a2=8000 a3=2 items=0 ppid=2127
pid=4312 auid=3267 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0
fsgid=0 tty=pts1 ses=4 comm="cat" exe="/bin/cat"
subj=staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023 key=(null)
<dwalsh> type=AVC msg=audit(1317830509.811:148661): avc:  denied  {
sys_ptrace } for  pid=4312 comm="cat" capability=19
scontext=staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023
tcontext=staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023 tclass=capability


Notice no permission denied.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6MgTcACgkQrlYvE4MpobOL7QCg4Cia2T7qeEmQI5dM2EORbP4B
1rkAniEQYiTnpj6EtZc622oxGxaWGEv2
=/gbR
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
