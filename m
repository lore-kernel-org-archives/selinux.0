Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7K5CQiG018080
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 01:12:26 -0400
Received: by mail-ua0-f175.google.com with SMTP id k90so112286718uak.1
 for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2016 22:12:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFC8oadn76ZLU2T0BAJyrceAzuVAtB+Yincvt7m7=29kbOrFNg@mail.gmail.com>
References: <CAFC8oadn76ZLU2T0BAJyrceAzuVAtB+Yincvt7m7=29kbOrFNg@mail.gmail.com>
From: Jason Zaman <jason@perfinion.com>
Date: Sat, 20 Aug 2016 13:12:16 +0800
Message-ID: <CAPuKSJZcvoALJ+tb3258mAORTnTu162zPs5h6YHX_mpqJFdZZw@mail.gmail.com>
Subject: Re: (How to ) Change the context of user
To: Kashif ali <kashif.ali.9498@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c07a396ce4ccd053a79db33
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c07a396ce4ccd053a79db33
Content-Type: text/plain; charset=UTF-8

On 20 Aug 2016 08:56, "Kashif ali" <kashif.ali.9498@gmail.com> wrote:
>
> Hi
>   * I'm facing a problem while changing the context of root user in
selinux, Selinux is in enforced and targeted policy. By default Selinux
assign user =>"unconfined_u:unconfiend_r:unconfined_t:"
> context for the user i have changed the selinux mapped root user
"unconifined_u" into "system_u" for root user with the help of command
> =>"semanage login -a -s system_u root"
> after executing this command the root user context is changed into
"system_u:unconfined_r:unconfined_t:".

Don't do this. System_u is not able to login. System_u is for daemon's.
Root is in sysadm_r or unconfined_r usually.

> * Now i have changed the root user role and domain type so i execute this
command
> =>"newrole -r system_r -t initrc_t:"
> and change the root user context into "system_u:system_r:initrc_t:" but
this change is temporary after rebooting the system the context of root
user is changed back to "system_u:unconfined_r:unconfined_t:"
>
> * what i need is to change the root user context permanently into
"system_u:system_r:initrc_t:".

Why permanently? This will probably break a lot of things. What are you
trying to accomplish with making it permanent?
If you need to run a command as initrc_t, use run_init in front. Eg:

# run_init /etc/init.d/sshd restart

This will first switch to system_u:system_r:initrc_t and then run ssh which
will automatically transition to sshd_t

-- Jason

--94eb2c07a396ce4ccd053a79db33
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">On 20 Aug 2016 08:56, &quot;Kashif ali&quot; &lt;<a href=3D"=
mailto:kashif.ali.9498@gmail.com">kashif.ali.9498@gmail.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt; Hi<br>
&gt; =C2=A0 * I&#39;m facing a problem while changing the context of root u=
ser in selinux, Selinux is in enforced and targeted policy. By default Seli=
nux assign user =3D&gt;&quot;unconfined_u:unconfiend_r:unconfined_t:&quot;=
=C2=A0<br>
&gt; context for the user i have changed the selinux mapped root user &quot=
;unconifined_u&quot; into &quot;system_u&quot; for root user with the help =
of command=C2=A0<br>
&gt; =3D&gt;&quot;semanage login -a -s system_u root&quot;=C2=A0<br>
&gt; after executing this command the root user context is changed into &qu=
ot;system_u:unconfined_r:unconfined_t:&quot;.</p>
<p dir=3D"ltr">Don&#39;t do this. System_u is not able to login. System_u i=
s for daemon&#39;s. Root is in sysadm_r or unconfined_r usually. </p>
<p dir=3D"ltr">&gt; * Now i have changed the root user role and domain type=
 so i execute this command=C2=A0<br>
&gt; =3D&gt;&quot;newrole -r system_r -t initrc_t:&quot;=C2=A0<br>
&gt; and change the root user context into &quot;system_u:system_r:initrc_t=
:&quot; but this change is temporary after rebooting the system the context=
 of root user is changed back to &quot;system_u:unconfined_r:unconfined_t:&=
quot;<br>
&gt;<br>
&gt; * what i need is to change the root user context permanently into &quo=
t;system_u:system_r:initrc_t:&quot;.</p>
<p dir=3D"ltr">Why permanently? This will probably break a lot of things. W=
hat are you trying to accomplish with making it permanent?<br>
If you need to run a command as initrc_t, use run_init in front. Eg:</p>
<p dir=3D"ltr"># run_init /etc/init.d/sshd restart</p>
<p dir=3D"ltr">This will first switch to system_u:system_r:initrc_t and the=
n run ssh which will automatically transition to sshd_t</p>
<p dir=3D"ltr">-- Jason<br>
</p>

--94eb2c07a396ce4ccd053a79db33--
