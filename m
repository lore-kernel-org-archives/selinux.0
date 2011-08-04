Subject: Re: SELinux policy regarding LD_LIBRARY_PATH
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aaron Sowry <aaron@cendio.se>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4E3AA12C.9000704@cendio.se>
References: <4E3A8D16.7060807@cendio.se>
	 <1312463365.20973.21.camel@moss-pluto>  <4E3AA12C.9000704@cendio.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Aug 2011 09:47:29 -0400
Message-ID: <1312465649.20973.48.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-08-04 at 15:39 +0200, Aaron Sowry wrote:
> > However, the behavior you are seeing might not be related to SELinux, as
> > Linux also enables AT_SECURE if the uid or gid changes across execve (to
> > be precise, if the effective identity is not equal to the real identity
> > after the credential change, as this was the legacy logic from libc).
> 
> So if I understand correctly, SELinux expands on AT_SECURE to sanitize
> environment variables across context changes instead of just
> setgid/setuid. Makes sense; you live and learn.
> 
> In this case I believe it was SELinux performing the sanitization as
> disabling it solved the problem, but this is helpful to know.

Just to clarify, we introduced AT_SECURE for SELinux.  Prior to SELinux,
userspace directly used AT_EUID/AT_UID and AT_EGID/AT_GID to decide
whether to sanitize the environment.  When we wanted a similar mechanism
for SELinux, Roland McGrath suggested that we create an AT_SECURE flag
that could be set by the kernel whenever a security-relevant change has
taken place, and then rework userspace to use that flag when present.
Thus we have a more general mechanism today that can be used for
setuid/setgid, capability changes, SELinux security context transitions,
or any other security module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
