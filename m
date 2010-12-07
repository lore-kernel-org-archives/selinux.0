MIME-Version: 1.0
In-Reply-To: <4CFE6748.8050803@schaufler-ca.com>
References: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>
	<4CF9C1A1.7050603@schaufler-ca.com>
	<1291498481.4929.77.camel@localhost.localdomain>
	<4CFB4191.3090106@schaufler-ca.com>
	<AANLkTinm_Or+G=BjOU7Tdher-6YnOZXdtb43nGX4N+Et@mail.gmail.com>
	<4CFE4B9E.3080408@schaufler-ca.com>
	<AANLkTiniPUa06wh0YHTQpZWL316dofxr9CrX-1ecgNS7@mail.gmail.com>
	<4CFE6748.8050803@schaufler-ca.com>
Date: Tue, 7 Dec 2010 12:34:59 -0500
Message-ID: <AANLkTinguKq9A4EwPhpFzv6rYW9EP_XDzJcS+ewXcDsO@mail.gmail.com>
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

On Tue, Dec 7, 2010 at 11:56 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Let's assume for the moment that no one has a significant objection
> to adding the component name to inode_init_security. I am not
> suggesting that what gets passed to inode_init_security is
> insufficiently general. I am asking if there are other hooks that
> also ought to have the component name as one of their parameters.
> Yes, I understand the concept of "if it ain't broke ...", and that
> may suffice at this point, and if not the fact that no one would be
> using the component name in those other hooks definitely would. I
> expect that when someone comes along with a new LSM that does access
> controls based on the final component* they aren't going to suffer
> unnecessary resistance from the SELinux community as they add the
> component name as a parameter to other hooks.
>
> ----
> * For example, only files suffixed with ".exe" can be executed and
>  only files suffixed with ".so" can be mmapped.

I think you can already achieve that via the pathname hooks, but if
not and you want it, go for it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
