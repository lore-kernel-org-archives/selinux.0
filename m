MIME-Version: 1.0
In-Reply-To: <201111230903.27267.russell@coker.com.au>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1321900374.9385.39.camel@moss-pluto>
	<CAGGozWRoHG9TW0xEy7c3ji1ksfXeHt_Nb+53=j3hpZSp0fWmDw@mail.gmail.com>
	<201111230903.27267.russell@coker.com.au>
Date: Thu, 1 Dec 2011 19:42:19 +0100
Message-ID: <CAGGozWTpWRiNBc7zVNAL4TntSc=30RqpE2XXuTkfEqpN-UJsqA@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d0447977d5cedb904b30c36b1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0447977d5cedb904b30c36b1
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I was wondering if there is way to do automatic policy updates for SELinux
at runtime. On similar lines, is there a means by which SELinux queries a
"supervisor" in the userspace in case a policy violation is detected in
enforcing mode. For example, lets say SELinux's initial policy (loaded
during device boot) does not permit program X to read file Y. If SELinux is
enforcing such a policy, X is not allowed to read Y (obviously). In this
scenario, is there a way to allow SELinux ask a user-space decision maker
program if Y could indeed be read by X? Maybe the user-space decision maker
deems the file safe to be read.

Apologies if I am being a little vague here. To put my question in
perspective, I am working on evaluating SELinux on Android and it is
sometimes useful for the Android middleware (sitting on top of the Linux
kernel) to interfere in kernel-level MAC e.g. SELinux. So, it would be
useful to know if a communication channel between SELinux and the
middleware could be established esp. wrt policy updates.

Any help is much appreciated.

Kind Regards,
Bhargava

On Tue, Nov 22, 2011 at 11:03 PM, Russell Coker <russell@coker.com.au>wrote:

> On Wed, 23 Nov 2011, Bhargava Shastry <bshas3@gmail.com> wrote:
> > between the two files. To do this, I need sources for Ubuntu-SELinux
> policy
> > (in order to compile a policy.conf) . I have somehow not been able to
> > locate the source for the policy binary that ubuntu uses (I looked in the
> > /etc/selinux dir to no avail). Any ideas as to where I can find them?
> > Alternatively, is there a tool to reverse engineer policy.conf from the
> > policy binary (e.g. policy.24)?
>
> To get the source for something on Ubuntu you should run
> "apt-get source PACKAGE".
>
> Also you might find it better to use Debian SE Linux stuff instead of
> Ubuntu.
>
> --
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
>



-- 
Bhargava Shastry

--f46d0447977d5cedb904b30c36b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<br><br>I was wondering if there is way to do automatic policy updat=
es for SELinux at runtime. On similar lines, is there a means by which SELi=
nux queries a &quot;supervisor&quot; in the userspace in case a policy viol=
ation is detected in enforcing mode. For example, lets say SELinux&#39;s in=
itial policy (loaded during device boot) does not permit program X to read =
file Y. If SELinux is enforcing such a policy, X is not allowed to read Y (=
obviously). In this scenario, is there a way to allow SELinux ask a user-sp=
ace decision maker program if Y could indeed be read by X? Maybe the user-s=
pace decision maker deems the file safe to be read.<br>
<br>Apologies if I am being a little vague here. To put my question in pers=
pective, I am working on evaluating SELinux on Android and it is sometimes =
useful for the Android middleware (sitting on top of the Linux kernel) to i=
nterfere in kernel-level MAC e.g. SELinux. So, it would be useful to know i=
f a communication channel between SELinux and the middleware could be estab=
lished esp. wrt policy updates.<br>
<br>Any help is much appreciated.<br><br>Kind Regards,<br>Bhargava<br><br><=
div class=3D"gmail_quote">On Tue, Nov 22, 2011 at 11:03 PM, Russell Coker <=
span dir=3D"ltr">&lt;<a href=3D"mailto:russell@coker.com.au">russell@coker.=
com.au</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>On Wed, 23 Nov 2011, Bhargava Shastry &lt;<a href=3D"mailto:bshas3@gmail.c=
om">bshas3@gmail.com</a>&gt; wrote:<br>

&gt; between the two files. To do this, I need sources for Ubuntu-SELinux p=
olicy<br>
&gt; (in order to compile a policy.conf) . I have somehow not been able to<=
br>
&gt; locate the source for the policy binary that ubuntu uses (I looked in =
the<br>
&gt; /etc/selinux dir to no avail). Any ideas as to where I can find them?<=
br>
&gt; Alternatively, is there a tool to reverse engineer policy.conf from th=
e<br>
&gt; policy binary (e.g. policy.24)?<br>
<br>
</div>To get the source for something on Ubuntu you should run<br>
&quot;apt-get source PACKAGE&quot;.<br>
<br>
Also you might find it better to use Debian SE Linux stuff instead of Ubunt=
u.<br>
<div><div></div><div class=3D"h5"><br>
--<br>
My Main Blog =A0 =A0 =A0 =A0 <a href=3D"http://etbe.coker.com.au/" target=
=3D"_blank">http://etbe.coker.com.au/</a><br>
My Documents Blog =A0 =A0<a href=3D"http://doc.coker.com.au/" target=3D"_bl=
ank">http://doc.coker.com.au/</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Bhargava Sh=
astry<br>

--f46d0447977d5cedb904b30c36b1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
