Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4PHZuSQ004895
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 13:35:57 -0400
Received: by mail-io0-f171.google.com with SMTP id p24so141115610ioi.0
 for <selinux@tycho.nsa.gov>; Thu, 25 May 2017 10:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20170524120854.GA1910@julius.enp8s0.d30>
 <1495656704.3489.4.camel@tycho.nsa.gov>
 <20170525054919.GB12190@julius.enp8s0.d30>
 <20170525091954.GD12190@julius.enp8s0.d30>
In-Reply-To: <20170525091954.GD12190@julius.enp8s0.d30>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Thu, 25 May 2017 17:35:37 +0000
Message-ID: <CABXk95DJqLLTXzGX-2CVXAhB4MNMPzxb4qUskuJ4vQ-yh86itQ@mail.gmail.com>
Subject: Re: ioctl help
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="94eb2c055866c7103205505ca662"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c055866c7103205505ca662
Content-Type: text/plain; charset="UTF-8"

The command number is just a uint16. It's up to each driver to interpret
it. So it's CHIOEXCHANGE for a particular driver and CM_IOCSPTS for a
different driver.

Ideally, you're whitelisting ioctls on a per-driver basis, so this model
works.

On Thu, May 25, 2017 at 2:21 AM Dominick Grift <dac.override@gmail.com>
wrote:

