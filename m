From: "Frank Mayer" <mayerf@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>, <SELinux@tycho.nsa.gov>
Subject: RE: Default Policy question?
Date: Mon, 2 Jun 2003 16:22:13 -0400
Message-ID: <002301c32944$aabf6210$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <3EDB7585.8050308@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> user_r    - Very little privs for general users
> sysadm_r  - Ability to manipulate all standard Linux config files.
> policy_r  - Ability to change the way the kernel handles policy.
> (/etc/security/selinux/*, /etc/grup.conf, chsid, avc_toggle ...)
> 
> policy_r should not be defaulted to the root user but garnered in some
> other way.
> 
> Anyone have any ideas on this?

I started down that patch a little last summer.  This resulted in patch
to the policy directory that created separate policies for checkpolicy
and load_policy (before sysadm_r had all the permissions necessary), and
with installing the policy source in a well-known location and labeling
the source files and directories.  Several times we thought about trying
to create a real policy administrator role, but never got to it.  It's a
great idea, but I believe it will be hard to achieve true separation.
Nonetheless, a pragmatic first step is still a useful addition to the
policy.  

We're also exploring a more fundamental policy management infrastructure
enhancement (where the policy becomes a set of separately management and
protected objects), but its only an idea on the drawing board right now
awaiting funding. 

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
