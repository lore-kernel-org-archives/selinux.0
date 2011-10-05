MIME-Version: 1.0
In-Reply-To: <4E8C7DCA.3020003@redhat.com>
References: <4E8C7DCA.3020003@redhat.com>
Date: Wed, 5 Oct 2011 12:16:16 -0400
Message-ID: <CACLa4psce0w2dgXL+LNVfRdvs7ycjxyEgL8zm79WKGXPcmz6ug@mail.gmail.com>
Subject: Re: I am trying an experiment of making allow_ptrace boolean actually
 do something useful.
From: Eric Paris <eparis@parisplace.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ps uses /proc/[pid]/stat .

/proc/pid/stat ouputs things like the last EIP ESP mm->start and stop
and the stack top IF you have ptrace permissions.  If you don't have
permissions you just get 0's for those fields.

see fs/proc/array.c::do_task_stat()

Should I force some sort of dontaudit all the way down this code path?

-Eric

On Wed, Oct 5, 2011 at 11:54 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The idea is, if you turn this boolean off, no domains will be allowed
> to sys_ptrace or ptrace.
>
> In doing this, I have noticed that the simplest ps -eZ command
> generates an access violation.
>
> allow sysadm_t self:capability sys_ptrace;
>
>
> # ps
>  PID TTY          TIME CMD
>  2123 pts/1    00:00:00 sudo
>  2127 pts/1    00:00:05 sh
>  4095 pts/1    00:00:00 ps
> sh-4.2# aud
>
>
> #============= sysadm_t ==============
> allow sysadm_t self:capability sys_ptrace;
>
> To me this looks like we are being too strict on the sys_ptrace
> cabability checking, which I believe is a bug in the kernel.
>
>
> If I go into /proc/PID directory of domain with a different UID, I get
> the following, permission denieds:
>
> cat: auxv: Permission denied
> cat: cwd: Permission denied
> cat: environ: Permission denied
> cat: exe: Permission denied
> cat: io: Permission denied
> cat: maps: Permission denied
> cat: numa_maps: Permission denied
> cat: pagemap: Permission denied
> cat: root: Permission denied
> cat: smaps: Permission denied
> cat: cwd: Permission denied
>
> Are all these really needed?  Is knowing a processes current working
> directory the same as executing
>
> gdb -p PID
>
>
> ???
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk6MfcoACgkQrlYvE4MpobNHggCfQ0grVjr4ewpfSS8v09rBjHCO
> 2REAnjSbZtLgyHuSixIa3+FlSlQ8nnoz
> =K+QE
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
