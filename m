Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7F8ulWR020643
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 04:56:51 -0400
Received: by mail-qt0-f182.google.com with SMTP id w38so18683949qtb.0
 for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2016 01:56:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGFJcwy=ccptSEnJVOX8ArK7y-MXYZK_tfMY-YcurJU9wTU-7g@mail.gmail.com>
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
 <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
 <b3b0b9b4-19ec-9520-7adc-f80d84d635c6@tycho.nsa.gov>
 <CAGFJcwy=ccptSEnJVOX8ArK7y-MXYZK_tfMY-YcurJU9wTU-7g@mail.gmail.com>
From: Miroslav Vadkerti <mvadkert@redhat.com>
Date: Mon, 15 Aug 2016 10:55:51 +0200
Message-ID: <CAGFJcwzEW0DG1i5u3p1QRJ9-D40vLMSwu2FAsyU9rRiAAwTPtw@mail.gmail.com>
Subject: Re: [PATCH] semanage: correct fcontext auditing
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113fde429bf0c3053a18685c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113fde429bf0c3053a18685c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Anyway, could we have this patch applied and sort out a better way
of supplying defaults later please?

Thanks,
/M

On Mon, Aug 15, 2016 at 8:33 AM, Miroslav Vadkerti <mvadkert@redhat.com>
wrote:

> On Fri, Aug 12, 2016 at 4:58 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>
>> On 08/12/2016 10:22 AM, Dominick Grift wrote:
>> > On 08/12/2016 03:57 PM, Miroslav Vadkerti wrote:
>> >> For modify action actually audit the selinux type, i.e. use
>> >> setype variable.
>> >>
>> >> For deleting equal fcontext rules do not audit ftype, as the
>> >> ftype value for equal rules makes little sense.
>> >>
>> >> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com> ---
>> >> policycoreutils/semanage/seobject.py | 4 ++-- 1 file changed, 2
>> >> insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/policycoreutils/semanage/seobject.py
>> >> b/policycoreutils/semanage/seobject.py index 786ed0e..8d3088c
>> >> 100644 --- a/policycoreutils/semanage/seobject.py +++
>> >> b/policycoreutils/semanage/seobject.py @@ -1992,7 +1992,7 @@
>> >> class fcontextRecords(semanageRecords): if not seuser: seuser =3D
>> >> "system_u"
>> >
>> > system_u is reference policy specific. this is selinux user space
>> > not reference policy user space.
>>
>> Yes, that's pre-existing though (not added by this patch), and
>> unfortunately pervasive throughout seobject.py.
>>
>> I guess we'll need to decide how to provide this information so that
>> it doesn't have to be hardcoded in seobject.py, e.g. yet another
>> policy configuration file with default values for each security
>> context field?
>>
>
> =E2=80=8BThe same issue might apply for serange, which also
> can be an empty string and thus gets audited badly
> if not some default value.
>
>
>>
>> >
>> >>
>> >> -        self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s
>> >> ftype=3D%s tcontext=3D%s:%s:%s:%s" %
>> >> (audit.audit_encode_nv_string("tglob", target, 0),
>> >> ftype_to_audit[ftype], seuser, "object_r", type, serange)) +
>> >> self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s ftype=3D%s
>> >> tcontext=3D%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob",
>> >> target, 0), ftype_to_audit[ftype], seuser, "object_r", setype,
>> >> serange))
>> >>
>> >> def modify(self, target, setype, ftype, serange, seuser):
>> >> self.begin() @@ -2030,7 +2030,7 @@ class
>> >> fcontextRecords(semanageRecords): self.equiv.pop(target)
>> >> self.equal_ind =3D True
>> >>
>> >> -            self.mylog.log_change("resrc=3Dfcontext
>> >> op=3Ddelete-equal %s ftype=3D%s" %
>> >> (audit.audit_encode_nv_string("tglob", target, 0),
>> >> ftype_to_audit[ftype])) +
>> >> self.mylog.log_change("resrc=3Dfcontext op=3Ddelete-equal %s" %
>> >> (audit.audit_encode_nv_string("tglob", target, 0)))
>> >>
>> >> return
>> >>
>> >>
>> >
>> >
>> >
>> >
>> > _______________________________________________ Selinux mailing
>> > list Selinux@tycho.nsa.gov To unsubscribe, send email to
>> > Selinux-leave@tycho.nsa.gov. To get help, send an email containing
>> > "help" to Selinux-request@tycho.nsa.gov.
>> >
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>>
>
>
>
> --
> Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security
> IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087
> Desk Phone +420 532 294 129 :: Mobile +420 773 944 252
> Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR
>
>


