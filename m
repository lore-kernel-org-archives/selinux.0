Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3O4rfpg003395
 for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2015 00:53:41 -0400
Received: by qcpm10 with SMTP id m10so20534597qcp.3
 for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2015 21:53:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d15a5dc7a1fc4677b6ea3908b7480c6c@MIVEXUSR1N01.corpzone.internalzone.com>
References: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
 <CAHC9VhS33Jys15zLsyy+RCLpgkAu4m-r-O5LY=Bstt7YJc8sWA@mail.gmail.com>
 <d15a5dc7a1fc4677b6ea3908b7480c6c@MIVEXUSR1N01.corpzone.internalzone.com>
Date: Fri, 24 Apr 2015 10:23:40 +0530
Message-ID: <CA+XqU8jVmuMFVo4wCr4VD+M0m7jZfgVbONDwnhcJLFxxgmeVnA@mail.gmail.com>
Subject: Re: Switching to enforcing mode introduces new policy issues?
From: Gaurav Gangwar <gauravgangwaar@gmail.com>
To: "Spector, Aaron" <Aaron_Spector@mcafee.com>
Content-Type: multipart/alternative; boundary=001a1149572412913b0514712e8d
Cc: "SELinux \(selinux@tycho.nsa.gov\)" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1149572412913b0514712e8d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

also check if you have modified the selinux code
also keep track of dmesg. i have noticed that few denials are only shown in
dmesg so $dmesg | grep avc is quit important while checking the boot time
denials.
one more thing you have to be sure is that u switch between permissive and
enforce mode on the same build/bootimage.


Thanks and Regards
Gaurav Gangwar

On 24 April 2015 at 09:42, Spector, Aaron <Aaron_Spector@mcafee.com> wrote:

> That sounds like an idea, I'll have to give it a shot. To add a bit more
> information, I'm seeing a bunch of these changes happen during the boot
> process in init and I would assume the AVC is cleared between reboots -
> I've tweaked and added some things there for experimentation. I can boot =
my
> system up in permissive and see no problems, but when I restart it in
> enforcing I start seeing brand new policy violations, things I haven't se=
en
> before. It seems odd that the same boot sequence would result in such
> different behavior.
>
> -Aaron
>
> -----Original Message-----
> From: Paul Moore [mailto:paul@paul-moore.com]
> Sent: Thursday, April 23, 2015 5:20 PM
> To: Spector, Aaron
> Cc: SELinux (selinux@tycho.nsa.gov)
> Subject: Re: Switching to enforcing mode introduces new policy issues?
>
> On Thu, Apr 23, 2015 at 5:14 PM, Spector, Aaron <Aaron_Spector@mcafee.com=
>
> wrote:
> > Hi all,
> >
> > I=E2=80=99ve been working on writing my first policy for SELinux and I=
=E2=80=99ve hit
> > a bit of a snag. I=E2=80=99ve gotten the policy clean in permissive mod=
e, but
> > when I swap the system over to enforcing, a whole new set of policy
> issues crop up.
> > Everything I=E2=80=99ve read says this isn=E2=80=99t to be expected so =
I=E2=80=99m a bit
> > confused as to what=E2=80=99s happening.
>
> {snip}
>
> > So far what I=E2=80=99ve had to do to get around it is to add to my pol=
icy,
> > but that doesn=E2=80=99t seem like that should be necessary. If the aud=
it is
> > clean in permissive mode, why isn=E2=80=99t it clean in enforcing?
> >
> > Is it possible that I=E2=80=99m missing policy deny audits when it=E2=
=80=99s in
> > permissive mode?
>
> It's important to remember that when you are in permissive mode you will
> only see a given SELinux AVC denial *once*, after that it will not be
> reported until the AVC is reset.  My two favorite ways of resetting the
> SELinux AVC are to run either 'load_policy' or toggle the system from
> permissive into enforcing and then back into permissive mode.  Try that a=
nd
> I suspect that will solve your problem.
>
> -Paul
>
> --
> paul moore
> www.paul-moore.com
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.

--001a1149572412913b0514712e8d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Aaron,<div><br><div>also check if you have modified the=
 selinux code=C2=A0</div><div>also keep track of dmesg. i have noticed that=
 few denials are only shown in dmesg so $dmesg | grep avc is quit important=
 while checking the boot time denials.</div><div>one more thing you have to=
 be sure is that u switch between permissive and enforce mode on the same b=
uild/bootimage.</div><div><br></div><div><br></div><div>Thanks and Regards<=
/div><div>Gaurav Gangwar</div></div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On 24 April 2015 at 09:42, Spector, Aaron <span di=
r=3D"ltr">&lt;<a href=3D"mailto:Aaron_Spector@mcafee.com" target=3D"_blank"=
>Aaron_Spector@mcafee.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">That sounds like an idea, I&#39;ll have to give it a shot. To add a =
bit more information, I&#39;m seeing a bunch of these changes happen during=
 the boot process in init and I would assume the AVC is cleared between reb=
oots - I&#39;ve tweaked and added some things there for experimentation. I =
can boot my system up in permissive and see no problems, but when I restart=
 it in enforcing I start seeing brand new policy violations, things I haven=
&#39;t seen before. It seems odd that the same boot sequence would result i=
n such different behavior.<br>
<br>
-Aaron<br>
<br>
-----Original Message-----<br>
From: Paul Moore [mailto:<a href=3D"mailto:paul@paul-moore.com">paul@paul-m=
oore.com</a>]<br>
Sent: Thursday, April 23, 2015 5:20 PM<br>
To: Spector, Aaron<br>
Cc: SELinux (<a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov=
</a>)<br>
Subject: Re: Switching to enforcing mode introduces new policy issues?<br>
<br>
On Thu, Apr 23, 2015 at 5:14 PM, Spector, Aaron &lt;<a href=3D"mailto:Aaron=
_Spector@mcafee.com">Aaron_Spector@mcafee.com</a>&gt; wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I=E2=80=99ve been working on writing my first policy for SELinux and I=
=E2=80=99ve hit<br>
&gt; a bit of a snag. I=E2=80=99ve gotten the policy clean in permissive mo=
de, but<br>
&gt; when I swap the system over to enforcing, a whole new set of policy is=
sues crop up.<br>
&gt; Everything I=E2=80=99ve read says this isn=E2=80=99t to be expected so=
 I=E2=80=99m a bit<br>
&gt; confused as to what=E2=80=99s happening.<br>
<br>
{snip}<br>
<br>
&gt; So far what I=E2=80=99ve had to do to get around it is to add to my po=
licy,<br>
&gt; but that doesn=E2=80=99t seem like that should be necessary. If the au=
dit is<br>
&gt; clean in permissive mode, why isn=E2=80=99t it clean in enforcing?<br>
&gt;<br>
&gt; Is it possible that I=E2=80=99m missing policy deny audits when it=E2=
=80=99s in<br>
&gt; permissive mode?<br>
<br>
It&#39;s important to remember that when you are in permissive mode you wil=
l only see a given SELinux AVC denial *once*, after that it will not be rep=
orted until the AVC is reset.=C2=A0 My two favorite ways of resetting the S=
ELinux AVC are to run either &#39;load_policy&#39; or toggle the system fro=
m permissive into enforcing and then back into permissive mode.=C2=A0 Try t=
hat and I suspect that will solve your problem.<br>
<br>
-Paul<br>
<br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" target=3D"_blank">www.paul-moore.com<=
/a><br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</blockqu=
ote></div><br></div>

--001a1149572412913b0514712e8d--
