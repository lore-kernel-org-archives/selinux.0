MIME-Version: 1.0
In-Reply-To: <CAFftDdqjtYd0RGoZ12dcJnyWpD42MPYf_KwkJitwYcaF=+ptgA@mail.gmail.com>
References: <4FFCC3C7.8080602@tresys.com>
	<1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
	<4FFDD7C7.4020703@tresys.com>
	<1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil>
	<1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>
	<CAFftDdqjtYd0RGoZ12dcJnyWpD42MPYf_KwkJitwYcaF=+ptgA@mail.gmail.com>
Date: Tue, 18 Sep 2012 10:54:47 -0700
Message-ID: <CAFftDdpDkSWWzgKiCyTLuJpAZNRtihgmoRE0WhBcbGa2tdfwPA@mail.gmail.com>
Subject: Re: seandroid and policy version
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Joman Chu <jcchu@tycho.ncsc.mil>
Content-Type: multipart/alternative; boundary=20cf3071cf9afe4d9b04c9fd9598
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf3071cf9afe4d9b04c9fd9598
Content-Type: text/plain; charset=ISO-8859-1

Actually on second thought, lets ditch the version. Either your have a
supported version or not, and if you don't have a supported
version you've done something very wrong, and can extract dmesg and use
libsepol on the host to solve your problem. I would imagine dmesg would
have "cannot load policy error" and libsepol on the host could tell your
version number.

Bill

On Tue, Sep 18, 2012 at 10:46 AM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> How hard is it to parse the header, is it a simple fixed with field?
>
> I could go either way on this, I like have the version number in the file
> name myself.
>
>
> On Tue, Sep 18, 2012 at 10:33 AM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>
>> On Wed, 2012-07-11 at 15:49 -0400, Stephen Smalley wrote:
>> > On Wed, 2012-07-11 at 15:45 -0400, Joshua Brindle wrote:
>> > > Stephen Smalley wrote:
>> > > > On Tue, 2012-07-10 at 20:07 -0400, Joshua Brindle wrote:
>> > > >> I was looking at this:
>> > > >> <https://android-review.googlesource.com/#/c/36321/4/init/init.c>
>> > > >>
>> > > >> and remembered that years ago we had a discussion about the
>> .policyver
>> > > >> filename syntax. I kind of get it for SELinux machines where there
>> is
>> > > >> managed policy and could be multiple policies on the system but
>> since
>> > > >> SEAndroid is targeting non-device managed policies, it adds extra
>> code
>> > > >> to search for the right extension and you can tell what version the
>> > > >> policy is as soon as you open it, why not ditch the suffix?
>> > > >
>> > > > First, that patch doesn't introduce the use of the version suffix
>> > > > (that's in the already merged code); it just preserves it in the new
>> > > > logic for reloading policy at runtime.
>> > >
>> > > I know, it just reminded me that I wanted to mention it :)
>> > >
>> > > >
>> > > > I'm open to removing the use of the policy version suffix in a
>> follow-on
>> > > > patch, although that would need to be coordinated across sepolicy
>> and
>> > > > system/core.  But the current code is consistent with existing
>> practice
>> > > > in Linux distributions (so follows principle of least surprise) and
>> it
>> > >
>> > >  From what I can tell most people doing anything with SEAndroid have
>> never been
>> > > exposed to SELinux so it probably is surprising to them that the file
>> extension
>> > > would change version to version.
>> > >
>> > > > allows for different versions to be installed simultaneously
>> (thereby
>> > > > supporting booting multiple kernels).  Also, we don't have libsepol
>> on
>> > >
>> > > I don't think this will ever be an issue on mobile devices (and I
>> don't think it
>> > > ever was an issue on real machines, more likely that stale policies
>> were being
>> > > enforced if there was some kernel or library change)
>> > >
>> > > > the device so we cannot in fact determine the version when we open
>> it
>> > > > there presently.  So I'm not convinced we should remove the suffix.
>> > >
>> > > We don't need libsepol, just read the first few bytes, a la file.
>> >
>> > We need libsepol at least if we want to support automatic downgrading of
>> > the policy to a version supported by the kernel.  So unless we think we
>> > can guarantee that Android userspace + kernel are always updated in
>> > lock-step and one will never want to support multiple kernels, it seems
>> > a bit inflexible to drop the versioning.
>>
>> So this issue has come up again in the context of implementing device
>> admin APIs and a sample device admin app.  The device admin API
>> implementation in the system_server needs to know how to name the file
>> it creates under /data/system for the kernel policy, but it has no way
>> to determine the actual policy version of the supplied policy.  So it
>> doesn't know what suffix to use.  Options:
>> - Get rid of the version suffix altogether, or at least for the sepolicy
>> file under /data/system.
>> - Have the system_server parse the header of the policy image to
>> determine the policy version, and use that as the suffix.
>>
>> Thoughts?
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>>
>
>
> --
> Respectfully,
>
> William C Roberts
>
>
>


-- 
Respectfully,

William C Roberts

--20cf3071cf9afe4d9b04c9fd9598
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Actually=A0on second thought, lets ditch the version. Either your have=
 a supported version or not, and if you don&#39;t have a supported version=
