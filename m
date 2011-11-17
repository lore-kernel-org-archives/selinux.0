MIME-Version: 1.0
In-Reply-To: <CACLa4puuN_nt+Hw3LU3UjYAJ9gGua=bEzt-ioXGv3=W41=1bBg@mail.gmail.com>
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
Date: Thu, 17 Nov 2011 11:15:08 +0100
Message-ID: <CAGGozWRxOzUiG33OvmEqX+Y4ywcGTfwx_8bVKuwQ31M_bdtN6Q@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Eric Paris <eparis@parisplace.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>
Content-Type: multipart/alternative; boundary=14dae93b576ec2363304b1eb7ec9
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--14dae93b576ec2363304b1eb7ec9
Content-Type: text/plain; charset=ISO-8859-1

>
> Sounds to me like you never loaded a policy.  I'd bet you are getting
> inside the if (!ss_initialized) section of
> security_sid_to_context_core.  You have to load a policy before you
> can properly set and retrieve labels.
>

Thanks, loading policy fixed the problem although I wonder why one
shouldn't be able to set xattr in the absence of a policy.


>
> On Wed, Nov 16, 2011 at 1:15 PM, Bhargava Shastry <bshas3@gmail.com>
> wrote:
> > Hi again,
> >
> > I am trying to set/get file SELinux contexts using the set/getfilecon
> > programs. I added debug prints in the kernel to track code flow. I notice
> > that although setfilecon succeeds on a given file, a subsequent call to
> > getfilecon on the same file returns the string "kernel" irrespective of
> the
> > context that was set using setfilecon. On any other file whose context is
> > not set yet, getfilecon properly returns the string "unlabeled"
> >
> > I suspect the inode struct in the kernel is not being updated properly
> after
> > a setxattr call. Has anyone else faced a similar problem? I am working on
> > Android's Nexus one phone.
> >
> > Thanks,
> > Bhargava
> >
> > On Fri, Nov 11, 2011 at 12:33 PM, Bhargava Shastry <bshas3@gmail.com>
> wrote:
> >>>
> >>> Don't set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX, and then you
> >>> don't need to set a value at all.  The only purpose of the option is to
> >>> force the kernel to report an older version than it truly supports, and
> >>> that was only to deal with a compatibility issue in Fedora 2/3.
> >>
> >> This somehow slipped my mind. Thanks, problem solved.
> >>
> >> Regards,
> >> Bhargava Shastry
> >
> >
> >
> > --
> > Bhargava Shastry
> >
>



-- 
Bhargava Shastry

--14dae93b576ec2363304b1eb7ec9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">Sounds to me like you never loaded a policy. =A0I&#39;d bet you a=
re getting<br>

inside the if (!ss_initialized) section of<br>
security_sid_to_context_core. =A0You have to load a policy before you<br>
can properly set and retrieve labels.<font color=3D"#888888"><br></font></b=
lockquote><div><br>Thanks, loading policy fixed the problem although I wond=
er why one shouldn&#39;t be able to set xattr in the absence of a policy. <=
br>
</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt =
0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex=
;"><font color=3D"#888888">
</font><div><div></div><div class=3D"h5"><br>
On Wed, Nov 16, 2011 at 1:15 PM, Bhargava Shastry &lt;<a href=3D"mailto:bsh=
as3@gmail.com">bshas3@gmail.com</a>&gt; wrote:<br>
&gt; Hi again,<br>
&gt;<br>
&gt; I am trying to set/get file SELinux contexts using the set/getfilecon<=
br>
&gt; programs. I added debug prints in the kernel to track code flow. I not=
ice<br>
&gt; that although setfilecon succeeds on a given file, a subsequent call t=
o<br>
&gt; getfilecon on the same file returns the string &quot;kernel&quot; irre=
spective of the<br>
&gt; context that was set using setfilecon. On any other file whose context=
 is<br>
&gt; not set yet, getfilecon properly returns the string &quot;unlabeled&qu=
ot;<br>
&gt;<br>
&gt; I suspect the inode struct in the kernel is not being updated properly=
 after<br>
&gt; a setxattr call. Has anyone else faced a similar problem? I am working=
 on<br>
&gt; Android&#39;s Nexus one phone.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Bhargava<br>
&gt;<br>
&gt; On Fri, Nov 11, 2011 at 12:33 PM, Bhargava Shastry &lt;<a href=3D"mail=
to:bshas3@gmail.com">bshas3@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Don&#39;t set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX, an=
d then you<br>
&gt;&gt;&gt; don&#39;t need to set a value at all. =A0The only purpose of t=
he option is to<br>
&gt;&gt;&gt; force the kernel to report an older version than it truly supp=
orts, and<br>
&gt;&gt;&gt; that was only to deal with a compatibility issue in Fedora 2/3=
.<br>
&gt;&gt;<br>
&gt;&gt; This somehow slipped my mind. Thanks, problem solved.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Bhargava Shastry<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Bhargava Shastry<br>
&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Bhargava Sh=
astry<br>

--14dae93b576ec2363304b1eb7ec9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
