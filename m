Date: Wed, 28 Aug 2002 15:53:51 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: ssh and fs relabel (new release)
In-Reply-To: <1030541100.2059.18.camel@phobos>
Message-ID: <Pine.GSO.4.33.0208281537090.25057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 28 Aug 2002, Timothy Wood wrote:

> When enforcing mode is enabled there are several things that do not work
> which should.  The first of these is sshd.  sshd works fine in
> permissive mode, but when in enforcing mode the following avc messages
> are logged and no connection can be completed.  From the client side
> authentication passes and then the connection is closed.
>
> avc:  denied  { relabelto } for  pid=1298 exe=/usr/sbin/sshd path=/0
> dev=00:06 ino=2 scontext=system_u:system_r:sshd_t
> tcontext=timothy:object_r:sysadm_devpts_t tclass=chr_file
>
> sshd[1298]: fatal: chsid(/dev/pts/0, 490) failed: Permission denied
>
> sshd[1298]: syslogin_perform_logout: logout() returned an error

This isn't new to this release.  We removed direct transitions from sshd_t
to sysadm_t in the prior release (2002070313) in response to the sshd
vulnerability, requiring people to login as user_r:user_t and then use
newrole.  This was discussed previously on the selinux list, e.g.
http://marc.theaimsgroup.com/?l=selinux&m=102613964408029&w=2

> Also while in enforcing mode attempting a make relabel from the
> selinux/policy directory fails with the following avc messages.
>
> avc:  denied  { read } for  pid=1476
> exe=/usr/local/selinux/bin/checkpolicy path=/src/selinux/policy/Makefile
> dev=03:0b ino=1737013 scontext=root:sysadm_r:checkpolicy_t
> tcontext=system_u:object_r:src_t tclass=file
>
> avc:  denied  { read } for  pid=1477 exe=/usr/local/selinux/bin/setfiles
> path=/src/selinux/policy/file_contexts/file_contexts dev=03:0b
> ino=1524031 scontext=root:sysadm_r:setfiles_t
> tcontext=system_u:object_r:src_t tclass=file

Several of the policy-related utilities (setfiles, checkpolicy,
load_policy) have been placed into their own domains and limited to
reading appropriate types.  The setfiles_t domain is also not new; it was
created by Russell and added prior to the 2002070313 release.  The
checkpolicy_t domain was added as part of the policy management patch
posted on the list by Tresys Technology.  In this case, the 'make relabel'
is only truly being prevented by the second denial.

Limiting these domains to reading particular types is useful in reducing
the risk of including untrustworthy data in the policy or file contexts
configuration.  At present, setfiles_t is still fairly permissive in this
regard (it still permits reading home directory types to permit 'make
relabel' from a selinux/policy in the user's home directory), but we are
likely to restrict it to reading policy_src_t in the future now that the
policy management patch has been merged.

As part of the policy management patch, the policy sources are now
installed into /etc/security/selinux/src/policy via 'make install-src',
which is run during the SELinux installation procedure.  You can then
perform subsequent policy loads and relabels from that directory.  That
directory is labeled with policy_src_t, which can be read by setfiles_t
and checkpolicy_t.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
