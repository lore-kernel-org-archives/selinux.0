In-Reply-To: <1298390734.30513.5.camel@localhost.localdomain>
References: <OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com>		<1298035684.23592.6.camel@moss-pluto>
	 <OFEB82FE90.36E35458-ON8625783B.005690C6-8625783B.00594784@us.ibm.com>		<1298046341.23592.16.camel@moss-pluto>
	 <OFAB2AD310.C60A1CF4-ON8625783B.007027A3-8625783B.0071BDC6@us.ibm.com>		<AANLkTimtVyT-7p+6H9=8KGE=cmHNr7kgramsdH5coWwv@mail.gmail.com>
	 <AANLkTik76eqvav9NvFbKSacitH-aZ14vxUeDRc_JWYGY@mail.gmail.com>		<4D6176AD.3000807@schaufler-ca.com>
	 <AANLkTimE5_WdsVVp-LtTGYoUMGstW7H1poj8o6PdWow-@mail.gmail.com>	 <OFC30DDCC5.CAFCD9BB-ON8625783F.0052D06B-8625783F.0054BB06@us.ibm.com> <1298390734.30513.5.camel@localhost.localdomain>
Subject: Re: inode security state and cluster file systems
To: Eric Paris <eparis@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        Eric Paris <eparis@parisplace.org>, Joel Becker <jlbec@evilplan.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Mark Fasheh <mfasheh@suse.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux@tycho.nsa.gov, selinux@davequigley.com, swhiteho@redhat.com
Message-ID: <OF1CC0F0C6.70B6A313-ON8625783F.0078620B-8625783F.007A77A2@us.ibm.com>
From: Yuri L Volobuev <volobuev@us.ibm.com>
Date: Tue, 22 Feb 2011 16:17:35 -0600
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=09BBF2ACDFEBE49B8f9e8a93df938690918c09BBF2ACDFEBE49B"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0__=09BBF2ACDFEBE49B8f9e8a93df938690918c09BBF2ACDFEBE49B
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


> > In the "pull" model that GFS2, OCFS2, and GPFS apparently follow, o=
n a
> > given node the file system code doesn't know that an xattr in a
> > security.* namespace got modified on another node.  All that is kno=
wn
> > is that the lock protecting inode xattrs has been lost, so now
> > everything protected by this lock is invalid.  The next time this
> > information is needed, it has to be re-initialized (e.g. by reading=

> > data from disk).  The security attribute label may or may not have
> > changed, that is not known at that point, but the inode security st=
ate
> > has to be re-initialized in case it did.  So it sounds like all
> > distributed file systems would benefit from an LSM API call that
> > invalidates inode security state.
> >
> > I think the tricky part here is how/when to drive inode security st=
ate
> > refresh, once it has been invalidated.  File system code could do t=
his
> > easily at dentry revalidation time, possibly even using existing AP=
I,
> > like security_d_instantiate (provided it does a full re-init, using=

> > getxattr, if it sees that the inode state has been invalidated).  A=

> > dentry is conveniently available at this juncture.
> > Permission checking prior to a write on an already open file is a
> > somewhat different problem.  In the current code, the permission ch=
eck
> > is made before file system code gets involved, so the call to re-in=
it
> > inode security state has to be made in VFS or LSM code, before the
> > permission check.  It would probably be easier/more logical to do t=
his
> > in security_file_permission.  Since the latter is passed struct fil=
e
> > *file, a dentry could be easily obtained as file->f_path.dentry.
>
> The two problems I see with doing the refresh 'when needed' is that F=
S
> code is almost certainly not designed to have a ->getxattr call durin=
g a
> read/write and not all permissions checks have a dentry.  Namely any
> calls to fs/namei.c::inode_permission() are going to end up in the LS=
M
> without a dentry and with an 'invalid' security struct.  I feel like =
the
> invalidate and refresh need to be done at the same time....

The invalidate and refresh can't really be done at the same time.  The
invalidate would happen at a point where a node has to relinquish a
distributed lock.  If in the process of relinquishing a lock one tried =
to
synchronously run an operation that requires the same lock (getxattr), =
that
would deadlock.  So the refresh has to come at a later point.

I think the scope of the "when to revalidate" problem here is not as la=
rge
as it may seem.  Cluster file systems already have the same
invalidation/revalidation problem with the struct inode content.  In mo=
st
code paths, a valid dentry is needed to get things going, and if the de=
ntry
has been marked as needing revalidation, it'll be revalidated before th=
e
first use.  The specific case of security_file_permission() being calle=
d
from rw_verify_area() would be an exception, since on vanilla Unix no
permission checking would be done prior to a read/write on an already o=
pen
file.  I don't think a getxattr() call from inside rw_verify_area() wou=
ld
be a problem for file system code, since the file system-specific code
hasn't been entered yet.  It would be somewhat difficult to verify that=
 all
special cases of this nature are covered, however.

It is not that hard to look up _a_ dentry given an inode pointer, one j=
ust
has to look at the inode's i_dentry list.  The problem is that multiple=

dentry's could be pointing to the same inode (e.g. for a regular file w=
ith
multiple hardlinks).  I don't know whether it matters which of the alia=
ses
is given as an argument to getxattr.  GPFS getxattr iop uses the dentry=

argument to get to an inode pointer, and doesn't use it for anything el=
se,
so any alias dentry would work as good as any other.  If this is also t=
he
case for other cluster file systems, perhaps doing an inode security st=
ate
refresh with nothing by inode pointer is not a problem.  From the GPFS
point of view, as long as the getxattr call is done outside of file sys=
tem
call proper, it shouldn't be a problem.  Calling it from inside of anot=
her
iop/fop could be problematic, depending on what locks are held at this
point.  There's already precedent for this (security_d_instantiate call=
ed
from d_splice_alias et al), so with care this can be made to work.

