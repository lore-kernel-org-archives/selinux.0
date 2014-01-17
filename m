Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0H5wxWx026065
 for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2014 00:59:00 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so3242282qcy.39
 for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2014 21:58:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52D8316C.502@redhat.com>
References: <CAAGUhVrrHH=ZwWk8kzsap+9UbmXzmHspULx6E4byQocfTnjsAA@mail.gmail.com>
 <52D8316C.502@redhat.com>
Date: Fri, 17 Jan 2014 11:28:58 +0530
Message-ID: <CAAGUhVrE43FBUhGrA1UDF3HHKoDQ-W=6=EkJ9gUgC552WBsjvQ@mail.gmail.com>
Subject: Fwd: SELINUX language suggestion for future goals
From: Nainesh Patel <nainesh@ddu.ac.in>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e0149cf80ea462704f0243cf2
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e0149cf80ea462704f0243cf2
Content-Type: text/plain; charset=ISO-8859-1

---------- Forwarded message ----------
From: Daniel J Walsh <dwalsh@redhat.com>
Date: Fri, Jan 17, 2014 at 12:52 AM
Subject: Re: SELINUX language suggestion for future goals
To: Nainesh Patel <nainesh@ddu.ac.in>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/16/2014 01:52 AM, Nainesh Patel wrote:
> Respected Sir,
>
> Currently, CIL (commom intemediate language) is being developed by tresys
> for the purpose of simplification and addition of features that are not
> possible in current macrolanguage for policy generation.
>
> My question is that, can we add a feature in the CIL language that it
> allows generation of rules based on the IP address of source and/or
> destination ?
>
> for example:
>
> Node A : IP address 1.1.1.1
>
> Node B : IP address 2.2.2.2
>
> GOAL : policy on Node A can be made to reflect that, any request from Node
> B to httpd_t object on Node A can not be accessed.
>
> Which means that we can define the IP based rules for the other hostson
> network, this can create a new domain which can make operating system more
> secure.
>
> Waiting for your reply.
>
> Thanks
>
> -------- Nainesh Patel
I am no CIL expert, but you could do this type of thing now using labeled
secmark.  This type of question should go to the SELinux
<selinux@tycho.nsa.gov> mail list.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLYMWwACgkQrlYvE4MpobPuGACghuCXvySI0Pb5IkYI5FAz+ewd
HoUAoNWTL0FrIJ4cN0vVrMdX6gxyy6QZ
=He9R
-----END PGP SIGNATURE-----



-- 
Nainesh Patel
Department of Computer Engineering

--089e0149cf80ea462704f0243cf2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote">---------- Forwarded messag=
e ----------<br>From: <b class=3D"gmail_sendername">Daniel J Walsh</b> <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:dwalsh@redhat.com">dwalsh@redhat.com</a=
>&gt;</span><br>
Date: Fri, Jan 17, 2014 at 12:52 AM<br>Subject: Re: SELINUX language sugges=
tion for future goals<br>To: Nainesh Patel &lt;<a href=3D"mailto:nainesh@dd=
u.ac.in">nainesh@ddu.ac.in</a>&gt;<br><br><br>-----BEGIN PGP SIGNED MESSAGE=
-----<br>

Hash: SHA1<br>
<br>
On 01/16/2014 01:52 AM, Nainesh Patel wrote:<br>
&gt; Respected Sir,<br>
&gt;<br>
&gt; Currently, CIL (commom intemediate language) is being developed by tre=
sys<br>
&gt; for the purpose of simplification and addition of features that are no=
t<br>
&gt; possible in current macrolanguage for policy generation.<br>
&gt;<br>
&gt; My question is that, can we add a feature in the CIL language that it<=
br>
&gt; allows generation of rules based on the IP address of source and/or<br=
>
&gt; destination ?<br>
&gt;<br>
&gt; for example:<br>
&gt;<br>
&gt; Node A : IP address 1.1.1.1<br>
&gt;<br>
&gt; Node B : IP address 2.2.2.2<br>
&gt;<br>
&gt; GOAL : policy on Node A can be made to reflect that, any request from =
Node<br>
&gt; B to httpd_t object on Node A can not be accessed.<br>
&gt;<br>
&gt; Which means that we can define the IP based rules for the other hostso=
n<br>
&gt; network, this can create a new domain which can make operating system =
more<br>
&gt; secure.<br>
&gt;<br>
&gt; Waiting for your reply.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; -------- Nainesh Patel<br>
I am no CIL expert, but you could do this type of thing now using labeled<b=
r>
secmark. =A0This type of question should go to the SELinux<br>
&lt;<a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>&gt; =
mail list.<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1<br>
Comment: Using GnuPG with Thunderbird - <a href=3D"http://www.enigmail.net/=
" target=3D"_blank">http://www.enigmail.net/</a><br>
<br>
iEYEARECAAYFAlLYMWwACgkQrlYvE4MpobPuGACghuCXvySI0Pb5IkYI5FAz+ewd<br>
HoUAoNWTL0FrIJ4cN0vVrMdX6gxyy6QZ<br>
=3DHe9R<br>
-----END PGP SIGNATURE-----<br>
</div><br><br clear=3D"all"><br>-- <br><span style=3D"font-family:courier n=
ew,monospace"><font size=3D"1">Nainesh Patel<br>Department of Computer Engi=
neering<br><br></font></span><div style=3D"font-family:courier new,monospac=
e">
</div>
</div>

--089e0149cf80ea462704f0243cf2--
