Subject: Re: permissions on /proc/self/attrib/current
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chuck Mead <csm@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <448D6FF2.7060004@redhat.com>
References: <4485C100.4030805@redhat.com>
	 <1150119045.8086.17.camel@moss-spartans.epoch.ncsc.mil>
	 <448D6FF2.7060004@redhat.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 10:51:26 -0400
Message-Id: <1150123886.8086.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-06-12 at 09:45 -0400, Chuck Mead wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Tue, 2006-06-06 at 13:53 -0400, Chuck Mead wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> The file /proc/self/attrib/current is world read and write. Is this
> >> correct? Why does it need world read and write?
> > 
> > To completely disable DAC restrictions, and leave it entirely to SELinux
> > to control access.  The corresponding hook functions in the SELinux
> > "module", selinux_getprocattr and selinux_setprocattr, apply permission
> > checks on reading and writing these nodes, and selinux_setprocattr
> > further prohibits a task from setting (writing) attributes other than
> > its own.
> > 
> > The DAC restrictions can be problematic when the task becomes
> > undumpable, e.g. setuid or setgid programs could otherwise lose access
> > to their own /proc/pid/attr nodes.
> 
> If selinux is disabled is this file still present?

The pseudo file is present, but reads and writes on it will always fail
(with errno EINVAL).
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
