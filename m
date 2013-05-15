MIME-Version: 1.0
In-Reply-To: <1547102.UbLjJyaKNC@sifl>
References: <CAHw9pMVv-Q7uZQvd2gJ_AD-FjRGegSWtZFwWH-U85u0vmF3YNw@mail.gmail.com>
	<1547102.UbLjJyaKNC@sifl>
Date: Wed, 15 May 2013 23:03:25 +0400
Message-ID: <CAHw9pMXP9FJvFNz7_wGz6mJa5PeYSSv4OfUKJMSBgcPO=1RZmg@mail.gmail.com>
Subject: Re: marking ipv6 loopback for cipsov?
From: vlad halilov <vlad.halilov@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e013a26d88eb38704dcc66766
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--089e013a26d88eb38704dcc66766
Content-Type: text/plain; charset=ISO-8859-1

So, i just remove ipv6 support from system and this programm using ipv4
loopback with normal label processing now :) Bug reported
https://bugzilla.redhat.com/show_bug.cgi?id=963427


On Wed, May 15, 2013 at 5:48 PM, Paul Moore <paul@paul-moore.com> wrote:

> On Wednesday, May 15, 2013 11:57:34 AM vlad halilov wrote:
> > Hello guyz. Is any way to mark traffic for ipv6 loopback interface as
> > 'cipso'?
>
> CIPSO is an IPv4-only protocol, CALIPSO/RFC5570 is a similar protocol for
> IPv6
> but unfortunately I have not yet finished its Linux/SELinux implementation.
>
> On RHEL6.4 if you want to use labeled networking for IPv6 addresses you can
> either use the NetLabel static/fallback labeling or labeled IPsec (yes, you
> can use IPsec over loopback with some tweaking, but it is not an ideal
> solution).
>
> > p.s.  btw, i tried to make something fool action, like 'netlabelctl map
> add
> > default address:::/128 protocol:cipsov4,32' and get kernel bug .. :)  is
> > these result need to be reported or no?
>
> Ouch, that's not good.  I'll take a look at that, but since this is on
> RHEL6.4
> I would highly recommend you file a bug with the Red Hat's Bugzilla.
>
>  * http://bugzilla.redhat.com
>
> --
> paul moore
> www.paul-moore.com
>
>

--089e013a26d88eb38704dcc66766
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So, i just remove ipv6 support from system and this progra=
mm using ipv4 loopback with normal label processing now :) Bug reported=A0<=
a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D963427">https://bug=
zilla.redhat.com/show_bug.cgi?id=3D963427</a></div>
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, May 1=
5, 2013 at 5:48 PM, Paul Moore <span dir=3D"ltr">&lt;<a href=3D"mailto:paul=
@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Wednesday, May 15, 2013 11:57:34 AM vlad halilov wrote=
:<br>
&gt; Hello guyz. Is any way to mark traffic for ipv6 loopback interface as<=
br>
&gt; &#39;cipso&#39;?<br>
<br>
</div>CIPSO is an IPv4-only protocol, CALIPSO/RFC5570 is a similar protocol=
 for IPv6<br>
but unfortunately I have not yet finished its Linux/SELinux implementation.=
<br>
<br>
On RHEL6.4 if you want to use labeled networking for IPv6 addresses you can=
<br>
either use the NetLabel static/fallback labeling or labeled IPsec (yes, you=
<br>
can use IPsec over loopback with some tweaking, but it is not an ideal<br>
solution).<br>
<div class=3D"im"><br>
&gt; p.s. =A0btw, i tried to make something fool action, like &#39;netlabel=
ctl map add<br>
&gt; default address:::/128 protocol:cipsov4,32&#39; and get kernel bug .. =
:) =A0is<br>
&gt; these result need to be reported or no?<br>
<br>
</div>Ouch, that&#39;s not good. =A0I&#39;ll take a look at that, but since=
 this is on RHEL6.4<br>
I would highly recommend you file a bug with the Red Hat&#39;s Bugzilla.<br=
>
<br>
=A0* <a href=3D"http://bugzilla.redhat.com" target=3D"_blank">http://bugzil=
la.redhat.com</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" target=3D"_blank">www.paul-moore.com<=
/a><br>
<br>
</font></span></blockquote></div><br></div>

--089e013a26d88eb38704dcc66766--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