> On Thu, May 25, 2017 at 07:49:19AM +0200, Dominick Grift wrote:
> > On Wed, May 24, 2017 at 04:11:44PM -0400, Stephen Smalley wrote:
> > > On Wed, 2017-05-24 at 14:08 +0200, Dominick Grift wrote:
> > > > I was looking again at ioctl whitelisting, and excuse me if I
> > > > overlooked some documentation, but I am having a hard time
> > > > implementing this.
> > > > what I did was I just wanted to basically test blacklisting a single
> > > > ioctl (no particular one)
> > > >
> > > > So i looked into androids sepolicy and just picked a semi-random
> > > > ioctl from their "
> https://android.googlesource.com/platform/system/se
> > > > policy/+/master/public/ioctl_defines"
> > > >
> > > > for example: PHONE_CAPABILITIES_CHECK 0x40087182
> > > >
> > > > However the xpermissions statement only allows 0x0000 to 0xFFFF when
> > > > i tried: (xpermission alg_socket_ioctl (ioctl alg_socket (not
> > > > (0x40087182))))
> > > >
> > > > My question is how do i convert these to something i can use with the
> > > > xpermission statement in CIL, and why can seandroid sepolicy get away
> > > > with using 0x12345678 where i have to use 0x1234? I could not find
> > > > any scripts that converts these in the android tree.
> > >
> > > FWIW, I added a simple test of ioctl whitelisting to the selinux-
> > > testsuite, although that was done in source policy and depends on the
> > > binary module format support for xperms.
> > >
> > > With regard to your question though, only the low 16 bits of the ioctl
> > > value (the type/driver and number/function fields) are actually used;
> > > the upper 16 bits encode the direction (read/write) and size of any
> > > argument to the ioctl and are therefore not relevant for whitelisting.
> > > So you can just use 0x7182.  checkpolicy just ignores the upper bits,
> > > which I guess is convenient so that they can use ioctl macro lists
> > > generated from kernel header definitions, and Android builds by using
> > > checkpolicy -C to convert policy.conf to CIL.
> >
> > Thanks. I considered that but then I thought I saw various different
> ioctls with the same last 16 bits so that got me confused
>
> With the above in mind, how should i interpret the following
>
> define(`CHIOEXCHANGE', `0x401c6302')
> define(`CM_IOCSPTS', `0x40086302')
>
> is "0x6203" CHIOEXCHANGE, is it CM_IOCSPTS, or are the two the same with
> exception of direction and/or size
>
> >
> > --
> > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> > Dominick Grift
>
>
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
>

--94eb2c055866c7103205505ca662
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The command number is just a uint16. It&#39;s up to each d=
river to interpret it. So it&#39;s=C2=A0CHIOEXCHANGE for a particular drive=
r and=C2=A0CM_IOCSPTS for a different driver.<div><div><br></div><div>Ideal=
ly, you&#39;re whitelisting ioctls on a per-driver basis, so this model wor=
ks.</div></div><div><br></div><div class=3D"gmail_quote"><div dir=3D"ltr">O=
n Thu, May 25, 2017 at 2:21 AM Dominick Grift &lt;<a href=3D"mailto:dac.ove=
rride@gmail.com" target=3D"_blank">dac.override@gmail.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">On Thu, May 25, 2017 at 07:49:19AM +0=
200, Dominick Grift wrote:<br>
&gt; On Wed, May 24, 2017 at 04:11:44PM -0400, Stephen Smalley wrote:<br>
&gt; &gt; On Wed, 2017-05-24 at 14:08 +0200, Dominick Grift wrote:<br>
&gt; &gt; &gt; I was looking again at ioctl whitelisting, and excuse me if =
I<br>
&gt; &gt; &gt; overlooked some documentation, but I am having a hard time<b=
r>
&gt; &gt; &gt; implementing this.<br>
&gt; &gt; &gt; what I did was I just wanted to basically test blacklisting =
a single<br>
&gt; &gt; &gt; ioctl (no particular one)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; So i looked into androids sepolicy and just picked a semi-ra=
ndom<br>
&gt; &gt; &gt; ioctl from their &quot;<a href=3D"https://android.googlesour=
ce.com/platform/system/se" rel=3D"noreferrer" target=3D"_blank">https://and=
roid.googlesource.com/platform/system/se</a><br>
&gt; &gt; &gt; policy/+/master/public/ioctl_defines&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; for example: PHONE_CAPABILITIES_CHECK 0x40087182<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; However the xpermissions statement only allows 0x0000 to 0xF=
FFF when<br>
&gt; &gt; &gt; i tried: (xpermission alg_socket_ioctl (ioctl alg_socket (no=
t<br>
&gt; &gt; &gt; (0x40087182))))<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; My question is how do i convert these to something i can use=
 with the<br>
&gt; &gt; &gt; xpermission statement in CIL, and why can seandroid sepolicy=
 get away<br>
&gt; &gt; &gt; with using 0x12345678 where i have to use 0x1234? I could no=
t find<br>
&gt; &gt; &gt; any scripts that converts these in the android tree.<br>
&gt; &gt;<br>
&gt; &gt; FWIW, I added a simple test of ioctl whitelisting to the selinux-=
<br>
&gt; &gt; testsuite, although that was done in source policy and depends on=
 the<br>
&gt; &gt; binary module format support for xperms.<br>
&gt; &gt;<br>
&gt; &gt; With regard to your question though, only the low 16 bits of the =
ioctl<br>
&gt; &gt; value (the type/driver and number/function fields) are actually u=
sed;<br>
&gt; &gt; the upper 16 bits encode the direction (read/write) and size of a=
ny<br>
&gt; &gt; argument to the ioctl and are therefore not relevant for whitelis=
ting.<br>
&gt; &gt; So you can just use 0x7182.=C2=A0 checkpolicy just ignores the up=
per bits,<br>
&gt; &gt; which I guess is convenient so that they can use ioctl macro list=
s<br>
&gt; &gt; generated from kernel header definitions, and Android builds by u=
sing<br>
&gt; &gt; checkpolicy -C to convert policy.conf to CIL.<br>
&gt;<br>
&gt; Thanks. I considered that but then I thought I saw various different i=
octls with the same last 16 bits so that got me confused<br>
<br>
With the above in mind, how should i interpret the following<br>
<br>
define(`CHIOEXCHANGE&#39;, `0x401c6302&#39;)<br>
define(`CM_IOCSPTS&#39;, `0x40086302&#39;)<br>
<br>
is &quot;0x6203&quot; CHIOEXCHANGE, is it CM_IOCSPTS, or are the two the sa=
me with exception of direction and/or size<br>
<br>
&gt;<br>
&gt; --<br>
&gt; Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8=C2=A0 02D5 3B6C 5F1D 2C7B=
 6B02<br>
&gt; <a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=
=3D0x3B6C5F1D2C7B6B02" rel=3D"noreferrer" target=3D"_blank">https://sks-key=
servers.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C5F1D2C7B6B02</a><br>
&gt; Dominick Grift<br>
<br>
<br>
<br>
--<br>
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8=C2=A0 02D5 3B6C 5F1D 2C7B 6B02=
<br>
<a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B=
6C5F1D2C7B6B02" rel=3D"noreferrer" target=3D"_blank">https://sks-keyservers=
.net/pks/lookup?op=3Dget&amp;search=3D0x3B6C5F1D2C7B6B02</a><br>
Dominick Grift<br>
</blockquote></div></div>

--94eb2c055866c7103205505ca662--
