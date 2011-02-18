In-Reply-To: <1298035684.23592.6.camel@moss-pluto>
References: <OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com> <1298035684.23592.6.camel@moss-pluto>
Subject: Re: inode security state and cluster file systems
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@davequigley.com, SELinux@tycho.nsa.gov, swhiteho@redhat.com
Message-ID: <OFEB82FE90.36E35458-ON8625783B.005690C6-8625783B.00594784@us.ibm.com>
From: Yuri L Volobuev <volobuev@us.ibm.com>
Date: Fri, 18 Feb 2011 10:15:05 -0600
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=09BBF2A8DFC516568f9e8a93df938690918c09BBF2A8DFC51656"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0__=09BBF2A8DFC516568f9e8a93df938690918c09BBF2A8DFC51656
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


> > The issue has to do with the semantics of multi-node xattr updates.=

> > The desirable behavior is simple: a change in an inode security lab=
el
> > (stored as an xattr) made on nodeA should be visible on all other
> > nodes on the next access. As far as I can tell, the current SELinux=

> > code would initialize the inode security state on the first access
> > (e.g. via security_d_instantiate/inode_doinit_with_dentry), and fro=
m
> > that point on the cached security state is considered valid, until =
the
> > inode is destroyed or reused. Any subsequent inode_doinit_with_dent=
ry
> > call would be a no-op, since isec->initialized is true. There's no =
way
> > to clear 'initialized', as far as I can see. This works when all
> > changes to the inode are local, and a local setxattr call would upd=
ate
> > the inode security state. However, if the security label has been
> > changed on another node, some mechanism is needed to update the cac=
hed
> > security state. One could achieve this by using
> > security_inode_notifysecctx if the value of the security context is=

> > known. However, in the general case retrieving the context value wo=
uld
> > require some knowledge about the implementation details of LSM (lik=
e
> > the name of the security label xattr), and such knowledge is curren=
tly
> > kept within LSM code, and arguably should remain so. In other words=
,
> > one would have to resort to hacking.
>
> Isn't this what inode_getsecctx() is for?  So that on the node where =
the
> setxattr() occurs, you can fetch the security context (without needin=
g
> to know the attribute name or whether it is even implemented via zero=
,
> one, or many attributes), and then ship that context over the wire us=
ing
> whatever protocol you like to the other nodes.  Then on the other nod=
es,
> you can invoke inode_notifysecctx() as you said to update the context=
.
> I think that is how it works for the labeled NFS support (not yet in
> mainline).  Admittedly that is a simpler client/server model and not =
a
> distributed cluster model.

In principle, it's possible to use the "push mode": the node that chang=
es
the xattr would notify others, and since it has all of the information
about the xattr at hand, on the receiving side inode_notifysecctx() cou=
ld
be used.  The "push mode" has inherent problematic properties though.  =
The
sender could die before notifying all nodes that have legitimate intere=
st
in seeing the update, which would make it tricky to commit the xattr ch=
ange
to disk and notify all interested nodes without the risk of an
inconsistency.  Doing this would require a synchronous RPC multicast,
possibly to a large number of nodes, and that's not a good thing for
performance and scalability.  For a client-server model, this makes sen=
se,
for a cluster file system, not necessarily.

Another approach to managing metadata consistency is the "pull mode": t=
he
node doing the update would acquire a distributed lock of an appropriat=
e
strength, which would make other nodes relinquish any conflicting locks=

they may have had and invalidate metadata protected by those locks.  Th=
e
writer would then make a (logged) metadata update.  If another node nee=
ds
to access the metadata object in question again, it would acquire the
appropriate distributed lock (which would make the writer
relinquish/downgrade its lock and flush corresponding dirty objects to
disk), and read the metadata object from disk.  This is the mode that G=
PFS
uses for metadata updates, e.g. inode attribute (mtime, uid, etc) chang=
es.
On Linux, struct inode is transparent, so the file system code could ma=
rk
its content as invalid when relinquishing the lock that protects it (an=
d
mark any corresponding dentry as needing revalidation), and then update=
 it
