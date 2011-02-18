Subject: inode security state and cluster file systems
To: SELinux@tycho.nsa.gov
Message-ID: <OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com>
From: Yuri L Volobuev <volobuev@us.ibm.com>
Date: Thu, 17 Feb 2011 21:08:24 -0600
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=09BBF2A9DFE53D778f9e8a93df938690918c09BBF2A9DFE53D77"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0__=09BBF2A9DFE53D778f9e8a93df938690918c09BBF2A9DFE53D77
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Hi,

I'm a developer on the IBM General Parallel File System (GPFS) team.  W=
e
are currently looking into implementing SELinux inode labeling support.=
  In
the process, we've run into some complications that have to do with the=

semantics of the Linux LSM API.  We've discussed the issue briefly with=

Eric Paris from RedHat, who has recommended that I bring up this topic =
on a
public list, since it concerns a larger issue of LSM interaction with
cluster file systems.  The idea here is not just to make a change for t=
he
benefit of an out-of-tree file system, but rather improve the LSM API t=
o be
friendlier to cluster file systems in general.

The issue has to do with the semantics of multi-node xattr updates.  Th=
e
desirable behavior is simple: a change in an inode security label (stor=
ed
as an xattr) made on nodeA should be visible on all other nodes on the =
next
access.  As far as I can tell, the current SELinux code would initializ=
e
the inode security state on the first access (e.g. via
security_d_instantiate/inode_doinit_with_dentry), and from that point o=
n
the cached security state is considered valid, until the inode is destr=
oyed
or reused.  Any subsequent inode_doinit_with_dentry call would be a no-=
op,
since isec->initialized is true.  There's no way to clear 'initialized'=
, as
far as I can see.  This works when all changes to the inode are local, =
and
a local setxattr call would update the inode security state.  However, =
if
the security label has been changed on another node, some mechanism is
needed to update the cached security state.  One could achieve this by
using security_inode_notifysecctx if the value of the security context =
is
known.  However, in the general case retrieving the context value would=

require some knowledge about the implementation details of LSM (like th=
e
name of the security label xattr), and such knowledge is currently kept=

within LSM code, and arguably should remain so.  In other words, one wo=
uld
have to resort to hacking.

To remedy this situation, a new API is proposed, courtesy of Eric Paris=
:

void security_inode_refresh_security(struct dentry *dentry);

The semantics would be similar to what SELinux inode_doinit provides: f=
or
the SECURITY_FS_USE_XATTR case, inode security state would be set based=
 on
the value of the security label fetched via getxattr -- even if the
security state is already initialized.  For other labeling behaviors, t=
he
call could be a no-op if security is already initialized, and an equiva=
lent
of inode_doinit otherwise.

Does this API look useful, in particular to other cluster file systems?=


Thanks,

yuri=

--0__=09BBF2A9DFE53D778f9e8a93df938690918c09BBF2A9DFE53D77
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>Hi,<br>
<br>
I'm a developer on the IBM General Parallel File System (GPFS) team.  W=
e are currently looking into implementing SELinux inode labeling suppor=
t.  In the process, we've run into some complications that have to do w=
ith the semantics of the Linux LSM API.  We've discussed the issue brie=
fly with Eric Paris from RedHat, who has recommended that I bring up th=
is topic on a public list, since it concerns a larger issue of LSM inte=
raction with cluster file systems.  The idea here is not just to make a=
 change for the benefit of an out-of-tree file system, but rather impro=
ve the LSM API to be friendlier to cluster file systems in general.<br>=

<br>
The issue has to do with the semantics of multi-node xattr updates.  Th=
e desirable behavior is simple: a change in an inode security label (st=
ored as an xattr) made on nodeA should be visible on all other nodes on=
 the next access.  As far as I can tell, the current SELinux code would=
 initialize the inode security state on the first access (e.g. via secu=
rity_d_instantiate/inode_doinit_with_dentry), and from that point on th=
e cached security state is considered valid, until the inode is destroy=
ed or reused.  Any subsequent inode_doinit_with_dentry call would be a =
no-op, since isec-&gt;initialized is true.  There's no way to clear 'in=
itialized', as far as I can see.  This works when all changes to the in=
ode are local, and a local setxattr call would update the inode securit=
y state.  However, if the security label has been changed on another no=
de, some mechanism is needed to update the cached security state.  One =
could achieve this by using security_inode_notifysecctx if the value of=
 the security context is known.  However, in the general case retrievin=
g the context value would require some knowledge about the implementati=
on details of LSM (like the name of the security label xattr), and such=
 knowledge is currently kept within LSM code, and arguably should remai=
n so.  In other words, one would have to resort to hacking.<br>
<br>
To remedy this situation, a new API is proposed, courtesy of Eric Paris=
:<br>
<br>
void security_inode_refresh_security(struct dentry *dentry);<br>
<br>
The semantics would be similar to what SELinux inode_doinit provides: f=
or the SECURITY_FS_USE_XATTR case, inode security state would be set ba=
sed on the value of the security label fetched via getxattr -- even if =
the security state is already initialized.  For other labeling behavior=
s, the call could be a no-op if security is already initialized, and an=
 equivalent of inode_doinit otherwise.<br>
<br>
Does this API look useful, in particular to other cluster file systems?=
<br>
<br>
Thanks,<br>
<br>
yuri</body></html>=

--0__=09BBF2A9DFE53D778f9e8a93df938690918c09BBF2A9DFE53D77--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
