MIME-Version: 1.0
References: <CABXk95BhYEZUQn74_H5Y0Ogxm23ZoLZA2Eiz22QTJwKG741B=Q@mail.gmail.com>
 <1504011284.5220.2.camel@tycho.nsa.gov>
In-Reply-To: <1504011284.5220.2.camel@tycho.nsa.gov>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Tue, 29 Aug 2017 17:06:42 +0000
Message-ID: <CABXk95DVc9EQ4hHngvG8fC_oKOf9-h3AOo2PfLz13aCShCWf0Q@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <Selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="94eb2c0483a42761170557e77004"
Subject: Re: sysfs symlinks in genfscon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c0483a42761170557e77004
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 5:50 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Mon, 2017-08-28 at 14:58 -0700, Jeffrey Vander Stoep via Selinux
> wrote:
> > Genfs_contexts does not label symlinks in sysfs, instead it leaves
> > them with the default =E2=80=9Csysfs=E2=80=9D label. Is this a bug?
>
> We excluded symlinks from genfscon labeling back when only proc was
> using genfscon for per-file labeling and we encountered a compatibility
> problem when /proc/net was moved to /proc/self/net for network
> namespaces (see commit cited below). Suddenly applications were getting
> proc_net_t:lnk_file read denials when accessing /proc/net because
> existing policies only allowed proc_t:lnk_file read and
> proc_net_t:dir/file read, so new kernel + old policy broke userspace,
> which is not allowed by Linus.  At the time, I couldn't see a use case
> where we would need to support per-file labeling of symlinks in proc,
> since the only meaningful operation on a proc symlink is read/getattr.
> The real access controls are to the individual directories/files, not
> the symlinks.
>
>
We previously allowed read on all symlinks with "sysfs" label. I've added
getattr here:
https://android-review.googlesource.com/#/c/platform/system/sepolicy/+/4705=
00/

Sounds like that should be sufficient to avoid breaking anything, at least
for sysfs.


> Do you truly need per-file labeling of symlinks in sysfs?  What's the
> use case?  I guess it is an inconsistency between the support for sysfs
> labeling via setxattr vs genfscon, but there are likely other more
> significant inconsistencies due to the support for pathname regexes in
> file_contexts versus pathname prefixes in genfscon, e.g. see
> https://github.com/SELinuxProject/selinux-kernel/issues/29
>
> That said, I agree it is an ugly hack and should likely be removed if
> it doesn't cause compatibility problems (we'd need to test on RHEL 6/7
> at least).
>
> Have you measured to see the impact of switching from setxattr to
> genfscon for sysfs labeling?
>

Yes, a couple of data points
1. Moving sysfs and debugfs to genfscon resulted in ~200 ms faster boot
time on Marlin.
2. Also on Marlin, coming out of suspend with screen off (which happens
somewhat regularly) takes about 500 ms. We were spending ~120 ms of that in
restorecon of /sys/devices/system/cpu. Moving to genfscon reduced the
restorecon time from 120 ms to 3 ms, resulting in a significant improvement
in screen-off battery life.


>
> commit ea6b184f7d521a503ecab71feca6e4057562252b
> Author: Stephen Smalley <sds@tycho.nsa.gov>
> Date:   Mon Sep 22 15:41:19 2008 -0400
>
>     selinux: use default proc sid on symlinks
>
>     As we are not concerned with fine-grained control over reading of
>     symlinks in proc, always use the default proc SID for all proc
> symlinks.
>     This should help avoid permission issues upon changes to the proc
> tree
>     as in the /proc/net -> /proc/self/net example.
>     This does not alter labeling of symlinks within /proc/pid
> directories.
>     ls -Zd /proc/net output before and after the patch should show the
> differenc
> e.
>
>     Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
>     Signed-off-by: James Morris <jmorris@namei.org>
>
>

