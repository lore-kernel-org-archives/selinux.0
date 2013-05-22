MIME-Version: 1.0
In-Reply-To: <1900232.vJ9DK3UHW4@sifl>
References: <CAHw9pMUEcHa_HExVs+yyJOVk8oVEkQ84o4aywemZ+ZvMYT0=LA@mail.gmail.com>
	<2466345.2mjuuyBiSJ@sifl>
	<CAHw9pMXbShFc9SPf-gD9baPn3Bq98_jfMyVS3B1WijcOyF5nyg@mail.gmail.com>
	<1900232.vJ9DK3UHW4@sifl>
Date: Wed, 22 May 2013 23:12:48 +0400
Message-ID: <CAHw9pMUgGr2zSNGJHkN5WW+ML_A4vsRJ5Uj1bAVxHFbcmL2GZg@mail.gmail.com>
Subject: Re: network, deep drive
From: vlad halilov <vlad.halilov@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=90e6ba61453afadea404dd5359d4
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--90e6ba61453afadea404dd5359d4
Content-Type: text/plain; charset=ISO-8859-1

Ouch, i forgot to configure interface with 'semanage interface -a -t
netif_t -r s1 eth0'. So, with that, i got expected result. Now, in audit a
deny 'egress' avc appeared, and s4->s1 information flow stopped. Now
everything is right, thanks a lot :)



> The problem is that a user_t:s1 process/socket can not receive
> netlabel_peer_t:s4 network traffic; since the problem is a constraint
> violation we know it is not a type enforcement problem, e.g. user_t not
> being
> able to receive netlabel_peer_t traffic, but rather a MLS problem, e.g. s1
> not
> being able to receive s4 traffic.
>

--90e6ba61453afadea404dd5359d4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Ouch, i forgot to configure interface with &#39;semanage interface -a -t =
netif_t -r s1 eth0&#39;. So, with that, i got expected result. Now, in audi=
t a deny &#39;egress&#39; avc appeared, and s4-&gt;s1 information flow stop=
ped. Now everything is right, thanks a lot :)</span><br>

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div><br>
</div>The problem is that a user_t:s1 process/socket can not receive<br>
netlabel_peer_t:s4 network traffic; since the problem is a constraint<br>
violation we know it is not a type enforcement problem, e.g. user_t not bei=
ng<br>
able to receive netlabel_peer_t traffic, but rather a MLS problem, e.g. s1 =
not<br>
being able to receive s4 traffic.<br></blockquote></div></div></div>

--90e6ba61453afadea404dd5359d4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
