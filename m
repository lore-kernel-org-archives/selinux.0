Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LHWJnE028044
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 13:32:23 -0400
Received: from smtp105.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p3LHWM9H029000
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 17:32:22 GMT
Message-ID: <4DB06A23.2040000@schaufler-ca.com>
Date: Thu, 21 Apr 2011 10:32:19 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: serge.hallyn@canonical.com, eparis@redhat.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 0/9] Open loaders and interpreters with new creds during
 exec
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/21/2011 7:30 AM, David Howells wrote:
> Currently, the caller must be able to open the script interpreter and/or the
> binary loader that an executable wants to make use of, even if the executable
> will be transitioned to a different context that can make use of that
> interpreter or loader when the caller's context does not permit it.

Yes. This is good and correct behavior. You need access to all of
the resources you are going to use before you can start using them.

> Override credentials in open_exec() and kernel_read() with the currently
> constructed new credentials so that if the executable file or its interpreter
> specifies a transition to a different security context (DAC or MAC), then the
> caller only has to provide access to the file to be executed, and not to the
> interpreter (e.g. perl) or binary loader (e.g. ld.so) for the executable or
> interpreter.

No. This is bad and incorrect behavior.

> This means that if the caller does not have access to a script interpreter or
> binary loader, it can still use scripts and executables that transition to a
> security context that do.

Which is very very bad.

Let me provide an example using groups where this creates a serious
security problem.

/usr/local/bin/swine is an interpreter with known security flaws.
It is kept on the system because one specific group of users have
a swine script (wallow) that requires that exact version and that
has been vetted to not be vulnerable to those flaws. It is owned
by root.swill and mode 550 (-r-xr-x--- for you kids out there) to
prevent it being used by anyone else. The group that needs to use
wallow are allowed to use newgroup to add the group to their lists.

/usr/bin/swine is a newer version of the interpreter with all
known security flaws repaired. The users of the system have taken
to writing swine scripts like pigs to ... well, you get the idea.
They share scripts freely and there is a large collection, many
provided by members of the swill group.

One member (wilbur) of the swill group creates a swine script (mud)
that does some of the things that expose a security flaw in the old
version of the interpreter. Either through ignorance or malice he
creates the script in a public place, owned by wilbur.swill and
sets the setgid bit.

Another user of the system who is not in the swill group runs

    % mud --ssn=538-99-9163

Because mud is setgid to swill it gets the old interpreter and
the flaw in the old swine sends sensitive information to a place
it does not belong. Even though the old bad version of swine is
clearly marked as inaccessible to the user it gets used.

Bad. Very bad.
Clear violation of the principle of least astonishment.

> Tetsuo Handa pointed out that TOMOYO had a problem because the loader image
> (such as ld-config.so) was checked with the wrong credentials (open_exec() is
> using the caller's credentials rather than credentials-to-be of the exec'd
> process.

I believe that our esteemed colleague is in error. I understand the
argument for the change, but I am not swayed by it.

> I note that this also applies to scripts and their interpreters.  A script may
> end up getting run in a context that allows access to its interpreter, but
> that's no good if the caller of execve() doesn't permit the script interpreter
> to be opened.

I follow the logic, but it is based on extrapolation from what I
see as a flawed premise.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
