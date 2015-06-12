Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5CKnGUx021769
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 16:49:17 -0400
Received: by obcej4 with SMTP id ej4so30612825obc.0
 for <selinux@tycho.nsa.gov>; Fri, 12 Jun 2015 13:49:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQCcod5LwMbEpYxvU7TFCtqOZqUK7wfgRS7nY305kYhXw@mail.gmail.com>
References: <1434124938-12477-1-git-send-email-jeffv@google.com>
 <CAHC9VhQCcod5LwMbEpYxvU7TFCtqOZqUK7wfgRS7nY305kYhXw@mail.gmail.com>
Date: Fri, 12 Jun 2015 13:49:14 -0700
Message-ID: <CABXk95C-3OYrFTWcgOgj3iHqdv-=pi=5xcXtZCuOqc_8vOVSwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v6] selinux: extended permissions for ioctls
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=001a1141c9b0abbc180518583d59
Cc: SELinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1141c9b0abbc180518583d59
Content-Type: text/plain; charset=UTF-8

Go ahead and just remove them. I normally do, but forgot. They're just
 tracking tags for android.

On Fri, Jun 12, 2015 at 1:46 PM, Paul Moore <paul@paul-moore.com> wrote:

> On Fri, Jun 12, 2015 at 12:02 PM, Jeff Vander Stoep <jeffv@google.com>
> wrote:
> > Add extended permissions logic to selinux. Extended permissions
> > provides additional permissions in 256 bit increments. Extend the
> > generic ioctl permission check to use the extended permissions for
> > per-command filtering. Source/target/class sets including the ioctl
> > permission may additionally include a set of commands. Example:
> >
> > allowxperm <source> <target>:<class> ioctl unpriv_app_socket_cmds
> > auditallowxperm <source> <target>:<class> ioctl priv_gpu_cmds
> >
> > Where unpriv_app_socket_cmds and priv_gpu_cmds are macros
> > representing commonly granted sets of ioctl commands.
> >
> > When ioctl commands are omitted only the permissions are checked.
> > This feature is intended to provide finer granularity for the ioctl
> > permission that may be too imprecise. For example, the same driver
> > may use ioctls to provide important and benign functionality such as
> > driver version or socket type as well as dangerous capabilities such
> > as debugging features, read/write/execute to physical memory or
> > access to sensitive data. Per-command filtering provides a mechanism
> > to reduce the attack surface of the kernel, and limit applications
> > to the subset of commands required.
> >
> > The format of the policy binary has been modified to include ioctl
> > commands, and the policy version number has been incremented to
> > POLICYDB_VERSION_XPERMS_IOCTL=30 to account for the format
> > change.
> >
> > The extended permissions logic is deliberately generic to allow
> > components to be reused e.g. netlink filters
> >
> > Bug: 19416735
> > Change-Id: Ibd462f12ba5748cf5dd91f28e5795764363121a2
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > ---
> > v6 adds ommitted function comment header entries for avc_update_node
> >
> >  security/selinux/avc.c              | 415
> ++++++++++++++++++++++++++++++++++--
> >  security/selinux/hooks.c            |  42 +++-
> >  security/selinux/include/avc.h      |   6 +
> >  security/selinux/include/security.h |  32 ++-
> >  security/selinux/ss/avtab.c         | 104 +++++++--
> >  security/selinux/ss/avtab.h         |  33 ++-
> >  security/selinux/ss/conditional.c   |  32 ++-
> >  security/selinux/ss/conditional.h   |   6 +-
> >  security/selinux/ss/policydb.c      |   5 +
> >  security/selinux/ss/services.c      | 213 ++++++++++++++++--
> >  security/selinux/ss/services.h      |   6 +
> >  11 files changed, 834 insertions(+), 60 deletions(-)
>
> Also applied to the SELinux next-queue, thank you.
>
> However, can you explain the "Bug" and "Change-Id" headers in your
> patch description above?  They are horribly generic and I'd like to
> remove them from the sign-off or at least provide a more descriptive
> name in order to limit the confusion.  For example, could we provide a
> URL instead of a bug ID#?  Could it be an Android-Change-Id (or
> similar)?
>
> --
> paul moore
> www.paul-moore.com
>

--001a1141c9b0abbc180518583d59
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Go ahead and just remove them. I normally do, but forgot. =
They&#39;re just =C2=A0tracking tags for android.</div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Fri, Jun 12, 2015 at 1:46 PM, Paul=
 Moore <span dir=3D"ltr">&lt;<a href=3D"mailto:paul@paul-moore.com" target=
