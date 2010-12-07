MIME-Version: 1.0
In-Reply-To: <4CFE4B9E.3080408@schaufler-ca.com>
References: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>
	<4CF9C1A1.7050603@schaufler-ca.com>
	<1291498481.4929.77.camel@localhost.localdomain>
	<4CFB4191.3090106@schaufler-ca.com>
	<AANLkTinm_Or+G=BjOU7Tdher-6YnOZXdtb43nGX4N+Et@mail.gmail.com>
	<4CFE4B9E.3080408@schaufler-ca.com>
Date: Tue, 7 Dec 2010 11:11:21 -0500
Message-ID: <AANLkTiniPUa06wh0YHTQpZWL316dofxr9CrX-1ecgNS7@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] fs/vfs/security: pass last path component to LSM
 on inode creation
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Paris <eparis@redhat.com>, penguin-kernel@i-love.sakura.ne.jp,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@lst.de
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 7, 2010 at 9:58 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> One of the concerns that has traditionally been raised when new
> LSM hooks or changes to existing hooks are proposed is that of
> generality. I can think of a number of ways in which the final
> component of a pathname could be used to make access control
> decisions, but I would not expect to be using them myself. Who
> else might you expect to make use of this LSM "enhancement", or
> is this something that only SELinux is ever going to want? Is
> the component something the LSM should be providing in general,
> or is this the only case in which it makes sense?

The existing inode_init_security hook is useful for any security
module that maintains security attributes on inodes (although when it
was added, it was only first used by SELinux as that was the only such
security module), and adding the last component name as a further
input argument is a general change that could benefit any such
security module that wants to use that information in determining the
correct attribute value for the new inode.  The fact that there are
only two such modules that implement the hook today (SELinux and
Smack), and that you chose to not use the argument for Smack doesn't
lessen its generality.   If you have an alternative parameter that
would be more general that you would like to pass to the hook that
would enable SELinux to do what it wants and provide benefit to Smack,
then feel free to suggest it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
