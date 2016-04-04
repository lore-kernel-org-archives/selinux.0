MIME-Version: 1.0
In-Reply-To: <CAHC9VhTQUTAUByVGrrFLxm_w8xzx8cvvrKYscnkRzs7b4fVDsg@mail.gmail.com>
References: <1459550439-29408-1-git-send-email-jeffv@google.com>
 <CAHC9VhTQUTAUByVGrrFLxm_w8xzx8cvvrKYscnkRzs7b4fVDsg@mail.gmail.com>
Date: Mon, 4 Apr 2016 13:45:31 -0700
Message-ID: <CAFftDdrefc7BP=bbbh-+-3k3hmYGu0pK6jtoDTcu2Rh9qbLOMg@mail.gmail.com>
Subject: Re: [PATCH] selinux: restrict kernel module loading
From: William Roberts <bill.c.roberts@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jeff Vander Stoep <jeffv@google.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113f1e16454e2c052faecf9c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113f1e16454e2c052faecf9c
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 2, 2016 at 8:31 AM, Paul Moore <paul@paul-moore.com> wrote:

> On Fri, Apr 1, 2016 at 6:40 PM, Jeff Vander Stoep <jeffv@google.com>
> wrote:
> > Utilize existing kernel_read_file hook on kernel module load.
> > Add module_load permission to the system class.
> >
> > Enforces restrictions on kernel module origin when calling the
> > finit_module syscall. The hook checks that source type has
> > permission module_load for the target type.
> > Example for finit_module:
> >
> > allow foo bar_file:system module_load;
> >
> > Similarly restrictions are enforced on kernel module loading when
> > calling the init_module syscall. The hook checks that source
> > type has permission module_load for the kernel target type.
> > Example for init_module:
> >
> > allow foo kernel:system module_load;
> >
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > ---
> >  security/selinux/hooks.c            | 52
> +++++++++++++++++++++++++++++++++++++
> >  security/selinux/include/classmap.h |  2 +-
> >  2 files changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3fa3ca5..5bc4875 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3719,6 +3719,57 @@ static int selinux_kernel_module_request(char
> *kmod_name)
> >                             SYSTEM__MODULE_REQUEST, &ad);
> >  }
> >
> > +static int selinux_kernel_module_from_file(struct file *file)
> > +{
> > +       struct common_audit_data ad;
> > +       struct inode_security_struct *isec;
> > +       struct file_security_struct *fsec;
> > +       struct inode *inode;
> > +       u32 sid = current_sid();
> > +       int rc;
> > +
> > +       /* init_module */
> > +       if (file == NULL) {
> > +               rc = avc_has_perm(sid, SECINITSID_KERNEL,
> SECCLASS_SYSTEM,
> > +                                       SYSTEM__MODULE_LOAD, NULL);
> > +               goto out;
> > +       }
>
> I don't think the object type is correct here; in this case, the
> object is the kernel module being loaded, and with init_module() that
> kernel module is coming from the calling process, not the kernel.  It
> seems like the following would be more appropriate:
>
>   avc_has_perm(sid, sid, SECCLASS_SYSTEM, SYSTEM__MODULE_LOAD, NULL);
>


Paul your saying you prefer this:

allow foo self:system module_load;

to this:

allow foo kernel:system module_load;

?

IMHO, the target would be the kernel since its what is being affected by a
module sourced from foo.

Bill


> --
> paul moore
> www.paul-moore.com
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



-- 
Respectfully,

William C Roberts

--001a113f1e16454e2c052faecf9c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Apr 2, 2016 at 8:31 AM, Paul Moore <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:paul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><=
div class=3D"h5">On Fri, Apr 1, 2016 at 6:40 PM, Jeff Vander Stoep &lt;<a h=
ref=3D"mailto:jeffv@google.com">jeffv@google.com</a>&gt; wrote:<br>
&gt; Utilize existing kernel_read_file hook on kernel module load.<br>
&gt; Add module_load permission to the system class.<br>
&gt;<br>
&gt; Enforces restrictions on kernel module origin when calling the<br>
&gt; finit_module syscall. The hook checks that source type has<br>
&gt; permission module_load for the target type.<br>
&gt; Example for finit_module:<br>
&gt;<br>
&gt; allow foo bar_file:system module_load;<br>
&gt;<br>
&gt; Similarly restrictions are enforced on kernel module loading when<br>
&gt; calling the init_module syscall. The hook checks that source<br>
&gt; type has permission module_load for the kernel target type.<br>
&gt; Example for init_module:<br>
&gt;<br>
&gt; allow foo kernel:system module_load;<br>
&gt;<br>
&gt; Signed-off-by: Jeff Vander Stoep &lt;<a href=3D"mailto:jeffv@google.co=
m">jeffv@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 security/selinux/hooks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 52 +++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 security/selinux/include/classmap.h |=C2=A0 2 +-<br>
&gt;=C2=A0 2 files changed, 53 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c<br>
&gt; index 3fa3ca5..5bc4875 100644<br>
&gt; --- a/security/selinux/hooks.c<br>
&gt; +++ b/security/selinux/hooks.c<br>
&gt; @@ -3719,6 +3719,57 @@ static int selinux_kernel_module_request(char *=
kmod_name)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SYSTEM__MODULE_REQUEST, &amp;ad);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static int selinux_kernel_module_from_file(struct file *file)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct common_audit_data ad;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode_security_struct *isec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct file_security_struct *fsec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 sid =3D current_sid();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* init_module */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (file =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D avc_has=
_perm(sid, SECINITSID_KERNEL, SECCLASS_SYSTEM,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SYSTE=
M__MODULE_LOAD, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</div></div>I don&#39;t think the object type is correct here; in this case=
, the<br>
object is the kernel module being loaded, and with init_module() that<br>
kernel module is coming from the calling process, not the kernel.=C2=A0 It<=
br>
seems like the following would be more appropriate:<br>
<br>
=C2=A0 avc_has_perm(sid, sid, SECCLASS_SYSTEM, SYSTEM__MODULE_LOAD, NULL);<=
br></blockquote><div><br></div><div><br></div><div>Paul your saying you pre=
fer this:</div><div><br></div><div>allow foo self:system module_load;</div>=
<div><br></div><div>to this:</div><div><br></div><div>allow foo kernel:syst=
em module_load;</div><div>=C2=A0</div><div>?</div><div><br></div><div>IMHO,=
 the target would be the kernel since its what is being affected by a modul=
e sourced from foo.</div><div><br></div><div>Bill</div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" rel=3D"noreferrer" target=3D"_blank">=
www.paul-moore.com</a><br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">_____________________=
__________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><b=
r></div>
</div></div>

--001a113f1e16454e2c052faecf9c--