with the up-to-date content when a new stat or d_revalidate arrives.  O=
ne
can't do the same with the inode security state, at present.

> > To remedy this situation, a new API is proposed, courtesy of Eric
> > Paris:
> >
> > void security_inode_refresh_security(struct dentry *dentry);
> >
> > The semantics would be similar to what SELinux inode_doinit provide=
s:
> > for the SECURITY_FS_USE_XATTR case, inode security state would be s=
et
> > based on the value of the security label fetched via getxattr -- ev=
en
> > if the security state is already initialized. For other labeling
> > behaviors, the call could be a no-op if security is already
> > initialized, and an equivalent of inode_doinit otherwise.
> >
> > Does this API look useful, in particular to other cluster file
> > systems?
>
> How do you know when to call this interface?  And if you know to call=

> it, why don't you know what the new context is already?

The logical place to make this call would be at d_revalidate time.  The=
 new
value of the security context is not readily available at that time, as=

described above.  Technically speaking, the file system code could know=
 the
new context -- it can do a getxattr, which would return the up-to-date
label content.  However, this would require knowing the security label
xattr name, which is not readily available in RHEL6.  (I actually had t=
he
code working with correct semantics on RHEL5, which has
security_inode_xattr_getsuffix(), but it would be fair to say that it w=
as
hacking around the API rather than leveraging it as intended).

Hope it makes things clearer.

yuri=

--0__=09BBF2A8DFC516568f9e8a93df938690918c09BBF2A8DFC51656
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>&gt; &gt; The issue has to do with the semantics of multi-node x=
attr updates.<br>
&gt; &gt; The desirable behavior is simple: a change in an inode securi=
ty label<br>
&gt; &gt; (stored as an xattr) made on nodeA should be visible on all o=
ther<br>
&gt; &gt; nodes on the next access. As far as I can tell, the current S=
ELinux<br>
&gt; &gt; code would initialize the inode security state on the first a=
ccess<br>
&gt; &gt; (e.g. via security_d_instantiate/inode_doinit_with_dentry), a=
nd from<br>
&gt; &gt; that point on the cached security state is considered valid, =
until the<br>
&gt; &gt; inode is destroyed or reused. Any subsequent inode_doinit_wit=
h_dentry<br>
&gt; &gt; call would be a no-op, since isec-&gt;initialized is true. Th=
ere's no way<br>
&gt; &gt; to clear 'initialized', as far as I can see. This works when =
all<br>
&gt; &gt; changes to the inode are local, and a local setxattr call wou=
ld update<br>
&gt; &gt; the inode security state. However, if the security label has =
been<br>
&gt; &gt; changed on another node, some mechanism is needed to update t=
he cached<br>
&gt; &gt; security state. One could achieve this by using<br>
&gt; &gt; security_inode_notifysecctx if the value of the security cont=
ext is<br>
&gt; &gt; known. However, in the general case retrieving the context va=
lue would<br>
&gt; &gt; require some knowledge about the implementation details of LS=
M (like<br>
&gt; &gt; the name of the security label xattr), and such knowledge is =
currently<br>
&gt; &gt; kept within LSM code, and arguably should remain so. In other=
 words,<br>
&gt; &gt; one would have to resort to hacking.<br>
&gt; <br>
&gt; Isn't this what inode_getsecctx() is for? &nbsp;So that on the nod=
e where the<br>
&gt; setxattr() occurs, you can fetch the security context (without nee=
ding<br>
&gt; to know the attribute name or whether it is even implemented via z=
ero,<br>
&gt; one, or many attributes), and then ship that context over the wire=
 using<br>
&gt; whatever protocol you like to the other nodes. &nbsp;Then on the o=
ther nodes,<br>
&gt; you can invoke inode_notifysecctx() as you said to update the cont=
ext.<br>
&gt; I think that is how it works for the labeled NFS support (not yet =
in<br>
&gt; mainline). &nbsp;Admittedly that is a simpler client/server model =
and not a<br>
&gt; distributed cluster model.<br>
</tt><br>
<tt>In principle, it's possible to use the &quot;push mode&quot;: the n=
ode that changes the xattr would notify others, and since it has all of=
 the information about the xattr at hand, on the receiving side inode_n=
