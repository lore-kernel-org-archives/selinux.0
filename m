Subject: Re: Sec context of unix domain sockets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Martin Christian <martin.christian@secunet.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4E11E53A.6080003@secunet.com>
References: <4E11E53A.6080003@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Jul 2011 10:21:34 -0400
Message-ID: <1310394094.3930.46.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-07-04 at 18:07 +0200, Martin Christian wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> how are unix domain sockets handeled regarding the default context?
> Please comment on the following statement or fill my gaps:

Aside from the code, useful (but possibly out of date) documentation can
be found in the technical reports available from:
http://www.nsa.gov/research/selinux/docs.shtml

In particular, the original tech report:
http://www.nsa.gov/research/_files/selinux/papers/slinux-abs.shtml
and the supplemental one for the port to LSM:
http://www.nsa.gov/research/_files/selinux/papers/module-abs.shtml
can be quite helpful.  There may however be discrepancies between what
they describe and the current implementation.  There have been changes
over time, so knowing exactly what kernel you are using is important.

> a. Processes inherit the label of their parent, except for the init
> process which gets the label of the kernel sid

On fork, a process inherits the label of its creator/parent.
On exec, a process may transition to another label based on policy
statements (type_transition, role_transition, range_transition) or by
calling setexeccon(3) if permitted by policy prior to invoking exec.
At any time, a process may invoke setcon(3) to switch its label (if
permitted by policy) although this practice is generally discouraged -
exec-based transitions are preferred.

The initial task starts with the kernel SID, but the "init" process will
typically transition into its own unique context (e.g. init_t) when the
init binary is executed after the policy has been loaded.  Some init
programs re-exec themselves after loading policy, while in other cases
the initial policy load is performed by the initrd/initramfs script
prior to mounting the real root and executing the real init program.

> b. Ext{2-4} files/directories get the label of their parent directory.
> Root (/) gets its label from the file system context (fs_use) on creation.

You need to distinguish the components of the security context, as they
have different default behaviors.  The user field is inherited from the
creating process.  The role field is presently unused for files and is
always set to the predefined object_r role, although there have been
proposals to change this behavior.  The type field defaults to the type
of the parent directory if no matching type_transition rule was
specified in the policy.  The range/level field defaults to the
low/current level of the creating process if no matching
range_transition rule was specified in the policy.

The above describes the default behavior for labeling files (inodes)
upon creation for any filesystem type that supports labeling, not just
ext[2-4].  This default behavior can be overridden by a process by
calling setfscreatecon(3) prior to creating the file, if permitted by
policy.

For existing files, the label is determined from the xattr value
associated with the file.  If there is no xattr value set on the file,
then the file is treated as being labeled with the default file SID for
the filesystem.  By default, this is the "file" initial SID, which is
mapped to a context by the policy.  This default may be overridden via
the defcontext= mount option on a per-mount basis.  So the root
directory may default to this value until you have explicitly labeled
it.  This differs however from the context specified in the fs_use_xattr
statement, which is the context of the filesystem/superblock.

> c. Inet sockets get the label specified with the portcon statement or
> the context of kernel sid (?)

Um, no.  Sockets are typically labeled with the context of the creating
process, although support for socket type transitions was recently
added.  portcon statements are only used to label ports, not sockets,
and then you have a permission check between a socket SID and a port SID
to control operations such as binding and connecting to specific ports.
Some sockets may be labeled with the kernel SID to reflect the fact that
they are kernel-internal sockets that are not directly exposed to
applications.   

> d. Unix domain sockets are split in 2 parts: the socket file is treated
> as b. The socket object gets the label of the kernel sid (?) Is there a
> way to define the context of a unix domain socket object? The only way I
> can see would be to define a transition.

The socket file is merely a way to name/address the socket, and isn't
even strictly required - you can use the abstract namespace instead and
thus avoid any use of the filesystem for Unix/local domain sockets.
When you use a socket file, yes, it gets labeled in accordance with the
usual file labeling rules as per b.  The socket object is labeled as per
c.  Security-aware applications can use setsockcreatecon(3) to
explicitly label sockets they create.

> Explanations and clarification much appreciated.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
