MIME-Version: 1.0
In-Reply-To: <1320930750.13691.5.camel@moss-pluto>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1320409924.1015.7.camel@moss-pluto>
	<CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
	<1320425998.1015.31.camel@moss-pluto>
	<CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
	<1320930750.13691.5.camel@moss-pluto>
Date: Thu, 10 Nov 2011 14:26:35 +0100
Message-ID: <CAGGozWQpW3Tvj00Rt44EEhk1qYn-w8BE07naY+MRQUbXurpYmQ@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
Content-Type: multipart/alternative; boundary=f46d04451829835d6e04b1615a79
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04451829835d6e04b1615a79
Content-Type: text/plain; charset=ISO-8859-1

>
> Linux 2.6.32 supported policy.24, unless you forced it to an older
> version via CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE (which
> you shouldn't set in your kernel config at all; it only exists to
> address a backward compatibility problem for Fedora Core 3/4).  Maybe we
> should get rid of that option altogether.
>
> I've been using policy.24 policies for Android on the emulator (2.6.29)
> and on the Nexus S phones (2.6.35).
>

The default value for CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
was 19 on my msm 2.6.32 kernel. I wonder why. Besides, like I mentioned
before, I tried to change it to 24 (on seeing the policy mismatch print)
but I can only set it to 23 (max value menuconfig allows me to enter).


>  > As regards Mr.Russell's comment, I'm afraid I won't be able to make
> > the binaries public at the moment. However, in order to get SELinux
> > enabled on the Android kernel one could simply do a menuconfig and
> > enable NSA SELinux support. Personally, I referred to this:
> >
> http://www.linuxtopia.org/online_books/linux_kernel/kernel_configuration/ch09s06.html. As for the Xattr patch for Android's yaffs FS, it is available publicly
> here: http://www.enck.org/tools/yaffs_xattr.patch
>
> You don't need an xattr patch anymore; upstream yaffs2 has xattr
> support.  You might need to back port newer upstream yaffs2 into your
> Android kernel if your Android kernel's yaffs2 lacks such support.  You
> also need a patch that I posted to the yaffs2 mailing list to ensure
> labeling of new files at creation time, as that isn't provided by
> default by the xattr support.
>

Thanks for the info. I shall apply the labeling patch as well.


>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Bhargava Shastry

--f46d04451829835d6e04b1615a79
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">Linux 2.6.32 supported policy.24, unless you forced it to an olde=
r<br>

version via CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE (which<br>
you shouldn&#39;t set in your kernel config at all; it only exists to<br>
address a backward compatibility problem for Fedora Core 3/4). =A0Maybe we<=
br>
should get rid of that option altogether.<br>
<br>
I&#39;ve been using policy.24 policies for Android on the emulator (2.6.29)=
<br>
and on the Nexus S phones (2.6.35).<br></blockquote><div><br>The default va=
lue for CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE was 19 on my msm=
 2.6.32 kernel. I wonder why. Besides, like I mentioned before, I tried to =
change it to 24 (on seeing the policy mismatch print) but I can only set it=
 to 23 (max value menuconfig allows me to enter).<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">
&gt; As regards Mr.Russell&#39;s comment, I&#39;m afraid I won&#39;t be abl=
e to make<br>
&gt; the binaries public at the moment. However, in order to get SELinux<br=
>
&gt; enabled on the Android kernel one could simply do a menuconfig and<br>
&gt; enable NSA SELinux support. Personally, I referred to this:<br>
&gt; <a href=3D"http://www.linuxtopia.org/online_books/linux_kernel/kernel_=
configuration/ch09s06.html" target=3D"_blank">http://www.linuxtopia.org/onl=
ine_books/linux_kernel/kernel_configuration/ch09s06.html</a> . As for the X=
attr patch for Android&#39;s yaffs FS, it is available publicly here: <a hr=
ef=3D"http://www.enck.org/tools/yaffs_xattr.patch" target=3D"_blank">http:/=
/www.enck.org/tools/yaffs_xattr.patch</a><br>

<br>
</div>You don&#39;t need an xattr patch anymore; upstream yaffs2 has xattr<=
br>
support. =A0You might need to back port newer upstream yaffs2 into your<br>
Android kernel if your Android kernel&#39;s yaffs2 lacks such support. =A0Y=
ou<br>
also need a patch that I posted to the yaffs2 mailing list to ensure<br>
labeling of new files at creation time, as that isn&#39;t provided by<br>
default by the xattr support.<br></blockquote><div><br>Thanks for the info.=
 I shall apply the labeling patch as well.<br>=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rg=
b(204, 204, 204); padding-left: 1ex;">

<div><div></div><div class=3D"h5"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Bhargava Sh=
astry<br>

--f46d04451829835d6e04b1615a79--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
