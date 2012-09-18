MIME-Version: 1.0
In-Reply-To: <1347992127.31966.93.camel@moss-pluto.epoch.ncsc.mil>
References: <4FFCC3C7.8080602@tresys.com>
	<1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
	<4FFDD7C7.4020703@tresys.com>
	<1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil>
	<1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>
	<CAFftDdqjtYd0RGoZ12dcJnyWpD42MPYf_KwkJitwYcaF=+ptgA@mail.gmail.com>
	<CAFftDdpDkSWWzgKiCyTLuJpAZNRtihgmoRE0WhBcbGa2tdfwPA@mail.gmail.com>
	<1347992127.31966.93.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 18 Sep 2012 11:25:11 -0700
Message-ID: <CAFftDdorhQYcJ4_76cFg-Nj49vLNJYkKHyM=Zz6RvZ+3jH31vw@mail.gmail.com>
Subject: Re: seandroid and policy version
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Joman Chu <jcchu@tycho.ncsc.mil>
Content-Type: multipart/alternative; boundary=20cf303b42f7b9c9a704c9fe0275
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf303b42f7b9c9a704c9fe0275
Content-Type: text/plain; charset=ISO-8859-1

Ahh yeah you are correct, it would have to be resident in kernel memory.
With that argument that api sounds sufficient.

Could we configure the policy version independent of the makefile. This way
oem's can control what version they want, maybe something like POLICYVERS
variable could be overridden too. I think we could just drop the version
suffix unless it gets us something that we may need in the future. If it
might be beneficial for unforeseen future growth, then we would keep it an
have system_server parse the first few bytes out for the version suffix.

On Tue, Sep 18, 2012 at 11:15 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2012-09-18 at 10:54 -0700, William Roberts wrote:
> > Actually on second thought, lets ditch the version. Either your have a
> > supported version or not, and if you don't have a supported version
> > you've done something very wrong, and can extract dmesg and use
> > libsepol on the host to solve your problem. I would imagine dmesg
> > would have "cannot load policy error" and libsepol on the host could
> > tell your version number.
>
> The reason for the version number suffix is so that you can have
> multiple versions installed simultaneously for different kernels,
> allowing you to install a new version for a new kernel yet still back
> out to the old version/old kernel if necessary.
>
> If we do drop the version suffix, do we do it only for
> the /data/system/sepolicy or also for /sepolicy?  Requires a coordinated
> change across external/sepolicy and external/libselinux (and for 4.0.4,
> system/core since it still has the old policy loading logic directly
> within init).
>
> Also, do we continue to force the policy version to 24 in
> external/sepolicy Android.mk or let it go with whatever checkpolicy
> supports.  We were capping it at policy.24 because that is the least
> common denominator for all of the AOSP kernels (going back to the
> emulator kernel), and because that was the latest version supported by
> Ubuntu 10.04 (but that doesn't matter now that there is a copy of
> checkpolicy in AOSP, which we might want to get updated btw).
>
> > On Tue, Sep 18, 2012 at 10:46 AM, William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> >         How hard is it to parse the header, is it a simple fixed with
> >         field?
> >
> >
> >         I could go either way on this, I like have the version number
> >         in the file name myself.
> >
> >
> >         On Tue, Sep 18, 2012 at 10:33 AM, Stephen Smalley
> >         <sds@tycho.nsa.gov> wrote:
> >                 On Wed, 2012-07-11 at 15:49 -0400, Stephen Smalley
> >                 wrote:
> >                 > On Wed, 2012-07-11 at 15:45 -0400, Joshua Brindle
> >                 wrote:
> >                 > > Stephen Smalley wrote:
> >                 > > > On Tue, 2012-07-10 at 20:07 -0400, Joshua
> >                 Brindle wrote:
> >                 > > >> I was looking at this:
> >                 > > >>
> >                 <
> https://android-review.googlesource.com/#/c/36321/4/init/init.c>
> >                 > > >>
> >                 > > >> and remembered that years ago we had a
> >                 discussion about the .policyver
> >                 > > >> filename syntax. I kind of get it for SELinux
> >                 machines where there is
> >                 > > >> managed policy and could be multiple policies
> >                 on the system but since
> >                 > > >> SEAndroid is targeting non-device managed
> >                 policies, it adds extra code
> >                 > > >> to search for the right extension and you can
> >                 tell what version the
> >                 > > >> policy is as soon as you open it, why not ditch
> >                 the suffix?
> >                 > > >
> >                 > > > First, that patch doesn't introduce the use of
> >                 the version suffix
> >                 > > > (that's in the already merged code); it just
> >                 preserves it in the new
> >                 > > > logic for reloading policy at runtime.
> >                 > >
> >                 > > I know, it just reminded me that I wanted to
> >                 mention it :)
> >                 > >
> >                 > > >
> >                 > > > I'm open to removing the use of the policy
> >                 version suffix in a follow-on
> >                 > > > patch, although that would need to be
> >                 coordinated across sepolicy and
> >                 > > > system/core.  But the current code is consistent
> >                 with existing practice
> >                 > > > in Linux distributions (so follows principle of
> >                 least surprise) and it
> >                 > >
> >                 > >  From what I can tell most people doing anything
> >                 with SEAndroid have never been
> >                 > > exposed to SELinux so it probably is surprising to
> >                 them that the file extension
> >                 > > would change version to version.
> >                 > >
> >                 > > > allows for different versions to be installed
> >                 simultaneously (thereby
> >                 > > > supporting booting multiple kernels).  Also, we
> >                 don't have libsepol on
> >                 > >
> >                 > > I don't think this will ever be an issue on mobile
> >                 devices (and I don't think it
> >                 > > ever was an issue on real machines, more likely
> >                 that stale policies were being
> >                 > > enforced if there was some kernel or library
> >                 change)
> >                 > >
> >                 > > > the device so we cannot in fact determine the
> >                 version when we open it
> >                 > > > there presently.  So I'm not convinced we should
> >                 remove the suffix.
> >                 > >
> >                 > > We don't need libsepol, just read the first few
> >                 bytes, a la file.
> >                 >
> >                 > We need libsepol at least if we want to support
> >                 automatic downgrading of
> >                 > the policy to a version supported by the kernel.  So
> >                 unless we think we
> >                 > can guarantee that Android userspace + kernel are
> >                 always updated in
> >                 > lock-step and one will never want to support
> >                 multiple kernels, it seems
> >                 > a bit inflexible to drop the versioning.
> >
> >
> >                 So this issue has come up again in the context of
> >                 implementing device
> >                 admin APIs and a sample device admin app.  The device
> >                 admin API
> >                 implementation in the system_server needs to know how
> >                 to name the file
> >                 it creates under /data/system for the kernel policy,
> >                 but it has no way
> >                 to determine the actual policy version of the supplied
> >                 policy.  So it
> >                 doesn't know what suffix to use.  Options:
> >                 - Get rid of the version suffix altogether, or at
> >                 least for the sepolicy
> >                 file under /data/system.
> >                 - Have the system_server parse the header of the
> >                 policy image to
> >                 determine the policy version, and use that as the
> >                 suffix.
> >
> >                 Thoughts?
> >
> >                 --
> >                 Stephen Smalley
> >                 National Security Agency
> >
> >
> >
> >
> >
> >
> >         --
> >         Respectfully,
> >
> >         William C Roberts
> >
> >
> >
> >
> >
> >
> >
> > --
> > Respectfully,
> >
> > William C Roberts
> >
> >
> >
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Respectfully,

