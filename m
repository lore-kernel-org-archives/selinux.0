MIME-Version: 1.0
In-Reply-To: <1321890697.9385.20.camel@moss-pluto>
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
Date: Mon, 21 Nov 2011 19:18:54 +0100
Message-ID: <CAGGozWQXo5bXgVKa0t3pO+45Vj70LJA12dF2ovX6Hm9KnYNNQQ@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>
Content-Type: multipart/alternative; boundary=f46d044480d72df4b304b242b8ee
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d044480d72df4b304b242b8ee
Content-Type: text/plain; charset=ISO-8859-1

>
> You need to add a fs_use_xattr statement to your policy configuration
> for yaffs2.  Similar to the existing statements for ext[234].
>

Thanks. I have the sources for a reference SELinux policy from the tresys
website. Unfortunately, with default policy build options, the resulting
monolithic policy is huge. I am using an Ubuntu machine; any hints as to
where to start for a minimal policy for Android. I tried selectively
building only basic modules but there are intricate dependencies
(checkpolicy throws up unresolved symbols error) between modules that is
hard to disentangle.

Regards,
Bhargava Shastry

--f46d044480d72df4b304b242b8ee
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">You need to add a fs_use_xattr statement to your policy configura=
tion<br>

for yaffs2. =A0Similar to the existing statements for ext[234].<br></blockq=
uote><div><br>Thanks. I have the sources for a reference SELinux policy fro=
m the tresys website. Unfortunately, with default policy build options, the=
 resulting monolithic policy is huge. I am using an Ubuntu machine; any hin=
ts as to where to start for a minimal policy for Android. I tried selective=
ly building only basic modules but there are intricate dependencies (checkp=
olicy throws up unresolved symbols error) between modules that is hard to d=
isentangle. <br>
</div></div><br>Regards,<br>Bhargava Shastry<br>

--f46d044480d72df4b304b242b8ee--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
