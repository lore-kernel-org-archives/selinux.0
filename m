Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7F6YHO4007100
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 02:34:17 -0400
Received: by mail-qt0-f171.google.com with SMTP id 52so17786193qtq.3
 for <selinux@tycho.nsa.gov>; Sun, 14 Aug 2016 23:34:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
 <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
 <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>
From: Miroslav Vadkerti <mvadkert@redhat.com>
Date: Mon, 15 Aug 2016 08:33:33 +0200
Message-ID: <CAGFJcwy=ccptSEnJVOX8ArK7y-MXYZK_tfMY-YcurJU9wTU-7g@mail.gmail.com>
Subject: Re: [PATCH] semanage: correct fcontext auditing
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1141b320ab4df6053a166b44
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1141b320ab4df6053a166b44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2016 at 4:58 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 08/12/2016 10:22 AM, Dominick Grift wrote:
> > On 08/12/2016 03:57 PM, Miroslav Vadkerti wrote:
> >> For modify action actually audit the selinux type, i.e. use
> >> setype variable.
> >>
> >> For deleting equal fcontext rules do not audit ftype, as the
> >> ftype value for equal rules makes little sense.
> >>
> >> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com> ---
> >> policycoreutils/semanage/seobject.py | 4 ++-- 1 file changed, 2
> >> insertions(+), 2 deletions(-)
> >>
> >> diff --git a/policycoreutils/semanage/seobject.py
> >> b/policycoreutils/semanage/seobject.py index 786ed0e..8d3088c
> >> 100644 --- a/policycoreutils/semanage/seobject.py +++
> >> b/policycoreutils/semanage/seobject.py @@ -1992,7 +1992,7 @@
> >> class fcontextRecords(semanageRecords): if not seuser: seuser =3D
> >> "system_u"
> >
> > system_u is reference policy specific. this is selinux user space
> > not reference policy user space.
>
> Yes, that's pre-existing though (not added by this patch), and
> unfortunately pervasive throughout seobject.py.
>
> I guess we'll need to decide how to provide this information so that
> it doesn't have to be hardcoded in seobject.py, e.g. yet another
> policy configuration file with default values for each security
> context field?
>

=E2=80=8BThe same issue might apply for serange, which also
can be an empty string and thus gets audited badly
if not some default value.


>
> >
> >>
> >> -        self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s
> >> ftype=3D%s tcontext=3D%s:%s:%s:%s" %
> >> (audit.audit_encode_nv_string("tglob", target, 0),
> >> ftype_to_audit[ftype], seuser, "object_r", type, serange)) +
> >> self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s ftype=3D%s
> >> tcontext=3D%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob",
> >> target, 0), ftype_to_audit[ftype], seuser, "object_r", setype,
> >> serange))
> >>
> >> def modify(self, target, setype, ftype, serange, seuser):
> >> self.begin() @@ -2030,7 +2030,7 @@ class
> >> fcontextRecords(semanageRecords): self.equiv.pop(target)
> >> self.equal_ind =3D True
> >>
> >> -            self.mylog.log_change("resrc=3Dfcontext
> >> op=3Ddelete-equal %s ftype=3D%s" %
> >> (audit.audit_encode_nv_string("tglob", target, 0),
> >> ftype_to_audit[ftype])) +
> >> self.mylog.log_change("resrc=3Dfcontext op=3Ddelete-equal %s" %
> >> (audit.audit_encode_nv_string("tglob", target, 0)))
> >>
> >> return
> >>
> >>
> >
> >
> >
> >
> > _______________________________________________ Selinux mailing
> > list Selinux@tycho.nsa.gov To unsubscribe, send email to
> > Selinux-leave@tycho.nsa.gov. To get help, send an email containing
> > "help" to Selinux-request@tycho.nsa.gov.
> >
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



--=20
Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security
IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087
Desk Phone +420 532 294 129 :: Mobile +420 773 944 252
Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR

--001a1141b320ab4df6053a166b44
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace"><font size=3D"2"><span style=3D"font-family:monospace">On Fri,=
 Aug 12, 2016 at 4:58 PM, Stephen Smalley </span><span dir=3D"ltr" style=3D=
"font-family:monospace">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"=
_blank">sds@tycho.nsa.gov</a>&gt;</span><span style=3D"font-family:monospac=
e"> wrote:</span><br></font></div><div class=3D"gmail_extra"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><font size=3D"2"><span class=3D=
"">On 08/12/2016 10:22 AM, Dominick Grift wrote:<br>
&gt; On 08/12/2016 03:57 PM, Miroslav Vadkerti wrote:<br>
&gt;&gt; For modify action actually audit the selinux type, i.e. use<br>
&gt;&gt; setype variable.<br>
&gt;&gt;<br>
&gt;&gt; For deleting equal fcontext rules do not audit ftype, as the<br>
&gt;&gt; ftype value for equal rules makes little sense.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Miroslav Vadkerti &lt;<a href=3D"mailto:mvadkert@re=
dhat.com">mvadkert@redhat.com</a>&gt; ---<br>
&gt;&gt; policycoreutils/semanage/<wbr>seobject.py | 4 ++-- 1 file changed,=
 2<br>
