Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9NKZfWt012014
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 16:35:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9NKZQIS015784
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 20:35:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9NKZQDc015781
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 20:35:26 GMT
Subject: Re: selinux, openssh and users
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ignacio Tripodi <ignaciot@unt.edu>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1066939944.3f9836281d4ed@eaglemail.unt.edu>
References: <1066939944.3f9836281d4ed@eaglemail.unt.edu>
Content-Type: text/plain
Message-Id: <1066941339.8242.164.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 23 Oct 2003 16:35:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-23 at 16:12, Ignacio Tripodi wrote:
> I just finished setting up a 2.6 selinux kernel environment, and noticed that I
> can't ssh to it.

Did you label the filesystems and reboot (or at least restart sshd)?  If
not, sshd is running in the wrong security domain and can't find a
reachable user context for you.  What does ps -eZ (ps -e --context)
show?

>  I found in the list archives that you cannot ssh using an
> admin_r user (is that still valid?)

The example policy prohibits direct transitions from sshd_t to sysadm_t,
but you should be able to login as staff_r:staff_t and then newrole to
sysadm_r:sysadm_t.

>  so I tried to create a regular user and
> assign the user_r role to it. If I do a "seuser add -R user_r username" it says
> that it couldn't modify the policy and failed to create the user. Do you know
> where can I start looking for errors?

Your 'dmesg' output or /var/log/messages will show avc denied messages
for SELinux access denials.  Is your kernel running in enforcing mode?
It is a good idea to start with permissive mode until you have worked
out any policy issues, as noted in the README.

> Also, once I am able to create a regular user, do I need to specify any
> role/context parameters in order to ssh to this machine? How does the openssh
> client get around this?

sshd (via libselinux) asks the kernel what contexts are reachable from
its domain for your user identity (kernel determines this based on the
policy) and then picks one of the reachable contexts based on either
/etc/security/default_contexts or $HOME/.default_contexts.  There is no
way to specify a context from the client.  

Note that a patched sshd isn't necessary if you use Dan's pam_selinux
module and alter your PAM sshd configuration to include it.  Not sure if
his module allows user selection of contexts for ssh sessions (if using
the 'multiple' option to the module).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
