Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7MJnl9b017440
 for <selinux@tycho.nsa.gov>; Tue, 22 Aug 2017 15:49:47 -0400
Received: by mail-qk0-f179.google.com with SMTP id k126so19604626qkb.5
 for <selinux@tycho.nsa.gov>; Tue, 22 Aug 2017 12:49:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRiTnsPNoPZNi2aAQfN4va3Kg81QZgxoed6S-8iAFFvPA@mail.gmail.com>
References: <20170209155823.22148-1-runcom@redhat.com>
 <CAHC9VhSL3ZS3R2r39+qzYmvU1=8-jC2nzqkXNQ0Yk3+okKd7jw@mail.gmail.com>
 <1489177036.6824.57.camel@tycho.nsa.gov>
 <CAHC9VhSL1dm9b7ZohYyCU0PjKbbtYLe7XX7Xv3CsQQx4CtG_Fw@mail.gmail.com>
 <CAHC9VhRiTnsPNoPZNi2aAQfN4va3Kg81QZgxoed6S-8iAFFvPA@mail.gmail.com>
From: Antonio Murdaca <runcom@redhat.com>
Date: Tue, 22 Aug 2017 21:49:37 +0200
Message-ID: <CALKLTGT_ZHA98dA=ec+J6fPtu5O--EZUF3HqipaWQoE+n3K8_w@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a1149d4a6406e7e05575ce575"
Subject: Re: [PATCH] security: selinux: allow per-file labeling for cgroupfs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1149d4a6406e7e05575ce575
Content-Type: text/plain; charset="UTF-8"

Thanks

On Aug 22, 2017 21:47, "Paul Moore" <paul@paul-moore.com> wrote:

> On Fri, Mar 10, 2017 at 3:21 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Mar 10, 2017 at 3:17 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> >> On Fri, 2017-03-10 at 15:01 -0500, Paul Moore wrote:
> >>> On Thu, Feb 9, 2017 at 10:58 AM, Antonio Murdaca <amurdaca@redhat.com
> >>> > wrote:
> >>> >
> >>> > This patch allows genfscon per-file labeling for cgroupfs. For
> >>> > instance,
> >>> > this allows to label the "release_agent" file within each
> >>> > cgroup mount and limit writes to it.
> >>> >
> >>> > Signed-off-by: Antonio Murdaca <runcom@redhat.com>
> >>> > ---
> >>> >  security/selinux/hooks.c | 2 ++
> >>> >  1 file changed, 2 insertions(+)
> >>>
> >>> Now that the merge window is behind us, let's get this merged, but
> >>> could you update it to use the selinux_policycap_cgroupseclabel
> >>> policy
> >>> capability?  See 2651225b5ebcdde ("selinux: wrap cgroup seclabel
> >>> support with its own policy capability") for more information.
> >>
> >> I don't think that is necessary.  This change unlike the other one
> >> should not yield any difference in behavior with existing policy; it
> >> just allows one to specify fine-grained labeling for cgroup nodes in
> >> future policy.  It doesn't affect any userspace interface.
> >
> > Yes, I thought about that, and if the policy capability was already
> > present in a released kernel then I wouldn't worry about it much, but
> > since the policy capability still only lives in the v4.11-rcX kernels
> > I'd prefer to see this code wrapped with the policy capability ...
> > even if all it really does is give me that warm fuzzy feeling.
>
> FWIW, I just decided I didn't care that much about the policy
> capability restriction for this patch and went ahead and merged it
> into selinux/next.
>
> --
> paul moore
> www.paul-moore.com
>

--001a1149d4a6406e7e05575ce575
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks</div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Aug 22, 2017 21:47, &quot;Paul Moore&quot; &lt;<a href=3D"m=
ailto:paul@paul-moore.com">paul@paul-moore.com</a>&gt; wrote:<br type=3D"at=
tribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">On Fri, Mar 10, 2017 at 3:21 PM, =
Paul Moore &lt;<a href=3D"mailto:paul@paul-moore.com">paul@paul-moore.com</=
a>&gt; wrote:<br>
&gt; On Fri, Mar 10, 2017 at 3:17 PM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;&gt; On Fri, 2017-03-10 at 15:01 -0500, Paul Moore wrote:<br>
&gt;&gt;&gt; On Thu, Feb 9, 2017 at 10:58 AM, Antonio Murdaca &lt;<a href=
=3D"mailto:amurdaca@redhat.com">amurdaca@redhat.com</a><br>
&gt;&gt;&gt; &gt; wrote:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; This patch allows genfscon per-file labeling for cgroupfs=
. For<br>
&gt;&gt;&gt; &gt; instance,<br>
&gt;&gt;&gt; &gt; this allows to label the &quot;release_agent&quot; file w=
ithin each<br>
&gt;&gt;&gt; &gt; cgroup mount and limit writes to it.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Signed-off-by: Antonio Murdaca &lt;<a href=3D"mailto:runc=
om@redhat.com">runcom@redhat.com</a>&gt;<br>
&gt;&gt;&gt; &gt; ---<br>
&gt;&gt;&gt; &gt;=C2=A0 security/selinux/hooks.c | 2 ++<br>
&gt;&gt;&gt; &gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Now that the merge window is behind us, let&#39;s get this mer=
ged, but<br>
&gt;&gt;&gt; could you update it to use the selinux_policycap_<wbr>cgroupse=
clabel<br>
&gt;&gt;&gt; policy<br>
&gt;&gt;&gt; capability?=C2=A0 See 2651225b5ebcdde (&quot;selinux: wrap cgr=
oup seclabel<br>
&gt;&gt;&gt; support with its own policy capability&quot;) for more informa=
tion.<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t think that is necessary.=C2=A0 This change unlike the =
other one<br>
&gt;&gt; should not yield any difference in behavior with existing policy; =
it<br>
&gt;&gt; just allows one to specify fine-grained labeling for cgroup nodes =
in<br>
&gt;&gt; future policy.=C2=A0 It doesn&#39;t affect any userspace interface=
.<br>
&gt;<br>
&gt; Yes, I thought about that, and if the policy capability was already<br=
>
&gt; present in a released kernel then I wouldn&#39;t worry about it much, =
but<br>
&gt; since the policy capability still only lives in the v4.11-rcX kernels<=
br>
&gt; I&#39;d prefer to see this code wrapped with the policy capability ...=
<br>
&gt; even if all it really does is give me that warm fuzzy feeling.<br>
<br>
FWIW, I just decided I didn&#39;t care that much about the policy<br>
capability restriction for this patch and went ahead and merged it<br>
into selinux/next.<br>
<br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" rel=3D"noreferrer" target=3D"_blank">=
www.paul-moore.com</a><br>
</blockquote></div></div>

--001a1149d4a6406e7e05575ce575--
