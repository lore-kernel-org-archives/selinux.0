MIME-Version: 1.0
In-Reply-To: <51B23681.8070508@mthode.org>
References: <51B125CE.5020801@mthode.org>
	<51B2136F.10900@tycho.nsa.gov>
	<51B214EF.5090609@tycho.nsa.gov>
	<51B23681.8070508@mthode.org>
Date: Mon, 10 Jun 2013 14:18:16 +0200
Message-ID: <CAPzO=Nz75V3+mtRLAnk0KDQUk3R7gw=2beGgh8r69=BTWNSvgw@mail.gmail.com>
Subject: Re: selinux on zfs(onlinux)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: mthode@mthode.org
Cc: SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1132ebac7c535104decbc6ff
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001a1132ebac7c535104decbc6ff
Content-Type: text/plain; charset=ISO-8859-1

On Jun 7, 2013 9:50 PM, "Matthew Thode" <mthode@mthode.org> wrote:
>
> On 06/07/2013 12:14 PM, Stephen Smalley wrote:
> > On 06/07/2013 01:07 PM, Stephen Smalley wrote:
> >> On 06/06/2013 08:14 PM, Matthew Thode wrote:
> >>> zfs is very close to usable as a root file-system with selinux, but is
> >>> just missing one thing, it doesn't know what to set the root context
to
> >>> on mount.
> >>>
> >>> I am going to petition for this to be added as a property, but should
it
> >>> be called rootcontext (want to make sure it's valid).
> >>>
> >>> system_u:object_r:fs_t is what I used just to get my system working
> >>> (including stuff like /usr, but meh).
> >>>
> >>>
> >>> here is the upstream bug if curious
> >>> https://github.com/zfsonlinux/zfs/issues/1504
> >>
> >> The mount options interpreted by SELinux are:
> >> 1. context= (treat all inodes in the filesystem as if they had the
> >> specified security context regardless of any on-disk extended attribute
> >> value),
> >>
> >> 2. fscontext= (treat the filesystem/superblock as if it had the
> >> specified security context, used in certain permission checks affecting
> >> filesystem operations like mount and umount),
> >>
> >> 3. rootcontext= (treat the root inode in the filesystem as if it had
the
> >> specified security context but the normal behavior for the rest, useful
> >> for assigning an initial context to a root directory of e.g. a tmpfs
> >> mount), and
> >>
> >> 4. defcontext= (treat any file that lacks an extended attribute as if
it
> >> had the specified security context).
> >>
> >> The context you specified is a fscontext (fs_t), not one normally used
> >> for inodes.  But I'm not sure which one you meant to use or whether you
> >> ultimately ought to support them all.
> >
> > Possibly a simpler method would be to just pass through any mount
> > options unknown to zfs to the kernel to allow interpretation and use by
> > the vfs and/or security modules.  That would also allow use with other
> > security modules.
> >
> >
> ya, this is probably a better option.  I do think that rootcontext
> matches closest though, but am confused as to how it is different then
> fscontext.  I will suggest a more generic option though, thanks :D

The fscontext is only for the filesystem class, rootcontext is for the
mountpoint itself (thus directory and file (and other) classes).

Wkr,
  Sven

--001a1132ebac7c535104decbc6ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jun 7, 2013 9:50 PM, &quot;Matthew Thode&quot; &lt;<a href=3D"mailto:mth=
ode@mthode.org">mthode@mthode.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 06/07/2013 12:14 PM, Stephen Smalley wrote:<br>
&gt; &gt; On 06/07/2013 01:07 PM, Stephen Smalley wrote:<br>
&gt; &gt;&gt; On 06/06/2013 08:14 PM, Matthew Thode wrote:<br>
&gt; &gt;&gt;&gt; zfs is very close to usable as a root file-system with se=
linux, but is<br>
&gt; &gt;&gt;&gt; just missing one thing, it doesn&#39;t know what to set t=
he root context to<br>
&gt; &gt;&gt;&gt; on mount.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I am going to petition for this to be added as a property=
, but should it<br>
&gt; &gt;&gt;&gt; be called rootcontext (want to make sure it&#39;s valid).=
<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; system_u:object_r:fs_t is what I used just to get my syst=
em working<br>
&gt; &gt;&gt;&gt; (including stuff like /usr, but meh).<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; here is the upstream bug if curious<br>
&gt; &gt;&gt;&gt; <a href=3D"https://github.com/zfsonlinux/zfs/issues/1504"=
>https://github.com/zfsonlinux/zfs/issues/1504</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The mount options interpreted by SELinux are:<br>
&gt; &gt;&gt; 1. context=3D (treat all inodes in the filesystem as if they =
had the<br>
&gt; &gt;&gt; specified security context regardless of any on-disk extended=
 attribute<br>
&gt; &gt;&gt; value),<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 2. fscontext=3D (treat the filesystem/superblock as if it had=
 the<br>
&gt; &gt;&gt; specified security context, used in certain permission checks=
 affecting<br>
&gt; &gt;&gt; filesystem operations like mount and umount),<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 3. rootcontext=3D (treat the root inode in the filesystem as =
if it had the<br>
&gt; &gt;&gt; specified security context but the normal behavior for the re=
st, useful<br>
&gt; &gt;&gt; for assigning an initial context to a root directory of e.g. =
a tmpfs<br>
&gt; &gt;&gt; mount), and<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 4. defcontext=3D (treat any file that lacks an extended attri=
bute as if it<br>
&gt; &gt;&gt; had the specified security context).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The context you specified is a fscontext (fs_t), not one norm=
ally used<br>
&gt; &gt;&gt; for inodes. =A0But I&#39;m not sure which one you meant to us=
e or whether you<br>
&gt; &gt;&gt; ultimately ought to support them all.<br>
&gt; &gt;<br>
&gt; &gt; Possibly a simpler method would be to just pass through any mount=
<br>
&gt; &gt; options unknown to zfs to the kernel to allow interpretation and =
use by<br>
&gt; &gt; the vfs and/or security modules. =A0That would also allow use wit=
h other<br>
&gt; &gt; security modules.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; ya, this is probably a better option. =A0I do think that rootcontext<b=
r>
&gt; matches closest though, but am confused as to how it is different then=
<br>
&gt; fscontext. =A0I will suggest a more generic option though, thanks :D</=
p>
<p dir=3D"ltr">The fscontext is only for the filesystem class, rootcontext =
is for the mountpoint itself (thus directory and file (and other) classes).=
</p>
<p dir=3D"ltr">Wkr,<br>
=A0 Sven<br>
</p>

--001a1132ebac7c535104decbc6ff--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