=3D"_blank">paul@paul-moore.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Fri, Jun 12, 2015 =
at 12:02 PM, Jeff Vander Stoep &lt;<a href=3D"mailto:jeffv@google.com">jeff=
v@google.com</a>&gt; wrote:<br>
&gt; Add extended permissions logic to selinux. Extended permissions<br>
&gt; provides additional permissions in 256 bit increments. Extend the<br>
&gt; generic ioctl permission check to use the extended permissions for<br>
&gt; per-command filtering. Source/target/class sets including the ioctl<br=
>
&gt; permission may additionally include a set of commands. Example:<br>
&gt;<br>
&gt; allowxperm &lt;source&gt; &lt;target&gt;:&lt;class&gt; ioctl unpriv_ap=
p_socket_cmds<br>
&gt; auditallowxperm &lt;source&gt; &lt;target&gt;:&lt;class&gt; ioctl priv=
_gpu_cmds<br>
&gt;<br>
&gt; Where unpriv_app_socket_cmds and priv_gpu_cmds are macros<br>
&gt; representing commonly granted sets of ioctl commands.<br>
&gt;<br>
&gt; When ioctl commands are omitted only the permissions are checked.<br>
&gt; This feature is intended to provide finer granularity for the ioctl<br=
>
&gt; permission that may be too imprecise. For example, the same driver<br>
&gt; may use ioctls to provide important and benign functionality such as<b=
r>
&gt; driver version or socket type as well as dangerous capabilities such<b=
r>
&gt; as debugging features, read/write/execute to physical memory or<br>
&gt; access to sensitive data. Per-command filtering provides a mechanism<b=
r>
&gt; to reduce the attack surface of the kernel, and limit applications<br>
&gt; to the subset of commands required.<br>
&gt;<br>
&gt; The format of the policy binary has been modified to include ioctl<br>
&gt; commands, and the policy version number has been incremented to<br>
&gt; POLICYDB_VERSION_XPERMS_IOCTL=3D30 to account for the format<br>
&gt; change.<br>
&gt;<br>
&gt; The extended permissions logic is deliberately generic to allow<br>
&gt; components to be reused e.g. netlink filters<br>
&gt;<br>
&gt; Bug: 19416735<br>
&gt; Change-Id: Ibd462f12ba5748cf5dd91f28e5795764363121a2<br>
&gt; Signed-off-by: Jeff Vander Stoep &lt;<a href=3D"mailto:jeffv@google.co=
m">jeffv@google.com</a>&gt;<br>
&gt; ---<br>
&gt; v6 adds ommitted function comment header entries for avc_update_node<b=
r>
&gt;<br>
&gt;=C2=A0 security/selinux/avc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 415 ++++++++++++++++++++++++++++++++++--<br>
&gt;=C2=A0 security/selinux/hooks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 42 +++-<br>
&gt;=C2=A0 security/selinux/include/avc.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 +<br>
&gt;=C2=A0 security/selinux/include/security.h |=C2=A0 32 ++-<br>
&gt;=C2=A0 security/selinux/ss/avtab.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
04 +++++++--<br>
&gt;=C2=A0 security/selinux/ss/avtab.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 33 ++-<br>
&gt;=C2=A0 security/selinux/ss/conditional.c=C2=A0 =C2=A0|=C2=A0 32 ++-<br>
&gt;=C2=A0 security/selinux/ss/conditional.h=C2=A0 =C2=A0|=C2=A0 =C2=A06 +-=
<br>
&gt;=C2=A0 security/selinux/ss/policydb.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A05 +<br>
&gt;=C2=A0 security/selinux/ss/services.c=C2=A0 =C2=A0 =C2=A0 | 213 +++++++=
+++++++++--<br>
&gt;=C2=A0 security/selinux/ss/services.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 +<br>
&gt;=C2=A0 11 files changed, 834 insertions(+), 60 deletions(-)<br>
<br>
</div></div>Also applied to the SELinux next-queue, thank you.<br>
<br>
However, can you explain the &quot;Bug&quot; and &quot;Change-Id&quot; head=
ers in your<br>
patch description above?=C2=A0 They are horribly generic and I&#39;d like t=
o<br>
remove them from the sign-off or at least provide a more descriptive<br>
name in order to limit the confusion.=C2=A0 For example, could we provide a=
<br>
URL instead of a bug ID#?=C2=A0 Could it be an Android-Change-Id (or<br>
similar)?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" rel=3D"noreferrer" target=3D"_blank">=
www.paul-moore.com</a><br>
</font></span></blockquote></div><br></div>

--001a1141c9b0abbc180518583d59--
