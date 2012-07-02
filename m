MIME-Version: 1.0
In-Reply-To: <1340980684.15948.7.camel@moss-pluto.epoch.ncsc.mil>
References: <201206211329.q5LDT6PW031262@tarius.tycho.ncsc.mil>
	<CAKi3Pur-Ne8vAfbw6t4hutrqJO73x=wOaHvTg8dca4W-LUOuLg@mail.gmail.com>
	<1340288275.4234.48.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3PuqSFBw8EHLCXuASBxoMEEX4wTuW0MZOdEURO5_GWTVcnA@mail.gmail.com>
	<CAKi3PurC2T92r2mhzPKj7WoYb0Rf5Foz3W332Nov=Q5HZ8Ac3g@mail.gmail.com>
	<CAKi3Puqf0u=H379cBk+uXtSNCbpQjtM-cDcyTifDGG8CdV93nA@mail.gmail.com>
	<1340980684.15948.7.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 2 Jul 2012 16:05:56 +0200
Message-ID: <CAKi3PupzMRZsYzPAj_U0ff_QyN1VJUkVB9mciL=D_K3Hinm5AQ@mail.gmail.com>
Subject: Re: Welcome to selinux
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8f646b35f592f404c3d94b76
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8f646b35f592f404c3d94b76
Content-Type: text/plain; charset=ISO-8859-1

Thank you very much to all of you!

On Fri, Jun 29, 2012 at 4:38 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2012-06-29 at 15:59 +0200, Alexandra Test wrote:
> > Hi,
> > sorry for all the mails!
> > I installed SeAndroid but I have some problems.
> > - the camera is not working (is it normal?)
>
> That's not SE Android related - it is a general AOSP issue; see
> discussions on android-building.  The extract-files.sh script from the
> per-device directory may help you.
>
>
I extracted old file from the phone before building and now it is working.


> > i would like to install other applications but I really didn't get how
> > to do that.
> > should I install the application and then define new policies?
>
> Yes, although you shouldn't need a new policy for each app; policy is
> written in terms of types (equivalence classes).
>

I tried to install application from the google play website directly from
the phone but it is not working.

So I installed directly from the apk... some of them are working, others
are not... but how to find legitimate apk?

> How to define the policies?

If using the middleware MAC support, you would amend the
> external/mac-policy/mac_permissions.xml configuration.


I am not using the MAC support.


>  For the SELinux
> policy, you would possibly amend external/sepolicy/seapp_contexts if you
> want to label the app differently and you might amend the rules in
> external/sepolicy/app.te.


How to get the formal meaning of the files? I tried to look for it...


>  > then I notice that I have some residual denials to address in my
> > policy.
> > I hope I will find a way and I am really sorry but I am a beginner!
>
> Best thing to do is to post the denials and let people help you
> understand what they mean and how to start addressing them.  Once you've
> done it for a few denials, you'll pick it up.
>

Yes, you are right, but I can't see any deny now... I only have to
understand how to go on...

>
>
--
> Stephen Smalley
> National Security Agency
>
> Thank you,
Alexandra

--e89a8f646b35f592f404c3d94b76
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you very much to all of you!<br><br><div class=3D"gmail_quote">On Fri=
, Jun 29, 2012 at 4:38 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D=
"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</spa=
n> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On Fri, 2012-06-29 at 15:59 +0200, Alex=
andra Test wrote:<br>
&gt; Hi,<br>
</div><div>&gt; sorry for all the mails!<br>
&gt; I installed SeAndroid but I have some problems.<br>
&gt; - the camera is not working (is it normal?)<br>
<br>
</div>That&#39;s not SE Android related - it is a general AOSP issue; see<b=
r>
discussions on android-building. =A0The extract-files.sh script from the<br=
>
per-device directory may help you.<br>
<div><br></div></blockquote><div><br>I extracted old file from the phone be=
fore building and now it is working.<br>=A0
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>
&gt; i would like to install other applications but I really didn&#39;t get=
 how<br>
&gt; to do that.<br>
&gt; should I install the application and then define new policies?<br>
<br>
</div>Yes, although you shouldn&#39;t need a new policy for each app; polic=
y is<br>
written in terms of types (equivalence classes).<br></blockquote><div><br>I=
 tried to install application from the google play website directly from th=
e phone but it is not working. <br><br>So I installed directly from the apk=
... some of them are working, others are not... but how to find legitimate =
apk?<br>

<br>
&gt; How to define the policies?<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">If using the middle=
ware MAC support, you would amend the<br>
external/mac-policy/mac_permissions.xml configuration.</blockquote><div><di=
v><br></div>I am not using the MAC support.<br>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">

 =A0For the SELinux<br>
policy, you would possibly amend external/sepolicy/seapp_contexts if you<br=
>
want to label the app differently and you might amend the rules in<br>
external/sepolicy/app.te.</blockquote><div><br>How to get the formal meanin=
g of the files? I tried to look for it...<br>=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">

<div>
&gt; then I notice that I have some residual denials to address in my<br>
&gt; policy.<br>
&gt; I hope I will find a way and I am really sorry but I am a beginner!<br=
> <br></div></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div>
</div>Best thing to do is to post the denials and let people help you<br>
understand what they mean and how to start addressing them. =A0Once you&#39=
;ve<br>
done it for a few denials, you&#39;ll pick it up.<div></div></blockquote><d=
iv><br>Yes, you are right, but I can&#39;t see any deny now... I only have =
to understand how to go on...=A0 <br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<div>=A0</div></blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div><div>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div>Thank you,<br>Alexandra<br>

--e89a8f646b35f592f404c3d94b76--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
