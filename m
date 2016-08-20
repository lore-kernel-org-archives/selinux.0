Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7KEhjtN003653
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 10:43:45 -0400
Received: by mail-ua0-f176.google.com with SMTP id k90so124675864uak.1
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 07:43:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPuKSJZcvoALJ+tb3258mAORTnTu162zPs5h6YHX_mpqJFdZZw@mail.gmail.com>
References: <CAFC8oadn76ZLU2T0BAJyrceAzuVAtB+Yincvt7m7=29kbOrFNg@mail.gmail.com>
 <CAPuKSJZcvoALJ+tb3258mAORTnTu162zPs5h6YHX_mpqJFdZZw@mail.gmail.com>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Sat, 20 Aug 2016 19:43:35 +0500
Message-ID: <CAFC8oadF+8bsRxvibsiTO_ekjC6xDGK2hm6M7w6J8xT6+tLUDw@mail.gmail.com>
Subject: Re: (How to ) Change the context of user
To: Jason Zaman <jason@perfinion.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c04336afb254f053a81d691
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c04336afb254f053a81d691
Content-Type: text/plain; charset=UTF-8

i want to change it because of docker_t label of docker daemon when root
user run in the following context
"unconfined_u:unconfined_r:unconfined_t:", when i run docker daemon on
network with the following command
=> docker daemon -H localhost:2376 --selinux-enabled &
then docker daemon have unconfined_t label on it and as it is described
unconfined domain have access to all process in the system and i have read
unconfined_t have no domain transition in selinux so

* but when i run root user in the following context
"system_u:system_r:initrc_t:", and when i run docker daemon in this context
then docker daemon have docker_t label on it

so is there anyway to solve this problem or anyway that should assign
correct docker_t label on docker daemon



On Sat, Aug 20, 2016 at 10:12 AM, Jason Zaman <jason@perfinion.com> wrote:

> On 20 Aug 2016 08:56, "Kashif ali" <kashif.ali.9498@gmail.com> wrote:
> >
> > Hi
> >   * I'm facing a problem while changing the context of root user in
> selinux, Selinux is in enforced and targeted policy. By default Selinux
> assign user =>"unconfined_u:unconfiend_r:unconfined_t:"
> > context for the user i have changed the selinux mapped root user
> "unconifined_u" into "system_u" for root user with the help of command
> > =>"semanage login -a -s system_u root"
> > after executing this command the root user context is changed into
> "system_u:unconfined_r:unconfined_t:".
>
> Don't do this. System_u is not able to login. System_u is for daemon's.
> Root is in sysadm_r or unconfined_r usually.
>
> > * Now i have changed the root user role and domain type so i execute
> this command
> > =>"newrole -r system_r -t initrc_t:"
> > and change the root user context into "system_u:system_r:initrc_t:" but
> this change is temporary after rebooting the system the context of root
> user is changed back to "system_u:unconfined_r:unconfined_t:"
> >
> > * what i need is to change the root user context permanently into
> "system_u:system_r:initrc_t:".
>
> Why permanently? This will probably break a lot of things. What are you
> trying to accomplish with making it permanent?
> If you need to run a command as initrc_t, use run_init in front. Eg:
>
> # run_init /etc/init.d/sshd restart
>
> This will first switch to system_u:system_r:initrc_t and then run ssh
> which will automatically transition to sshd_t
>
> -- Jason
>

--94eb2c04336afb254f053a81d691
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">i want to change it because of docker_t label of docker da=
emon when root user run in the following context=C2=A0<div>&quot;unconfined=
_u:unconfined_r:unconfined_t:&quot;, when i run docker daemon on network wi=
th the following command=C2=A0<br>=3D&gt; docker daemon -H localhost:2376 -=
-selinux-enabled &amp;=C2=A0<br>then docker daemon have unconfined_t label =
on it and as it is described unconfined domain have access to all process i=
n the system and i have read unconfined_t have no domain transition in seli=
nux so=C2=A0<br><br>* but when i run root user in the following context &qu=
ot;system_u:system_r:initrc_t:&quot;, and when i run docker daemon in this =
context then docker daemon have docker_t label on it<br><br>so is there any=
way to solve this problem or anyway that should assign correct docker_t lab=
el on docker daemon <br>=C2=A0<br><div><div><br></div></div></div></div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Aug 20, 2016=
 at 10:12 AM, Jason Zaman <span dir=3D"ltr">&lt;<a href=3D"mailto:jason@per=
finion.com" target=3D"_blank">jason@perfinion.com</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D""><p dir=3D"ltr">On 20 Aug 20=
16 08:56, &quot;Kashif ali&quot; &lt;<a href=3D"mailto:kashif.ali.9498@gmai=
l.com" target=3D"_blank">kashif.ali.9498@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi<br>
&gt; =C2=A0 * I&#39;m facing a problem while changing the context of root u=
ser in selinux, Selinux is in enforced and targeted policy. By default Seli=
nux assign user =3D&gt;&quot;unconfined_u:unconfiend_r:<wbr>unconfined_t:&q=
uot;=C2=A0<br>
&gt; context for the user i have changed the selinux mapped root user &quot=
;unconifined_u&quot; into &quot;system_u&quot; for root user with the help =
of command=C2=A0<br>
&gt; =3D&gt;&quot;semanage login -a -s system_u root&quot;=C2=A0<br>
&gt; after executing this command the root user context is changed into &qu=
ot;system_u:unconfined_r:<wbr>unconfined_t:&quot;.</p>
</span><p dir=3D"ltr">Don&#39;t do this. System_u is not able to login. Sys=
tem_u is for daemon&#39;s. Root is in sysadm_r or unconfined_r usually. </p=
><span class=3D"">
<p dir=3D"ltr">&gt; * Now i have changed the root user role and domain type=
 so i execute this command=C2=A0<br>
&gt; =3D&gt;&quot;newrole -r system_r -t initrc_t:&quot;=C2=A0<br>
&gt; and change the root user context into &quot;system_u:system_r:initrc_t=
:&quot; but this change is temporary after rebooting the system the context=
 of root user is changed back to &quot;system_u:unconfined_r:<wbr>unconfine=
d_t:&quot;<br>
&gt;<br>
&gt; * what i need is to change the root user context permanently into &quo=
t;system_u:system_r:initrc_t:&quot;.</p>
</span><p dir=3D"ltr">Why permanently? This will probably break a lot of th=
ings. What are you trying to accomplish with making it permanent?<br>
If you need to run a command as initrc_t, use run_init in front. Eg:</p>
<p dir=3D"ltr"># run_init /etc/init.d/sshd restart</p>
<p dir=3D"ltr">This will first switch to system_u:system_r:initrc_t and the=
n run ssh which will automatically transition to sshd_t</p><span class=3D"H=
OEnZb"><font color=3D"#888888">
<p dir=3D"ltr">-- Jason<br>
</p>
</font></span></blockquote></div><br></div>

--94eb2c04336afb254f053a81d691--
