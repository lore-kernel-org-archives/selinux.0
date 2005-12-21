Subject: Re: [RFC] SELinux file_ioctl hook permission checks changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: NSA SELinux Mailing-List <SELinux@tycho.nsa.gov>
In-Reply-To: <1135190595.8583.5.camel@estila>
References: <1135190595.8583.5.camel@estila>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Dec 2005 14:51:03 -0500
Message-Id: <1135194663.18223.156.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-21 at 19:43 +0100, Lorenzo Hernández García-Hierro
wrote:
> We've been considering the implementation of certain changes to the permission checks applied
> to ioctl(2) calls via the selinux_file_ioctl hook.
> 
> The objective is to remove hard coded ioctl commands inside the mentioned hook and use
> "generalized" checks instead.

Note that this patch would also obsolete the SELinux 'ioctl' permission
altogether; it would no longer be used by the SELinux module at all.
Which might be no real loss because we end up having to allow it
whenever we allow read or write permission to the file due to pervasive
probing via ioctl.

Instead, every ioctl command would trigger a more specific permission
check based on its _IOC_DIR (unless its _IOC_DIR is none, in which case
it would only check access to the open file, not the inode).

> A patch based upon Chris' comments was developed ([3]). It basically performs a check for distinction
> of a read/write ioctl command and constructs an access vector with the getattr/setattr permissions.
> Although, this approach has a potential concern. setattr permission also covers chown/chmod and other
> cases. This is the desired behavior for certain ioctl commands (ie. EXT3_IOC_SETFLAGS) but other
> ones that perform data write (write permission) may not be suitable for setattr permission
> (set attributes). One example of conflict is ssh performing an ioctl on /dev/ptmx to allocate the
> pty, triggering a setattr denial since it gets _IOC_WRITE back from the _IOC_DIR checks in
> selinux_file_ioctl hook.

Right, so if we stay with getattr/setattr as the ioctl permission
checks, then we may need to allow setattr permission more widely than
presently, which would also permit use of chown/chmod on the file.  sshd
has a legitimate need to write to ptmx; it doesn't need to chown/chmod
it.

> The dilemma is that we could map _IOC_READ/WRITE to read/write permissions respectively, solving the
> ssh case but we would have still no distinction between EXT3_IOC_SETFLAGS/SETVERSION ioctl commands
> and a data write to the file.

Right, so if we switch to checking read/write permissions on ioctl based
on _IOC_DIR, then for example, chattr(1) may suddenly require write
permission to the file in order to set the ext2/3-specific attributes
via ioctl.

> Feedback will be appreciated, regarding this issue as well as suggestions, comments and possible
> solutions regarding it's implementation and impact on the policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
