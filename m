Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UMPNjc025639
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 18:25:23 -0400
Received: by mail-qk0-f178.google.com with SMTP id l2so34058748qkf.3
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 15:25:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGH-KgtOQx6XLStD++n8kBMKNky1t8or7KC2UyYxdaRXjQMhbA@mail.gmail.com>
References: <147259160184.15526.16504125805093739705.stgit@localhost>
 <CAGH-KgtOQx6XLStD++n8kBMKNky1t8or7KC2UyYxdaRXjQMhbA@mail.gmail.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Tue, 30 Aug 2016 14:58:58 -0700
Message-ID: <CABXk95Dkm-8zsThUJsVCLJ3k5vD+1nc_6j4uR_MRKZLzQn-=eQ@mail.gmail.com>
Subject: Re: [PATCH] audit: consistently record PIDs with task_tgid_nr()
To: Paul Moore <pmoore@redhat.com>, linux-audit@redhat.com
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114fadea791525053b51168f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114fadea791525053b51168f
Content-Type: text/plain; charset=UTF-8

Can you add tid while you're at it?

We're already looking for it on Android:
https://android-review.googlesource.com/#/c/236952

On Tue, Aug 30, 2016 at 2:15 PM Paul Moore <pmoore@redhat.com> wrote:

> On Tue, Aug 30, 2016 at 5:13 PM, Paul Moore <pmoore@redhat.com> wrote:
> > From: Paul Moore <paul@paul-moore.com>
> >
> > Unfortunately we record PIDs in audit records using a variety of
> > methods despite the correct way being the use of task_tgid_nr().
> > This patch converts all of these callers, except for the case of
> > AUDIT_SET in audit_receive_msg() (see the comment in the code).
> >
> > Reported-by: Jeff Vander Stoep <jeffv@google.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  kernel/audit.c       |    8 +++++++-
> >  kernel/auditsc.c     |   12 ++++++------
> >  security/lsm_audit.c |    4 ++--
> >  3 files changed, 15 insertions(+), 9 deletions(-)
>
> I forgot to tag this with "RFC".  This patch compiles but I haven't
> had a chance to test it yet so it isn't going into audit#next just
> yet; if you have any concerns, now is the time to voice them.
>
> --
> paul moore
> security @ redhat
>

--001a114fadea791525053b51168f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Can you add tid while you&#39;re at it?<br><br>We&#39;re a=
lready looking for it on Android:=C2=A0<a href=3D"https://android-review.go=
oglesource.com/#/c/236952">https://android-review.googlesource.com/#/c/2369=
52</a><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, Aug 30, 2=
016 at 2:15 PM Paul Moore &lt;<a href=3D"mailto:pmoore@redhat.com" target=
=3D"_blank">pmoore@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border=
-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On T=
ue, Aug 30, 2016 at 5:13 PM, Paul Moore &lt;<a href=3D"mailto:pmoore@redhat=
.com" target=3D"_blank">pmoore@redhat.com</a>&gt; wrote:<br>
&gt; From: Paul Moore &lt;<a href=3D"mailto:paul@paul-moore.com" target=3D"=
_blank">paul@paul-moore.com</a>&gt;<br>
&gt;<br>
&gt; Unfortunately we record PIDs in audit records using a variety of<br>
&gt; methods despite the correct way being the use of task_tgid_nr().<br>
&gt; This patch converts all of these callers, except for the case of<br>
&gt; AUDIT_SET in audit_receive_msg() (see the comment in the code).<br>
&gt;<br>
&gt; Reported-by: Jeff Vander Stoep &lt;<a href=3D"mailto:jeffv@google.com"=
 target=3D"_blank">jeffv@google.com</a>&gt;<br>
&gt; Signed-off-by: Paul Moore &lt;<a href=3D"mailto:paul@paul-moore.com" t=
arget=3D"_blank">paul@paul-moore.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 kernel/audit.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 8 ++++++=
+-<br>
&gt;=C2=A0 kernel/auditsc.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A012 ++++++-----=
-<br>
&gt;=C2=A0 security/lsm_audit.c |=C2=A0 =C2=A0 4 ++--<br>
&gt;=C2=A0 3 files changed, 15 insertions(+), 9 deletions(-)<br>
<br>
I forgot to tag this with &quot;RFC&quot;.=C2=A0 This patch compiles but I =
haven&#39;t<br>
had a chance to test it yet so it isn&#39;t going into audit#next just<br>
yet; if you have any concerns, now is the time to voice them.<br>
<br>
--<br>
paul moore<br>
security @ redhat<br>
</blockquote></div></div>

--001a114fadea791525053b51168f--
