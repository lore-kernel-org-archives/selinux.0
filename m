Message-ID: <552FA882.7030604@tycho.nsa.gov>
Date: Thu, 16 Apr 2015 08:18:10 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Florian Weimer <fweimer@redhat.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Impersonating a process for file creation purposes
References: <552F80C8.9060809@redhat.com>
In-Reply-To: <552F80C8.9060809@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/16/2015 05:28 AM, Florian Weimer wrote:
> The ABRT coredump handler has code to emulate default core file creation
> (as if no such pipe-based handler was installed).  The handler runs in a
> separate process, initially as root.  Currently, the handler just
> switches effective IDs and creates the file.  This does not replicate
> the SELinux context of the zombie process.

Pardon me for asking, but why does it include this code for emulating
default core file creation, versus just letting the kernel directly
handle it?

> Is there a way to do that?   Is there some recommended way to inherit
> all the security-related process attributes?

Technically it could use setcon() if allowed by policy but I wouldn't
really recommend it.  You'd have to allow it to dyntransition to any
domain for any potential process you want it to be able to dump, at
which point it could assume any of the permissions of any of those
processes at will.  Not so great if there is ever a vulnerability in
ABRT itself.  Plus any other process in the same context would be able
to act on the handler at that point as they would then be in the same
context.

It could also compute the context in which the file would be created by
the zombie by calling security_compute_create() with the context of the
zombie process, the context of the directory into which it is writing
the core dump file, and string_to_security_class("file") as its
arguments, and then pass the resulting context returned by that call to
setfscreatecon() prior to creating the core dump file and then call
setfscreatecon(NULL) afterward; this will create the core dump file in
that context.  That seems more suited to your scenario.
