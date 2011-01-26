Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0QKZ9wT001779
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 15:35:09 -0500
Received: from mail-yx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0QKZ8hj015151
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 20:35:08 GMT
Received: by yxd39 with SMTP id 39so311815yxd.12
        for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 12:35:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D40812C.4060004@gmail.com>
References: <0B31D28E10F4FA489A0261135B94A14804A4489F@XMB-AMS-109.cisco.com>
	<4D40812C.4060004@gmail.com>
Date: Wed, 26 Jan 2011 12:35:07 -0800
Message-ID: <AANLkTimT45Ua4+Qui9TULCCdjYU6zag2UJy58XgmJuq2@mail.gmail.com>
Subject: Re: SeLinux Policy design question
From: Ethan Heidrick <ethanheidrick@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=000e0cd5d022c97c9d049ac5c4d4
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd5d022c97c9d049ac5c4d4
Content-Type: text/plain; charset=ISO-8859-1

hello Ger,

having a suite as you refer to as managing sys is a product inside the
array.
I may be misinformed but writing a policy that allows socketing for the
desired
services will allow for a better access measure for both the sys and the
user context

hope that helps,
en

On Wed, Jan 26, 2011 at 12:16 PM, Dominick Grift <domg472@gmail.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 01/26/2011 07:16 PM, Ger Lawlor (gelawlor) wrote:
> > Hi,
> >
> >
> >
> > I am pondering the best approach to design of appropriate filesystem
> > labeling that will reduce the long term complexity of managing contexts
> > and transitions in SeLinux.
> >
> > If I have a suite of services that interface within a single product and
> > those services have the potential to share access to similar sub
> > directory structures, but they
> >
> > currently only access files and execute within their own install
> > directories. It's obviously better to keep locked down any access
> > outside of each services domain.
> >
> > However, what if all services within a product were permitted open
> > access to all known directories within a product - apart from the
> > obvious i.e. these services could
> >
> > Interfere with each other, are there any reasons why this approach would
> > not be considered a suitable initial approach to seLinux development,
> > with continued
> >
> > Evolution, adding contexts for further refinement of control over time?
> > Are there best practice guides to filesystem labeling that considers the
> > complexity that can
> >
> > Come from excessive labeling?
>
> In my experience it is probably easier and safer to design policy as
> fine grained as you need to initially. Because it is in my experience
> easier to allow a restricted domain some extra permissions over time
> that it may need later than it is to restrict generic domain for a
> particular process.
>
> For example:
>
> Lets say you start as generic as possible and create a single domain
> where all the services in your suite runs in. That means that this
> single generic domain needs all permissions required to allow each
> service to function properly.
>
> Then later you decide to create a new domain for one of the services in
> your suite. That service requires a unique permission. That would then
> mean that your initial generic domain can drop that permission. Because
> the service that needs it now runs in its own domain with its own
> permission set.
>
> In theory if you know that the permission in question is unique then its
> easy to just remove that from the generic domain, however in practice it
> is not that easy to determine that it is unique and only required by a
> specific service.
>
> And so chances are that the initial generic domain becomes more
> permissive than it has to be.
>
> If this only applies to a single domain, then this is not such a big
> deal, because once you got to confining each other service in your suite
> over time, you could just revisit the initial more generic domain.
>
> But the more generic confined domains you have the harder it gets.
>
> It is in my view i guess a balance of priorities. I would probably keep
> my policy under development until i reached all my security goals, and
> then deploy it. But you may not have this luxury.
>
> You can choose you start with some generic domain to dump all your
> targeted processes in and refine policy later but basically you may end
> up with extra work, just to be able to basically deploy an unfinished
> policy.
>
> Besides in either case you run the risk of having to maintain policy
> over time any ways.
>
> But as for overall, keep it as generic as possible to reduce complexity,
> but not at the cost of not meeting your security goals.
> Because that's eventually what it is all about (meeting all your
> security goals.
>
> Disclaimer: I am not a professional security expert and so my
> suggestions may be fundamentally wrong. Use my advice at your own risk.
>
> >
> >
> > Thanks.
> >
> > Ger.
> >
> >
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.16 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk1AgSsACgkQMlxVo39jgT8sPgCfTurKF2uof7bYDPG01Mwb+54X
> nNsAoLFJNtd/+NYh0NwwL8krb6iDmAqs
> =IuF6
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--000e0cd5d022c97c9d049ac5c4d4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hello Ger,<br><br>having a suite as you refer to as managing sys is a produ=
ct inside the array.=A0 <br>I may be misinformed but writing a policy that =
allows socketing for the desired <br>services will allow for a better acces=
s measure for both the sys and the user context<br>
<br>hope that helps,<br>en<br><br><div class=3D"gmail_quote">On Wed, Jan 26=
, 2011 at 12:16 PM, Dominick Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:=
domg472@gmail.com">domg472@gmail.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px s=
olid rgb(204, 204, 204); padding-left: 1ex;">
-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<div><div></div><div class=3D"h5"><br>
On 01/26/2011 07:16 PM, Ger Lawlor (gelawlor) wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I am pondering the best approach to design of appropriate filesystem<b=
r>
&gt; labeling that will reduce the long term complexity of managing context=
s<br>
&gt; and transitions in SeLinux.<br>
&gt;<br>
&gt; If I have a suite of services that interface within a single product a=
nd<br>
&gt; those services have the potential to share access to similar sub<br>
&gt; directory structures, but they<br>
&gt;<br>
&gt; currently only access files and execute within their own install<br>
&gt; directories. It&#39;s obviously better to keep locked down any access<=
br>
&gt; outside of each services domain.<br>
&gt;<br>
&gt; However, what if all services within a product were permitted open<br>
&gt; access to all known directories within a product - apart from the<br>
&gt; obvious i.e. these services could<br>
&gt;<br>
&gt; Interfere with each other, are there any reasons why this approach wou=
ld<br>
&gt; not be considered a suitable initial approach to seLinux development,<=
br>
&gt; with continued<br>
&gt;<br>
&gt; Evolution, adding contexts for further refinement of control over time=
?<br>
&gt; Are there best practice guides to filesystem labeling that considers t=
he<br>
&gt; complexity that can<br>
&gt;<br>
&gt; Come from excessive labeling?<br>
<br>
</div></div>In my experience it is probably easier and safer to design poli=
cy as<br>
fine grained as you need to initially. Because it is in my experience<br>
easier to allow a restricted domain some extra permissions over time<br>
that it may need later than it is to restrict generic domain for a<br>
particular process.<br>
<br>
For example:<br>
<br>
Lets say you start as generic as possible and create a single domain<br>
where all the services in your suite runs in. That means that this<br>
single generic domain needs all permissions required to allow each<br>
service to function properly.<br>
<br>
Then later you decide to create a new domain for one of the services in<br>
your suite. That service requires a unique permission. That would then<br>
mean that your initial generic domain can drop that permission. Because<br>
the service that needs it now runs in its own domain with its own<br>
permission set.<br>
<br>
In theory if you know that the permission in question is unique then its<br=
>
easy to just remove that from the generic domain, however in practice it<br=
>
is not that easy to determine that it is unique and only required by a<br>
specific service.<br>
<br>
And so chances are that the initial generic domain becomes more<br>
permissive than it has to be.<br>
<br>
If this only applies to a single domain, then this is not such a big<br>
deal, because once you got to confining each other service in your suite<br=
>
over time, you could just revisit the initial more generic domain.<br>
<br>
But the more generic confined domains you have the harder it gets.<br>
<br>
It is in my view i guess a balance of priorities. I would probably keep<br>
my policy under development until i reached all my security goals, and<br>
then deploy it. But you may not have this luxury.<br>
<br>
You can choose you start with some generic domain to dump all your<br>
targeted processes in and refine policy later but basically you may end<br>
up with extra work, just to be able to basically deploy an unfinished<br>
policy.<br>
<br>
Besides in either case you run the risk of having to maintain policy<br>
over time any ways.<br>
<br>
But as for overall, keep it as generic as possible to reduce complexity,<br=
>
but not at the cost of not meeting your security goals.<br>
Because that&#39;s eventually what it is all about (meeting all your<br>
security goals.<br>
<br>
Disclaimer: I am not a professional security expert and so my<br>
suggestions may be fundamentally wrong. Use my advice at your own risk.<br>
<br>
&gt;<br>
&gt;<br>
&gt; Thanks.<br>
&gt;<br>
&gt; Ger.<br>
&gt;<br>
&gt;<br>
<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v2.0.16 (GNU/Linux)<br>
Comment: Using GnuPG with Fedora - <a href=3D"http://enigmail.mozdev.org/" =
target=3D"_blank">http://enigmail.mozdev.org/</a><br>
<br>
iEYEARECAAYFAk1AgSsACgkQMlxVo39jgT8sPgCfTurKF2uof7bYDPG01Mwb+54X<br>
nNsAoLFJNtd/+NYh0NwwL8krb6iDmAqs<br>
=3DIuF6<br>
-----END PGP SIGNATURE-----<br>
<font color=3D"#888888"><br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></blockquote></div><br>

--000e0cd5d022c97c9d049ac5c4d4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
