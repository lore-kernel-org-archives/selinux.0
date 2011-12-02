MIME-Version: 1.0
In-Reply-To: <1322766282.7212.10.camel@moss-pluto>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1321900374.9385.39.camel@moss-pluto>
	<CAGGozWRoHG9TW0xEy7c3ji1ksfXeHt_Nb+53=j3hpZSp0fWmDw@mail.gmail.com>
	<201111230903.27267.russell@coker.com.au>
	<CAGGozWTpWRiNBc7zVNAL4TntSc=30RqpE2XXuTkfEqpN-UJsqA@mail.gmail.com>
	<1322766282.7212.10.camel@moss-pluto>
Date: Fri, 2 Dec 2011 11:37:04 +0100
Message-ID: <CAGGozWTRYZk5FGhTy1hfxVATpaLjxiV7faDaCXW5PywvZR6yoA@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: russell@coker.com.au, SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8f839b21d1dcff04b3198c75
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8f839b21d1dcff04b3198c75
Content-Type: text/plain; charset=ISO-8859-1

Hi Stephen,

Thanks again for sharing your insights. Your timely inputs are much
appreciated.

It is however possible for a userspace agent to exercise various degrees
> of control over SELinux, e.g. by loading new policy, by changing policy
> booleans, or by specifying how to label particular processes and
> objects.  But that would occur in response to some event visible to the
> userspace agent, not in response to an upcall from SELinux in the middle
> of processing some system call.


Alright. So, in essence, user-space can only indirectly affect SELinux's
functioning. I presume this calls for making SELinux policy dynamic enough
(e.g. by means of booleans and conditional checks in policy) to respond to
changes triggered in the user-space.

Regards,
Bhargava Shastry

--e89a8f839b21d1dcff04b3198c75
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Stephen,<br><br>Thanks again for sharing your insights. Your timely inpu=
ts are much appreciated.<br><br><div class=3D"gmail_quote"><div></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


It is however possible for a userspace agent to exercise various degrees<br=
>
of control over SELinux, e.g. by loading new policy, by changing policy<br>
booleans, or by specifying how to label particular processes and<br>
objects. =A0But that would occur in response to some event visible to the<b=
r>
userspace agent, not in response to an upcall from SELinux in the middle<br=
>
of processing some system call.</blockquote><div><br>Alright. So, in essenc=
e, user-space can only indirectly affect SELinux&#39;s functioning. I presu=
me this calls for making SELinux policy dynamic enough (e.g. by means of bo=
oleans and conditional checks in policy) to respond to changes triggered in=
 the user-space. <br>
</div></div><br>Regards,<br>Bhargava Shastry<br>

--e89a8f839b21d1dcff04b3198c75--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