William C Roberts

--20cf303b42f7b9c9a704c9fe0275
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ahh yeah you are correct, it would have to be resident in kernel memory. Wi=
th that argument that api sounds sufficient.<div><br></div><div>Could we co=
nfigure the policy version independent of the makefile. This way oem&#39;s =
can control what version they want, maybe something like POLICYVERS variabl=
e could be=A0overridden=A0too. I think we could just drop the version suffi=
x unless it gets us something that we may need in the future. If it might b=
e beneficial for=A0unforeseen=A0future growth, then we would keep it an hav=
e system_server parse the first few bytes out for the version suffix.<br>
<br><div class=3D"gmail_quote">On Tue, Sep 18, 2012 at 11:15 AM, Stephen Sm=
alley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"=
_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<div class=3D"im">On Tue, 2012-09-18 at 10:54 -0700, William Roberts wrote:=
<br>
&gt; Actually on second thought, lets ditch the version. Either your have a=
<br>
&gt; supported version or not, and if you don&#39;t have a supported versio=
n<br>
&gt; you&#39;ve done something very wrong, and can extract dmesg and use<br=
>
&gt; libsepol on the host to solve your problem. I would imagine dmesg<br>
&gt; would have &quot;cannot load policy error&quot; and libsepol on the ho=
st could<br>
&gt; tell your version number.<br>
<br>
</div>The reason for the version number suffix is so that you can have<br>
multiple versions installed simultaneously for different kernels,<br>
allowing you to install a new version for a new kernel yet still back<br>
out to the old version/old kernel if necessary.<br>
<br>
If we do drop the version suffix, do we do it only for<br>
the /data/system/sepolicy or also for /sepolicy? =A0Requires a coordinated<=
br>
change across external/sepolicy and external/libselinux (and for 4.0.4,<br>
system/core since it still has the old policy loading logic directly<br>
within init).<br>
<br>
Also, do we continue to force the policy version to 24 in<br>
external/sepolicy Android.mk or let it go with whatever checkpolicy<br>
supports. =A0We were capping it at policy.24 because that is the least<br>
common denominator for all of the AOSP kernels (going back to the<br>
emulator kernel), and because that was the latest version supported by<br>
Ubuntu 10.04 (but that doesn&#39;t matter now that there is a copy of<br>
checkpolicy in AOSP, which we might want to get updated btw).<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; On Tue, Sep 18, 2012 at 10:46 AM, William Roberts<br>
&gt; &lt;<a href=3D"mailto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.c=
om</a>&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 How hard is it to parse the header, is it a simple fix=
ed with<br>
&gt; =A0 =A0 =A0 =A0 field?<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I could go either way on this, I like have the version=
 number<br>
