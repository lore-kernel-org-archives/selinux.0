MIME-Version: 1.0
In-Reply-To: <CAHC9VhReO7tLcB=K6KbGpH_inzMCLVLHmYWibNFGVku27Y=kFw@mail.gmail.com>
References: <1468524562-30981-1-git-send-email-william.c.roberts@intel.com>
 <CAHC9VhReO7tLcB=K6KbGpH_inzMCLVLHmYWibNFGVku27Y=kFw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 14 Jul 2016 16:18:54 -0700
Message-ID: <CAFftDdoHOeGdwfK79aviHmFr4JxE1rX0z0vcfZZtbtvv2TL9ew@mail.gmail.com>
Subject: Re: [PATCH] selinux: print leading 0x on ioctlcmd audits
To: Paul Moore <paul@paul-moore.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 Steve Grubb <sgrubb@redhat.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-audit@redhat.com" <linux-audit@redhat.com>
Content-Type: multipart/alternative; boundary=001a11397e46c7bb900537a0b90e
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

--001a11397e46c7bb900537a0b90e
Content-Type: text/plain; charset=UTF-8

On Thu, Jul 14, 2016 at 3:17 PM, Paul Moore <paul@paul-moore.com> wrote:

> On Thu, Jul 14, 2016 at 3:29 PM,  <william.c.roberts@intel.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > ioctlcmd is currently printing hex numbers, but their is no leading
> > 0x. Thus things like ioctlcmd=1234 are misleading, as the base is
> > not evident.
> >
> > Correct this by adding 0x as a prefix, so ioctlcmd=1234 becomes
> ioctlcmd=0x1234.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  security/lsm_audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> NOTE: adding Steve Grubb and the audit mailing list to the CC line
>
> Like it or not, I believe the general standard/convention when it
> comes to things like this is to leave off the "0x" prefix; the idea
> being that is saves precious space in the audit logs and the value is
> only ever going to be in hex anyway.
>

Is it always in hex, what about pid?


>
> > diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> > index cccbf30..82e4dbb 100644
> > --- a/security/lsm_audit.c
> > +++ b/security/lsm_audit.c
> > @@ -257,7 +257,7 @@ static void dump_common_audit_data(struct
> audit_buffer *ab,
> >                         audit_log_format(ab, " ino=%lu", inode->i_ino);
> >                 }
> >
> > -               audit_log_format(ab, " ioctlcmd=%hx", a->u.op->cmd);
> > +               audit_log_format(ab, " ioctlcmd=0x%hx", a->u.op->cmd);
> >                 break;
> >         }
> >         case LSM_AUDIT_DATA_DENTRY: {
> > --
> > 1.9.1
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
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

--001a11397e46c7bb900537a0b90e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Jul 14, 2016 at 3:17 PM, Paul Moore <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:paul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, Jul 14, 2016 a=
t 3:29 PM,=C2=A0 &lt;<a href=3D"mailto:william.c.roberts@intel.com">william=
.c.roberts@intel.com</a>&gt; wrote:<br>
&gt; From: William Roberts &lt;<a href=3D"mailto:william.c.roberts@intel.co=
m">william.c.roberts@intel.com</a>&gt;<br>
&gt;<br>
&gt; ioctlcmd is currently printing hex numbers, but their is no leading<br=
>
&gt; 0x. Thus things like ioctlcmd=3D1234 are misleading, as the base is<br=
>
&gt; not evident.<br>
&gt;<br>
&gt; Correct this by adding 0x as a prefix, so ioctlcmd=3D1234 becomes ioct=
lcmd=3D0x1234.<br>
&gt;<br>
&gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c.roberts=
@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 security/lsm_audit.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
NOTE: adding Steve Grubb and the audit mailing list to the CC line<br>
<br>
Like it or not, I believe the general standard/convention when it<br>
comes to things like this is to leave off the &quot;0x&quot; prefix; the id=
ea<br>
being that is saves precious space in the audit logs and the value is<br>
only ever going to be in hex anyway.<br></blockquote><div><br></div><div>Is=
 it always in hex, what about pid?</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
&gt; diff --git a/security/lsm_audit.c b/security/lsm_audit.c<br>
&gt; index cccbf30..82e4dbb 100644<br>
&gt; --- a/security/lsm_audit.c<br>
&gt; +++ b/security/lsm_audit.c<br>
&gt; @@ -257,7 +257,7 @@ static void dump_common_audit_data(struct audit_bu=
ffer *ab,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0audit_log_format(ab, &quot; ino=3D%lu&quot;, inode-&gt;=
i_ino);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0audit_log_form=
at(ab, &quot; ioctlcmd=3D%hx&quot;, a-&gt;u.op-&gt;cmd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0audit_log_form=
at(ab, &quot; ioctlcmd=3D0x%hx&quot;, a-&gt;u.op-&gt;cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case LSM_AUDIT_DATA_DENTRY: {<br>
<span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
<br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" rel=3D"noreferrer" target=3D"_blank">=
www.paul-moore.com</a><br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Respect=
fully,<br><br>William C Roberts<br><br></div>
</div></div>

--001a11397e46c7bb900537a0b90e--
