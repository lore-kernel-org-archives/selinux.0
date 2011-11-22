MIME-Version: 1.0
In-Reply-To: <1321900374.9385.39.camel@moss-pluto>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1320409924.1015.7.camel@moss-pluto>
	<CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
	<1320425998.1015.31.camel@moss-pluto>
	<CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
	<1320930750.13691.5.camel@moss-pluto>
	<CAGGozWQpW3Tvj00Rt44EEhk1qYn-w8BE07naY+MRQUbXurpYmQ@mail.gmail.com>
	<1320942368.13691.7.camel@moss-pluto>
	<CAGGozWRK117G=93o1=v0yM6HxdtbDRSZ8sKybDEYNEKjpyHMNA@mail.gmail.com>
	<CAGGozWR8pNNC6P1T8cYtbkfqZu56iVty+JdmXwudo3ZaAVbN-g@mail.gmail.com>
	<CACLa4puuN_nt+Hw3LU3UjYAJ9gGua=bEzt-ioXGv3=W41=1bBg@mail.gmail.com>
	<CAGGozWRxOzUiG33OvmEqX+Y4ywcGTfwx_8bVKuwQ31M_bdtN6Q@mail.gmail.com>
	<1321537184.4836.9.camel@moss-pluto>
	<CAGGozWT9PP-p4-UA6WJtiZmwHE1ot_Of85pKQRLGeab37e4kaQ@mail.gmail.com>
	<1321890697.9385.20.camel@moss-pluto>
	<CAGGozWQXo5bXgVKa0t3pO+45Vj70LJA12dF2ovX6Hm9KnYNNQQ@mail.gmail.com>
	<1321900374.9385.39.camel@moss-pluto>
Date: Tue, 22 Nov 2011 20:25:30 +0100
Message-ID: <CAGGozWRoHG9TW0xEy7c3ji1ksfXeHt_Nb+53=j3hpZSp0fWmDw@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>
Content-Type: multipart/alternative; boundary=f46d0447954d2eb75904b257c4c5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0447954d2eb75904b257c4c5
Content-Type: text/plain; charset=ISO-8859-1

>
> It doesn't make much sense to use the reference policy for Android,
> because the Android userspace is completely different from a typical
> Linux distribution.  I created a policy from scratch for my work.
>
> You can generate a minimal policy from the kernel tree (see
> scripts/selinux/mdp).  However, that generated policy will only take you
> so far since it lacks any of the macro definitions/build infrastructure
> and since it places everything in a single type/domain.  So you can
> start there, but you'll likely want to split it out into multiple files,
> add some of the macros from refpolicy or the original example policy,
> and start defining individual domains and types.


Thanks for pointing out. I am getting myself acquainted with SELinux policy
semantics to be able to start from scratch. I have one question though and
the answer to this would make my task of creating an Android specific
policy much smoother.
I had previously loaded an Ubuntu SELinux policy on Android and it seemed
to label all the filesystems correctly (except yaffs). I would like to diff
a very basic policy (i.e., mdp output) with the default ubuntu policy so
that I would get an idea of how filesystems are being labeled and how
transitions are handled among other things; basically to learn from a delta
between the two files. To do this, I need sources for Ubuntu-SELinux policy
(in order to compile a policy.conf) . I have somehow not been able to
locate the source for the policy binary that ubuntu uses (I looked in the
/etc/selinux dir to no avail). Any ideas as to where I can find them?
Alternatively, is there a tool to reverse engineer policy.conf from the
policy binary (e.g. policy.24)?


Kind Regards,
Bhargava Shastry

--f46d0447954d2eb75904b257c4c5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">It doesn&#39;t make much sense to use the reference policy for An=
droid,<br>


because the Android userspace is completely different from a typical<br>
Linux distribution. =A0I created a policy from scratch for my work.<br>
<br>
You can generate a minimal policy from the kernel tree (see<br>
scripts/selinux/mdp). =A0However, that generated policy will only take you<=
br>
so far since it lacks any of the macro definitions/build infrastructure<br>
and since it places everything in a single type/domain. =A0So you can<br>
start there, but you&#39;ll likely want to split it out into multiple files=
,<br>
add some of the macros from refpolicy or the original example policy,<br>
and start defining individual domains and types.</blockquote><br>Thanks=20
for pointing out. I am getting myself acquainted with SELinux policy=20
semantics to be able to start from scratch. I have one question though=20
and the answer to this would make my task of creating an Android=20
specific policy much smoother. <br>
I had previously loaded an Ubuntu SELinux policy on Android and it=20
seemed to label all the filesystems correctly (except yaffs). I would=20
like to diff a very basic policy (i.e., mdp output) with the default=20
ubuntu policy so that I would get an idea of how filesystems are being=20
labeled and how transitions are handled among other things; basically to
 learn from a delta between the two files. To do this, I need sources=20
for Ubuntu-SELinux policy (in order to compile a policy.conf) . I have=20
somehow not been able to locate the source for the policy binary that=20
ubuntu uses (I looked in the /etc/selinux dir to no avail). Any ideas as
 to where I can find them? Alternatively, is there a tool to reverse=20
engineer policy.conf from the policy binary (e.g. policy.24)?<br></div><br>=
<br clear=3D"all">Kind Regards,<br>
Bhargava Shastry

--f46d0447954d2eb75904b257c4c5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
