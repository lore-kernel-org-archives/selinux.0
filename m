Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Timothy Wood <timothy@hallcomp.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: ssh and fs relabel (new release)
Date: Wed, 28 Aug 2002 15:45:11 +0200
References: <1030541100.2059.18.camel@phobos>
In-Reply-To: <1030541100.2059.18.camel@phobos>
MIME-Version: 1.0
Message-Id: <20020828134511.DAFDD8FDA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Aug 2002 15:25, Timothy Wood wrote:
> I just preformed a clean install of RH7.2 and the latest lsm from the
> NSA site and there seem to be a few problems.
>
> When enforcing mode is enabled there are several things that do not work
> which should.  The first of these is sshd.  sshd works fine in
> permissive mode, but when in enforcing mode the following avc messages
> are logged and no connection can be completed.  From the client side
> authentication passes and then the connection is closed.
>
> avc:  denied  { relabelto } for  pid=1298 exe=/usr/sbin/sshd path=/0
> dev=00:06 ino=2 scontext=system_u:system_r:sshd_t
> tcontext=timothy:object_r:sysadm_devpts_t tclass=chr_file

In the new policy ssh is totally denied access to the sysadm_t domain 
(there's no domain transition allowed) and to the pseudo-tty devices (can't 
access them or transition to/from them).  You can change ssh.te, change the 
following line:
allow sshd_t userpty_type:chr_file { setattr relabelto rw_file_perms };
to:
allow sshd_t { sysadm_devpts_t userpty_type }:chr_file { setattr relabelto 
rw_file_perms };

Then change the following:
domain_trans($1, shell_exec_t, unpriv_userdomain)
to:
domain_trans($1, shell_exec_t, { sysadm_t unpriv_userdomain })

However, be aware that making such changes grants anyone who has port 22 
access to your machine full administrative access if (when?) another bug is 
discovered in sshd...

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

It's expected that the policy source files have type policy_src_t...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
