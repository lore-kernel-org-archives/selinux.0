In-Reply-To: <AANLkTimE5_WdsVVp-LtTGYoUMGstW7H1poj8o6PdWow-@mail.gmail.com>
References: <OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com>	<1298035684.23592.6.camel@moss-pluto>
	<OFEB82FE90.36E35458-ON8625783B.005690C6-8625783B.00594784@us.ibm.com>	<1298046341.23592.16.camel@moss-pluto>
	<OFAB2AD310.C60A1CF4-ON8625783B.007027A3-8625783B.0071BDC6@us.ibm.com>	<AANLkTimtVyT-7p+6H9=8KGE=cmHNr7kgramsdH5coWwv@mail.gmail.com>
	<AANLkTik76eqvav9NvFbKSacitH-aZ14vxUeDRc_JWYGY@mail.gmail.com>	<4D6176AD.3000807@schaufler-ca.com> <AANLkTimE5_WdsVVp-LtTGYoUMGstW7H1poj8o6PdWow-@mail.gmail.com>
Subject: Re: inode security state and cluster file systems
To: Eric Paris <eparis@parisplace.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Joel Becker <jlbec@evilplan.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Mark Fasheh <mfasheh@suse.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@davequigley.com, SELinux@tycho.nsa.gov, swhiteho@redhat.com
Message-ID: <OFC30DDCC5.CAFCD9BB-ON8625783F.0052D06B-8625783F.0054BB06@us.ibm.com>
From: Yuri L Volobuev <volobuev@us.ibm.com>
Date: Tue, 22 Feb 2011 09:25:24 -0600
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=09BBF2ACDFC156FB8f9e8a93df938690918c09BBF2ACDFC156FB"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0__=09BBF2ACDFC156FB8f9e8a93df938690918c09BBF2ACDFC156FB
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


> >>> If we made the invalidation point an explicit refresh of the labe=
l at
> >>> least the filesystems would be able to control both of those
> >>> problems.....
> >
> > So far the only case that has been discussed is one in which there
> > is one security attribute on the file. While we don't have it yet t=
here
> > are a couple of efforts underway to support multiple concurrent LSM=
s.
> > It is also plausible for an LSM to use more than one security attri=
bute
> > on a given file. An approach based on a secid interface may not wor=
k
> > in either scenario. If you want a comparative example, look at
directory
> > default ACLs, which are important security information, but are nor=

used
> > to make access decisions on the object to which they are attached.
>
> I'm still leaning towards a solution in which the filesystem needs to=

> tell the LSM that it's labels are invalid (I suggest that be done on
> any change in the security.* namespace) and that same call needs to
> cause the LSM to refresh its labels.  I seem to think that such a cal=
l
> would work just fine with any LSM stacker or even
> multi-attribute/multi-label LSM (which uses the security.* namespace)=
.

In the "pull" model that GFS2, OCFS2, and GPFS apparently follow, on a
given node the file system code doesn't know that an xattr in a securit=
y.*
namespace got modified on another node.  All that is known is that the =
lock
protecting inode xattrs has been lost, so now everything protected by t=
his
lock is invalid.  The next time this information is needed, it has to b=
e
re-initialized (e.g. by reading data from disk).  The security attribut=
e
label may or may not have changed, that is not known at that point, but=
 the
inode security state has to be re-initialized in case it did.  So it so=
unds
like all distributed file systems would benefit from an LSM API call th=
at
invalidates inode security state.

I think the tricky part here is how/when to drive inode security state
refresh, once it has been invalidated.  File system code could do this
easily at dentry revalidation time, possibly even using existing API, l=
ike
security_d_instantiate (provided it does a full re-init, using getxattr=
, if
it sees that the inode state has been invalidated).  A dentry is
conveniently available at this juncture.
Permission checking prior to a write on an already open file is a somew=
hat
different problem.  In the current code, the permission check is made
before file system code gets involved, so the call to re-init inode
security state has to be made in VFS or LSM code, before the permission=

check.  It would probably be easier/more logical to do this in
security_file_permission.  Since the latter is passed struct file *file=
, a
dentry could be easily obtained as file->f_path.dentry.

yuri=

--0__=09BBF2ACDFC156FB8f9e8a93df938690918c09BBF2ACDFC156FB
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>&gt; &gt;&gt;&gt; If we made the invalidation point an explicit =
refresh of the label at<br>
&gt; &gt;&gt;&gt; least the filesystems would be able to control both o=
f those<br>
&gt; &gt;&gt;&gt; problems.....<br>
&gt; &gt;<br>
&gt; &gt; So far the only case that has been discussed is one in which =
there<br>
&gt; &gt; is one security attribute on the file. While we don't have it=
 yet there<br>
&gt; &gt; are a couple of efforts underway to support multiple concurre=
nt LSMs.<br>
&gt; &gt; It is also plausible for an LSM to use more than one security=
 attribute<br>
&gt; &gt; on a given file. An approach based on a secid interface may n=
ot work<br>
&gt; &gt; in either scenario. If you want a comparative example, look a=
t directory<br>
&gt; &gt; default ACLs, which are important security information, but a=
re nor used<br>
&gt; &gt; to make access decisions on the object to which they are atta=
ched.<br>
&gt; <br>
&gt; I'm still leaning towards a solution in which the filesystem needs=
 to<br>
&gt; tell the LSM that it's labels are invalid (I suggest that be done =
on<br>
&gt; any change in the security.* namespace) and that same call needs t=
o<br>
&gt; cause the LSM to refresh its labels. &nbsp;I seem to think that su=
ch a call<br>
&gt; would work just fine with any LSM stacker or even<br>
&gt; multi-attribute/multi-label LSM (which uses the security.* namespa=
ce).<br>
</tt><br>
<tt>In the &quot;pull&quot; model that GFS2, OCFS2, and GPFS apparently=
 follow, on a given node the file system code doesn't know that an xatt=
r in a security.* namespace got modified on another node. &nbsp;All tha=
t is known is that the lock protecting inode xattrs has been lost, so n=
ow everything protected by this lock is invalid. &nbsp;The next time th=
is information is needed, it has to be re-initialized (e.g. by reading =
data from disk). &nbsp;The security attribute label may or may not have=
 changed, that is not known at that point, but the inode security state=
 has to be re-initialized in case it did. &nbsp;So it sounds like all d=
istributed file systems would benefit from an LSM API call that invalid=
ates inode security state.</tt><br>
<br>
<tt>I think the tricky part here is how/when to drive inode security st=
ate refresh, once it has been invalidated. &nbsp;File system code could=
 do this easily at dentry revalidation time, possibly even using existi=
ng API, like </tt><tt>security_d_instantiate (provided it does a full r=
e-init, using getxattr, if it sees that the inode state has been invali=
dated). &nbsp;A dentry is conveniently available at this juncture. &nbs=
p;</tt><br>
<tt>Permission checking prior to a write on an already open file is a s=
omewhat different problem. &nbsp;In the current code, the permission ch=
eck is made before file system code gets involved, so the call to re-in=
it inode security state has to be made in VFS or LSM code, before the p=
ermission check. &nbsp;It would probably be easier/more logical to do t=
his in </tt><tt>security_file_permission. &nbsp;Since the latter is pas=
sed struct file *file, a dentry could be easily obtained as </tt><tt>fi=
le-&gt;f_path.dentry.</tt><br>
<br>
<tt>yuri</tt></body></html>=

--0__=09BBF2ACDFC156FB8f9e8a93df938690918c09BBF2ACDFC156FB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