=A0you&#39;ve=A0done something very wrong, and can extract dmesg and use li=
bsepol on the host to solve your problem. I would imagine dmesg would have =
&quot;cannot load policy error&quot; and libsepol on the host could tell yo=
ur version number.=A0</div>
<div><br></div><div>Bill<br><div><br><div class=3D"gmail_quote">On Tue, Sep=
 18, 2012 at 10:46 AM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a=
>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">How hard is it to parse the header, is it a =
simple fixed with field?<div><br></div><div>I could go either way on this, =
I like have the version number in the file name myself.<div>
<div class=3D"h5"><br><br><div class=3D"gmail_quote">On Tue, Sep 18, 2012 a=
t 10:33 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tyc=
ho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div>On Wed, 2012-07-11 at 15:49 -0400,=
 Stephen Smalley wrote:<br>
&gt; On Wed, 2012-07-11 at 15:45 -0400, Joshua Brindle wrote:<br>
&gt; &gt; Stephen Smalley wrote:<br>
&gt; &gt; &gt; On Tue, 2012-07-10 at 20:07 -0400, Joshua Brindle wrote:<br>
&gt; &gt; &gt;&gt; I was looking at this:<br>
&gt; &gt; &gt;&gt; &lt;<a href=3D"https://android-review.googlesource.com/#=
/c/36321/4/init/init.c" target=3D"_blank">https://android-review.googlesour=
ce.com/#/c/36321/4/init/init.c</a>&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; and remembered that years ago we had a discussion about =
the .policyver<br>
&gt; &gt; &gt;&gt; filename syntax. I kind of get it for SELinux machines w=
here there is<br>
&gt; &gt; &gt;&gt; managed policy and could be multiple policies on the sys=
tem but since<br>
&gt; &gt; &gt;&gt; SEAndroid is targeting non-device managed policies, it a=
dds extra code<br>
&gt; &gt; &gt;&gt; to search for the right extension and you can tell what =
version the<br>
&gt; &gt; &gt;&gt; policy is as soon as you open it, why not ditch the suff=
ix?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; First, that patch doesn&#39;t introduce the use of the versi=
on suffix<br>
&gt; &gt; &gt; (that&#39;s in the already merged code); it just preserves i=
t in the new<br>
&gt; &gt; &gt; logic for reloading policy at runtime.<br>
&gt; &gt;<br>
&gt; &gt; I know, it just reminded me that I wanted to mention it :)<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;m open to removing the use of the policy version suffi=
x in a follow-on<br>
&gt; &gt; &gt; patch, although that would need to be coordinated across sep=
olicy and<br>
&gt; &gt; &gt; system/core. =A0But the current code is consistent with exis=
ting practice<br>
&gt; &gt; &gt; in Linux distributions (so follows principle of least surpri=
se) and it<br>
&gt; &gt;<br>
&gt; &gt; =A0From what I can tell most people doing anything with SEAndroid=
 have never been<br>
&gt; &gt; exposed to SELinux so it probably is surprising to them that the =
file extension<br>
&gt; &gt; would change version to version.<br>
&gt; &gt;<br>
&gt; &gt; &gt; allows for different versions to be installed simultaneously=
 (thereby<br>
&gt; &gt; &gt; supporting booting multiple kernels). =A0Also, we don&#39;t =
have libsepol on<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t think this will ever be an issue on mobile devices (a=
nd I don&#39;t think it<br>
&gt; &gt; ever was an issue on real machines, more likely that stale polici=
es were being<br>
&gt; &gt; enforced if there was some kernel or library change)<br>
&gt; &gt;<br>
&gt; &gt; &gt; the device so we cannot in fact determine the version when w=
e open it<br>
&gt; &gt; &gt; there presently. =A0So I&#39;m not convinced we should remov=
e the suffix.<br>
&gt; &gt;<br>
&gt; &gt; We don&#39;t need libsepol, just read the first few bytes, a la f=
ile.<br>
&gt;<br>
&gt; We need libsepol at least if we want to support automatic downgrading =
of<br>
&gt; the policy to a version supported by the kernel. =A0So unless we think=
 we<br>
&gt; can guarantee that Android userspace + kernel are always updated in<br=
>
&gt; lock-step and one will never want to support multiple kernels, it seem=
s<br>
&gt; a bit inflexible to drop the versioning.<br>
<br>
</div></div>So this issue has come up again in the context of implementing =
device<br>
admin APIs and a sample device admin app. =A0The device admin API<br>
implementation in the system_server needs to know how to name the file<br>
it creates under /data/system for the kernel policy, but it has no way<br>
to determine the actual policy version of the supplied policy. =A0So it<br>
doesn&#39;t know what suffix to use. =A0Options:<br>
- Get rid of the version suffix altogether, or at least for the sepolicy<br=
>
file under /data/system.<br>
- Have the system_server parse the header of the policy image to<br>
determine the policy version, and use that as the suffix.<br>
<br>
Thoughts?<br>
<div><div><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div></div><=
/div><span class=3D"HOEnZb"><font color=3D"#888888">-- <br>Respectfully,<br=
><br>William C Roberts<br><br><br>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Respectfully=
,<br><br>William C Roberts<br><br><br>
</div></div>

--20cf3071cf9afe4d9b04c9fd9598--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
