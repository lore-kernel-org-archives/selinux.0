Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u12Kkh2G000689
 for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2016 15:46:43 -0500
Received: by mail-wm0-f48.google.com with SMTP id r129so136226202wmr.0
 for <selinux@tycho.nsa.gov>; Tue, 02 Feb 2016 12:46:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMN686EKKebVP7Kwj9M+ziZu_-8KSZZsUu3+_Kcg-ahQZtVRYw@mail.gmail.com>
References: <CAB5=j_qPtHM-D0X6qZf151es_erjfBWYMohLx+PF6toFaKaJgg@mail.gmail.com>
 <56B0F257.60504@tycho.nsa.gov>
 <CAMN686EKKebVP7Kwj9M+ziZu_-8KSZZsUu3+_Kcg-ahQZtVRYw@mail.gmail.com>
From: Mark Steele <mark@control-alt-del.org>
Date: Tue, 2 Feb 2016 15:45:23 -0500
Message-ID: <CAB5=j_rcya+JWZ7DEUhPWn-B5nSywUmN2tre14nbHMyXX7_Mvg@mail.gmail.com>
Subject: Re: SELinux file context matching
To: Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7bb04b82fd5923052acf96d2
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bb04b82fd5923052acf96d2
Content-Type: text/plain; charset=UTF-8

Thanks guys, I forgot to check the _dist file, switching to /usr/lib did
the trick.

Cheers,

Mark

On Tue, Feb 2, 2016 at 1:31 PM, Mike Palmiotto <
mike.palmiotto@crunchydata.com> wrote:

> On Tue, Feb 2, 2016 at 1:15 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 02/02/2016 12:48 PM, Mark Steele wrote:
> >>
> >> Hi list,
> >>
> >> I've got some file contexts setup for an application, and can't get the
> >> file context matching to work as I would expect.
> >>
> >> [root@dev1 policy]# cat
> >> /etc/selinux/targeted/contexts/files/file_contexts | grep cinched
> >> /etc/cinched(/.*)?      system_u:object_r:ts_etc_t:s0
> >> /var/log/cinched(/.*)?  system_u:object_r:ts_log_t:s0
> >> /var/lib/cinched(/.*)?  system_u:object_r:ts_t:s0
> >> */usr/lib64/cinched(/.*)?        system_u:object_r:ts_lib_t:s0*
> >> /etc/bash_completion.d/cinched_bash_completions
> >> system_u:object_r:ts_etc_t:s0
> >> /var/log/cinched/audit(/.*)?    system_u:object_r:ts_audit_log_t:s0
> >> /usr/sbin/cinched       system_u:object_r:ts_exec_t:s0
> >>
> >> [root@dev1 policy]# matchpathcon /usr/lib64/cinched/
> >> */usr/lib64/cinched      system_u:object_r:lib_t:s0*
> >>
> >> [root@dev1 policy]# findcon
> >> /etc/selinux/targeted/contexts/files/file_contexts -p /usr/lib64/cinched
> >> /.*             system_u:object_r:default_t:s0
> >> /usr/.*         system_u:object_r:usr_t:s0
> >> */usr/lib64/cinched(/.*)?                system_u:object_r:ts_lib_t:s0*
> >>
> >>
> >> This is running on CentOS 7. I was assuming that since my rule has the
> >> longest stem, it would be applied.
> >>
> >> Any suggestions?
> >
> >
> > It would help to see the complete file_contexts file.
> > Do you have anything in file_contexts.local that could be overriding it?
>
> Also, it looks like file_context.subs_dist has the entry: '/usr/lib64
> /usr/lib' on CentOS 7. Perhaps Mark's file entries should instead be
> using /usr/lib/cinched?
>
> --Mike
>

--047d7bb04b82fd5923052acf96d2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks guys, I forgot to check the _dist file, switching t=
o /usr/lib did the trick.<div><br></div><div>Cheers,</div><div class=3D"gma=
il_extra"><br></div><div class=3D"gmail_extra">Mark<br><div class=3D"gmail_=
quote"><br></div><div class=3D"gmail_quote">On Tue, Feb 2, 2016 at 1:31 PM,=
 Mike Palmiotto <span dir=3D"ltr">&lt;<a href=3D"mailto:mike.palmiotto@crun=
chydata.com" target=3D"_blank">mike.palmiotto@crunchydata.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=
=3D"h5">On Tue, Feb 2, 2016 at 1:15 PM, Stephen Smalley &lt;<a href=3D"mail=
to:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt; On 02/02/2016 12:48 PM, Mark Steele wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi list,<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ve got some file contexts setup for an application, and can&=
#39;t get the<br>
&gt;&gt; file context matching to work as I would expect.<br>
&gt;&gt;<br>
&gt;&gt; [root@dev1 policy]# cat<br>
&gt;&gt; /etc/selinux/targeted/contexts/files/file_contexts | grep cinched<=
br>
&gt;&gt; /etc/cinched(/.*)?=C2=A0 =C2=A0 =C2=A0 system_u:object_r:ts_etc_t:=
s0<br>
&gt;&gt; /var/log/cinched(/.*)?=C2=A0 system_u:object_r:ts_log_t:s0<br>
&gt;&gt; /var/lib/cinched(/.*)?=C2=A0 system_u:object_r:ts_t:s0<br>
&gt;&gt; */usr/lib64/cinched(/.*)?=C2=A0 =C2=A0 =C2=A0 =C2=A0 system_u:obje=
ct_r:ts_lib_t:s0*<br>
&gt;&gt; /etc/bash_completion.d/cinched_bash_completions<br>
&gt;&gt; system_u:object_r:ts_etc_t:s0<br>
&gt;&gt; /var/log/cinched/audit(/.*)?=C2=A0 =C2=A0 system_u:object_r:ts_aud=
it_log_t:s0<br>
&gt;&gt; /usr/sbin/cinched=C2=A0 =C2=A0 =C2=A0 =C2=A0system_u:object_r:ts_e=
xec_t:s0<br>
&gt;&gt;<br>
&gt;&gt; [root@dev1 policy]# matchpathcon /usr/lib64/cinched/<br>
&gt;&gt; */usr/lib64/cinched=C2=A0 =C2=A0 =C2=A0 system_u:object_r:lib_t:s0=
*<br>
&gt;&gt;<br>
&gt;&gt; [root@dev1 policy]# findcon<br>
&gt;&gt; /etc/selinux/targeted/contexts/files/file_contexts -p /usr/lib64/c=
inched<br>
&gt;&gt; /.*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u:object=
_r:default_t:s0<br>
&gt;&gt; /usr/.*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u:object_r:usr_t:s=
0<br>
&gt;&gt; */usr/lib64/cinched(/.*)?=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 system_u:object_r:ts_lib_t:s0*<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; This is running on CentOS 7. I was assuming that since my rule has=
 the<br>
&gt;&gt; longest stem, it would be applied.<br>
&gt;&gt;<br>
&gt;&gt; Any suggestions?<br>
&gt;<br>
&gt;<br>
&gt; It would help to see the complete file_contexts file.<br>
&gt; Do you have anything in file_contexts.local that could be overriding i=
t?<br>
<br>
</div></div>Also, it looks like file_context.subs_dist has the entry: &#39;=
/usr/lib64<br>
/usr/lib&#39; on CentOS 7. Perhaps Mark&#39;s file entries should instead b=
e<br>
using /usr/lib/cinched?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--Mike<br>
</font></span></blockquote></div><br></div></div>

--047d7bb04b82fd5923052acf96d2--
