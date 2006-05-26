Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, dhowells@redhat.com
In-Reply-To: <1148575812.3304.45.camel@moss-tarheels.epoch.ncsc.mil>
References: <1148575812.3304.45.camel@moss-tarheels.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 26 May 2006 08:30:35 -0400
Message-Id: <1148646635.20976.189.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 12:50 -0400, Michael LeMay wrote:
> One interesting
> result of initializing root's keyrings during kernel initialization
> is that they are assigned the type "kernel_t", rather than "xdm_t"
> as is the case with all ordinary users.  I hope this is an acceptable
> labeling...

xdm_t (i.e. the security context of the display manager) on the user
keys doesn't seem right; I would think it should be the context of the
user session itself, so that user sessions with different security
contexts would have distinct key labels (both for role/domain separation
and for level separation).  Anyone know how keys are created by gdm et
al, e.g. is it done from some pam module?  gdm is already instrumented
to call setexeccon() to set the user session security context before
executing the session, but if it is directly creating the key within the
main gdm process (without executing a helper) or if it executes a helper
before performing that setup, the key creation will happen in gdm's
context.  

> One other notable change in this patch is the addition of the "lookup"
> permission to the "key" security class.  This permission is passed to
> SELinux whenever the key handling code performs a null permission check.

Are these null permission checks done as internal tests by the kernel
itself, or do they originate from userspace queries?  If the former,
then failing the lookup based on the user's context could lead to
internal confusion for the kernel (e.g. it decides that the key doesn't
exist, so it creates a duplicate).  

Compatibility question:  If you build a kernel with these checks and try
running it on an existing system today without corresponding policy
updates, does anything critical immediately break?  You mentioned that
gdm is creating keys - what happens if that fails?  Just want to know
how closely we need to coordinate the kernel update with any policy
update.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
