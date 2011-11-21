MIME-Version: 1.0
In-Reply-To: <1321537184.4836.9.camel@moss-pluto>
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
Date: Mon, 21 Nov 2011 16:45:23 +0100
Message-ID: <CAGGozWT9PP-p4-UA6WJtiZmwHE1ot_Of85pKQRLGeab37e4kaQ@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>
Content-Type: multipart/alternative; boundary=14dae9399d7730dde304b2409321
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--14dae9399d7730dde304b2409321
Content-Type: text/plain; charset=ISO-8859-1

Hello,

On loading an SELinux policy, I see that SELinux recognises the YAFFS
blocks on Android as FS where labeling is not supported. Here is a sample
dmesg print:
"SELinux: initialized (dev mtdblock3, type yaffs2), not configured for
labeling"

On looking into the SELinux code, I see that such a print is spat out on a
check for a file-system superblock security attribute called "behavior".
Could I possibly correct this by changing something in the YAFFS
file-system code. I tried mounting the yaffs partition by appening the
context= option in Android's init.rc but the mount fails.
I should add that I am able to execute getfilecon on YAFFS (extended
attributes have been ported to YAFFS) successfully but setfilecon fails
possibly due to the above debug print. And as previously mentioned, I
attempt set/getfilecon only after a load_policy. Also, all other
filesystems (rootfs, procfs, tmpfs etc. are correctly initialised on policy
load)

Thanks,
Bhargava

On Thu, Nov 17, 2011 at 2:39 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2011-11-17 at 11:15 +0100, Bhargava Shastry wrote:
> >         Sounds to me like you never loaded a policy.  I'd bet you are
> >         getting
> >         inside the if (!ss_initialized) section of
> >         security_sid_to_context_core.  You have to load a policy
> >         before you
> >         can properly set and retrieve labels.
> >
> > Thanks, loading policy fixed the problem although I wonder why one
> > shouldn't be able to set xattr in the absence of a policy.
>
> Because SELinux has no way to interpret the xattr value if there is no
> policy loaded.
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Bhargava Shastry

--14dae9399d7730dde304b2409321
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>On loading an SELinux policy, I see that SELinux recognises t=
he YAFFS blocks on Android as FS where labeling is not supported. Here is a=
 sample dmesg print:<br>&quot;SELinux: initialized (dev mtdblock3, type yaf=
fs2), not configured for labeling&quot;<br>
<br>On looking into the SELinux code, I see that such a print is spat out o=
n a check for a file-system superblock security attribute called &quot;beha=
vior&quot;. Could I possibly correct this by changing something in the YAFF=
S file-system code. I tried mounting the yaffs partition by appening the co=
ntext=3D option in Android&#39;s init.rc but the mount fails.<br>
I should add that I am able to execute getfilecon on YAFFS (extended attrib=
utes have been ported to YAFFS) successfully but setfilecon fails possibly =
due to the above debug print. And as previously mentioned, I attempt set/ge=
tfilecon only after a load_policy. Also, all other filesystems (rootfs, pro=
cfs, tmpfs etc. are correctly initialised on policy load)<br>
<br>Thanks,<br>Bhargava<br><br><div class=3D"gmail_quote">On Thu, Nov 17, 2=
011 at 2:39 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds=
@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px soli=
d rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Thu, 2011-11-17 at 11:15 +0100, Bhargava Shastry wrote=
:<br>
&gt; =A0 =A0 =A0 =A0 Sounds to me like you never loaded a policy. =A0I&#39;=
d bet you are<br>
&gt; =A0 =A0 =A0 =A0 getting<br>
&gt; =A0 =A0 =A0 =A0 inside the if (!ss_initialized) section of<br>
&gt; =A0 =A0 =A0 =A0 security_sid_to_context_core. =A0You have to load a po=
licy<br>
&gt; =A0 =A0 =A0 =A0 before you<br>
&gt; =A0 =A0 =A0 =A0 can properly set and retrieve labels.<br>
&gt;<br>
&gt; Thanks, loading policy fixed the problem although I wonder why one<br>
&gt; shouldn&#39;t be able to set xattr in the absence of a policy.<br>
<br>
</div>Because SELinux has no way to interpret the xattr value if there is n=
o<br>
policy loaded.<br>
<div><div></div><div class=3D"h5"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Bhargava Sh=
astry<br>

--14dae9399d7730dde304b2409321--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
