Message-ID: <4F3A684B.6010009@redhat.com>
Date: Tue, 14 Feb 2012 08:57:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Currently the kernel is interpreting reading the link file on
 /proc/PID/exe as sys_ptrace for a different UID.
References: <4F398582.7030004@redhat.com> <CAB9W1A3SHFQ-YQAUDyN=wCx0x3PQvrvmSo90_VzUDd-m5-ZTiw@mail.gmail.com>
In-Reply-To: <CAB9W1A3SHFQ-YQAUDyN=wCx0x3PQvrvmSo90_VzUDd-m5-ZTiw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/13/2012 06:09 PM, Stephen Smalley wrote:
> On Mon, Feb 13, 2012 at 1:49 PM, Daniel J Walsh <dwalsh@redhat.com>
> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> I believe this should be DAC_READ_SEARCH.
>> 
>> I am trying to prevent all SYS_PTRACE from any domain on the
>> system but certain apps like dbus, consolekit, policykit,
>> systemd-logger and others like to look /proc/PID/exe to report
>> the path of the executable they are communicating with.  This
>> causes lots of sys_ptrace access being required for domains, that
>> I do not believe need it.
>> 
>> They need DAC_READ_SEARCH because they are trying to read content
>> that is owned by a different UID.  The SYS_PTRACE stuff was put
>> in to prevent apps from reading process memory information stored
>> in /proc.
>> 
>> I think this is a bug in the kernel.
> 
> SELinux just mirrors the Linux capability checks.  CAP_SYS_PTRACE
> is applied when the normal DAC check on ptrace fails (i.e.
> different uid).  The SELinux MAC check here is the :process ptrace
> check.  That is what you should focus on - SELinux already
> distinguishes /proc access from ptrace (except for /proc/pid/mem,
> which is viewed as equivalent).  dontaudit :capability sys_ptrace
> where needed, but not :process ptrace.
> 
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.



But I have to allow all these domains capability sys_ptrace then,
since these domains legitimately want to either use an access check
based on the executable of the process or in the case of the
systemd_jounal, want to log it.

If the CAP check on reading a symbolic link in /proc is SYS_PTRACE,
that seems bogus.  If it was reading /proc/pid/mem or any of the other
/proc/pid fields that tell you about the memory, then I agree those
should be SYS_PTRACE.  But this is a DAC_READ_SEARCH check in my opinion.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk86aEoACgkQrlYvE4MpobO0PQCeOICfnYN7KOPFinPDUFGtBWGf
GE4AnibOo/KpJixmKqktQpGZgE2aDbEx
=g2rt
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
