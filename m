Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q84ATD7n023424
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2012 06:29:13 -0400
Received: by vbbfc26 with SMTP id fc26so7154601vbb.12
        for <selinux@tycho.nsa.gov>; Tue, 04 Sep 2012 03:29:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
References: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
Date: Tue, 4 Sep 2012 11:29:12 +0100
Message-ID: <CADxHy9e0sQu8h82KVUQ8k_q4as46NNW90u0ZH6i5yAk--gu64A@mail.gmail.com>
Subject: Re: RBAC to SELinux policy migration
From: Marcel Butucea <marcelbutucea@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf307c9bdcb1a91d04c8ddba04
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf307c9bdcb1a91d04c8ddba04
Content-Type: text/plain; charset=ISO-8859-1

Clarifying to avoid confusion:

1. I assumed I would be able to allow a user the ability to run system
utilities like tcpdump, chkconfig, etc. by using selinux (either by using
domain transitions or applying a sysadm_u context to the user or ...)
Is that correct ?
2. I am not sure capabilities can do that, my understanding was that they
work on a per file basis not per user.....
3. if the uid is checked by the utility I won't be able to workaround that
by means of selinux, right ?

Regards,
Marcel

On 3 September 2012 23:41, Marcel Butucea <marcelbutucea@gmail.com> wrote:

>  Hello SELinux Team,
>
> As I am a beginner in deciphering the depths of SELinux I come to you with
> the following predicament in hope of guidance and help:
>
> We are migrating an application from Solaris to Linux and the main user is
> allowed, through the use of RBAC roles, to run a few system commands like
> svccfg/svcadm (chkconfig on redhat).
>
> Is it possible, using only SElinux (no sudo), to allow a normal user to
> run chkconfig off/on <service> (basically giving it the ability to
> add/remove services) ?(my ultimate goal would be to allow this user to run
> other "root-only" utilities as well). One of my concerns is that
> chkconfig might have some internal check for the uid of the calling user,
> ergo blocking this account from running the utility irrespective of my
> selinux policy, is my worry legitimate or am I imagining things ?
>
> My approach was to try to create an SElinux user with a corresponding
> SElinux role that manages the app's domain/type and is allowed to
> transition to all other domains required to run chkconfig, tcpdump or any
> other system utility usually restricted to root access only. All my
> attempts so far have failed, so my second question would be where could I
> find good documentation that applies to this specific problem ?
>
> Thank you for your support!
>
> Best Regards,
>
> Marcel
>
>

--20cf307c9bdcb1a91d04c8ddba04
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Clarifying=A0to avoid confusion:<div><br></div><div>1. I assumed I would be=
 able to allow a user the ability to run system utilities like tcpdump, chk=
config, etc. by using selinux (either by using domain transitions or=A0appl=
ying=A0a sysadm_u context to the user or ...)</div>
<div>Is that correct ?</div><div>2. I am not sure capabilities can do that,=
 my understanding was that they work on a per file basis not per user.....<=
/div><div>3. if the uid is checked by the utility I won&#39;t be able to=A0=
workaround=A0that by means of selinux, right ?</div>
<div><br></div><div>Regards,</div><div>Marcel</div><div><br><div class=3D"g=
mail_quote">On 3 September 2012 23:41, Marcel Butucea <span dir=3D"ltr">&lt=
;<a href=3D"mailto:marcelbutucea@gmail.com" target=3D"_blank">marcelbutucea=
@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><p style=3D"clear:both;vertical-align:baseli=
ne;text-align:left;margin:0px 0px 1em;word-wrap:break-word;border:0px;paddi=
ng:0px">
</p><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:ba=
seline;clear:both;word-wrap:break-word">

</p><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:ba=
seline;clear:both;word-wrap:break-word"></p><p style=3D"margin:0px 0px 1em;=
padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-w=
ord">


