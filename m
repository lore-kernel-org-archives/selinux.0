MIME-Version: 1.0
In-Reply-To: <1526618308.525900.1445351998505.JavaMail.yahoo@mail.yahoo.com>
References: <CAFftDdratpqGkyLp0m48YWo1iOw58sECd+NhQe1o4TqZQOSwcw@mail.gmail.com>
 <1526618308.525900.1445351998505.JavaMail.yahoo@mail.yahoo.com>
Date: Tue, 20 Oct 2015 07:49:22 -0700
Message-ID: <CAFftDdpub5p8h5S4cbi=sgWk8GB3DM48X33WYX6B054eQcKgDw@mail.gmail.com>
Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
From: William Roberts <bill.c.roberts@gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1140ffba1adbf705228a5efe
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140ffba1adbf705228a5efe
Content-Type: text/plain; charset=UTF-8

FYI you can take just 1 C and H file from crypt lib. You don't need it all.
On Oct 20, 2015 8:42 AM, "Richard Haines" <richard_c_haines@btinternet.com>
wrote:

>
> On Tuesday, 20 October 2015, 15:00, William Roberts <
> bill.c.roberts@gmail.com> wrote:
>
> >
> >
> >
> >On Oct 20, 2015 7:46 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> >>
> >> On 10/20/2015 08:27 AM, Richard Haines wrote:
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>> On Monday, 19 October 2015, 19:10, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> >>>>>
> >>>>> On 10/18/2015 11:00 AM, Richard Haines wrote:
> >>>>>
> >>>>>
> >>>>>>   On Sunday, 18 October 2015, 15:07, Dominick Grift
> >>>>
> >>>> <dac.override@gmail.com> wrote:
> >>>>>
> >>>>>
> >>>>>>>   -----BEGIN PGP SIGNED MESSAGE-----
> >>>>>>
> >>>>>>   Hash: SHA512
> >>>>>>
> >>>>>>   On Sun, Oct 18, 2015 at 12:48:12PM +0000, Richard Haines wrote:
> >>>>>>>
> >>>>>>>     I added openssl to libselinux to support the new
> >>>>
> >>>> selabel_digest(3)
> >>>>>>>
> >>>>>>>     function.
> >>>>>>>
> >>>>>>>     I'm not aware of any issues between openssl and gnutls,
> >>>>
> >>>> however as
> >>>>>>>
> >>>>>>>
> >>>>>>>     selabel_digest was only added last week I guess not much
> testing.
> >>>>>>>     Well apart from myself as I'm currently adding the
> >>>>
> >>>> selinux_restorecon
> >>>>>>>
> >>>>>>>     feature that makes use of it.
> >>>>>>>
> >>>>>>
> >>>>>>   Thanks for clarifying, I am not hitting any issues with it just
> >>>>>>   wondering if instead of openssl, gnutls could be used for this
> and if
> >>>>>
> >>>>>
> >>>>>>   so, if this should be somehow supported or not.
> >>>>>
> >>>>>
> >>>>>   I tried using gnutls after I read your initial email, however I
> >>>>>   could not find a way to generate the same digest as openssl
> >>>>>   (I changed the SHA1 function to gnutls_hmac_fast(3) with various
> >>>>>   algorithms and used the selabel_digest util to compare digests).
> >>>>>   It could be that I should use some other function but I could
> >>>>>
> >>>>>   not find any useful info on this (including web searches).
> >>>>>   If anyone knows how to resolve this please let me know.
> >>>>>
> >>>>>   I guess what is supported (openssl or gnutls) would be down to
> >>>>>   the maintainers.
> >>>>
> >>>>
> >>>> Wondering if dependency on openssl might be a license issue for Debian
> >>>> or others.  Apparently openssl license is considered GPL-incompatible
> >>>> [1] [2], and obviously libselinux is linked by a variety of
> GPL-licensed
> >>>> programs.  Fedora seems to view this as falling under the system
> library
> >>>> exception [3] but not clear that other distributions would view it
> that
> >>>> way.  On the other hand, using gnutls would be subject to the reverse
> >>>> problem; it would make libselinux depend on a LGPL library, and that
> >>>> could create issues for non-GPL programs that statically link
> >>>> libselinux.  We might need to revert this change and revisit how to
> >>>
> >>>
> >>>> solve this in a manner that avoids such issues.
> >>>
> >>>
> >>>
> >>> Would building with the Android mincrypt SHA functions help regarding
> the
> >>> licensing issues ??? I've attached a quick patch that seems to work
> okay
> >>> using Android system/core/libmincrypt/sha.c
> >>
> >>
> >> That looks BSD-licensed and thus broadly compatible.  We would need to
> amend libselinux/LICENSE to add that license information and we would need
> to hide those functions from being exposed outside of the library.  Other
> alternative would be to look for a public domain SHA implementation and use
> that.
>
> >>
>
> I've found a simple implementation at
> www.ghostscript.com/doc/jbig2dec/sha1.c
>
> I'll try that first and if fails CryptLib will be next.
>
>
>
>
> >>
> >Will CryptLib work:
>
> >http://unlicense.org/
>
>
> >
> >
> >>
> >> _______________________________________________
> >> Selinux mailing list
> >> Selinux@tycho.nsa.gov
> >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov
> >.
> >
> >
> >
>