&gt;&gt; insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/policycoreutils/semanage/<wbr>seobject.py<br>
&gt;&gt; b/policycoreutils/semanage/<wbr>seobject.py index 786ed0e..8d3088c=
<br>
&gt;&gt; 100644 --- a/policycoreutils/semanage/<wbr>seobject.py +++<br>
&gt;&gt; b/policycoreutils/semanage/<wbr>seobject.py @@ -1992,7 +1992,7 @@<=
br>
&gt;&gt; class fcontextRecords(<wbr>semanageRecords): if not seuser: seuser=
 =3D<br>
&gt;&gt; &quot;system_u&quot;<br>
&gt;<br>
&gt; system_u is reference policy specific. this is selinux user space<br>
&gt; not reference policy user space.<br>
<br>
</span>Yes, that&#39;s pre-existing though (not added by this patch), and<b=
r>
unfortunately pervasive throughout seobject.py.<br>
<br>
I guess we&#39;ll need to decide how to provide this information so that<br=
>
it doesn&#39;t have to be hardcoded in seobject.py, e.g. yet another<br>
policy configuration file with default values for each security<br>
context field?<br></font></blockquote><div><font size=3D"2"><br></font></di=
v><div><div class=3D"gmail_default" style=3D"font-family:monospace,monospac=
e"><font size=3D"2">=E2=80=8BThe same issue might apply for serange, which =
also</font></div><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace"><font size=3D"2">can be an empty string and thus gets audited =
badly</font></div><div class=3D"gmail_default" style=3D"font-family:monospa=
ce,monospace"><font size=3D"2">if not some default value.</font></div></div=
><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"><fo=
nt size=3D"2"><span style=3D"font-family:monospace">=C2=A0</span><br></font=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<font size=3D"2"><span class=3D""><br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3D<=
wbr>fcontext op=3Dmodify %s<br>
&gt;&gt; ftype=3D%s tcontext=3D%s:%s:%s:%s&quot; %<br>
&gt;&gt; (audit.audit_encode_nv_string(<wbr>&quot;tglob&quot;, target, 0),<=
br>
&gt;&gt; ftype_to_audit[ftype], seuser, &quot;object_r&quot;, type, serange=
)) +<br>
&gt;&gt; self.mylog.log_change(&quot;resrc=3D<wbr>fcontext op=3Dmodify %s f=
type=3D%s<br>
&gt;&gt; tcontext=3D%s:%s:%s:%s&quot; % (audit.audit_encode_nv_string(<wbr>=
&quot;tglob&quot;,<br>
&gt;&gt; target, 0), ftype_to_audit[ftype], seuser, &quot;object_r&quot;, s=
etype,<br>
&gt;&gt; serange))<br>
&gt;&gt;<br>
&gt;&gt; def modify(self, target, setype, ftype, serange, seuser):<br>
&gt;&gt; self.begin() @@ -2030,7 +2030,7 @@ class<br>
&gt;&gt; fcontextRecords(<wbr>semanageRecords): self.equiv.pop(target)<br>
&gt;&gt; self.equal_ind =3D True<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&=
quot;resrc=3D<wbr>fcontext<br>
&gt;&gt; op=3Ddelete-equal %s ftype=3D%s&quot; %<br>
&gt;&gt; (audit.audit_encode_nv_string(<wbr>&quot;tglob&quot;, target, 0),<=
br>
&gt;&gt; ftype_to_audit[ftype])) +<br>
&gt;&gt; self.mylog.log_change(&quot;resrc=3D<wbr>fcontext op=3Ddelete-equa=
l %s&quot; %<br>
&gt;&gt; (audit.audit_encode_nv_string(<wbr>&quot;tglob&quot;, target, 0)))=
<br>
&gt;&gt;<br>
&gt;&gt; return<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</span>&gt; ______________________________<wbr>_________________ Selinux ma=
iling<br>
&gt; list <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a=
> To unsubscribe, send email to<br>
&gt; <a href=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa=
.gov</a>. To get help, send an email containing<br>
&gt; &quot;help&quot; to <a href=3D"mailto:Selinux-request@tycho.nsa.gov">S=
elinux-request@tycho.nsa.gov</a>.<br>
&gt;<br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></blockquote></div><font size=3D"2"><br><br clear=3D"all"></font><di=
v><font size=3D"2"><br></font></div><font size=3D"2">-- <br></font><div cla=
ss=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><font face=3D"monospace, m=
onospace" size=3D"2">Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Se=
curity</font></div><div><font face=3D"monospace, monospace" size=3D"2">IRC =
mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087<br></font></div><div><fo=
nt face=3D"monospace, monospace" size=3D"2">Desk Phone +420 532 294 129 :: =
Mobile +420 773 944 252<br></font></div><div><font size=3D"2"><font face=3D=
"monospace, monospace">Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, B=
rno, CR</font><br></font></div><div><br></div></div></div></div></div></div=
></div>
</div></div>

--001a1141b320ab4df6053a166b44--