--=20
Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security
IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087
Desk Phone +420 532 294 129 :: Mobile +420 773 944 252
Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR

--001a113fde429bf0c3053a18685c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Anyway, could we have this patch applied and sort out a better=
 way</div><div class=3D"gmail_default" style=3D"font-family:monospace,monos=
pace">of supplying defaults later please?</div><div class=3D"gmail_default"=
 style=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace">Thanks,</div><div class=3D=
"gmail_default" style=3D"font-family:monospace,monospace">/M</div></div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Aug 15, 2016=
 at 8:33 AM, Miroslav Vadkerti <span dir=3D"ltr">&lt;<a href=3D"mailto:mvad=
kert@redhat.com" target=3D"_blank">mvadkert@redhat.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><span class=3D""><div =
class=3D"gmail_default" style=3D"font-family:monospace,monospace"><font siz=
e=3D"2"><span style=3D"font-family:monospace">On Fri, Aug 12, 2016 at 4:58 =
PM, Stephen Smalley </span><span dir=3D"ltr" style=3D"font-family:monospace=
">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.=
gov</a>&gt;</span><span style=3D"font-family:monospace"> wrote:</span><br><=
/font></div></span><div class=3D"gmail_extra"><div class=3D"gmail_quote"><s=
pan class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><font size=3D"2"><span>On 08/=
12/2016 10:22 AM, Dominick Grift wrote:<br>
&gt; On 08/12/2016 03:57 PM, Miroslav Vadkerti wrote:<br>
&gt;&gt; For modify action actually audit the selinux type, i.e. use<br>
&gt;&gt; setype variable.<br>
&gt;&gt;<br>
&gt;&gt; For deleting equal fcontext rules do not audit ftype, as the<br>
&gt;&gt; ftype value for equal rules makes little sense.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Miroslav Vadkerti &lt;<a href=3D"mailto:mvadkert@re=
dhat.com" target=3D"_blank">mvadkert@redhat.com</a>&gt; ---<br>
&gt;&gt; policycoreutils/semanage/seobj<wbr>ect.py | 4 ++-- 1 file changed,=
 2<br>
&gt;&gt; insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/policycoreutils/semanage/seo<wbr>bject.py<br>
&gt;&gt; b/policycoreutils/semanage/seo<wbr>bject.py index 786ed0e..8d3088c=
<br>
&gt;&gt; 100644 --- a/policycoreutils/semanage/seo<wbr>bject.py +++<br>
&gt;&gt; b/policycoreutils/semanage/seo<wbr>bject.py @@ -1992,7 +1992,7 @@<=
br>
&gt;&gt; class fcontextRecords(semanageRecord<wbr>s): if not seuser: seuser=
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
v></span><div><div class=3D"gmail_default" style=3D"font-family:monospace,m=
onospace"><font size=3D"2">=E2=80=8BThe same issue might apply for serange,=
 which also</font></div><div class=3D"gmail_default" style=3D"font-family:m=