yuri=

--0__=09BBF2ACDFEBE49B8f9e8a93df938690918c09BBF2ACDFEBE49B
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>&gt; &gt; In the &quot;pull&quot; model that GFS2, OCFS2, and GP=
FS apparently follow, on a<br>
&gt; &gt; given node the file system code doesn't know that an xattr in=
 a<br>
&gt; &gt; security.* namespace got modified on another node. &nbsp;All =
that is known<br>
&gt; &gt; is that the lock protecting inode xattrs has been lost, so no=
w<br>
&gt; &gt; everything protected by this lock is invalid. &nbsp;The next =
time this<br>
&gt; &gt; information is needed, it has to be re-initialized (e.g. by r=
eading<br>
&gt; &gt; data from disk). &nbsp;The security attribute label may or ma=
y not have<br>
&gt; &gt; changed, that is not known at that point, but the inode secur=
ity state<br>
&gt; &gt; has to be re-initialized in case it did. &nbsp;So it sounds l=
ike all<br>
&gt; &gt; distributed file systems would benefit from an LSM API call t=
hat<br>
&gt; &gt; invalidates inode security state.<br>
&gt; &gt; <br>
&gt; &gt; I think the tricky part here is how/when to drive inode secur=
ity state<br>
&gt; &gt; refresh, once it has been invalidated. &nbsp;File system code=
 could do this<br>
&gt; &gt; easily at dentry revalidation time, possibly even using exist=
ing API,<br>
&gt; &gt; like security_d_instantiate (provided it does a full re-init,=
 using<br>
&gt; &gt; getxattr, if it sees that the inode state has been invalidate=
d). &nbsp;A<br>
&gt; &gt; dentry is conveniently available at this juncture. &nbsp;<br>=

&gt; &gt; Permission checking prior to a write on an already open file =
is a<br>
&gt; &gt; somewhat different problem. &nbsp;In the current code, the pe=
rmission check<br>
&gt; &gt; is made before file system code gets involved, so the call to=
 re-init<br>
&gt; &gt; inode security state has to be made in VFS or LSM code, befor=
e the<br>
&gt; &gt; permission check. &nbsp;It would probably be easier/more logi=
cal to do this<br>
&gt; &gt; in security_file_permission. &nbsp;Since the latter is passed=
 struct file<br>
&gt; &gt; *file, a dentry could be easily obtained as file-&gt;f_path.d=
entry.<br>
&gt; <br>
&gt; The two problems I see with doing the refresh 'when needed' is tha=
t FS<br>
&gt; code is almost certainly not designed to have a -&gt;getxattr call=
 during a<br>
&gt; read/write and not all permissions checks have a dentry. &nbsp;Nam=
ely any<br>
&gt; calls to fs/namei.c::inode_permission() are going to end up in the=
 LSM<br>
&gt; without a dentry and with an 'invalid' security struct. &nbsp;I fe=
el like the<br>
&gt; invalidate and refresh need to be done at the same time....<br>
</tt><br>
<tt>The invalidate and refresh can't really be done at the same time. &=
nbsp;The invalidate would happen at a point where a node has to relinqu=
ish a distributed lock. &nbsp;If in the process of relinquishing a lock=
 one tried to synchronously run an operation that requires the same loc=
k (getxattr), that would deadlock. &nbsp;So the refresh has to come at =
a later point.</tt><br>
<br>
<tt>I think the scope of the &quot;when to revalidate&quot; problem her=
e is not as large as it may seem. &nbsp;Cluster file systems already ha=
ve the same invalidation/revalidation problem with the struct inode con=
tent. &nbsp;In most code paths, a valid dentry is needed to get things =
going, and if the dentry has been marked as needing revalidation, it'll=
 be revalidated before the first use. &nbsp;The specific case of </tt><=
tt>security_file_permission() being called from </tt><tt>rw_verify_area=
() would be an exception, since on vanilla Unix no permission checking =
would be done prior to a read/write on an already open file. &nbsp;I do=
n't think a getxattr() call from inside </tt><tt>rw_verify_area() would=
 be a problem for file system code, since the file system-specific code=
 hasn't been entered yet. &nbsp;It would be somewhat difficult to verif=
y that all special cases of this nature are covered, however.</tt><br>
<br>
<tt>It is not that hard to look up _a_ dentry given an inode pointer, o=
ne just has to look at the inode's </tt><tt>i_dentry list. &nbsp;The pr=
oblem is that multiple dentry's could be pointing to the same inode (e.=
g. for a regular file with multiple hardlinks). &nbsp;I don't know whet=
her it matters which of the aliases is given as an argument to getxattr=
. &nbsp;GPFS getxattr iop uses the dentry argument to get to an inode p=
ointer, and doesn't use it for anything else, so any alias dentry would=
 work as good as any other. &nbsp;If this is also the case for other cl=
uster file systems, perhaps doing an inode security state refresh with =
nothing by inode pointer is not a problem. &nbsp;From the GPFS point of=
 view, as long as the getxattr call is done outside of file system call=
 proper, it shouldn't be a problem. &nbsp;Calling it from inside of ano=
ther iop/fop could be problematic, depending on what locks are held at =
this point. &nbsp;There's already precedent for this (security_d_instan=
tiate called from d_splice_alias et al), so with care this can be made =
to work.</tt><br>
<br>
<tt>yuri</tt></body></html>=

--0__=09BBF2ACDFEBE49B8f9e8a93df938690918c09BBF2ACDFEBE49B--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
