Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v19MWCUk004074
 for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2017 17:32:12 -0500
Received: by mail-oi0-f46.google.com with SMTP id w204so10988185oiw.0
 for <selinux@tycho.nsa.gov>; Thu, 09 Feb 2017 14:32:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSj4ztDZwxfcuugaD5-OJrBVaJ=TQS=t4=jfL0+ZdbdYQ@mail.gmail.com>
References: <20170209160242.23405-1-amurdaca@redhat.com>
 <CAHC9VhRFxDuRJHYEuRs7kc4ivgaT=-SxdU-o5Lq7H-O+5JJRxQ@mail.gmail.com>
 <CALKLTGTc7U7ohxd44MHOuzVomW-oUsumqUqr0MKaUohw1NpSsg@mail.gmail.com>
 <CAHC9VhSj4ztDZwxfcuugaD5-OJrBVaJ=TQS=t4=jfL0+ZdbdYQ@mail.gmail.com>
From: Antonio Murdaca <amurdaca@redhat.com>
Date: Thu, 9 Feb 2017 23:32:09 +0100
Message-ID: <CALKLTGTjpBYd5-M9RiO-Q4H_SokEiPJYptbxktg_aPccws59Jw@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labeling for cgroupfs
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov, Antonio Murdaca <runcom@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a113ddd2e4d95680548208da5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113ddd2e4d95680548208da5
Content-Type: text/plain; charset=UTF-8

On Feb 9, 2017 20:23, "Paul Moore" <paul@paul-moore.com> wrote:

On Thu, Feb 9, 2017 at 12:39 PM, Antonio Murdaca <amurdaca@redhat.com>
wrote:
> On Feb 9, 2017 17:14, "Paul Moore" <paul@paul-moore.com> wrote:
> On Thu, Feb 9, 2017 at 11:02 AM, Antonio Murdaca <amurdaca@redhat.com>
> wrote:
>> From: Antonio Murdaca <runcom@redhat.com>
>>
>> This patch allows genfscon per-file labeling for cgroupfs. For instance,
>> this allows to label the "release_agent" file within each
>> cgroup mount and limit writes to it.
>>
>> Signed-off-by: Antonio Murdaca <amurdaca@redhat.com>
>> ---
>>  security/selinux/hooks.c | 2 ++
>>  1 file changed, 2 insertions(+)
>
> This was already merged ... ?
>
>
> This is adding cgroup and cgroup2 to the other whitelist (afaict).

Yes, my apologies, I read this patch too quickly and confused it with
the previous cgroups patch.

Just to set expectations, this patch is too late for the upcoming
merge window, we can consider it in a few weeks once the merge window
has closed.  This should give you some time to do some further testing
(hint, hint).


Sure, I'm going to test this and add tests in selinux-testsuite as well


--
paul moore
www.paul-moore.com

--001a113ddd2e4d95680548208da5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Feb 9, 2017 20:23, &quot;Paul Moore&quot; &lt;<a href=3D"mailt=
o:paul@paul-moore.com">paul@paul-moore.com</a>&gt; wrote:<br type=3D"attrib=
ution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">On Thu, Feb 9, 2=
017 at 12:39 PM, Antonio Murdaca &lt;<a href=3D"mailto:amurdaca@redhat.com"=
>amurdaca@redhat.com</a>&gt; wrote:<br>
&gt; On Feb 9, 2017 17:14, &quot;Paul Moore&quot; &lt;<a href=3D"mailto:pau=
l@paul-moore.com">paul@paul-moore.com</a>&gt; wrote:<br>
&gt; On Thu, Feb 9, 2017 at 11:02 AM, Antonio Murdaca &lt;<a href=3D"mailto=
:amurdaca@redhat.com">amurdaca@redhat.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt; From: Antonio Murdaca &lt;<a href=3D"mailto:runcom@redhat.com">run=
com@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; This patch allows genfscon per-file labeling for cgroupfs. For ins=
tance,<br>
&gt;&gt; this allows to label the &quot;release_agent&quot; file within eac=
h<br>
&gt;&gt; cgroup mount and limit writes to it.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Antonio Murdaca &lt;<a href=3D"mailto:amurdaca@redh=
at.com">amurdaca@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 security/selinux/hooks.c | 2 ++<br>
&gt;&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; This was already merged ... ?<br>
&gt;<br>
&gt;<br>
&gt; This is adding cgroup and cgroup2 to the other whitelist (afaict).<br>
<br>
</div>Yes, my apologies, I read this patch too quickly and confused it with=
<br>
the previous cgroups patch.<br>
<br>
Just to set expectations, this patch is too late for the upcoming<br>
merge window, we can consider it in a few weeks once the merge window<br>
has closed.=C2=A0 This should give you some time to do some further testing=
<br>
(hint, hint).<br></blockquote></div></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Sure, I&#39;m going to test this and add tests in selinu=
x-testsuite as well</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<font color=3D"#888888"><br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" rel=3D"noreferrer" target=3D"_blank">=
www.paul-moore.com</a><br>
</font></blockquote></div><br></div></div></div>

--001a113ddd2e4d95680548208da5--
