MIME-Version: 1.0
In-Reply-To: <1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
References: <CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	<1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
	<1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 20 Sep 2012 15:57:52 +0200
Message-ID: <CAKi3PuokYYQxCwf+SGga7UuguXBR14ZSneFMOfFQ-g0qX5btMA@mail.gmail.com>
Subject: Re: seandroid 4.1.1
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001636c5b33c665c4b04ca2282a8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636c5b33c665c4b04ca2282a8
Content-Type: text/plain; charset=ISO-8859-1

I don't have any denials.
If I change in enforcing mode with the wifi still connected, the wifi
works.
But if, in the enforcing mode, I disconnect it and try to reconnect it, it
doesn't : he says "obtaining IP address", "connecting", "saved" at the end
without being connected...



On Thu, Sep 20, 2012 at 2:55 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-09-20 at 12:19 +0200, Alexandra Test wrote:
> > I am sorry... it is working when the device is in permissive mode.
> > I really cannot understand the way to define the policies.
> > For the wifi, for example, what do I suppose to do?
> >
> > Thanks for your help
>
> Follow the instructions on the wiki,
> http://selinuxproject.org/page/SEAndroid#Getting_Started_with_SE_Android
>
> In particular, capture the dmesg output to see the avc denials, and then
> address those denials in your policy.  If you need help, post the avc
> denials to the list and we can help you decipher them.
>
> Boot it permissive, use the wifi, and then run adb shell su 0 dmesg |
> grep avc, and post the result.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--001636c5b33c665c4b04ca2282a8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I don&#39;t have any denials.<div>If I change in enforcing mode with the wi=
fi still connected, the wifi works.=A0</div><div>But if, in the enforcing m=
ode, I disconnect it and try to reconnect it, it doesn&#39;t : he says &quo=
t;obtaining IP address&quot;, &quot;connecting&quot;, &quot;saved&quot; at =
the end without being connected...=A0</div>
<div><br></div><div><br><br><div class=3D"gmail_quote">On Thu, Sep 20, 2012=
 at 2:55 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@ty=
cho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<div class=3D"im">On Thu, 2012-09-20 at 12:19 +0200, Alexandra Test wrote:<=
br>
&gt; I am sorry... it is working when the device is in permissive mode.<br>
&gt; I really cannot understand the way to define the policies.<br>
&gt; For the wifi, for example, what do I suppose to do?<br>
&gt;<br>
&gt; Thanks for your help<br>
<br>
</div>Follow the instructions on the wiki,<br>
<a href=3D"http://selinuxproject.org/page/SEAndroid#Getting_Started_with_SE=
_Android" target=3D"_blank">http://selinuxproject.org/page/SEAndroid#Gettin=
g_Started_with_SE_Android</a><br>
<br>
In particular, capture the dmesg output to see the avc denials, and then<br=
>
address those denials in your policy. =A0If you need help, post the avc<br>
denials to the list and we can help you decipher them.<br>
<br>
Boot it permissive, use the wifi, and then run adb shell su 0 dmesg |<br>
grep avc, and post the result.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br></div>

--001636c5b33c665c4b04ca2282a8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