--94eb2c0483a42761170557e77004
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue=
, Aug 29, 2017 at 5:50 AM Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.n=
sa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">On Mon, 2017-08-28 at 14:58 -0700, Jeffrey Vander Stoep via Selinux<b=
r>
wrote:<br>
&gt; Genfs_contexts does not label symlinks in sysfs, instead it leaves<br>
&gt; them with the default =E2=80=9Csysfs=E2=80=9D label. Is this a bug?<br=
>
<br>
We excluded symlinks from genfscon labeling back when only proc was<br>
using genfscon for per-file labeling and we encountered a compatibility<br>
problem when /proc/net was moved to /proc/self/net for network<br>
namespaces (see commit cited below). Suddenly applications were getting<br>
proc_net_t:lnk_file read denials when accessing /proc/net because<br>
existing policies only allowed proc_t:lnk_file read and<br>
proc_net_t:dir/file read, so new kernel + old policy broke userspace,<br>
which is not allowed by Linus.=C2=A0 At the time, I couldn&#39;t see a use =
case<br>
where we would need to support per-file labeling of symlinks in proc,<br>
since the only meaningful operation on a proc symlink is read/getattr.<br>
The real access controls are to the individual directories/files, not<br>
the symlinks.<br>
<br></blockquote><div>=C2=A0</div><div>We previously allowed read on all sy=
mlinks with &quot;sysfs&quot; label. I&#39;ve added getattr here:=C2=A0<a h=
ref=3D"https://android-review.googlesource.com/#/c/platform/system/sepolicy=
/+/470500/">https://android-review.googlesource.com/#/c/platform/system/sep=
olicy/+/470500/</a></div><div><br></div><div>Sounds like that should be suf=
ficient to avoid breaking anything, at least for sysfs.</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
Do you truly need per-file labeling of symlinks in sysfs?=C2=A0 What&#39;s =
the<br>
use case?=C2=A0 I guess it is an inconsistency between the support for sysf=
s<br>
labeling via setxattr vs genfscon, but there are likely other more<br>
significant inconsistencies due to the support for pathname regexes in<br>
file_contexts versus pathname prefixes in genfscon, e.g. see<br>
<a href=3D"https://github.com/SELinuxProject/selinux-kernel/issues/29" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/SELinuxProject/selinux=
-kernel/issues/29</a><br>
<br>
That said, I agree it is an ugly hack and should likely be removed if<br>
it doesn&#39;t cause compatibility problems (we&#39;d need to test on RHEL =
6/7<br>
at least).<br>
<br>
Have you measured to see the impact of switching from setxattr to<br>
genfscon for sysfs labeling?<br></blockquote><div><br></div><div>Yes, a cou=
ple of data points</div><div>1. Moving sysfs and debugfs to genfscon result=
ed in ~200 ms faster boot time on Marlin.</div><div>2. Also on Marlin, comi=
ng out of suspend with screen off (which happens somewhat regularly) takes =
about 500 ms. We were spending ~120 ms of that in restorecon of /sys/device=
s/system/cpu. Moving to genfscon reduced the restorecon time from 120 ms to=
 3 ms, resulting in a significant improvement in screen-off battery life.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
commit ea6b184f7d521a503ecab71feca6e4057562252b<br>
Author: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"=
_blank">sds@tycho.nsa.gov</a>&gt;<br>
Date:=C2=A0=C2=A0=C2=A0Mon Sep 22 15:41:19 2008 -0400<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0selinux: use default proc sid on symlinks<br>
=C2=A0=C2=A0=C2=A0=C2=A0<br>
=C2=A0=C2=A0=C2=A0=C2=A0As we are not concerned with fine-grained control o=
ver reading of<br>
=C2=A0=C2=A0=C2=A0=C2=A0symlinks in proc, always use the default proc SID f=
or all proc<br>
symlinks.<br>
=C2=A0=C2=A0=C2=A0=C2=A0This should help avoid permission issues upon chang=
es to the proc<br>
tree<br>
=C2=A0=C2=A0=C2=A0=C2=A0as in the /proc/net -&gt; /proc/self/net example.<b=
r>
=C2=A0=C2=A0=C2=A0=C2=A0This does not alter labeling of symlinks within /pr=
oc/pid<br>
directories.<br>
=C2=A0=C2=A0=C2=A0=C2=A0ls -Zd /proc/net output before and after the patch =
should show the<br>
differenc<br>
e.<br>
=C2=A0=C2=A0=C2=A0=C2=A0<br>
=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by:=C2=A0=C2=A0Stephen D. Smalley &lt;<a=
 href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&=
gt;<br>
=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: James Morris &lt;<a href=3D"mailto:j=
morris@namei.org" target=3D"_blank">jmorris@namei.org</a>&gt;<br>
<br>
</blockquote></div></div>

--94eb2c0483a42761170557e77004--
