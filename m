MIME-Version: 1.0
In-Reply-To: <55E0605F.7070002@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC56010597CC@ORSMSX103.amr.corp.intel.com>
 <55DDC373.8030509@tycho.nsa.gov> <20150826140659.GA26572@x250>
 <55E0605F.7070002@tycho.nsa.gov>
Date: Fri, 28 Aug 2015 07:11:21 -0700
Message-ID: <CAFftDdrOtmcesn7SWzrg+XUqHLhsTqO+-UoN=HxS6nSfLdn7Qw@mail.gmail.com>
Subject: Re: kernel access to device comm is kdevtmpfs
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>,
 "Roberts, William C" <william.c.roberts@intel.com>
Content-Type: multipart/alternative; boundary=001a1142e2208ad8f8051e5fa828
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1142e2208ad8f8051e5fa828
Content-Type: text/plain; charset=UTF-8

The best solution is to remove it if not needed. Android supports a full
udev userspace (full enough). So removing this is the direction I'm headed.
On Aug 28, 2015 6:24 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On 08/26/2015 10:07 AM, Dominick Grift wrote:
> > On Wed, Aug 26, 2015 at 09:47:31AM -0400, Stephen Smalley wrote:
> >
> > <snip>
> >
> >
> >> Fedora has tried to work around this by defining name-based type
> >> transitions for the kernel domain on /dev to label the device nodes
> >> correctly on creation.  However, name-based type transitions aren't well
> >> suited to that purpose; they only support exact match (no prefix, glob,
> >> or regex matching), they only match the last component, and they were
> >> only intended to cover exceptional cases where regular type transitions
> >> weren't sufficiently granular and one couldn't modify the creating
> >> program to explicitly label the file based on file_contexts (so they
> >> aren't designed to scale well).  Maybe we could use genfs_contexts
> >> instead (i.e. add devtmpfs to the list of filesystems that have
> >> SE_SBGENFS set in sbsec->flags, then you can specify path prefixes
> >> relative to the root of devtmpfs and label them that way).
> >
> > This sounds like a good idea to me.
>
> Unfortunately, I was wrong.  Merely setting SE_SBGENFS in sbsec->flags
> for devtmpfs filesystems does NOT enable genfs_context-based labeling of
> devtmpfs files, because devtmpfs is tmpfs-backed, and tmpfs, like ext4,
> calls security_inode_init_security() upon new inode creation to
> explicitly initialize the in-core inode security state and to obtain the
> xattr name/value pair.  That's why type transitions work for devtmpfs
> (and tmpfs).  Filesystems that use genfscon-based labeling (e.g. proc,
> sysfs, debugfs, pstore) do not support userspace file creation and
> therefore do not call that hook and their inode security state is
> initialized upon security_d_instantiate(), at which point we have a
> dentry and can therefore generate a path relative to the root.
> So we can't do this as a one-liner patch; it would be more involved.
> devtmpfs/tmpfs does ultimately call d_instantiate() ->
> security_d_instantiate(), but at that point the inode security state is
> already initialized in the usual way and we therefore don't do anything
> further with it.  We would need to rework the way inode security
> initialization works, and do it in a way that avoids weird side effects
> (e.g. if the policy defines a type transition, as in current Fedora
> policy, we don't want to override that with a genfscon-based lookup).
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Seandroid-list-request@tycho.nsa.gov.
>

--001a1142e2208ad8f8051e5fa828
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">The best solution is to remove it if not needed. Android sup=
ports a full udev userspace (full enough). So removing this is the directio=
n I&#39;m headed.</p>
<div class=3D"gmail_quote">On Aug 28, 2015 6:24 AM, &quot;Stephen Smalley&q=
uot; &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 08/26/2015 10=
:07 AM, Dominick Grift wrote:<br>
&gt; On Wed, Aug 26, 2015 at 09:47:31AM -0400, Stephen Smalley wrote:<br>
&gt;<br>
&gt; &lt;snip&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt; Fedora has tried to work around this by defining name-based type<b=
r>
&gt;&gt; transitions for the kernel domain on /dev to label the device node=
s<br>
&gt;&gt; correctly on creation.=C2=A0 However, name-based type transitions =
aren&#39;t well<br>
&gt;&gt; suited to that purpose; they only support exact match (no prefix, =
glob,<br>
&gt;&gt; or regex matching), they only match the last component, and they w=
ere<br>
&gt;&gt; only intended to cover exceptional cases where regular type transi=
tions<br>
&gt;&gt; weren&#39;t sufficiently granular and one couldn&#39;t modify the =
creating<br>
&gt;&gt; program to explicitly label the file based on file_contexts (so th=
ey<br>
&gt;&gt; aren&#39;t designed to scale well).=C2=A0 Maybe we could use genfs=
_contexts<br>
&gt;&gt; instead (i.e. add devtmpfs to the list of filesystems that have<br=
>
&gt;&gt; SE_SBGENFS set in sbsec-&gt;flags, then you can specify path prefi=
xes<br>
&gt;&gt; relative to the root of devtmpfs and label them that way).<br>
&gt;<br>
&gt; This sounds like a good idea to me.<br>
<br>
Unfortunately, I was wrong.=C2=A0 Merely setting SE_SBGENFS in sbsec-&gt;fl=
ags<br>
for devtmpfs filesystems does NOT enable genfs_context-based labeling of<br=
>
devtmpfs files, because devtmpfs is tmpfs-backed, and tmpfs, like ext4,<br>
calls security_inode_init_security() upon new inode creation to<br>
explicitly initialize the in-core inode security state and to obtain the<br=
>
xattr name/value pair.=C2=A0 That&#39;s why type transitions work for devtm=
pfs<br>
(and tmpfs).=C2=A0 Filesystems that use genfscon-based labeling (e.g. proc,=
<br>
sysfs, debugfs, pstore) do not support userspace file creation and<br>
therefore do not call that hook and their inode security state is<br>
initialized upon security_d_instantiate(), at which point we have a<br>
dentry and can therefore generate a path relative to the root.<br>
So we can&#39;t do this as a one-liner patch; it would be more involved.<br=
>
devtmpfs/tmpfs does ultimately call d_instantiate() -&gt;<br>
security_d_instantiate(), but at that point the inode security state is<br>
already initialized in the usual way and we therefore don&#39;t do anything=
<br>
further with it.=C2=A0 We would need to rework the way inode security<br>
initialization works, and do it in a way that avoids weird side effects<br>
(e.g. if the policy defines a type transition, as in current Fedora<br>
policy, we don&#39;t want to override that with a genfscon-based lookup).<b=
r>
_______________________________________________<br>
Seandroid-list mailing list<br>
<a href=3D"mailto:Seandroid-list@tycho.nsa.gov">Seandroid-list@tycho.nsa.go=
v</a><br>
To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@tycho.=
nsa.gov">Seandroid-list-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Seandroid-list-request@tycho.nsa.gov">Seandroid-list-request@tycho.nsa.gov=
</a>.<br>
</blockquote></div>

--001a1142e2208ad8f8051e5fa828--