otifysecctx() could be used. &nbsp;The &quot;push mode&quot; has inhere=
nt problematic properties though. &nbsp;The sender could die before not=
ifying all nodes that have legitimate interest in seeing the update, wh=
ich would make it tricky to commit the xattr change to disk and notify =
all interested nodes without the risk of an inconsistency. &nbsp;Doing =
this would require a synchronous RPC multicast, possibly to a large num=
ber of nodes, and that's not a good thing for performance and scalabili=
ty. &nbsp;For a client-server model, this makes sense, for a cluster fi=
le system, not necessarily.</tt><br>
<tt><br>
Another approach to managing metadata consistency is the &quot;pull mod=
e&quot;: the node doing the update would acquire a distributed lock of =
an appropriate strength, which would make other nodes relinquish any co=
nflicting locks they may have had and invalidate metadata protected by =
those locks. &nbsp;The writer would then make a (logged) metadata updat=
e. &nbsp;If another node needs to access the metadata object in questio=
n again, it would acquire the appropriate distributed lock (which would=
 make the writer relinquish/downgrade its lock and flush corresponding =
dirty objects to disk), and read the metadata object from disk. &nbsp;T=
his is the mode that GPFS uses for metadata updates, e.g. inode attribu=
te (mtime, uid, etc) changes. &nbsp;On Linux, struct inode is transpare=
nt, so the file system code could mark its content as invalid when reli=
nquishing the lock that protects it (and mark any corresponding dentry =
as needing revalidation), and then update it with the up-to-date conten=
t when a new stat or d_revalidate arrives. &nbsp;One can't do the same =
with the inode security state, at present.</tt><br>
<br>
<tt>&gt; &gt; To remedy this situation, a new API is proposed, courtesy=
 of Eric<br>
&gt; &gt; Paris:<br>
&gt; &gt; <br>
&gt; &gt; void security_inode_refresh_security(struct dentry *dentry);<=
br>
&gt; &gt; <br>
&gt; &gt; The semantics would be similar to what SELinux inode_doinit p=
rovides:<br>
&gt; &gt; for the SECURITY_FS_USE_XATTR case, inode security state woul=
d be set<br>
&gt; &gt; based on the value of the security label fetched via getxattr=
 -- even<br>
&gt; &gt; if the security state is already initialized. For other label=
ing<br>
&gt; &gt; behaviors, the call could be a no-op if security is already<b=
r>
&gt; &gt; initialized, and an equivalent of inode_doinit otherwise.<br>=

&gt; &gt; <br>
&gt; &gt; Does this API look useful, in particular to other cluster fil=
e<br>
&gt; &gt; systems?<br>
&gt; <br>
&gt; How do you know when to call this interface? &nbsp;And if you know=
 to call<br>
&gt; it, why don't you know what the new context is already?<br>
</tt><br>
<tt>The logical place to make this call would be at d_revalidate time. =
&nbsp;The new value of the security context is not readily available at=
 that time, as described above. &nbsp;Technically speaking, the file sy=
stem code could know the new context -- it can do a getxattr, which wou=
ld return the up-to-date label content. &nbsp;However, this would requi=
re knowing the security label xattr name, which is not readily availabl=
e in RHEL6. &nbsp;(I actually had the code working with correct semanti=
cs on RHEL5, which has </tt><tt>security_inode_xattr_getsuffix(), but i=
t would be fair to say that it was hacking around the API rather than l=
everaging it as intended).</tt><br>
<br>
<tt>Hope it makes things clearer.</tt><br>
<br>
<tt>yuri</tt></body></html>=

--0__=09BBF2A8DFC516568f9e8a93df938690918c09BBF2A8DFC51656--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
