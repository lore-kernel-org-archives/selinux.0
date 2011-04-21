Subject: Re: [PATCH 0/9] Open loaders and interpreters with new creds
 during exec
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: serge.hallyn@canonical.com, eparis@redhat.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Apr 2011 12:12:47 -0400
Message-ID: <1303402367.5381.17.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-04-21 at 15:30 +0100, David Howells wrote:
> Currently, the caller must be able to open the script interpreter and/or the
> binary loader that an executable wants to make use of, even if the executable
> will be transitioned to a different context that can make use of that
> interpreter or loader when the caller's context does not permit it.
> 
> Override credentials in open_exec() and kernel_read() with the currently
> constructed new credentials so that if the executable file or its interpreter
> specifies a transition to a different security context (DAC or MAC), then the
> caller only has to provide access to the file to be executed, and not to the
> interpreter (e.g. perl) or binary loader (e.g. ld.so) for the executable or
> interpreter.
> 
> This means that if the caller does not have access to a script interpreter or
> binary loader, it can still use scripts and executables that transition to a
> security context that do.
> 
> Tetsuo Handa pointed out that TOMOYO had a problem because the loader image
> (such as ld-config.so) was checked with the wrong credentials (open_exec() is
> using the caller's credentials rather than credentials-to-be of the exec'd
> process.
> 
> I note that this also applies to scripts and their interpreters.  A script may
> end up getting run in a context that allows access to its interpreter, but
> that's no good if the caller of execve() doesn't permit the script interpreter
> to be opened.
> 
> Here's a set of patches to deal with this.  The last patch is the main
> ingredient.
> 
> 
> I have a couple of comments/questions on the above:
> 
>  (1) Consider a SUID binary.  If the loader for that binary is executable by
>      the uid to which the binary changes its uid on execution, but not by the
>      uid of the caller, should execution succeed?
> 
>      For example, if, as root, I do this:
> 
> 	cp -v /bin/ls /tmp/ls
> 	perl -p -i -e s/ld-linux/ld-linuQ/ /tmp/ls
> 	cp -v /lib64/ld-linux-x86-64.so.2 /lib64/ld-linuQ-x86-64.so.2
> 	chmod -v 0700 /lib64/ld-linuQ-x86-64.so.2
> 
>      then as myself do this:
> 
> 	/tmp/ls
> 
>      this currently fails with permission denied; but with patch (5) above
>      applied, it works.  Obviously, this is a contrived example, but it also
>      may applies to script interpreters if an LSM provides a security ID
>      transition.
> 
>  (2) Conversely, if the loader is not executable by the uid to which an SUID
>      executable switches, should that execution succeed?
> 
>      So if I alter the ownership and permissions on the above binaries:
> 
> 	chown -v dhowells /lib64/ld-linuQ-x86-64.so.2
> 	chown -v bin /tmp/ls
> 	chmod u+s /tmp/ls
> 
>      then as myself do:
> 
> 	/tmp/ls
> 
>      this works with patches removed and gives permission denied with it
>      applied.
> 
>  (3) The SUID/SGID changes from patch 5 that I've noted in comments (1) and (2)
>      should, I think, have no impact on the execution environment because:
> 
> 	(*) loaders and interpreters are normally accessible to everyone in
> 	    their DAC permissions (UID, GID, umask), and
> 
> 	(*) recursing through prepare_binprm() multiple times only takes
> 	    account of the SUID/SGID settings of the final level (which means
> 	    that whilst you can have a SUID/SGID interpreter, you can't have a
> 	    SUID/SGID script).
> 
> 	    An exception to this are binfmt_misc cases that have
> 	    MISC_FMT_CREDENTIALS flagged - in those the credentials remain
> 	    unchanged for the iteration, even if the next executable is
> 	    SUID/SGID.
> 
>  (4) SELinux's testsuite needs the following additional rules:
> 
> 	[policy/test_ptrace.te]
> 	allow test_ptrace_traced_t bin_t:file { execute read open };
> 
> 	[policy/test_file.te]
> 	allow fileop_t fileop_exec_t:file { execute read open };
> 
>      to permit the ptrace test to access its script interpreter (perl) and the
>      SIGIO file test's wait_io program to access its own executable.

This is an interesting change, but as it does change user-visible
behavior, does it need to be subject to some /proc/sys/kernel toggle so
that users can retain the existing behavior?  And does at least the SUID
behavior change require discussion on lkml?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
