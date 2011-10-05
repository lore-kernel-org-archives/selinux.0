Message-ID: <4E8C8B86.5000200@redhat.com>
Date: Wed, 05 Oct 2011 12:53:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: I am trying an experiment of making allow_ptrace boolean actually
 do something useful.
References: <4E8C7DCA.3020003@redhat.com> <CACLa4psce0w2dgXL+LNVfRdvs7ycjxyEgL8zm79WKGXPcmz6ug@mail.gmail.com>
In-Reply-To: <CACLa4psce0w2dgXL+LNVfRdvs7ycjxyEgL8zm79WKGXPcmz6ug@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/05/2011 12:16 PM, Eric Paris wrote:
> ps uses /proc/[pid]/stat .
> 
> /proc/pid/stat ouputs things like the last EIP ESP mm->start and
> stop and the stack top IF you have ptrace permissions.  If you
> don't have permissions you just get 0's for those fields.
> 
> see fs/proc/array.c::do_task_stat()
> 
> Should I force some sort of dontaudit all the way down this code
> path?
> 
> -Eric
> 
> On Wed, Oct 5, 2011 at 11:54 AM, Daniel J Walsh <dwalsh@redhat.com>
> wrote: The idea is, if you turn this boolean off, no domains will
> be allowed to sys_ptrace or ptrace.
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
>> 
>> -- This message was distributed to subscribers of the selinux
>> mailing list. If you no longer wish to subscribe, send mail to
>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
>> without quotes as the message.
>> 
> 
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 

Grepping through fedora policy I see 21 domains with dontaudit
capability sys_ptrace and another 41 with allow rules.

Seems to me most of these could be eliminated if we just allowed ps -e
to work without generating an AVC.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6Mi4YACgkQrlYvE4MpobPXJwCfYn9GnqFpn08v6VzqPFuIYZnt
1NkAoLN3jFbEq3PmOFggIXPyvwVTmux7
=N4WZ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