onospace,monospace"><font size=3D"2">can be an empty string and thus gets a=
udited badly</font></div><div class=3D"gmail_default" style=3D"font-family:=
monospace,monospace"><font size=3D"2">if not some default value.</font></di=
v></div><div><div class=3D"h5"><div class=3D"gmail_default" style=3D"font-f=
amily:monospace,monospace"><font size=3D"2"><span style=3D"font-family:mono=
space">=C2=A0</span><br></font></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<font size=3D"2"><span><br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&quot;resrc=3Df=
<wbr>context op=3Dmodify %s<br>
&gt;&gt; ftype=3D%s tcontext=3D%s:%s:%s:%s&quot; %<br>
&gt;&gt; (audit.audit_encode_nv_string(<wbr>&quot;tglob&quot;, target, 0),<=
br>
&gt;&gt; ftype_to_audit[ftype], seuser, &quot;object_r&quot;, type, serange=
)) +<br>
&gt;&gt; self.mylog.log_change(&quot;resrc=3Df<wbr>context op=3Dmodify %s f=
type=3D%s<br>
&gt;&gt; tcontext=3D%s:%s:%s:%s&quot; % (audit.audit_encode_nv_string(<wbr>=
&quot;tglob&quot;,<br>
&gt;&gt; target, 0), ftype_to_audit[ftype], seuser, &quot;object_r&quot;, s=
etype,<br>
&gt;&gt; serange))<br>
&gt;&gt;<br>
&gt;&gt; def modify(self, target, setype, ftype, serange, seuser):<br>
&gt;&gt; self.begin() @@ -2030,7 +2030,7 @@ class<br>
&gt;&gt; fcontextRecords(semanageRecord<wbr>s): self.equiv.pop(target)<br>
&gt;&gt; self.equal_ind =3D True<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.mylog.log_change(&=
quot;resrc=3Df<wbr>context<br>
&gt;&gt; op=3Ddelete-equal %s ftype=3D%s&quot; %<br>
&gt;&gt; (audit.audit_encode_nv_string(<wbr>&quot;tglob&quot;, target, 0),<=
br>
&gt;&gt; ftype_to_audit[ftype])) +<br>
&gt;&gt; self.mylog.log_change(&quot;resrc=3Df<wbr>context op=3Ddelete-equa=
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
&gt; list <a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinu=
x@tycho.nsa.gov</a> To unsubscribe, send email to<br>
&gt; <a href=3D"mailto:Selinux-leave@tycho.nsa.gov" target=3D"_blank">Selin=
ux-leave@tycho.nsa.gov</a>. To get help, send an email containing<br>
&gt; &quot;help&quot; to <a href=3D"mailto:Selinux-request@tycho.nsa.gov" t=
arget=3D"_blank">Selinux-request@tycho.nsa.gov</a>.<br>
&gt;<br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</font></blockquote></div></div></div><span class=3D"HOEnZb"><font color=3D=
"#888888"><font size=3D"2"><br><br clear=3D"all"></font><div><font size=3D"=
2"><br></font></div><font size=3D"2">-- <br></font><div data-smartmail=3D"g=
mail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr=
"><div><font face=3D"monospace, monospace" size=3D"2">Miroslav Vadkerti :: =
Senior QE / RHCSS :: BaseOS QE Security</font></div><div><font face=3D"mono=
space, monospace" size=3D"2">IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x=
25881087<br></font></div><div><font face=3D"monospace, monospace" size=3D"2=
">Desk Phone <a href=3D"tel:%2B420%20532%20294%20129" value=3D"+42053229412=
9" target=3D"_blank">+420 532 294 129</a> :: Mobile <a href=3D"tel:%2B420%2=
0773%20944%20252" value=3D"+420773944252" target=3D"_blank">+420 773 944 25=
2</a><br></font></div><div><font size=3D"2"><font face=3D"monospace, monosp=
ace">Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR</font><br>=
</font></div><div><br></div></div></div></div></div></div></div>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><div dir=3D"ltr"><div><div dir=3D"ltr"><div><font face=3D"monospace, mon=
ospace" size=3D"2">Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Secu=
rity</font></div><div><font face=3D"monospace, monospace" size=3D"2">IRC mv=
adkert #qe #urt #brno #rpmdiff :: GPG 0x25881087<br></font></div><div><font=
 face=3D"monospace, monospace" size=3D"2">Desk Phone +420 532 294 129 :: Mo=
bile +420 773 944 252<br></font></div><div><font face=3D"monospace, monospa=
ce" size=3D"2">Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR<=
/font><br></div><div><br></div></div></div></div></div></div></div>
</div>

--001a113fde429bf0c3053a18685c--
