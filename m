MIME-Version: 1.0
In-Reply-To: <4F398582.7030004@redhat.com>
References: <4F398582.7030004@redhat.com>
Date: Mon, 13 Feb 2012 15:09:37 -0800
Message-ID: <CAB9W1A3SHFQ-YQAUDyN=wCx0x3PQvrvmSo90_VzUDd-m5-ZTiw@mail.gmail.com>
Subject: Re: Currently the kernel is interpreting reading the link file on
 /proc/PID/exe as sys_ptrace for a different UID.
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Feb 13, 2012 at 1:49 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> I believe this should be DAC_READ_SEARCH.
>
> I am trying to prevent all SYS_PTRACE from any domain on the system
> but certain apps like dbus, consolekit, policykit, systemd-logger and
> others like to look /proc/PID/exe to report the path of the executable
> they are communicating with.  This causes lots of sys_ptrace access
> being required for domains, that I do not believe need it.
>
> They need DAC_READ_SEARCH because they are trying to read content that
> is owned by a different UID.  The SYS_PTRACE stuff was put in to
> prevent apps from reading process memory information stored in /proc.
>
> I think this is a bug in the kernel.

SELinux just mirrors the Linux capability checks.  CAP_SYS_PTRACE is
applied when the normal DAC check on ptrace fails (i.e. different
uid).  The SELinux MAC check here is the :process ptrace check.  That
is what you should focus on - SELinux already distinguishes /proc
access from ptrace (except for /proc/pid/mem, which is viewed as
equivalent).  dontaudit :capability sys_ptrace where needed, but not
:process ptrace.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
