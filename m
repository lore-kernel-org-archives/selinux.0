Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB7GujNm022721
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2010 11:56:45 -0500
Received: from smtp105.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oB7GuiU6002126
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2010 16:56:44 GMT
Message-ID: <4CFE6748.8050803@schaufler-ca.com>
Date: Tue, 07 Dec 2010 08:56:40 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>
CC: Eric Paris <eparis@redhat.com>, penguin-kernel@i-love.sakura.ne.jp,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@lst.de, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH 1/2] fs/vfs/security: pass last path component to
 LSM on inode creation
References: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>	<4CF9C1A1.7050603@schaufler-ca.com>	<1291498481.4929.77.camel@localhost.localdomain>	<4CFB4191.3090106@schaufler-ca.com>	<AANLkTinm_Or+G=BjOU7Tdher-6YnOZXdtb43nGX4N+Et@mail.gmail.com>	<4CFE4B9E.3080408@schaufler-ca.com> <AANLkTiniPUa06wh0YHTQpZWL316dofxr9CrX-1ecgNS7@mail.gmail.com>
In-Reply-To: <AANLkTiniPUa06wh0YHTQpZWL316dofxr9CrX-1ecgNS7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/7/2010 8:11 AM, Stephen Smalley wrote:
> On Tue, Dec 7, 2010 at 9:58 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> One of the concerns that has traditionally been raised when new
>> LSM hooks or changes to existing hooks are proposed is that of
>> generality. I can think of a number of ways in which the final
>> component of a pathname could be used to make access control
>> decisions, but I would not expect to be using them myself. Who
>> else might you expect to make use of this LSM "enhancement", or
>> is this something that only SELinux is ever going to want? Is
>> the component something the LSM should be providing in general,
>> or is this the only case in which it makes sense?
> The existing inode_init_security hook is useful for any security
> module that maintains security attributes on inodes (although when it
> was added, it was only first used by SELinux as that was the only such
> security module), and adding the last component name as a further
> input argument is a general change that could benefit any such
> security module that wants to use that information in determining the
> correct attribute value for the new inode.  The fact that there are
> only two such modules that implement the hook today (SELinux and
> Smack), and that you chose to not use the argument for Smack doesn't
> lessen its generality.   If you have an alternative parameter that
> would be more general that you would like to pass to the hook that
> would enable SELinux to do what it wants and provide benefit to Smack,
> then feel free to suggest it.

Let's assume for the moment that no one has a significant objection
to adding the component name to inode_init_security. I am not
suggesting that what gets passed to inode_init_security is
insufficiently general. I am asking if there are other hooks that
also ought to have the component name as one of their parameters.
Yes, I understand the concept of "if it ain't broke ...", and that
may suffice at this point, and if not the fact that no one would be
using the component name in those other hooks definitely would. I
expect that when someone comes along with a new LSM that does access
controls based on the final component* they aren't going to suffer
unnecessary resistance from the SELinux community as they add the
component name as a parameter to other hooks.

----
* For example, only files suffixed with ".exe" can be executed and
  only files suffixed with ".so" can be mmapped.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
