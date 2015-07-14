MIME-Version: 1.0
In-Reply-To: <559FF186.7090008@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC560102C611@ORSMSX103.amr.corp.intel.com>
 <559FBD3A.4090300@tycho.nsa.gov>
 <CAFftDdqP616u6UDZQAnd8AucCz=EXm0mY1Uhcwmp3x9rmWNBgg@mail.gmail.com>
 <476DC76E7D1DF2438D32BFADF679FC560102C7C5@ORSMSX103.amr.corp.intel.com>
 <559FF186.7090008@tycho.nsa.gov>
Date: Tue, 14 Jul 2015 16:15:33 -0700
Message-ID: <CAFftDdoTnAfVGCaPa7Q8Y8j2NHvDebQ5AGRkKdL7XDq_GD-J4Q@mail.gmail.com>
Subject: Re: executing off of a fusefs
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=089e0102ef54e4601a051ade0309
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e0102ef54e4601a051ade0309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 9:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 07/10/2015 11:53 AM, Roberts, William C wrote:
> > Also, I see the manpage for mount has rootcontext, does this provide th=
e
> > rootnode context so the xattr won=E2=80=99t be queried, or does it prov=
ide some
> > transient
> > label that is replaced at  mount with the xattr query?
>
> rootcontext=3D is typically used to assign a specific context to the root
> directory of e.g. tmpfs mounts, rather than having to first mount it and
> then change the context to some value.
>
> Using it wouldn't suppress the getxattr call by SELinux for a
> fs_use_xattr filesystem, as SELinux always does that regardless just to
> probe whether the filesystem supports security xattrs (if not, then it
> will fail the mount).  It would however override any underlying xattr
> value for the root directory.
>

I found this before, but cannot seem to find it now, where in the mount cal=
l
path is the routine to query the xattr for the rootnode?




--=20
Respectfully,

William C Roberts

--089e0102ef54e4601a051ade0309
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Jul 10, 2015 at 9:23 AM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 0=
7/10/2015 11:53 AM, Roberts, William C wrote:<br>
&gt; Also, I see the manpage for mount has rootcontext, does this provide t=
he<br>
&gt; rootnode context so the xattr won=E2=80=99t be queried, or does it pro=
vide some<br>
&gt; transient<br>
&gt; label that is replaced at=C2=A0 mount with the xattr query?<br>
<br>
</span>rootcontext=3D is typically used to assign a specific context to the=
 root<br>
directory of e.g. tmpfs mounts, rather than having to first mount it and<br=
>
then change the context to some value.<br>
<br>
Using it wouldn&#39;t suppress the getxattr call by SELinux for a<br>
fs_use_xattr filesystem, as SELinux always does that regardless just to<br>
probe whether the filesystem supports security xattrs (if not, then it<br>
will fail the mount).=C2=A0 It would however override any underlying xattr<=
br>
value for the root directory.<br></blockquote><div><br></div><div>I found t=
his before, but cannot seem to find it now, where in the mount call</div><d=
iv>path is the routine to query the xattr for the rootnode?</div><div>=C2=
=A0</div></div><br><br clear=3D"all"><div><br></div>-- <br><div class=3D"gm=
ail_signature">Respectfully,<br><br>William C Roberts<br><br></div>
</div></div>

--089e0102ef54e4601a051ade0309--