--001a1140ffba1adbf705228a5efe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">FYI you can take just 1 C and H file from crypt lib. You don=
&#39;t need it all. </p>
<div class=3D"gmail_quote">On Oct 20, 2015 8:42 AM, &quot;Richard Haines&qu=
ot; &lt;<a href=3D"mailto:richard_c_haines@btinternet.com">richard_c_haines=
@btinternet.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><br>
On Tuesday, 20 October 2015, 15:00, William Roberts &lt;<a href=3D"mailto:b=
ill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; wrote:<br>
<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;On Oct 20, 2015 7:46 AM, &quot;Stephen Smalley&quot; &lt;<a href=3D"mai=
lto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 10/20/2015 08:27 AM, Richard Haines wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Monday, 19 October 2015, 19:10, Stephen Smalley &lt;<a =
href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On 10/18/2015 11:00 AM, Richard Haines wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0On Sunday, 18 October 2015, 15:07, Dom=
inick Grift<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:dac.override@gmail.com">dac.override=
@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0-----BEGIN PGP SIGNED MESSAGE-----=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0Hash: SHA512<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0On Sun, Oct 18, 2015 at 12:48:12PM +00=
00, Richard Haines wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0I added openssl to libselin=
ux to support the new<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; selabel_digest(3)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0function.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0I&#39;m not aware of any is=
sues between openssl and gnutls,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; however as<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0selabel_digest was only add=
ed last week I guess not much testing.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Well apart from myself as I=
&#39;m currently adding the<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; selinux_restorecon<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0feature that makes use of i=
t.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0Thanks for clarifying, I am not hittin=
g any issues with it just<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0wondering if instead of openssl, gnutl=
s could be used for this and if<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0so, if this should be somehow supporte=
d or not.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0I tried using gnutls after I read your ini=
tial email, however I<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0could not find a way to generate the same =
digest as openssl<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0(I changed the SHA1 function to gnutls_hma=
c_fast(3) with various<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0algorithms and used the selabel_digest uti=
l to compare digests).<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0It could be that I should use some other f=
unction but I could<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0not find any useful info on this (includin=
g web searches).<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0If anyone knows how to resolve this please=
 let me know.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0I guess what is supported (openssl or gnut=
ls) would be down to<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0the maintainers.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Wondering if dependency on openssl might be a license issu=
e for Debian<br>
&gt;&gt;&gt;&gt; or others.=C2=A0 Apparently openssl license is considered =
GPL-incompatible<br>
&gt;&gt;&gt;&gt; [1] [2], and obviously libselinux is linked by a variety o=
f GPL-licensed<br>
&gt;&gt;&gt;&gt; programs.=C2=A0 Fedora seems to view this as falling under=
 the system library<br>
&gt;&gt;&gt;&gt; exception [3] but not clear that other distributions would=
 view it that<br>
&gt;&gt;&gt;&gt; way.=C2=A0 On the other hand, using gnutls would be subjec=
t to the reverse<br>
&gt;&gt;&gt;&gt; problem; it would make libselinux depend on a LGPL library=
, and that<br>
&gt;&gt;&gt;&gt; could create issues for non-GPL programs that statically l=
ink<br>
&gt;&gt;&gt;&gt; libselinux.=C2=A0 We might need to revert this change and =
revisit how to<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; solve this in a manner that avoids such issues.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Would building with the Android mincrypt SHA functions help re=
garding the<br>
&gt;&gt;&gt; licensing issues ??? I&#39;ve attached a quick patch that seem=
s to work okay<br>
&gt;&gt;&gt; using Android system/core/libmincrypt/sha.c<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; That looks BSD-licensed and thus broadly compatible.=C2=A0 We woul=
d need to amend libselinux/LICENSE to add that license information and we w=
ould need to hide those functions from being exposed outside of the library=
.=C2=A0 Other alternative would be to look for a public domain SHA implemen=
tation and use that.<br>
<br>
&gt;&gt;<br>
<br>
I&#39;ve found a simple implementation at<br>
<a href=3D"http://www.ghostscript.com/doc/jbig2dec/sha1.c" rel=3D"noreferre=
r" target=3D"_blank">www.ghostscript.com/doc/jbig2dec/sha1.c</a><br>
<br>
I&#39;ll try that first and if fails CryptLib will be next.<br>
<br>
<br>
<br>
<br>
&gt;&gt;<br>
&gt;Will CryptLib work:<br>
<br>
&gt;<a href=3D"http://unlicense.org/" rel=3D"noreferrer" target=3D"_blank">=
http://unlicense.org/</a><br>
<br>
<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Selinux mailing list<br>
&gt;&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>=
<br>
&gt;&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tych=
o.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt;&gt; To get help, send an email containing &quot;help&quot; to <a href=
=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>=
<br>
&gt;.<br>
&gt;<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--001a1140ffba1adbf705228a5efe--
