Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h56GQRI4004667
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 12:26:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h56GQ4tV017500
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 16:26:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h56GQ3al017497 for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 16:26:03 GMT
Subject: Re: A vulnerability in SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Wayne Salamon <wsalamon@nailabs.com>,
   Rajal Wojtczuk <rafal_wojtczuk@nai.com>,
   Russell Coker <russell@coker.com.au>, Brian May <bam@snoopy.apana.org.au>,
   Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1054916729.1057.213.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 06 Jun 2003 12:25:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On June 6 2003, Wayne Salamon wrote:
> Here's the reply from Rafal with the details on the SELinux exploit.

On June 5 2003, Rajal Wojtczuk wrote:
>The description and the exploit code in the attachments. Eager to hear some
>comments :)

We have been able to reproduce this vulnerability and we believe it
deserves your attention. We recommend everyone apply the short term fix
below promptly.  In the future, please report vulnerabilities to
selinux-team@epoch.ncsc.mil prior to posting them publically so that we
can prepare a fix to publish at the same time.

The simplest short term fix for the specific exploit is to relabel
/lib/libSegFault.so from shlib_t to lib_t (or any type not executable by
passwd_t):
	chcon system_u:object_r:lib_t /lib/libSegFault.so

Naturally, this only deals with that particular shared library, and
will break any applications that are dynamically linked with that library
unless they happen to have execute access to lib_t.

A better short term fix would be to rebuild the spasswd collection of
utilities statically as suggested by Rajal:
	Add -static to LDFLAGS in selinux/utils/spasswd/Makefile.
	cd selinux/utils/spasswd
	make clean
	make install
	cd ../../policy
	make relabel (or directly run chcon on the spasswd utilities)

A detailed response to the vulnerability description follows.

>	In the default install, there are at least two kinds of binaries
which 
>are directly executable by an unprivileged user, and which run with high 
>privilege. They are:
>1) newrole
>2) set of password management binaries wrappers

>	If an user can take control over any of them, he can subvert all 
>selinux security mechanisms. In case of 1) compromise, attacker can
directly 
>change his security context; in case of 2) compromise, attacker can alter 
>passwords of all users.

A compromise of newrole does _not_ imply the ability to change to
arbitrary roles.  newrole can only change the role to one that is
authorized for the SELinux user identity, and it cannot change the
SELinux user identity at all.  The user->role limitation is enforced by
the kernel, not by newrole.

A compromise of the password management wrappers does allow the attacker
to alter the passwords of other users if the attacker also has the Linux
root uid. 

>	The history of unix security teaches us that parent process can
>influence a privileged child in many ways. Too many, to consider "grant
>privileges via execve" solution secure. Therefore, in some Linux 
>distributions (e.g. Owl), there is no setuid binaries - and it can be done 
>without loss of functionality.

Controlled transitions upon program execution can be provided safely,
but they do require greater safeguards than the ordinary setuid
mechanism.  Some of those safeguards touch on application-specific
knowledge, and some properly belong in the dynamic linker or in the
individual applications, not in the kernel.  A full integration of
SELinux into a Linux distribution should include appropriate changes to
ld.so to apply safeguards on domain transitioning executables (which can
be detected by checking the previous context/old SID against the current
context/SID), just as certain safeguards are currently applied to setuid
execution.  SELinux is _not_ a Linux distribution, and has never claimed
to be one.

>How does it work ? /lib/libSegfault.so is successfully preloaded - as it
>resides in /lib, it was labeled with the security context of 
>system_u:object_r:shlib_t. The .init section of libSegfault.so executes,
which 
>installs a handler for SIGSEGV. Then schfn starts execution. As the stack
size 
>is made low, it segfaults quickly. The signal handler from libSegfault.so 
>happily overwrites SEGFAULT_OUTPUT_NAME with data similar to the following:

