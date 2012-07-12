MIME-Version: 1.0
In-Reply-To: <1342046389-9271-1-git-send-email-hqjiang1988@gmail.com>
References: <1342046389-9271-1-git-send-email-hqjiang1988@gmail.com>
Date: Thu, 12 Jul 2012 06:13:39 -0400
Message-ID: <CADQgGG00fEqFSKqKH_umO51YjPjB3qB0B=SY1azD3bYn+y70-w@mail.gmail.com>
Subject: Re: Patches to target denies of GpsLocationProvider and media_app
 over mtp_device
From: Robert Craig <robertpcraig@gmail.com>
To: hqjiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=00504502d3ada984e004c49f378b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504502d3ada984e004c49f378b
Content-Type: text/plain; charset=ISO-8859-1

What branch are you on? I have a build of master that
has android.process.media labeled as

u:r:media_app:s0:c10

which would suggest to me that the seinfo string is media. If
your android.process.media is
not being labeled as media that what is its label. There was a brief period
on the master
branch that the mac_permissions.xml file was wrong because of some updates
on
Jelly Bean permissions needed by some of the apps. Specifically the
MediaProvider.
Are you seeing any "MMAC_DENIAL" messages in logcat for any media apps
during
install?

I would try to re-sync on master and see what happens.




On Wed, Jul 11, 2012 at 6:39 PM, hqjiang <hqjiang1988@gmail.com> wrote:

> One thing should be paid attentions here:
> We add a new entry of "user=app_* name=android.process.media
> domain=media_app levelFromUid=true" to seapp_context file.
> One would say it's nonecessary because there's already one policy
> "user=app_* seinfo=media domain=media_app levelFromUid=true".
> But the thing is that the seinfo of "android.process.media" is not media.
>
> If you have better ideas, pleae let us know. And we can resubmit the
> refined patches later.
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--00504502d3ada984e004c49f378b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>What branch are you on? I have a build of master that has=A0android.pr=
ocess.media labeled as</div><div><br></div><div>u:r:media_app:s0:c10</div><=
div><br></div><div>which would suggest to me that the seinfo string is medi=
a. If your=A0android.process.media is</div>
<div>not being labeled as media that what is its label. There was a brief p=
eriod on the master</div><div>branch that the mac_permissions.xml file was =
wrong because of some updates on</div><div>Jelly Bean permissions needed by=
 some of the apps. Specifically the MediaProvider.</div>
<div>Are you seeing any &quot;MMAC_DENIAL&quot; messages in logcat for any =
media apps during</div><div>install?</div><div><br></div><div>I would try t=
o re-sync on master and see what happens.</div><div><br></div><div><br>
</div><br><br><div class=3D"gmail_quote">On Wed, Jul 11, 2012 at 6:39 PM, h=
qjiang <span dir=3D"ltr">&lt;<a href=3D"mailto:hqjiang1988@gmail.com" targe=
t=3D"_blank">hqjiang1988@gmail.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
One thing should be paid attentions here:<br>
We add a new entry of &quot;user=3Dapp_* name=3Dandroid.process.media domai=
n=3Dmedia_app levelFromUid=3Dtrue&quot; to seapp_context file.<br>
One would say it&#39;s nonecessary because there&#39;s already one policy &=
quot;user=3Dapp_* seinfo=3Dmedia domain=3Dmedia_app levelFromUid=3Dtrue&quo=
t;.<br>
But the thing is that the seinfo of &quot;android.process.media&quot; is no=
t media.<br>
<br>
If you have better ideas, pleae let us know. And we can resubmit the refine=
d patches later.<br>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</blockquote></div><br>

--00504502d3ada984e004c49f378b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
