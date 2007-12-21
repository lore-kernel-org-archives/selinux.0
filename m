Subject: Re: I have been working on a example policy/rpm package to
	demontrate how to ship SELinux policy in an RPM
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <476BD322.2050904@redhat.com>
References: <476BD322.2050904@redhat.com>
Content-Type: text/plain
Date: Fri, 21 Dec 2007 10:34:41 -0500
Message-Id: <1198251281.2944.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2007-12-21 at 09:52 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Doing this I believe I found a bug in bug in SELinux,  that I am not
> sure how we fix.
> 
> Steps to produce bug.
> 
> Build and install
> 
> http://people.fedoraproject.org/~dwalsh/SELinux/example-1.0-0.fc9.src.rpm
> 
> This will install a daemon program
> 
> /usr/sbin/example
> /var/spool/example
> /etc/init.d/example
> 
> All of these should be labeled correctly
> 
> Now start the daemon
> # rpm -Uhv example-1.0-0.fc9.noarch.rpm
> # service example start
> 
> This will only create a pid file /var/run/example.pid
> 
> Now make sure everything is labeled correctly
> 
> # ls -ldZ /usr/sbin/example /etc/init.d/example /var/spool/example/
> /var/run/example.pid
> - -rwxr-xr-x  root root system_u:object_r:example_script_exec_t
> /etc/init.d/example
> - -rwxr-xr-x  root root system_u:object_r:example_exec_t /usr/sbin/example
> - -rw-r--r--  root root system_u:object_r:example_var_run_t
> /var/run/example.pid
> drwxr-xr-x  root root system_u:object_r:example_spool_t /var/spool/example/
> 
> Touch a file in /var/spool/example to make sure rpm does not remove with
> the package
> 
> # touch /var/spool/example/example.tmp
> 
> Now I am going to test the uninstall of the package.
> 
> 
> rpm -e example
> 
> ls -ldZ /usr/sbin/example /etc/init.d/example /var/spool/example/
> /var/run/example.pid
> ls: cannot access /usr/sbin/example: No such file or directory
> ls: cannot access /etc/init.d/example: No such file or directory
> - -rw-r--r--  root root system_u:object_r:unlabeled_t
> /var/run/example.pid
> drwxr-xr-x  root root system_u:object_r:var_spool_t    /var/spool/example/
> 
> # restorecon -R -v /var/run/example.pid
> # ls -lZ /var/run/example.pid
> - -rw-r--r--  root root system_u:object_r:unlabeled_t
> /var/run/example.pid
> 
> It leaves the pid file as unlabeled_t, this is because
> 
> /var/run/.*\.*pid	<<none>>
> 
> Which tells restorecon to not change any context on a pid file.  But
> leaving the file as unlabeled_t causes other problems.

Interestingly though, there are specific entries for specific pid files
in the .fc files.  In which case I'm not sure why we retain the above -
the original point of marking /var/run pid files with <<none>> was
because those files are runtime files and thus just labeled based on
type transitions when they are created, and we didn't want
setfiles/restorecon to clobber those labels.  But if we have specific
entries for the individual files (because they actually do have
meaningful and predictable names, unlike /tmp files), then we don't
really buy much by having the <<none>> entry.

> Now I reinstall the package
> 
> # rpm -Uhv
> /home/devel/dwalsh/sources/RPMS/noarch/example-1.0-0.fc9.noarch.rpm
> Preparing...                ###########################################
> [100%]
>    1:example                ###########################################
> [100%]
> /sbin/restorecon set context
> /var/run/example.pid->system_u:object_r:example_var_run_t:s0
> failed:'Permission denied'
> 
> AVC is generated
> 
> time->Thu Dec 20 19:28:50 2007
> type=PATH msg=audit(1198196930.130:1540): item=0
> name="/var/run/example.pid" inode=3178877 dev=fd:00 mode=0100644 ouid=0
> ogid=0 rdev=00:00 obj=system_u:object_r:example_var_run_t:s0
> type=CWD msg=audit(1198196930.130:1540):  cwd="/"
> type=SYSCALL msg=audit(1198196930.130:1540): arch=40000003 syscall=227
> success=no exit=-13 a0=bfcbd7e0 a1=1417c1 a2=ba1ed1e0 a3=27 items=1
> ppid=23898 pid=23928 auid=3267 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
> sgid=0 fsgid=0 tty=pts2 comm="restorecon" exe="/sbin/setfiles"
> subj=unconfined_u:unconfined_r:setfiles_t:s0-s0:c0.c1023 key=(null)
> type=AVC msg=audit(1198196930.130:1540): avc:  denied  { relabelto } for
>  pid=23928 comm="restorecon" name="example.pid" dev=dm-0 ino=3178877
> scontext=unconfined_u:unconfined_r:setfiles_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:example_var_run_t:s0 tclass=file

That doesn't seem to match the policy, since setfiles_t does have
relabelto for all file types, and it has relabelfrom for unlabeled_t
AFAICS.  And it has the attribute needed to relabel files with different
SELinux user identities.

> If I pipe this to audit2why
> type=AVC msg=audit(1198196930.130:1540): avc:  denied  { relabelto } for
>  pid=23928 comm="restorecon" name="example.pid" dev=dm-0 ino=3178877
> scontext=unconfined_u:unconfined_r:setfiles_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:example_var_run_t:s0 tclass=file
> 	Was caused by:
> 		Unknown - would be allowed by active policy
> 		Possible mismatch between this policy and the one under which the
> audit message was generated.
> 		Possible mismatch between current in-memory boolean settings vs.
> permanent ones.

So userland's interpretation of the policy doesn't match the kernel's
interpretation, or they aren't actually seeing the same policy.  Not
good.

> If I run restorecon on it now, it is fine.

That's interesting - does it run in a different context when run
interactively than from rpm?
> 
> If I do the exact same steps above, but change the context on
> /var/run/example.pid to say bin_t.
> 
> The install happens successfully.

Hmmm..which seems to tie it to the fact that the file was unlabeled (or
more precisely, had an invalidated SID).  Yet the denial itself wasn't
on the unlabeled SID but on the new label.

> It seems that during the rpm update the policy in the kernel is
> different then when it completes.  All the postinstall is doing is
> 
> # semodule -s targeted -i example.pp
> followed by a fixfiles on the files in example.spec
> 
> Why this would work outside the rpm transaction but not inside is the
> bug.  Why does it work with the label of bin_t, but not when it is
> labeled unlabeled_t?

I agree it shouldn't differ, so this suggests a bug in the kernel's
handling of inodes with invalidated SIDs.

We should try to track that down regardless, but one thing that might
change the situation would be the old patch I had to retain invalidated
contexts in the SID table and then turn them back into valid SIDs upon
policy reload that make them valid once again.  That avoided the whole
unlabeled_t state for such files.  That patch actually had two logical
changes within it, one to support preservation of such invalidated
contexts and one to let privileged programs (ala rpm) set invalid
contexts in the first place (so that they could set down the context
before loading the policy module).  The latter part was the more
controversial piece and could be removed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
