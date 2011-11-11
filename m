MIME-Version: 1.0
In-Reply-To: <1320942368.13691.7.camel@moss-pluto>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1320409924.1015.7.camel@moss-pluto>
	<CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
	<1320425998.1015.31.camel@moss-pluto>
	<CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
	<1320930750.13691.5.camel@moss-pluto>
	<CAGGozWQpW3Tvj00Rt44EEhk1qYn-w8BE07naY+MRQUbXurpYmQ@mail.gmail.com>
	<1320942368.13691.7.camel@moss-pluto>
Date: Fri, 11 Nov 2011 12:33:00 +0100
Message-ID: <CAGGozWRK117G=93o1=v0yM6HxdtbDRSZ8sKybDEYNEKjpyHMNA@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
Content-Type: multipart/alternative; boundary=f46d04451829269ff604b173e297
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04451829269ff604b173e297
Content-Type: text/plain; charset=ISO-8859-1

>
> Don't set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX, and then you
> don't need to set a value at all.  The only purpose of the option is to
> force the kernel to report an older version than it truly supports, and
> that was only to deal with a compatibility issue in Fedora 2/3.


This somehow slipped my mind. Thanks, problem solved.

Regards,
Bhargava Shastry

--f46d04451829269ff604b173e297
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">Don&#39;t set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX, and t=
hen you<br>




don&#39;t need to set a value at all. =A0The only purpose of the option is =
to<br>
force the kernel to report an older version than it truly supports, and<br>
that was only to deal with a compatibility issue in Fedora 2/3.</blockquote=
><div><br>This somehow slipped my mind. Thanks, problem solved.<br></div></=
div><br>Regards,<br>Bhargava Shastry<br>

--f46d04451829269ff604b173e297--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
