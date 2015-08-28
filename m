MIME-Version: 1.0
In-Reply-To: <20150828142711.GA23231@x250>
References: <476DC76E7D1DF2438D32BFADF679FC56010597CC@ORSMSX103.amr.corp.intel.com>
 <55DDC373.8030509@tycho.nsa.gov> <20150826140659.GA26572@x250>
 <55E0605F.7070002@tycho.nsa.gov>
 <CAFftDdrOtmcesn7SWzrg+XUqHLhsTqO+-UoN=HxS6nSfLdn7Qw@mail.gmail.com>
 <20150828142711.GA23231@x250>
Date: Fri, 28 Aug 2015 07:58:59 -0700
Message-ID: <CAFftDdq=aasRHsuB8pF2vb2uu23TOZ-P7dc37JqPXwzoe8OE9A@mail.gmail.com>
Subject: Re: kernel access to device comm is kdevtmpfs
From: William Roberts <bill.c.roberts@gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Eric Paris <eparis@redhat.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114787a6dbea45051e6052fc
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114787a6dbea45051e6052fc
Content-Type: text/plain; charset=UTF-8

On Fri, Aug 28, 2015 at 7:27 AM, Dominick Grift <dac.override@gmail.com>
wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On Fri, Aug 28, 2015 at 07:11:21AM -0700, William Roberts wrote:
> > The best solution is to remove it if not needed. Android supports a full
> > udev userspace (full enough). So removing this is the direction I'm
> headed.
> > On Aug 28, 2015 6:24 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> Sure, but this thread mixes up two topics.
>
> 1. to use devtmpfs or not to use devtmpfs
> 2. support genfscon style labeling for devtmpfs
>
> I was focussing on the second question, and i saw no reason not to
> support genfscon style labeling for devtmpfs, as it would have just
> provided more flexibility and it wouldnt force anyone into anything.
>
> Not that it matters now though. Since it turns out to not be so
> straightforward to add this functionality
>

Yes for the general case. However, this is the specific case of Android,
which I see no great reason to need it.


