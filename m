MIME-Version: 1.0
In-Reply-To: <CAGGozWRK117G=93o1=v0yM6HxdtbDRSZ8sKybDEYNEKjpyHMNA@mail.gmail.com>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1320409924.1015.7.camel@moss-pluto>
	<CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
	<1320425998.1015.31.camel@moss-pluto>
	<CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
	<1320930750.13691.5.camel@moss-pluto>
	<CAGGozWQpW3Tvj00Rt44EEhk1qYn-w8BE07naY+MRQUbXurpYmQ@mail.gmail.com>
	<1320942368.13691.7.camel@moss-pluto>
	<CAGGozWRK117G=93o1=v0yM6HxdtbDRSZ8sKybDEYNEKjpyHMNA@mail.gmail.com>
Date: Wed, 16 Nov 2011 19:15:13 +0100
Message-ID: <CAGGozWR8pNNC6P1T8cYtbkfqZu56iVty+JdmXwudo3ZaAVbN-g@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
Content-Type: multipart/alternative; boundary=f46d04447311d11f7104b1de15b8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04447311d11f7104b1de15b8
Content-Type: text/plain; charset=ISO-8859-1

Hi again,

I am trying to set/get file SELinux contexts using the set/getfilecon
programs. I added debug prints in the kernel to track code flow. I notice
that although setfilecon succeeds on a given file, a subsequent call to
getfilecon on the same file returns the string "kernel" irrespective of the
context that was set using setfilecon. On any other file whose context is
not set yet, getfilecon properly returns the string "unlabeled"

I suspect the inode struct in the kernel is not being updated properly
after a setxattr call. Has anyone else faced a similar problem? I am
working on Android's Nexus one phone.

Thanks,
Bhargava

On Fri, Nov 11, 2011 at 12:33 PM, Bhargava Shastry <bshas3@gmail.com> wrote:

> Don't set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX, and then you
>> don't need to set a value at all.  The only purpose of the option is to
>> force the kernel to report an older version than it truly supports, and
>> that was only to deal with a compatibility issue in Fedora 2/3.
>
>
> This somehow slipped my mind. Thanks, problem solved.
>
> Regards,
> Bhargava Shastry
>



-- 
Bhargava Shastry

--f46d04447311d11f7104b1de15b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi again,<br><br>I am trying to set/get file SELinux contexts using the set=
/getfilecon programs. I added debug prints in the kernel to track code flow=
. I notice that although setfilecon succeeds on a given file, a subsequent =
call to getfilecon on the same file returns the string &quot;kernel&quot; i=
rrespective of the context that was set using setfilecon. On any other file=
 whose context is not set yet, getfilecon properly returns the string &quot=
;unlabeled&quot;<br>
<br>I suspect the inode struct in the kernel is not being updated properly =
after a setxattr call. Has anyone else faced a similar problem? I am workin=
g on Android&#39;s Nexus one phone.<br><br>Thanks,<br>Bhargava<br><br><div =
class=3D"gmail_quote">
On Fri, Nov 11, 2011 at 12:33 PM, Bhargava Shastry <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:bshas3@gmail.com">bshas3@gmail.com</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bord=
er-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"gmail_quote"><div class=3D"im"><blockquote class=3D"gmail_quo=
te" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204=
, 204); padding-left: 1ex;">Don&#39;t set CONFIG_SECURITY_SELINUX_POLICYDB_=
VERSION_MAX, and then you<br>





don&#39;t need to set a value at all. =A0The only purpose of the option is =
to<br>
force the kernel to report an older version than it truly supports, and<br>
that was only to deal with a compatibility issue in Fedora 2/3.</blockquote=
></div><div><br>This somehow slipped my mind. Thanks, problem solved.<br></=
div></div><br>Regards,<br><font color=3D"#888888">Bhargava Shastry<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Bhargava Shastry=
<br>

--f46d04447311d11f7104b1de15b8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
