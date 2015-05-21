MIME-Version: 1.0
In-Reply-To: <CABXk95CESxmfTbmpTyx0_jkj3TXs6EEYeZwo_Jpri0nAVtUCDg@mail.gmail.com>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555D3E20.7050907@quarksecurity.com>
 <CABXk95CESxmfTbmpTyx0_jkj3TXs6EEYeZwo_Jpri0nAVtUCDg@mail.gmail.com>
Date: Thu, 21 May 2015 07:44:07 -0700
Message-ID: <CAFftDdpuSc6qyAo8Zd8At+LodwUbNmdi2LGT7HurAfG68rEruQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: William Roberts <bill.c.roberts@gmail.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: multipart/alternative; boundary=047d7b86ead46881530516989377
Cc: linux-security-module@vger.kernel.org,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, James Morris <james.l.morris@oracle.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b86ead46881530516989377
Content-Type: text/plain; charset=UTF-8

On Wed, May 20, 2015 at 9:17 PM, Jeffrey Vander Stoep <jeffv@google.com>
wrote:

> Thanks for all the feedback and suggestions. Agreed that raw numerical
> values are confusing. I will fix up the commit message to set a better
> precedent for intended use. I included them more to illustrate what is
> happening under the hood. I like the idea of a qualifier for clarity.
> The qualifier seems necessary for the suggested non-ioctl-specific
> approach.
>
> Individual ioctl labels are only marginally better than raw numbers.
> E.g. { TCSETSF TIOCGWINSZ TCGETA TCSETA TCSETAW TCSETAF TCSBRK TCXONC
> TIOCMBIS }. More helpful...but not much.
>
> My plan was to group commonly used ioctl sets into macros.
>
> e.g. common_socket_ioc, priv_socket_ioc, tty_ioc, gpu_ioc, etc
>

This is exactly what I had in mind, just use m4


>
> After monitoring ioctl use across five different devices I think this
> is a good approach as just 10-20 macros would be adequate for a
> targeted policy and would provide a clearer explanation of the
> permissions given.
>



-- 
Respectfully,

William C Roberts

--047d7b86ead46881530516989377
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, May 20, 2015 at 9:17 PM, Jeffrey Vander Stoep <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:jeffv@google.com" target=3D"_blank">jeffv@google.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Thanks for all the=
 feedback and suggestions. Agreed that raw numerical<br>
values are confusing. I will fix up the commit message to set a better<br>
precedent for intended use. I included them more to illustrate what is<br>
happening under the hood. I like the idea of a qualifier for clarity.<br>
The qualifier seems necessary for the suggested non-ioctl-specific<br>
approach.<br>
<br>
Individual ioctl labels are only marginally better than raw numbers.<br>
E.g. { TCSETSF TIOCGWINSZ TCGETA TCSETA TCSETAW TCSETAF TCSBRK TCXONC<br>
TIOCMBIS }. More helpful...but not much.<br>
<br>
My plan was to group commonly used ioctl sets into macros.<br>
<br>
e.g. common_socket_ioc, priv_socket_ioc, tty_ioc, gpu_ioc, etc<br></blockqu=
ote><div><br></div><div>This is exactly what I had in mind, just use m4</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
After monitoring ioctl use across five different devices I think this<br>
is a good approach as just 10-20 macros would be adequate for a<br>
targeted policy and would provide a clearer explanation of the<br>
permissions given.<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><br></div>
</div></div>

--047d7b86ead46881530516989377--
