In-Reply-To: <1298046341.23592.16.camel@moss-pluto>
References: <OFF4F848CC.EFE2D45E-ON8625783A.0076BBE7-8625783B.001141BA@us.ibm.com>	 <1298035684.23592.6.camel@moss-pluto>
	 <OFEB82FE90.36E35458-ON8625783B.005690C6-8625783B.00594784@us.ibm.com> <1298046341.23592.16.camel@moss-pluto>
Subject: Re: inode security state and cluster file systems
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov,
        selinux@davequigley.com, swhiteho@redhat.com
Message-ID: <OFAB2AD310.C60A1CF4-ON8625783B.007027A3-8625783B.0071BDC6@us.ibm.com>
From: Yuri L Volobuev <volobuev@us.ibm.com>
Date: Fri, 18 Feb 2011 14:42:16 -0600
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=09BBF2A8DFE3A1338f9e8a93df938690918c09BBF2A8DFE3A133"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0__=09BBF2A8DFE3A1338f9e8a93df938690918c09BBF2A8DFE3A133
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


> > The logical place to make this call would be at d_revalidate time.
> >  The new value of the security context is not readily available at
> > that time, as described above.  Technically speaking, the file syst=
em
> > code could know the new context -- it can do a getxattr, which woul=
d
> > return the up-to-date label content.  However, this would require
> > knowing the security label xattr name, which is not readily availab=
le
> > in RHEL6.  (I actually had the code working with correct semantics =
on
> > RHEL5, which has security_inode_xattr_getsuffix(), but it would be
> > fair to say that it was hacking around the API rather than leveragi=
ng
> > it as intended).
> >
> > Hope it makes things clearer.
>
> Yes, thanks.  One lingering concern then is that we revalidate
> permissions on read/write via security_file_permission ->
> selinux_file_permission.  Within selinux_file_permission, we check
> whether the task SID, inode SID, or policy has changed since the file=

> was opened, and if so, we recheck permissions.  If you only make the
> call at d_revalidate time, then we'll only update the inode sid on ne=
xt
> lookup and thus ongoing reads/writes on an already open file will
> continue to succeed even if they should be denied by policy until som=
e
> process on that node attempts another lookup.

Interesting.  With plain Unix semantics, a permission check would be do=
ne
at file open time, and wouldn't be repeated at read/write time.  So the=
re's
no attempt by the kernel proper to revalidate the associated dentry/ino=
de
prior to calling read/write fop.  So, if the file owner were to change =
(for
example), the local inode would not necessarily have the correct owner
prior to a write, which is probably important.  So this is something th=
at
transcends the issue of inode security state per se.

Another possible approach here, as noted by GFS folks, is to invalidate=

inode security state when a lock protecting it is lost.  GPFS could
certainly take that approach as well (it's done already for "regular" i=
node
state).  In this case, it sounds like kernel/LSM code would be responsi=
ble
to refreshing the inode security state when it's needed (although fs co=
de
could also drive this explicitly at d_revalidate time).  I'd be fine wi=
th
that approach.

yuri=

--0__=09BBF2A8DFE3A1338f9e8a93df938690918c09BBF2A8DFE3A133
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>&gt; &gt; The logical place to make this call would be at d_reva=
lidate time.<br>
&gt; &gt; &nbsp;The new value of the security context is not readily av=
ailable at<br>
&gt; &gt; that time, as described above. &nbsp;Technically speaking, th=
e file system<br>
&gt; &gt; code could know the new context -- it can do a getxattr, whic=
h would<br>
&gt; &gt; return the up-to-date label content. &nbsp;However, this woul=
d require<br>
&gt; &gt; knowing the security label xattr name, which is not readily a=
vailable<br>
&gt; &gt; in RHEL6. &nbsp;(I actually had the code working with correct=
 semantics on<br>
&gt; &gt; RHEL5, which has security_inode_xattr_getsuffix(), but it wou=
ld be<br>
&gt; &gt; fair to say that it was hacking around the API rather than le=
veraging<br>
&gt; &gt; it as intended).<br>
&gt; &gt; <br>
&gt; &gt; Hope it makes things clearer.<br>
&gt; <br>
&gt; Yes, thanks. &nbsp;One lingering concern then is that we revalidat=
e<br>
&gt; permissions on read/write via security_file_permission -&gt;<br>
&gt; selinux_file_permission. &nbsp;Within selinux_file_permission, we =
check<br>
&gt; whether the task SID, inode SID, or policy has changed since the f=
ile<br>
&gt; was opened, and if so, we recheck permissions. &nbsp;If you only m=
ake the<br>
&gt; call at d_revalidate time, then we'll only update the inode sid on=
 next<br>
&gt; lookup and thus ongoing reads/writes on an already open file will<=
br>
&gt; continue to succeed even if they should be denied by policy until =
some<br>
&gt; process on that node attempts another lookup.<br>
</tt><br>
<tt>Interesting. &nbsp;With plain Unix semantics, a permission check wo=
uld be done at file open time, and wouldn't be repeated at read/write t=
ime. &nbsp;So there's no attempt by the kernel proper to revalidate the=
 associated dentry/inode prior to calling read/write fop. &nbsp;So, if =
the file owner were to change (for example), the local inode would not =
necessarily have the correct owner prior to a write, which is probably =
important. &nbsp;So this is something that transcends the issue of inod=
e security state per se.</tt><br>
<br>
<tt>Another possible approach here, as noted by GFS folks, is to invali=
date inode security state when a lock protecting it is lost. &nbsp;GPFS=
 could certainly take that approach as well (it's done already for &quo=
t;regular&quot; inode state). &nbsp;In this case, it sounds like kernel=
/LSM code would be responsible to refreshing the inode security state w=
hen it's needed (although fs code could also drive this explicitly at d=
_revalidate time). &nbsp;I'd be fine with that approach.</tt><br>
<br>
<tt>yuri</tt></body></html>=

--0__=09BBF2A8DFE3A1338f9e8a93df938690918c09BBF2A8DFE3A133--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