This reflects a couple of points:
1) ld.so needs a SELinux patch to apply appropriate linker-specific
safeguards when dealing with SID/context transitioning programs.
2) The policy should provide a tighter binding between specific sets of
shared libraries and specific sets of executables.  Note that the
example policy is merely to help demonstrate SELinux and provide people
with a starting point for writing real policies.  It was never intended
to be "the policy."  The set of shared libraries should be partitioned
into multiple types, and each program should only be granted execute
access to the necessary set of types.

>	It may look like the properties of libSegfault.so are just an.
>unfortunate accident; but as mentioned before, the real problem is in the
>design. In the example above, the privileged child inherits:
>a) altered environment, including dynamic linker variables
>b) altered resource limits
>additionally, the attached code:
>c) changes argv[0] in order to write user-controlled data to /etc/passwd
>d) preloads additional variables, in order to easily control the flow of
>	execution via throttling LD_DEBUG output.
>None of the above should be possible on a secure system.

It is not the proper place of the kernel to filter dynamic linker
variables or any other application-specific information.  At most, the
kernel might support an all-or-nothing inheritance of environment
variables, but many applications are unlikely to function properly in
the inherit-nothing scenario, so you would not want to apply this to all
domain transitions.  A finer-grained solution would be a SELinux patch
to ld.so for the dynamic linker variables, and code in trusted
applications to sanitize their environment appropriately.

>	The short term solution, against this particular vulnerability,
>would be to link password management binaries wrappers statically. 

Correct.  Or using the policy to limit the wrappers to executing only
the right set of shared libraries.

>However, other domain transitions still remain at risk. 

Only ones that involve non-set[ug]id programs, since ld.so already
ignores the LD_ vars for those.  In the example policy, I think that
this is only the password management wrappers (and only because they are
wrappers rather than directly integrated patches into the existing
setuid programs) and newrole.

>Two long term solution against this particular vulnerability are possible:
>1) use a password management scheme which does not require highly
privileged
>helpers. tcb suite is a good step (but it allowes ordinary users to update 
>/etc/shadow only, not /etc/passwd).
>2) wrap password management securely; preferably run (over a unix 
>domain socket) a daemon, which will accept and verify username and then
>perform desired operation.

A possible model, but not the only one.  Integration of a SELinux patch
into ld.so would help significantly, and coarse-grained controls in the
kernel for environment variable inheritance and resource limit
inheritance on SID/context transitions might be helpful for trusted
applications.

>	This solution should be accompanied by the removal of "newrole"
binary. 

I don't see this as necessary or desirable.  As mentioned above, newrole
does not give access to roles unless the SELinux user identity is
already authorized for the role.  There is also a  functional aspect of
newrole; users want to be able to change roles within a session, and in
a full policy, there will be far more roles than just user_r and
sysadm_r.

>Let's see what happens in the default policy (that is, sshd cannot
>transition to sysadm_t directly) if an attacker compromises an sshd process

>(the parent one, not the chrooted one; parent/chrooted in terms of sshd 
>privilege separation). He can ptrace the main sshd process, and then setup
a 
>fake sshd server in order to hijack users' passwords. Even if sshd domain
is 
>denied ptrace totally (even ptrace calls which are not  privileged), the 
>attacker can obtain a security context of user U, who can execute newrole
to 
>get sysadm_r role. The attacker then waits for U to log in, attaches to any

>process spawned by U's login shell(***) with ptrace, and executes a program

>which proxies standard input to a shell spawned as a subprocess. This way, 
>passwords can be stealed almost invisibly. So, sshd compromise is fatal; 
>therefore it is more secure to grant sshd the right for transition to other

>domains, and get rid of "newrole" binary.

A compromise of sshd is fatal in theory if the policy allows sshd_t to
reach (directly or indirectly) sysadm_t (a policy issue), but even in
that case, you can still make the attacker work harder to effectively
exploit it.  ptrace is controlled based on the pair of domains, and is
revalidated on domain transitions upon execve, so sshd_t can't directly
ptrace user_t, although I suppose it could launch its own user_t process
to do that.    On a production system, people may even choose to disable
ptrace permission  entirely (even within a domain), so that no process
(or only administrator processes) can use it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
