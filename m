Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p67DkJ6S026936
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 09:46:19 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p67DkHvf003452
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 13:46:18 GMT
Received: by wyh22 with SMTP id 22so770335wyh.12
        for <selinux@tycho.nsa.gov>; Thu, 07 Jul 2011 06:46:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1309961490.2323.8.camel@localhost.localdomain>
References: <CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>
	<1309932598.2498.28.camel@localhost.localdomain>
	<CAJstirRb7dTEpk0eq+xP_HNBwfEcZ4BF6ftXBrtDLT50JQktHg@mail.gmail.com>
	<1309961490.2323.8.camel@localhost.localdomain>
Date: Thu, 7 Jul 2011 08:46:16 -0500
Message-ID: <CAJstirTP4BvfX_2Gn-=ykYkgLdBW=gJhpf6n=qH-mJpMABGqrw@mail.gmail.com>
Subject: Re: Best base policy to use
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=000e0ce0b4f0eef2c804a77af0f9
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0ce0b4f0eef2c804a77af0f9
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jul 6, 2011 at 9:11 AM, Dominick Grift <domg472@gmail.com> wrote:

>
>
> On Wed, 2011-07-06 at 08:59 -0500, Jeremiah Jahn wrote:
> > semanage  makes persistent changes to a system, correct?
>
> correct
>
> > I'm still uncertain of the best way to modify a module, or at least
> > make one less permissive. would it be to remove or disable a module,
> > get the source, modify it, rename it, and then import it over the old
> > one?
>
> That is one way yes but some modules depend on other modules so it may
> get a bit more complicated than that.
>
> Generally it becomes harder to maintain.
>
> See my suggestion below
>
> > for example lets say I didn't want rpm_script_t to be able to
> > transition into initrc_t, no matter what role it started as. Or, I
> > don't want the sysadm_t to be able to do both run_init_t and rpm_t. Or
> > am I completely in left field and not understanding the proper use of
> > roles?
>
> No, you can achieve that by editing the policy i believe.
>
> I would probably fork selinux policy. El6 policy does not get much
> significant updates so merging changes into your fork should not be too
> much work (as opposed to Fedora)
>

Thanks for the help, that's what I had to do with the old ref policy, I
guess I was just hoping I wouldn't have to do that again, because there was
some newfangled way.  :) Oh well, but thanks again for the help.

--000e0ce0b4f0eef2c804a77af0f9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jul 6, 2011 at 9:11 AM, Dominick=
 Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:domg472@gmail.com">domg472@g=
mail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">
<div class=3D"im"><br>
<br>
On Wed, 2011-07-06 at 08:59 -0500, Jeremiah Jahn wrote:<br>
&gt; semanage =A0makes persistent changes to a system, correct?<br>
<br>
correct<br>
<br>
&gt; I&#39;m still uncertain of the best way to modify a module, or at leas=
t<br>
&gt; make one less permissive. would it be to remove or disable a module,<b=
r>
&gt; get the source, modify it, rename it, and then import it over the old<=
br>
&gt; one?<br>
<br>
</div>That is one way yes but some modules depend on other modules so it ma=
y<br>
get a bit more complicated than that.<br>
<br>
Generally it becomes harder to maintain.<br>
<br>
See my suggestion below<br>
<div class=3D"im"><br>
&gt; for example lets say I didn&#39;t want rpm_script_t to be able to<br>
&gt; transition into initrc_t, no matter what role it started as. Or, I<br>
&gt; don&#39;t want the sysadm_t to be able to do both run_init_t and rpm_t=
. Or<br>
&gt; am I completely in left field and not understanding the proper use of<=
br>
&gt; roles?<br>
<br>
</div>No, you can achieve that by editing the policy i believe.<br>
<br>
I would probably fork selinux policy. El6 policy does not get much<br>
significant updates so merging changes into your fork should not be too<br>
much work (as opposed to Fedora)<br></blockquote><div><br>Thanks for the he=
lp, that&#39;s what I had to do with the old ref policy, I guess I was just=
 hoping I wouldn&#39;t have to do that again, because there was some newfan=
gled way.=A0 :) Oh well, but thanks again for the help.<br>
</div></div><br>

--000e0ce0b4f0eef2c804a77af0f9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