</p><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:ba=
seline;clear:both;word-wrap:break-word"><font face=3D"Arial, Liberation San=
s, DejaVu Sans, sans-serif"><span style=3D"font-size:14px;line-height:18px"=
>Hello SELinux Team,</span></font></p>


<p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:baseli=
ne;clear:both;word-wrap:break-word"><font face=3D"Arial, Liberation Sans, D=
ejaVu Sans, sans-serif"><span style=3D"font-size:14px;line-height:18px">As =
I am a beginner in deciphering the depths of SELinux I come to you with the=
 following predicament in hope of guidance and help:</span></font></p>


<p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:baseli=
ne;clear:both;word-wrap:break-word"><font face=3D"Arial, Liberation Sans, D=
ejaVu Sans, sans-serif"><span style=3D"font-size:14px;line-height:18px">We =
are migrating an application from Solaris to Linux and the main user is all=
owed, through the use of RBAC roles, to run a few system commands like svcc=
fg/svcadm (chkconfig on redhat).</span></font></p>


<p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:baseli=
ne;clear:both;word-wrap:break-word"><font face=3D"Arial, Liberation Sans, D=
ejaVu Sans, sans-serif"><span style=3D"font-size:14px;line-height:18px">Is =
it possible, using only SElinux (no sudo), to allow a normal user to run ch=
kconfig off/on &lt;service&gt; (basically giving it the ability to add/remo=
ve services) ?(my ultimate goal would be to allow this user to run other &q=
uot;root-only&quot;=A0utilities=A0as well).=A0</span></font><span style=3D"=
font-size:14px;line-height:18px;font-family:Arial,&#39;Liberation Sans&#39;=
,&#39;DejaVu Sans&#39;,sans-serif">One of my concerns is that chkconfig mig=
ht have some internal check for the uid of the calling user, ergo blocking =
this account from running the utility irrespective of my selinux policy, is=
 my worry legitimate or am I=A0</span><span style=3D"font-size:14px;line-he=
ight:18px;font-family:Arial,&#39;Liberation Sans&#39;,&#39;DejaVu Sans&#39;=
,sans-serif">imagining</span><span style=3D"font-size:14px;line-height:18px=
;font-family:Arial,&#39;Liberation Sans&#39;,&#39;DejaVu Sans&#39;,sans-ser=
if">=A0things ?</span></p>


<p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:baseli=
ne;clear:both;word-wrap:break-word"><font face=3D"Arial, Liberation Sans, D=
ejaVu Sans, sans-serif"><span style=3D"font-size:14px;line-height:18px">My =
approach was to try to create an SElinux user with a corresponding SElinux =
role that manages the app&#39;s domain/type and is allowed to transition to=
 all other domains required to run chkconfig, tcpdump or any other system u=
tility usually restricted to root access only. All my attempts so far have =
failed, so my second question would be where could I find good documentatio=
n that applies to this specific problem ?</span></font></p>


<p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:baseli=
ne;clear:both;word-wrap:break-word"><font face=3D"Arial, Liberation Sans, D=
ejaVu Sans, sans-serif"><span style=3D"font-size:14px;line-height:18px">Tha=
nk you for your support!</span></font></p>


<p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:baseli=
ne;clear:both;word-wrap:break-word"><span style=3D"font-size:14px;line-heig=
ht:18px;font-family:Arial,&#39;Liberation Sans&#39;,&#39;DejaVu Sans&#39;,s=
ans-serif">Best Regards,</span></p>


<p style=3D"margin:0px 0px 1em;padding:0px;border:0px;vertical-align:baseli=
ne;clear:both;word-wrap:break-word"><font face=3D"Arial, Liberation Sans, D=
ejaVu Sans, sans-serif"><span style=3D"font-size:14px;line-height:18px">Mar=
cel</span></font></p>


<p></p><p></p><p></p><p></p>
</blockquote></div><br></div>

--20cf307c9bdcb1a91d04c8ddba04--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
