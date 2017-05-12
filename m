MIME-Version: 1.0
In-Reply-To: <CAPc65ayVwUbbiqYJY3BJJAaq03d=iVB0q=Jy7A4j3KkNKgz7pw@mail.gmail.com>
References: <20170511235002.26468-1-tomcherry@google.com>
 <1494595373.9454.2.camel@tycho.nsa.gov>
 <CAPc65ayVwUbbiqYJY3BJJAaq03d=iVB0q=Jy7A4j3KkNKgz7pw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 12 May 2017 15:11:45 -0700
Message-ID: <CAFftDdpsy9L=59MZvH4RHLm6bkMT1A+TGu3JxruRLmb3fPEZGQ@mail.gmail.com>
Subject: Re: [PATCH] procattr.c: Use __BIONIC__ instead of __ANDROID__
To: Tom Cherry <tomcherry@google.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Elliott Hughes <enh@google.com>
Content-Type: multipart/alternative; boundary="001a113dbeeeb34bf6054f5afd73"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113dbeeeb34bf6054f5afd73
Content-Type: text/plain; charset="UTF-8"

On Fri, May 12, 2017 at 11:01 AM, Tom Cherry <tomcherry@google.com> wrote:

> On Fri, May 12, 2017 at 6:22 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Thu, 2017-05-11 at 16:50 -0700, Tom Cherry via Selinux wrote:
> >> This check is not specific to Android devices. If libselinux were
> >> used
> >> with Bionic on a normal Linux system this check would still be
> >> needed.
> >>
> >> Signed-off-by: Tom Cherry <tomcherry@google.com>
> >
> > Thanks, applied.  This was actually switched from ANDROID to _ANDROID__
> >  by nnk in 044f6ef104c8a9d8f42faa8756e71a0525198f5b.  We don't appear
> > to have any other uses of __ANDROID__, but we do have a number of uses
> > of ANDROID.  Offhand though these other uses of ANDROID don't appear to
> > be related to bionic but instead reflect differences in SELinux
> > userspace integration in Android vs GNU/Linux.  If however your
> > bionic/Linux system integrates SELinux support in an Android-like
> > manner (e.g. kernel policy file is /sepolicy, no /etc/selinux/config,
> > ...), then you might need to generalize those as well.
>
> Thanks!  I took a look at the other ANDROID ifdefs in the code and I'm not
> sure
> how or if they would need to be changed.  This change is needed to get
> libselinux building with bionic on the host which is just the first step.
>

Thanks for checking, and I am glad (and surprised) this was the only issue
to get
it to build for a host using bionic.


>
> >
> >> ---
> >>  libselinux/src/procattr.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> >> index ebc0adec..48dd8aff 100644
> >> --- a/libselinux/src/procattr.c
> >> +++ b/libselinux/src/procattr.c
> >> @@ -22,8 +22,8 @@ static pthread_key_t destructor_key;
> >>  static int destructor_key_initialized = 0;
> >>  static __thread char destructor_initialized;
> >>
> >> -#ifndef __ANDROID__
> >> -/* Android declares this in unistd.h and has a definition for it */
> >> +#ifndef __BIONIC__
> >> +/* Bionic declares this in unistd.h and has a definition for it */
> >>  static pid_t gettid(void)
> >>  {
> >>       return syscall(__NR_gettid);
>



-- 
Respectfully,

William C Roberts

--001a113dbeeeb34bf6054f5afd73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, May 12, 2017 at 11:01 AM, Tom Cherry <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:tomcherry@google.com" target=3D"_blank">tomcherry@google.com<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On=
 Fri, May 12, 2017 at 6:22 AM, Stephen Smalley &lt;<a href=3D"mailto:sds@ty=
cho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt; On Thu, 2017-05-11 at 16:50 -0700, Tom Cherry via Selinux wrote:<br>
&gt;&gt; This check is not specific to Android devices. If libselinux were<=
br>
&gt;&gt; used<br>
&gt;&gt; with Bionic on a normal Linux system this check would still be<br>
&gt;&gt; needed.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Tom Cherry &lt;<a href=3D"mailto:tomcherry@google.c=
om">tomcherry@google.com</a>&gt;<br>
&gt;<br>
&gt; Thanks, applied.=C2=A0 This was actually switched from ANDROID to _AND=
ROID__<br>
&gt;=C2=A0 by nnk in 044f6ef104c8a9d8f42faa8756e71a<wbr>0525198f5b.=C2=A0 W=
e don&#39;t appear<br>
&gt; to have any other uses of __ANDROID__, but we do have a number of uses=
<br>
&gt; of ANDROID.=C2=A0 Offhand though these other uses of ANDROID don&#39;t=
 appear to<br>
&gt; be related to bionic but instead reflect differences in SELinux<br>
&gt; userspace integration in Android vs GNU/Linux.=C2=A0 If however your<b=
r>
&gt; bionic/Linux system integrates SELinux support in an Android-like<br>
&gt; manner (e.g. kernel policy file is /sepolicy, no /etc/selinux/config,<=
br>
&gt; ...), then you might need to generalize those as well.<br>
<br>
</span>Thanks!=C2=A0 I took a look at the other ANDROID ifdefs in the code =
and I&#39;m not sure<br>
how or if they would need to be changed.=C2=A0 This change is needed to get=
<br>
libselinux building with bionic on the host which is just the first step.<b=
r></blockquote><div><br></div><div>Thanks for checking, and I am glad (and =
surprised) this was the only issue to get</div><div>it to build for a host =
using bionic.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 libselinux/src/procattr.c | 4 ++--<br>
&gt;&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c=
<br>
&gt;&gt; index ebc0adec..48dd8aff 100644<br>
&gt;&gt; --- a/libselinux/src/procattr.c<br>
&gt;&gt; +++ b/libselinux/src/procattr.c<br>
&gt;&gt; @@ -22,8 +22,8 @@ static pthread_key_t destructor_key;<br>
&gt;&gt;=C2=A0 static int destructor_key_initialized =3D 0;<br>
&gt;&gt;=C2=A0 static __thread char destructor_initialized;<br>
&gt;&gt;<br>
&gt;&gt; -#ifndef __ANDROID__<br>
&gt;&gt; -/* Android declares this in unistd.h and has a definition for it =
*/<br>
&gt;&gt; +#ifndef __BIONIC__<br>
&gt;&gt; +/* Bionic declares this in unistd.h and has a definition for it *=
/<br>
&gt;&gt;=C2=A0 static pid_t gettid(void)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return syscall(__NR_gettid);<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Respectfu=
lly,<br><br>William C Roberts<br><br></div>
</div></div>

--001a113dbeeeb34bf6054f5afd73--
