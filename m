Subject: Re: A few questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Quigley <selinux@davequigley.com>
Cc: Yao <yffbrave@163.com>, selinux@tycho.nsa.gov
In-Reply-To: <c7e5c731607a1975c4e24583bdf36d98@countercultured.net>
References: <14357406.17003.135edba7f47.Coremail.yffbrave@163.com>
	 <c7e5c731607a1975c4e24583bdf36d98@countercultured.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Mar 2012 11:23:55 -0500
Message-ID: <1331137435.16697.53.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-07 at 10:57 -0500, David Quigley wrote:
> On 03/07/2012 10:15, Yao wrote:
> > Hi,
> > Lately I'm studying SELinux and got some questions which I want to be
> > clear.
> >
> > (1)I know SELinux is based on Flask architecture and I know where the
> > SS is, but I'm not sure
> > where the OM locates, I guess the variable "security_ops" which
> > belongs to LSM represents the OM, am I right?
> >
> > (2)the struct "selinux_ops" in file hooks.c is declared as "static",
> > why not add "const" qualifier so that
> > the it will be put in read-only data section in the kernel?
> >
> > (3)Is there any way to hack the SELinux, I mean, to disable it on the
> > fly? For example, replace the policy db with a
> > blank file so that any permission is allowed. Is it feasible?
> >
> > Regards,
> > Yao
> 
> So In order.
> 
> I asked (1) when I first started as well and the answer I got was the 
> kernel itself is the object manager. You'll notice a bunch of security_ 
> calles through the kernel. These are the enforcement points which query 
> the security server through the selinux specific hooks behind the LSM 
> interface.

In general, the "object manager" is the component that implements the
object abstraction and operations and is responsible for enforcement of
the policy decisions.  The kernel can either be viewed as a single
object manager or as a collection of object managers (e.g. the process
management subsystem, the vfs and filesystem implementations, the
networking subsystem, the ipc subsystem, ...).  In the case of the Flask
microkernel-based OS, the various subsystems were in fact separate tasks
running on the microkernel.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
