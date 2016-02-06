Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u16AwGkw011761
 for <selinux@tycho.nsa.gov>; Sat, 6 Feb 2016 05:58:16 -0500
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com
 [209.85.215.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 4B7135647B4
 for <selinux@tycho.nsa.gov>; Sat,  6 Feb 2016 11:58:12 +0100 (CET)
Received: by mail-lf0-f42.google.com with SMTP id j78so71559477lfb.1
 for <selinux@tycho.nsa.gov>; Sat, 06 Feb 2016 02:58:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201602061258.00611.russell@coker.com.au>
References: <201602050832.20068.russell@coker.com.au>
 <56B4E9F1.8070904@tycho.nsa.gov>
 <201602061258.00611.russell@coker.com.au>
Date: Sat, 6 Feb 2016 11:58:11 +0100
Message-ID: <CAJfZ7=ktGwNiHc7WWBLp6J7HOXszMoB2F9MQuEDFqu7N9fj1qw@mail.gmail.com>
Subject: Re: selinux_set_callback() problem
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: Russell Coker <russell@coker.com.au>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113fc1be00d876052b17d815
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113fc1be00d876052b17d815
Content-Type: text/plain; charset=UTF-8

On Sat, Feb 6, 2016 at 2:58 AM, Russell Coker <russell@coker.com.au> wrote:

> On Sat, 6 Feb 2016 05:29:05 AM Stephen Smalley wrote:
> > On 02/04/2016 04:32 PM, Russell Coker wrote:
> > > type=USER_AVC msg=audit(1454447396.743:48359): pid=1 uid=0
> > > auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> > > msg='avc:  denied  { status } for auid=0 uid=0 gid=0
> > > path="/lib/systemd/system/reboot.target"
> > > cmdline="reboot"
> > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > tcontext=system_u:object_r:systemd_unit_file_t:SystemLow tclass=service
> > > exe="/lib/systemd/systemd" sauid=0 hostname=? addr=? terminal=?'
> > >
> > > I'm seeing entries like the above from the Debian/Jessie systemd in
> > > audit.log. Below is the relevant code from the systemd source:
> > >
> > > _printf_(2, 3) static int log_callback(int type, const char *fmt, ...)
> {
> > >
> > >          va_list ap;
> > >
> > > #ifdef HAVE_AUDIT
> > >
> > >          if (get_audit_fd() >= 0) {
> > >
> > >                  _cleanup_free_ char *buf = NULL;
> > >                  int r;
> > >
> > >                  va_start(ap, fmt);
> > >                  r = vasprintf(&buf, fmt, ap);
> > >                  va_end(ap);
> > >
> > >                  if (r >= 0) {
> > >
> > >                          audit_log_user_avc_message(get_audit_fd(),
> > >
> > > AUDIT_USER_AVC, buf,
> > > NULL, NULL, NULL, 0);
> > >
> > >                          return 0;
> > >
> > >                  }
> > >
> > >          }
> > >
> > > #endif
> > >
> > >          va_start(ap, fmt);
> > >          log_metav(LOG_USER | LOG_INFO, __FILE__, __LINE__,
> __FUNCTION__,
> > >          fmt,
> > >
> > > ap);
> > >
> > >          va_end(ap);
> > >
> > >          return 0;
> > >
> > > }
> > >
> > > Then the following line is in the access_init() function to enable it:
> > >
> > > selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback)
> > > log_callback);
> > >
> > > Any suggestions as to where I should start working on this?
> > >
> > > Sorry if it's a newbie question, I haven't worked on SE Linux library
> > > code for a while.
> >
> > What exactly is the problem?  Is it that the scontext has a raw context
> > and the tcontext has a translated context?  Or is it that it was denied
> > when it should have been allowed?
> >
> > The callback itself is obviously being executed or you wouldn't have the
> > audit message at all.
>
> The problem is a translated context which breaks audit2allow.  Even if it
> didn't break audit2allow it wouldn't be a good thing to have as the text
> representations can (in theory at least) change.


In systemd git log, there is
https://github.com/systemd/systemd/commit/24154879845c6aa68a82d3a606f037e9df7527e0
which seems to fix this issue for systemd >=226. Nevertheless there may
have been a regression since then. Which version of systemd are you using?

-- Nicolas

