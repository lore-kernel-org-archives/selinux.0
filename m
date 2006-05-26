Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, dhowells@redhat.com
In-Reply-To: <1148646635.20976.189.camel@moss-spartans.epoch.ncsc.mil>
References: <1148575812.3304.45.camel@moss-tarheels.epoch.ncsc.mil>
	 <1148646635.20976.189.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 26 May 2006 08:56:14 -0400
Message-Id: <1148648174.20976.211.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-26 at 08:30 -0400, Stephen Smalley wrote:
> On Thu, 2006-05-25 at 12:50 -0400, Michael LeMay wrote:
> > One interesting
> > result of initializing root's keyrings during kernel initialization
> > is that they are assigned the type "kernel_t", rather than "xdm_t"
> > as is the case with all ordinary users.  I hope this is an acceptable
> > labeling...
> 
> xdm_t (i.e. the security context of the display manager) on the user
> keys doesn't seem right; I would think it should be the context of the
> user session itself, so that user sessions with different security
> contexts would have distinct key labels (both for role/domain separation
> and for level separation).  Anyone know how keys are created by gdm et
> al, e.g. is it done from some pam module?  gdm is already instrumented
> to call setexeccon() to set the user session security context before
> executing the session, but if it is directly creating the key within the
> main gdm process (without executing a helper) or if it executes a helper
> before performing that setup, the key creation will happen in gdm's
> context.  

Ah, wait - is this just the keyring allocated upon set*uid via
alloc_uid_keyring()?  In that case, then those keyrings will always be
labeled with the security label of the login-like program rather than
the user session itself.  So keyrings created via a gdm login will have
one label, while keyrings created by local login or by sshd will have
another label.  But multiple user logins via the same mechanism will all
get the same label on that keyring.

Now, if we introduced a /proc/pid/attr/keycreate node for specifying a
desired label for a new key/keyring (controlled via a separate create
permission in the key class, and modified the login-like programs to
call an interface to set that to match the user session security context
(e.g. setkeycreatecon()), then we could put those keyrings into the user
session security context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