>
> >
> > > On 08/26/2015 10:07 AM, Dominick Grift wrote:
> > > > On Wed, Aug 26, 2015 at 09:47:31AM -0400, Stephen Smalley wrote:
> > > >
> > > > <snip>
> > > >
> > > >
> > > >> Fedora has tried to work around this by defining name-based type
> > > >> transitions for the kernel domain on /dev to label the device nodes
> > > >> correctly on creation.  However, name-based type transitions aren't
> well
> > > >> suited to that purpose; they only support exact match (no prefix,
> glob,
> > > >> or regex matching), they only match the last component, and they
> were
> > > >> only intended to cover exceptional cases where regular type
> transitions
> > > >> weren't sufficiently granular and one couldn't modify the creating
> > > >> program to explicitly label the file based on file_contexts (so they
> > > >> aren't designed to scale well).  Maybe we could use genfs_contexts
> > > >> instead (i.e. add devtmpfs to the list of filesystems that have
> > > >> SE_SBGENFS set in sbsec->flags, then you can specify path prefixes
> > > >> relative to the root of devtmpfs and label them that way).
> > > >
> > > > This sounds like a good idea to me.
> > >
> > > Unfortunately, I was wrong.  Merely setting SE_SBGENFS in sbsec->flags
> > > for devtmpfs filesystems does NOT enable genfs_context-based labeling
> of
> > > devtmpfs files, because devtmpfs is tmpfs-backed, and tmpfs, like ext4,
> > > calls security_inode_init_security() upon new inode creation to
> > > explicitly initialize the in-core inode security state and to obtain
> the
> > > xattr name/value pair.  That's why type transitions work for devtmpfs
> > > (and tmpfs).  Filesystems that use genfscon-based labeling (e.g. proc,
> > > sysfs, debugfs, pstore) do not support userspace file creation and
> > > therefore do not call that hook and their inode security state is
> > > initialized upon security_d_instantiate(), at which point we have a
> > > dentry and can therefore generate a path relative to the root.
> > > So we can't do this as a one-liner patch; it would be more involved.
> > > devtmpfs/tmpfs does ultimately call d_instantiate() ->
> > > security_d_instantiate(), but at that point the inode security state is
> > > already initialized in the usual way and we therefore don't do anything
> > > further with it.  We would need to rework the way inode security
> > > initialization works, and do it in a way that avoids weird side effects
> > > (e.g. if the policy defines a type transition, as in current Fedora
> > > policy, we don't want to override that with a genfscon-based lookup).
> > > _______________________________________________
> > > Seandroid-list mailing list
> > > Seandroid-list@tycho.nsa.gov
> > > To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to
> > > Seandroid-list-request@tycho.nsa.gov.
> > >
>
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
>
> - --
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iQGcBAEBCgAGBQJV4G+7AAoJENAR6kfG5xmc2ZsMAKJ4QmUjoFpDlvvTHe56OzLq
> wFNdebybP7q7D6/5brKuZjLhbrZYXPi+UgJzjy4w8K0T9qaMe0LWX6yHp8hNFwwb
> w0NcJJttJxMtLeH/K5KzDRFHE8qiJwQkhCrcoTecFm/9/Ho08Z1G5v0MjSbrdqKg
> pVkx2ZmzdN2WI6GH+lb7xTXfBUipylqMq7jLDyXPXxBAcjLhVsY+zS+vEcMzCUwr
> eyb6pc2KIEa1jH98gplEToHU24P1SdeJf+AkJZM0pTexb3t/010SQHc2w67um8tA
> +t5vEMp8jQxGIp56YmKqvGFAJChwRskYm/+5ghDcXZmMaSfrYIe1bHUFWbYLxJCV
> sagT45FZBiVYPp/CE0OR8LAciIRnhTe8pb0Nek0US88OPY61n7rxnvpKzn+y2k2i
> r9P6z9O8MygoOxARCDaIaEIPwCe1qbuWShH6vErN45EgL2shE55Jge11TD9U/APM
> aBuEC6J6LJDNIMWfVcVKxM54/UhZCcbQcUOuyEKzbA==
> =sL/v
> -----END PGP SIGNATURE-----
>



-- 
Respectfully,

William C Roberts

--001a114787a6dbea45051e6052fc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Aug 28, 2015 at 7:27 AM, Dominick Grift <span dir=3D"ltr">&lt;<=
a href=3D"mailto:dac.override@gmail.com" target=3D"_blank">dac.override@gma=
il.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA512<br>
<br>
</span><span class=3D"">On Fri, Aug 28, 2015 at 07:11:21AM -0700, William R=
oberts wrote:<br>
&gt; The best solution is to remove it if not needed. Android supports a fu=
ll<br>
&gt; udev userspace (full enough). So removing this is the direction I&#39;=
m headed.<br>
&gt; On Aug 28, 2015 6:24 AM, &quot;Stephen Smalley&quot; &lt;<a href=3D"ma=
ilto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
<br>
</span>Sure, but this thread mixes up two topics.<br>
<br>
1. to use devtmpfs or not to use devtmpfs<br>
2. support genfscon style labeling for devtmpfs<br>
<br>
I was focussing on the second question, and i saw no reason not to<br>
support genfscon style labeling for devtmpfs, as it would have just<br>
provided more flexibility and it wouldnt force anyone into anything.<br>
<br>
Not that it matters now though. Since it turns out to not be so<br>
straightforward to add this functionality<br></blockquote><div><br></div><d=
iv>Yes for the general case. However, this is the specific case of Android,=
 which I see no great reason to need it.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<div><div class=3D"h5"><br>
&gt;<br>
&gt; &gt; On 08/26/2015 10:07 AM, Dominick Grift wrote:<br>
&gt; &gt; &gt; On Wed, Aug 26, 2015 at 09:47:31AM -0400, Stephen Smalley wr=
ote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &lt;snip&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt; Fedora has tried to work around this by defining name-ba=
sed type<br>
&gt; &gt; &gt;&gt; transitions for the kernel domain on /dev to label the d=
evice nodes<br>
&gt; &gt; &gt;&gt; correctly on creation.=C2=A0 However, name-based type tr=
ansitions aren&#39;t well<br>
&gt; &gt; &gt;&gt; suited to that purpose; they only support exact match (n=
o prefix, glob,<br>
&gt; &gt; &gt;&gt; or regex matching), they only match the last component, =
and they were<br>
&gt; &gt; &gt;&gt; only intended to cover exceptional cases where regular t=
ype transitions<br>
&gt; &gt; &gt;&gt; weren&#39;t sufficiently granular and one couldn&#39;t m=
odify the creating<br>
&gt; &gt; &gt;&gt; program to explicitly label the file based on file_conte=
xts (so they<br>
&gt; &gt; &gt;&gt; aren&#39;t designed to scale well).=C2=A0 Maybe we could=
 use genfs_contexts<br>
&gt; &gt; &gt;&gt; instead (i.e. add devtmpfs to the list of filesystems th=
at have<br>
&gt; &gt; &gt;&gt; SE_SBGENFS set in sbsec-&gt;flags, then you can specify =
path prefixes<br>
&gt; &gt; &gt;&gt; relative to the root of devtmpfs and label them that way=
).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This sounds like a good idea to me.<br>
&gt; &gt;<br>
&gt; &gt; Unfortunately, I was wrong.=C2=A0 Merely setting SE_SBGENFS in sb=
sec-&gt;flags<br>
&gt; &gt; for devtmpfs filesystems does NOT enable genfs_context-based labe=
ling of<br>
&gt; &gt; devtmpfs files, because devtmpfs is tmpfs-backed, and tmpfs, like=
 ext4,<br>
&gt; &gt; calls security_inode_init_security() upon new inode creation to<b=
r>
&gt; &gt; explicitly initialize the in-core inode security state and to obt=
ain the<br>
&gt; &gt; xattr name/value pair.=C2=A0 That&#39;s why type transitions work=
 for devtmpfs<br>
&gt; &gt; (and tmpfs).=C2=A0 Filesystems that use genfscon-based labeling (=
e.g. proc,<br>
&gt; &gt; sysfs, debugfs, pstore) do not support userspace file creation an=
d<br>
&gt; &gt; therefore do not call that hook and their inode security state is=
<br>
&gt; &gt; initialized upon security_d_instantiate(), at which point we have=
 a<br>
&gt; &gt; dentry and can therefore generate a path relative to the root.<br=
>
&gt; &gt; So we can&#39;t do this as a one-liner patch; it would be more in=
volved.<br>
&gt; &gt; devtmpfs/tmpfs does ultimately call d_instantiate() -&gt;<br>
&gt; &gt; security_d_instantiate(), but at that point the inode security st=
ate is<br>
&gt; &gt; already initialized in the usual way and we therefore don&#39;t d=
o anything<br>
&gt; &gt; further with it.=C2=A0 We would need to rework the way inode secu=
rity<br>
&gt; &gt; initialization works, and do it in a way that avoids weird side e=
ffects<br>
&gt; &gt; (e.g. if the policy defines a type transition, as in current Fedo=
ra<br>
&gt; &gt; policy, we don&#39;t want to override that with a genfscon-based =
lookup).<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Seandroid-list mailing list<br>
&gt; &gt; <a href=3D"mailto:Seandroid-list@tycho.nsa.gov">Seandroid-list@ty=
cho.nsa.gov</a><br>
&gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-le=
ave@tycho.nsa.gov">Seandroid-list-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; To get help, send an email containing &quot;help&quot; to<br>
&gt; &gt; <a href=3D"mailto:Seandroid-list-request@tycho.nsa.gov">Seandroid=
-list-request@tycho.nsa.gov</a>.<br>
&gt; &gt;<br>
<br>
</div></div><span class=3D"">&gt; _________________________________________=
______<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
</span>&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@t=
ycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
<span class=3D""><br>
<br>
- --<br>
02DFF788<br>
4D30 903A 1CF3 B756 FB48=C2=A0 1514 3148 83A2 02DF F788<br>
<a href=3D"http://keys.gnupg.net/pks/lookup?op=3Dvindex&amp;search=3D0x3148=
83A202DFF788" rel=3D"noreferrer" target=3D"_blank">http://keys.gnupg.net/pk=
s/lookup?op=3Dvindex&amp;search=3D0x314883A202DFF788</a><br>
Dominick Grift<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v2<br>
<br>
</span>iQGcBAEBCgAGBQJV4G+7AAoJENAR6kfG5xmc2ZsMAKJ4QmUjoFpDlvvTHe56OzLq<br>
wFNdebybP7q7D6/5brKuZjLhbrZYXPi+UgJzjy4w8K0T9qaMe0LWX6yHp8hNFwwb<br>
w0NcJJttJxMtLeH/K5KzDRFHE8qiJwQkhCrcoTecFm/9/Ho08Z1G5v0MjSbrdqKg<br>
pVkx2ZmzdN2WI6GH+lb7xTXfBUipylqMq7jLDyXPXxBAcjLhVsY+zS+vEcMzCUwr<br>
eyb6pc2KIEa1jH98gplEToHU24P1SdeJf+AkJZM0pTexb3t/010SQHc2w67um8tA<br>
+t5vEMp8jQxGIp56YmKqvGFAJChwRskYm/+5ghDcXZmMaSfrYIe1bHUFWbYLxJCV<br>
sagT45FZBiVYPp/CE0OR8LAciIRnhTe8pb0Nek0US88OPY61n7rxnvpKzn+y2k2i<br>
r9P6z9O8MygoOxARCDaIaEIPwCe1qbuWShH6vErN45EgL2shE55Jge11TD9U/APM<br>
aBuEC6J6LJDNIMWfVcVKxM54/UhZCcbQcUOuyEKzbA=3D=3D<br>
=3DsL/v<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><br></div>
</div></div>

--001a114787a6dbea45051e6052fc--