--001a113fc1be00d876052b17d815
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On S=
at, Feb 6, 2016 at 2:58 AM, Russell Coker <span dir=3D"ltr">&lt;<a href=3D"=
mailto:russell@coker.com.au" target=3D"_blank">russell@coker.com.au</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-=
left-style:solid;padding-left:1ex"><div class=3D""><div class=3D"h5">On Sat=
, 6 Feb 2016 05:29:05 AM Stephen Smalley wrote:<br>
&gt; On 02/04/2016 04:32 PM, Russell Coker wrote:<br>
&gt; &gt; type=3DUSER_AVC msg=3Daudit(1454447396.743:48359): pid=3D1 uid=3D=
0<br>
&gt; &gt; auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_=
t:s0<br>
&gt; &gt; msg=3D&#39;avc:=C2=A0 denied=C2=A0 { status } for auid=3D0 uid=3D=
0 gid=3D0<br>
&gt; &gt; path=3D&quot;/lib/systemd/system/reboot.target&quot;<br>
&gt; &gt; cmdline=3D&quot;reboot&quot;<br>
&gt; &gt; scontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023<=
br>
&gt; &gt; tcontext=3Dsystem_u:object_r:systemd_unit_file_t:SystemLow tclass=
=3Dservice<br>
&gt; &gt; exe=3D&quot;/lib/systemd/systemd&quot; sauid=3D0 hostname=3D? add=
r=3D? terminal=3D?&#39;<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m seeing entries like the above from the Debian/Jessie syst=
emd in<br>
&gt; &gt; audit.log. Below is the relevant code from the systemd source:<br=
>
&gt; &gt;<br>
&gt; &gt; _printf_(2, 3) static int log_callback(int type, const char *fmt,=
 ...) {<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 va_list ap;<br>
&gt; &gt;<br>
&gt; &gt; #ifdef HAVE_AUDIT<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_audit_fd() &gt;=3D 0) {=
<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _cl=
eanup_free_ char *buf =3D NULL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int=
 r;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 va_=
start(ap, fmt);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =
=3D vasprintf(&amp;buf, fmt, ap);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 va_=
end(ap);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(r &gt;=3D 0) {<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 audit_log_user_avc_message(get_audit_fd(),<br>
&gt; &gt;<br>
&gt; &gt; AUDIT_USER_AVC, buf,<br>
&gt; &gt; NULL, NULL, NULL, 0);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<b=
r>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; #endif<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 va_start(ap, fmt);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log_metav(LOG_USER | LOG_INFO, =
__FILE__, __LINE__, __FUNCTION__,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fmt,<br>
&gt; &gt;<br>
&gt; &gt; ap);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 va_end(ap);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; Then the following line is in the access_init() function to enabl=
e it:<br>
&gt; &gt;<br>
&gt; &gt; selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback)<br>
&gt; &gt; log_callback);<br>
&gt; &gt;<br>
&gt; &gt; Any suggestions as to where I should start working on this?<br>
&gt; &gt;<br>
&gt; &gt; Sorry if it&#39;s a newbie question, I haven&#39;t worked on SE L=
inux library<br>
&gt; &gt; code for a while.<br>
&gt;<br>
&gt; What exactly is the problem?=C2=A0 Is it that the scontext has a raw c=
ontext<br>
&gt; and the tcontext has a translated context?=C2=A0 Or is it that it was =
denied<br>
&gt; when it should have been allowed?<br>
&gt;<br>
&gt; The callback itself is obviously being executed or you wouldn&#39;t ha=
ve the<br>
&gt; audit message at all.<br>
<br>
</div></div>The problem is a translated context which breaks audit2allow.=
=C2=A0 Even if it<br>
didn&#39;t break audit2allow it wouldn&#39;t be a good thing to have as the=
 text<br>
representations can (in theory at least) change.</blockquote><div><br></div=
><div>In systemd git log, there is <a href=3D"https://github.com/systemd/sy=
stemd/commit/24154879845c6aa68a82d3a606f037e9df7527e0">https://github.com/s=
ystemd/systemd/commit/24154879845c6aa68a82d3a606f037e9df7527e0</a> which se=
ems to fix this issue for systemd &gt;=3D226. Nevertheless there may have b=
een a regression since then. Which version of systemd are you using?<br></d=
iv><div><br></div><div>-- Nicolas</div></div></div></div>

--001a113fc1be00d876052b17d815--
