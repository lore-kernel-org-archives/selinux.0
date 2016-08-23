Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7N9WsBn029220
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 05:32:54 -0400
Received: by mail-ua0-f175.google.com with SMTP id 74so234975872uau.0
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 02:32:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160821034954.GA19749@meriadoc.perfinion.com>
References: <CAFC8oac4Ut1Qm9R_KY2-XHatmeq-m+VoraEbwGYbGdCTi+xYcA@mail.gmail.com>
 <20160821034954.GA19749@meriadoc.perfinion.com>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Tue, 23 Aug 2016 14:32:51 +0500
Message-ID: <CAFC8oacbbWqMb2OGGKLN+9mCSHHjiN5V97OGGAQ0gWbfhMv=Eg@mail.gmail.com>
Subject: Re: docker daemon type label issue
To: Jason Zaman <jason@perfinion.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c000d70471b39053ab9d9ea
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c000d70471b39053ab9d9ea
Content-Type: text/plain; charset=UTF-8

thanks jason it was very helpful

On Sun, Aug 21, 2016 at 8:49 AM, Jason Zaman <jason@perfinion.com> wrote:

> On Sun, Aug 21, 2016 at 07:20:57AM +0500, Kashif ali wrote:
> > Hi
> > * When i run my docker daemon with on port for communication with client
> > with the help of this command
> > => "docker daemon -H localhost:2376 --selinux-enabled &"
> >    then the docker daemon have following label
> >    "root:unconfined_r:unconfined_t:s0-s0:c0.c1023 2535 pts/0 00:00:00
> > dockerd"
> >
> > *  Root user is running in the following context
> > "root:unconfined_r:unconfined_t:"
> >
> > * is there anything i am missing why docker daemon don't have docker_t
> > label on it,
> >   i know as docker daemon is started by unconfined_t domain and
> > unconfined_t domain   have no domain transition then in which context the
> > docker daemon should start and     as i read if init_t start the process
> > then docker daemon will have docker_t label on it so   how can i run
> docker
> > daemon with init_t context
>
> You want to run docker in the docker_t domain? then just set a domtrans
> so it will transition to docker. you do not have to go via system_u or
> init_t for that. you can also use "runcon -t docker_t docker daemon..."
> if there is no transition.
> Are you on redhat? you might want to ask on their mailing list, they'd
> be a better help probably.
>
> -- Jason
>

--94eb2c000d70471b39053ab9d9ea
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">thanks jason it was very helpful</div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Sun, Aug 21, 2016 at 8:49 AM, Jaso=
n Zaman <span dir=3D"ltr">&lt;<a href=3D"mailto:jason@perfinion.com" target=
=3D"_blank">jason@perfinion.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Sun, Aug 21, 2016 =
at 07:20:57AM +0500, Kashif ali wrote:<br>
&gt; Hi<br>
&gt; * When i run my docker daemon with on port for communication with clie=
nt<br>
&gt; with the help of this command<br>
&gt; =3D&gt; &quot;docker daemon -H localhost:2376 --selinux-enabled &amp;&=
quot;<br>
&gt;=C2=A0 =C2=A0 then the docker daemon have following label<br>
&gt;=C2=A0 =C2=A0 &quot;root:unconfined_r:unconfined_<wbr>t:s0-s0:c0.c1023 =
2535 pts/0 00:00:00<br>
&gt; dockerd&quot;<br>
&gt;<br>
&gt; *=C2=A0 Root user is running in the following context<br>
&gt; &quot;root:unconfined_r:unconfined_<wbr>t:&quot;<br>
&gt;<br>
&gt; * is there anything i am missing why docker daemon don&#39;t have dock=
er_t<br>
&gt; label on it,<br>
&gt;=C2=A0 =C2=A0i know as docker daemon is started by unconfined_t domain =
and<br>
&gt; unconfined_t domain=C2=A0 =C2=A0have no domain transition then in whic=
h context the<br>
&gt; docker daemon should start and=C2=A0 =C2=A0 =C2=A0as i read if init_t =
start the process<br>
&gt; then docker daemon will have docker_t label on it so=C2=A0 =C2=A0how c=
an i run docker<br>
&gt; daemon with init_t context<br>
<br>
</div></div>You want to run docker in the docker_t domain? then just set a =
domtrans<br>
so it will transition to docker. you do not have to go via system_u or<br>
init_t for that. you can also use &quot;runcon -t docker_t docker daemon...=
&quot;<br>
if there is no transition.<br>
Are you on redhat? you might want to ask on their mailing list, they&#39;d<=
br>
be a better help probably.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-- Jason<br>
</font></span></blockquote></div><br></div>

--94eb2c000d70471b39053ab9d9ea--
