Message-ID: <559FBD3A.4090300@tycho.nsa.gov>
Date: Fri, 10 Jul 2015 08:40:26 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "Selinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>
Subject: Re: executing off of a fusefs
References: <476DC76E7D1DF2438D32BFADF679FC560102C611@ORSMSX103.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC560102C611@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/09/2015 07:04 PM, Roberts, William C wrote:
> I have this problem on Android, but it’s SELinux general. I’d like to
> get some info from those in the know.
> 
> If you wanted to be able to execute files off of fuse and have the
> kernel handle the transition, would it be as simple as having the file
> system return the getxattr call for the security label?

Aren't fuse mounts mounted with nosuid?  That disables SELinux context
transitions as well as suid/sgid/file-capabilities. Otherwise, the
kernel is trusting the userspace filesystem to not cause a privilege
escalation, potentially in excess of the privileges of the userspace
filesystem daemon itself.

Aside from that, you would also need to configure SELinux to use xattrs
from fuse (i.e. fs_use_xattr fuse ...), and change the daemon to support
getxattr, and ensure that you do not have the deadlock problem that
exists with upstream FUSE where it does not support handling a getxattr
request on the root directory during the mount(2) call.  And doing this
would affect all fuse mounts (e.g. /storage/emulated), not just a
specific one.  There was an attempt to add per-subtype support for
fs_use so that one could specify a different labeling behavior for a
specific kind of fuse filesystem, see kernel commit
102aefdda4d8275ce7d7100bc16c88c74272b260, but this was reverted in
4d546f81717d253ab67643bf072c6d8821a9249c and
29b1deb2a48a9dd02b93597aa4c055a24c0e989f as it did not work and caused a
deadlock for other fuse filesystems.
