MIME-Version: 1.0
In-Reply-To: <1320425998.1015.31.camel@moss-pluto>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1320409924.1015.7.camel@moss-pluto>
	<CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
	<1320425998.1015.31.camel@moss-pluto>
Date: Thu, 10 Nov 2011 11:33:23 +0100
Message-ID: <CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d044480d71b6b2604b15eef7c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d044480d71b6b2604b15eef7c
Content-Type: text/plain; charset=ISO-8859-1

Hello,

After some tweaks to load_policy, I was able to compile it against
Android's bionic C lib. However, I have a problem with loading a sample
policy compiled on my desktop Ubuntu PC (policydb version 24) on the
Android phone. Specifically, dmesg on the phone's kernel throws up the
following error:
SELinux:  policydb version 24 does not match my version range 15-19

I see two quick solutions: (1) Re-compile Android kernel with policydb
version setting changed to 24. Unfortunately, the max version number
currently supported in Android's 2.6.32 msm kernel is 23. (2) Downgrade to
policy version 19 on the PC. Any thoughts on alternate solutions.

As regards Mr.Russell's comment, I'm afraid I won't be able to make the
binaries public at the moment. However, in order to get SELinux enabled on
the Android kernel one could simply do a menuconfig and enable NSA SELinux
support. Personally, I referred to this:
http://www.linuxtopia.org/online_books/linux_kernel/kernel_configuration/ch09s06.html.
As for the Xattr patch for Android's yaffs FS, it is available
publicly
here: http://www.enck.org/tools/yaffs_xattr.patch

Regards,
Bhargava

On Fri, Nov 4, 2011 at 5:59 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2011-11-04 at 17:25 +0100, Bhargava Shastry wrote:
> > Dear Mr. Smalley,
> >
> > Thanks for your inputs. I did go through the slides of your recent
> > presentation on a case for SELinux enhanced Android phone. You have
> > done a great job re-engineering Android to retrofit SELinux.
> >
> > I was wondering how much effort it is to actually port a subset of
> > SELinux's userspace (e.g., loadpolicy, chcon and a few others) tools
> > to Android? Does it entail major changes to Android's existing
> > toolchain including modifications to its bionic libc?  Also, I was
> > wondering if you also undertook a port of coreutils as well (to enable
> > the -Z option for utils like ps and ls)?
>
> I did need to make some changes to bionic, e.g. adding the xattr system
> calls to SYSCALLS.TXT and re-generating the syscall wrapper functions
> via gensyscalls.py, adding support for the AT_SECURE auxv flag.  Then I
> could port a subset of libselinux. To support the SELinux commands and
> -Z option, I modified the Android toolbox with support for ps -Z and ls
> -Z and added new commands to it for various SELinux tools.  To date, I
> have added chcon, [gs]etenforce, [gs]etsebool, load_policy, restorecon,
> and runcon.
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Bhargava Shastry

--f46d044480d71b6b2604b15eef7c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>After some tweaks to load_policy, I was able to compile it ag=
ainst Android&#39;s bionic C lib. However, I have a problem with loading a =
sample policy compiled on my desktop Ubuntu PC (policydb version 24) on the=
 Android phone. Specifically, dmesg on the phone&#39;s kernel throws up the=
 following error:<br>
SELinux:=A0 policydb version 24 does not match my version range 15-19<br><b=
r>I see two quick solutions: (1) Re-compile Android kernel with policydb ve=
rsion setting changed to 24. Unfortunately, the max version number currentl=
y supported in Android&#39;s 2.6.32 msm kernel is 23. (2) Downgrade to poli=
cy version 19 on the PC. Any thoughts on alternate solutions.<br>
<br>As regards Mr.Russell&#39;s comment, I&#39;m afraid I won&#39;t be able=
 to make the binaries public at the moment. However, in order to get SELinu=
x enabled on the Android kernel one could simply do a menuconfig and enable=
 NSA SELinux support. Personally, I referred to this: <a href=3D"http://www=
.linuxtopia.org/online_books/linux_kernel/kernel_configuration/ch09s06.html=
">http://www.linuxtopia.org/online_books/linux_kernel/kernel_configuration/=
ch09s06.html</a> . As for the Xattr patch for Android&#39;s yaffs FS, it is=
 available publicly here: <a href=3D"http://www.enck.org/tools/yaffs_xattr.=
patch">http://www.enck.org/tools/yaffs_xattr.patch</a><br>
<br>Regards,<br>Bhargava<br><br><div class=3D"gmail_quote">On Fri, Nov 4, 2=
011 at 5:59 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds=
@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px soli=
d rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Fri, 2011-11-04 at 17:25 +0100, Bhargava Shastry wrote=
:<br>
&gt; Dear Mr. Smalley,<br>
&gt;<br>
&gt; Thanks for your inputs. I did go through the slides of your recent<br>
&gt; presentation on a case for SELinux enhanced Android phone. You have<br=
>
&gt; done a great job re-engineering Android to retrofit SELinux.<br>
&gt;<br>
&gt; I was wondering how much effort it is to actually port a subset of<br>
&gt; SELinux&#39;s userspace (e.g., loadpolicy, chcon and a few others) too=
ls<br>
&gt; to Android? Does it entail major changes to Android&#39;s existing<br>
&gt; toolchain including modifications to its bionic libc? =A0Also, I was<b=
r>
&gt; wondering if you also undertook a port of coreutils as well (to enable=
<br>
&gt; the -Z option for utils like ps and ls)?<br>
<br>
</div>I did need to make some changes to bionic, e.g. adding the xattr syst=
em<br>
calls to SYSCALLS.TXT and re-generating the syscall wrapper functions<br>
via gensyscalls.py, adding support for the AT_SECURE auxv flag. =A0Then I<b=
r>
could port a subset of libselinux. To support the SELinux commands and<br>
-Z option, I modified the Android toolbox with support for ps -Z and ls<br>
-Z and added new commands to it for various SELinux tools. =A0To date, I<br=
>
have added chcon, [gs]etenforce, [gs]etsebool, load_policy, restorecon,<br>
and runcon.<br>
<div><div></div><div class=3D"h5"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Bhargava Sh=
astry<br>

--f46d044480d71b6b2604b15eef7c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
