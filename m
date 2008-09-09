Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m89ATutm008487
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 06:29:56 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m89ATuCw026586
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 10:29:56 GMT
Date: Tue, 9 Sep 2008 20:29:51 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Murray McAllister <mmcallis@redhat.com>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Confined and Unconfined User Domains"
 review
In-Reply-To: <48C6236D.4020408@redhat.com>
Message-ID: <alpine.LRH.1.10.0809092001230.21555@tundra.namei.org>
References: <48C6236D.4020408@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 9 Sep 2008, Murray McAllister wrote:

> Each Linux user account is mapped to an SELinux user identity when a user
> login session is created, and the mapped SELinux user identity is used in the
> security context for processes in that session.

This is a long sentence which I suspect general users would not easily 
understand.  Perhaps break it into two sentences, with the second as:

"The SELinux user identity is indicated in the user's process security 
context for that session."

Do you have a diagram breaking down the security context?  You could refer 
to it here.

> By default, on Fedora 10,
> Linux users are mapped to the SELinux unconfined_u user. This is seen by
> running the id -Z and /usr/sbin/semanage login -l commands:
> 
> # id -Z
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

This command will have different outputs depending on how the user is 
logged in, and there are seemingly (to the reader) two different ways to 
see the SELinux user mapping (a new concept to them at this point).

I suggest breaking it up so you first show the mapping via semanage, then 
show the output of 'id -Z' for one of the Unix logins, also perhaps 
explaining the flow:

- Linux users are mapped to SELinux users via policy

- user commences login
- pam_selinux maps the user and sets up the resulting security context
- user shell is launched in that context

> # /usr/sbin/semanage login -l
> 
> Login Name                SELinux User              MLS/MCS Range
> 
> __default__               unconfined_u              s0-s0:c0.c1023
> root                      unconfined_u              s0-s0:c0.c1023
> system_u                  system_u                  s0-s0:c0.c1023
> 
> The first row, __default__, defines that any new Linux users created that are
> not specifically mapped to an SELinux user, are mapped to the SELinux
> unconfined_u user. For a description of each column, refer to Chapter 3,
> SELinux Contexts.

I think you need to refer to a concrete example with the current text.

> Unconfined Linux users are subject to executable and
> writeable memory checks, and are also restricted by MCS (and MLS, if the MLS
> policy is used). If they execute an object that the SELinux policy defines can

Why introduce unfamiliar terminology like "execute an object" ?  People 
execute applications.

> transition from the unconfined_t domain to its own confined domain, the
> unconfined Linux users are still subject to the restrictions of that confined
> domain.

Perhaps important to (re)state the security benefit of this, in that 
an unconfined user cannot override the security policy for a confined 
application just because they themselves are unconfined.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
