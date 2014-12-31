Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBV2GTBp027378
 for <selinux@tycho.nsa.gov>; Tue, 30 Dec 2014 21:16:29 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so21426925wgg.5
 for <selinux@tycho.nsa.gov>; Tue, 30 Dec 2014 18:16:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54A3298C.8040509@m4x.org>
References: <1419081017-20565-1-git-send-email-jason@perfinion.com>
 <54958580.9090708@m4x.org> <20141220195711.GA30413@meriadoc.Home>
 <54A3298C.8040509@m4x.org>
Date: Wed, 31 Dec 2014 06:16:26 +0400
Message-ID: <CAPuKSJadjQyVEJiOFtut7__hiONZbYzQJ0bM3LqTSrp5=8iVfg@mail.gmail.com>
Subject: Re: [PATCH] run_init: Use a ring buffer in open_init_pty
From: Jason Zaman <jason@perfinion.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: multipart/alternative; boundary=089e013d2028e04ca4050b79b1cc
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e013d2028e04ca4050b79b1cc
Content-Type: text/plain; charset=UTF-8

Oops. Sorry about this. I think I forgot to git add. Will resend later.
On 31 Dec 2014 06:39, "Nicolas Iooss" <nicolas.iooss@m4x.org> wrote:

> 2014-12-20 20:57 GMT+01:00 Jason Zaman:
> > On Sat, Dec 20, 2014 at 03:19:44PM +0100, Nicolas Iooss wrote:
> >> 2014-12-20 14:10 GMT+01:00 Jason Zaman:
> >>> diff --git a/policycoreutils/run_init/open_init_pty.c
> b/policycoreutils/run_init/open_init_pty.c
> >>> index 4f04e72..fb428a3 100644
> >>> [SNIP]
> >>> +static void setfd_nonblock(int fd)
> >>> +{
> >>> +   int fsflags = fcntl(fd, F_GETFL);
> >>> +
> >>> +   if (fsflags < 0) {
> >>> +           fprintf(stderr, "fcntl(%d, F_GETFL): %s\n", fd,
> strerror(errno));
> >>> +           exit(EX_IOERR);
> >>> +   }
> >>> +
> >>> +   if (fcntl(STDIN_FILENO, F_SETFL, fsflags | O_NONBLOCK) < 0) {
> >>> +           fprintf(stderr, "fcntl(%d, F_SETFL, ... | O_NONBLOCK):
> %s\n", fd, strerror(errno));
> >>> +           exit(EX_IOERR);
> >>> +   }
> >>> +}
> >>
> >> Why does the second fcntl use STDIN_FILENO instead of fd?
> >
> > This indeed looks wrong, good catch. I did not touch this part so it
> > must have worked in debian for quite a while.
> >
> You did not change this in the v2.  Actually the v2 is exactly the same
> as the v1 except the git version at the bottom of your mail.  Did you
> resubmit the same patch on purpose?
>
> >
> >> Otherwise the patch looks good to me.  I have not tested it as I'm using
> >> systemd on my systems running SELinux and I believe it does not use
> >> open_init_pty.
> >
> > you can test this by building and copying it to /usr/sbin/open_init_pty.
> > run_init has that path hard coded so you would have to copy it there.
> > You can then test it with "run_init /bin/echo hello" or "run_init id -Z"
>
> That's unfortunately not so simple.  "strace run_init /usr/bin/id -Z"
> tells me:
>
>   access("/usr/sbin/open_init_pty", X_OK) = 0
>   execve("/usr/bin/id", ["id", "-Z"], [/* 32 vars */]) = 0
>
> ... so /usr/sbin/open_init_pty is not run.
> If I "chmod -x /usr/sbin/open_init_pty":
>
>   access("/usr/sbin/open_init_pty", X_OK) = -1 EACCES (Permission denied)
>   execve("/usr/sbin/open_init_pty", ["./run_init", "/usr/bin/id", "-Z"],
> [/* 32 vars */]) = -1 EACCES (Permission denied)
>   write(2, "execvp: Permission denied\n", 26) = 26
>   exit_group(-1)                          = ?
>   +++ exited with 255 +++
>
> The code which performs the access() is at
>
> https://github.com/SELinuxProject/selinux/blob/policycoreutils-2.4-rc7/policycoreutils/run_init/run_init.c#L409
> . In this line, there is a bang before
> "access("/usr/sbin/open_init_pty", X_OK)" so that open_init_pty is *not*
> run when it exists and is executable.  I don't understand how this part
> of the code work.  More precisely, if the "!" is removed, the codes
> makes sense, but this seems weird as the original commit is quite short:
>
> https://github.com/SELinuxProject/selinux/commit/d46e88abb6e1f7b0228c30c98ba4fb739e63cda3
> .  Does "run_init id -Z" works as expected on your system?
>
> A relevant test may consist in that "readlink /proc/self/fd/1" and
> "run_init readlink /proc/self/fd/1" give different results.
>
> Cheers,
>
> Nicolas
>
>

--089e013d2028e04ca4050b79b1cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Oops. Sorry about this. I think I forgot to git add. Will re=
send later. </p>
<div class=3D"gmail_quote">On 31 Dec 2014 06:39, &quot;Nicolas Iooss&quot; =
&lt;<a href=3D"mailto:nicolas.iooss@m4x.org">nicolas.iooss@m4x.org</a>&gt; =
wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">2014-12-20 20=
:57 GMT+01:00 Jason Zaman:<br>
&gt; On Sat, Dec 20, 2014 at 03:19:44PM +0100, Nicolas Iooss wrote:<br>
&gt;&gt; 2014-12-20 14:10 GMT+01:00 Jason Zaman:<br>
&gt;&gt;&gt; diff --git a/policycoreutils/run_init/open_init_pty.c b/policy=
coreutils/run_init/open_init_pty.c<br>
&gt;&gt;&gt; index 4f04e72..fb428a3 100644<br>
&gt;&gt;&gt; [SNIP]<br>
&gt;&gt;&gt; +static void setfd_nonblock(int fd)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0int fsflags =3D fcntl(fd, F_GETFL);<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0if (fsflags &lt; 0) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quo=
t;fcntl(%d, F_GETFL): %s\n&quot;, fd, strerror(errno));<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EX_IOERR);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0if (fcntl(STDIN_FILENO, F_SETFL, fsflags | O_NON=
BLOCK) &lt; 0) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quo=
t;fcntl(%d, F_SETFL, ... | O_NONBLOCK): %s\n&quot;, fd, strerror(errno));<b=
r>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EX_IOERR);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0}<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;<br>
&gt;&gt; Why does the second fcntl use STDIN_FILENO instead of fd?<br>
&gt;<br>
&gt; This indeed looks wrong, good catch. I did not touch this part so it<b=
r>
&gt; must have worked in debian for quite a while.<br>
&gt;<br>
You did not change this in the v2.=C2=A0 Actually the v2 is exactly the sam=
e<br>
as the v1 except the git version at the bottom of your mail.=C2=A0 Did you<=
br>
resubmit the same patch on purpose?<br>
<br>
&gt;<br>
&gt;&gt; Otherwise the patch looks good to me.=C2=A0 I have not tested it a=
s I&#39;m using<br>
&gt;&gt; systemd on my systems running SELinux and I believe it does not us=
e<br>
&gt;&gt; open_init_pty.<br>
&gt;<br>
&gt; you can test this by building and copying it to /usr/sbin/open_init_pt=
y.<br>
&gt; run_init has that path hard coded so you would have to copy it there.<=
br>
&gt; You can then test it with &quot;run_init /bin/echo hello&quot; or &quo=
t;run_init id -Z&quot;<br>
<br>
That&#39;s unfortunately not so simple.=C2=A0 &quot;strace run_init /usr/bi=
n/id -Z&quot;<br>
tells me:<br>
<br>
=C2=A0 access(&quot;/usr/sbin/open_init_pty&quot;, X_OK) =3D 0<br>
=C2=A0 execve(&quot;/usr/bin/id&quot;, [&quot;id&quot;, &quot;-Z&quot;], [/=
* 32 vars */]) =3D 0<br>
<br>
... so /usr/sbin/open_init_pty is not run.<br>
If I &quot;chmod -x /usr/sbin/open_init_pty&quot;:<br>
<br>
=C2=A0 access(&quot;/usr/sbin/open_init_pty&quot;, X_OK) =3D -1 EACCES (Per=
mission denied)<br>
=C2=A0 execve(&quot;/usr/sbin/open_init_pty&quot;, [&quot;./run_init&quot;,=
 &quot;/usr/bin/id&quot;, &quot;-Z&quot;],<br>
[/* 32 vars */]) =3D -1 EACCES (Permission denied)<br>
=C2=A0 write(2, &quot;execvp: Permission denied\n&quot;, 26) =3D 26<br>
=C2=A0 exit_group(-1)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D ?<br>
=C2=A0 +++ exited with 255 +++<br>
<br>
The code which performs the access() is at<br>
<a href=3D"https://github.com/SELinuxProject/selinux/blob/policycoreutils-2=
.4-rc7/policycoreutils/run_init/run_init.c#L409" target=3D"_blank">https://=
github.com/SELinuxProject/selinux/blob/policycoreutils-2.4-rc7/policycoreut=
ils/run_init/run_init.c#L409</a><br>
. In this line, there is a bang before<br>
&quot;access(&quot;/usr/sbin/open_init_pty&quot;, X_OK)&quot; so that open_=
init_pty is *not*<br>
run when it exists and is executable.=C2=A0 I don&#39;t understand how this=
 part<br>
of the code work.=C2=A0 More precisely, if the &quot;!&quot; is removed, th=
e codes<br>
makes sense, but this seems weird as the original commit is quite short:<br=
>
<a href=3D"https://github.com/SELinuxProject/selinux/commit/d46e88abb6e1f7b=
0228c30c98ba4fb739e63cda3" target=3D"_blank">https://github.com/SELinuxProj=
ect/selinux/commit/d46e88abb6e1f7b0228c30c98ba4fb739e63cda3</a><br>
.=C2=A0 Does &quot;run_init id -Z&quot; works as expected on your system?<b=
r>
<br>
A relevant test may consist in that &quot;readlink /proc/self/fd/1&quot; an=
d<br>
&quot;run_init readlink /proc/self/fd/1&quot; give different results.<br>
<br>
Cheers,<br>
<br>
Nicolas<br>
<br>
</blockquote></div>

--089e013d2028e04ca4050b79b1cc--