&gt; =A0 =A0 =A0 =A0 in the file name myself.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 On Tue, Sep 18, 2012 at 10:33 AM, Stephen Smalley<br>
&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa=
.gov</a>&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 On Wed, 2012-07-11 at 15:49 -0400, Ste=
phen Smalley<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; On Wed, 2012-07-11 at 15:45 -0400=
, Joshua Brindle<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; Stephen Smalley wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; On Tue, 2012-07-10 at 2=
0:07 -0400, Joshua<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Brindle wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;&gt; I was looking at th=
is:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &lt;<a href=3D"https://android-review.=
googlesource.com/#/c/36321/4/init/init.c" target=3D"_blank">https://android=
-review.googlesource.com/#/c/36321/4/init/init.c</a>&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;&gt; and remembered that=
 years ago we had a<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 discussion about the .policyver<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;&gt; filename syntax. I =
kind of get it for SELinux<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 machines where there is<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;&gt; managed policy and =
could be multiple policies<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 on the system but since<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;&gt; SEAndroid is target=
ing non-device managed<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policies, it adds extra code<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;&gt; to search for the r=
ight extension and you can<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tell what version the<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;&gt; policy is as soon a=
s you open it, why not ditch<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the suffix?<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; First, that patch doesn=
&#39;t introduce the use of<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the version suffix<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; (that&#39;s in the alre=
ady merged code); it just<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preserves it in the new<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; logic for reloading pol=
icy at runtime.<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; I know, it just reminded me =
that I wanted to<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mention it :)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; I&#39;m open to removin=
g the use of the policy<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 version suffix in a follow-on<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; patch, although that wo=
uld need to be<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 coordinated across sepolicy and<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; system/core. =A0But the=
 current code is consistent<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 with existing practice<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; in Linux distributions =
(so follows principle of<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 least surprise) and it<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; =A0From what I can tell most=
 people doing anything<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 with SEAndroid have never been<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; exposed to SELinux so it pro=
bably is surprising to<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 them that the file extension<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; would change version to vers=
ion.<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; allows for different ve=
rsions to be installed<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 simultaneously (thereby<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; supporting booting mult=
iple kernels). =A0Also, we<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 don&#39;t have libsepol on<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; I don&#39;t think this will =
ever be an issue on mobile<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devices (and I don&#39;t think it<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; ever was an issue on real ma=
chines, more likely<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 that stale policies were being<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; enforced if there was some k=
ernel or library<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 change)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; the device so we cannot=
 in fact determine the<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 version when we open it<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; &gt; there presently. =A0So =
I&#39;m not convinced we should<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove the suffix.<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; &gt; We don&#39;t need libsepol, =
just read the first few<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes, a la file.<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; We need libsepol at least if we w=
ant to support<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 automatic downgrading of<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; the policy to a version supported=
 by the kernel. =A0So<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unless we think we<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; can guarantee that Android usersp=
ace + kernel are<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 always updated in<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; lock-step and one will never want=
 to support<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 multiple kernels, it seems<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; a bit inflexible to drop the vers=
ioning.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 So this issue has come up again in the=
 context of<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 implementing device<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 admin APIs and a sample device admin a=
pp. =A0The device<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 admin API<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 implementation in the system_server ne=
eds to know how<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 to name the file<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 it creates under /data/system for the =
kernel policy,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 but it has no way<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 to determine the actual policy version=
 of the supplied<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policy. =A0So it<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 doesn&#39;t know what suffix to use. =
=A0Options:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - Get rid of the version suffix altoge=
ther, or at<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 least for the sepolicy<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 file under /data/system.<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 - Have the system_server parse the hea=
der of the<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policy image to<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 determine the policy version, and use =
that as the<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suffix.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Thoughts?<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Stephen Smalley<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 National Security Agency<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 Respectfully,<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 William C Roberts<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Respectfully,<br>
&gt;<br>
&gt; William C Roberts<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--20cf303b42f7b9c9a704c9fe0275--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
