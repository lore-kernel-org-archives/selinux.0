Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8CF2EKA002777
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2012 11:02:14 -0400
Received: by wibhq4 with SMTP id hq4so4375823wib.12
        for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2012 08:02:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdqD-VRvrFjbvg=jxsFyo8Ucp50bOwS1Cs+0GLAe9vNMFg@mail.gmail.com>
References: <CAN93RkJ63JnR-ajfVtKx772+NsFT=-P2_L7Cv3cr4rEAJxMYDg@mail.gmail.com>
 <CAN93Rk+Q1QSftoKtV=kiJ7gUqq8V-C6uJJmibeUQhjR5-AgiAw@mail.gmail.com> <CAFftDdqD-VRvrFjbvg=jxsFyo8Ucp50bOwS1Cs+0GLAe9vNMFg@mail.gmail.com>
From: Cesar Maiorino <cesar.maiorino@gmail.com>
Date: Wed, 12 Sep 2012 11:01:31 -0400
Message-ID: <CAN93RkJ24TMdj7J-yWRE14HhPaGdAYoOMcvLyyA_r0D_eGXzzA@mail.gmail.com>
Subject: Re: Problem with SEManager app on Seandroid 4.0.4
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00504502d531b5575a04c98279c7
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504502d531b5575a04c98279c7
Content-Type: text/plain; charset=ISO-8859-1

I did have these in my init.rc, but my build was not copying init.rc to  to
the out directory.
I copied it over manually and rebuilt the boot.img and it now I can change
the values.
So that is progress.
Now, however, when I toggle on SELinux, my device locks up. On reboot it is
stuck at the
lock screen.
Thanks for the help.

On Tue, Sep 11, 2012 at 4:37 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> My guess is you need to change the permissions of /selinux/*
> (/selinux/booleans for the booleans) to system system.
>
> the init.rc needs to have chown system system for all of the booleans,
> setenforce etc
>
>     chown system system /selinux/enforce
>     chown -R system system /selinux/booleans
>     chown system system /selinux/commit_pending_bools
>
> You'll need to patch in the recursive support or enumerate all the
> bools. The patch for recursive support can be found:
> https://android-review.googlesource.com/#/c/32220/
>
> Hope this helps.
>
>
> On Tue, Sep 11, 2012 at 1:23 PM, Cesar Maiorino
> <cesar.maiorino@gmail.com> wrote:
> > I finally got a version of seandroid (4.0.4) running on my Qualcomm
> MSM8960
> > Mobile Development Platform. This required some manual intervention as
> the
> > patch files did not all apply cleanly, so it's possible that I've messed
> > something up in the process.
> >
> > That being said, the SEManager app does not let me change any settings
> aside
> > from toggling "MAC Mode" on and off. So I can't change '"SELinux Mode"
> > (stuck in permissive), and I can't change any of the Booleans.
> >
> > AVC and MAC logging seem to be working.
> >
> > Any ideas?
> >
>
>
>
> --
> Respectfully,
>
> William C Roberts
>

--00504502d531b5575a04c98279c7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I did have these in my init.rc, but my build was not copying init.rc to=A0 =
to the out directory. <br>I copied it over manually and rebuilt the boot.im=
g and it now I can change the values.<br>So that is progress.<br>Now, howev=
er, when I toggle on SELinux, my device locks up. On reboot it is stuck at =
the<br>

lock screen. <br>Thanks for the help.<br><br><div class=3D"gmail_quote">On =
Tue, Sep 11, 2012 at 4:37 PM, William Roberts <span dir=3D"ltr">&lt;<a href=
=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail=
.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">My guess is you need to change the permissio=
ns of /selinux/*<br>
(/selinux/booleans for the booleans) to system system.<br>
<br>
the init.rc needs to have chown system system for all of the booleans,<br>
setenforce etc<br>
<br>
=A0 =A0 chown system system /selinux/enforce<br>
=A0 =A0 chown -R system system /selinux/booleans<br>
=A0 =A0 chown system system /selinux/commit_pending_bools<br>
<br>
You&#39;ll need to patch in the recursive support or enumerate all the<br>
bools. The patch for recursive support can be found:<br>
<a href=3D"https://android-review.googlesource.com/#/c/32220/" target=3D"_b=
lank">https://android-review.googlesource.com/#/c/32220/</a><br>
<br>
Hope this helps.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On Tue, Sep 11, 2012 at 1:23 PM, Cesar Maiorino<br>
&lt;<a href=3D"mailto:cesar.maiorino@gmail.com">cesar.maiorino@gmail.com</a=
>&gt; wrote:<br>
&gt; I finally got a version of seandroid (4.0.4) running on my Qualcomm MS=
M8960<br>
&gt; Mobile Development Platform. This required some manual intervention as=
 the<br>
&gt; patch files did not all apply cleanly, so it&#39;s possible that I&#39=
;ve messed<br>
&gt; something up in the process.<br>
&gt;<br>
&gt; That being said, the SEManager app does not let me change any settings=
 aside<br>
&gt; from toggling &quot;MAC Mode&quot; on and off. So I can&#39;t change &=
#39;&quot;SELinux Mode&quot;<br>
&gt; (stuck in permissive), and I can&#39;t change any of the Booleans.<br>
&gt;<br>
&gt; AVC and MAC logging seem to be working.<br>
&gt;<br>
&gt; Any ideas?<br>
&gt;<br>
<br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Respectfully,<br>
<br>
William C Roberts<br>
</font></span></blockquote></div><br>

--00504502d531b5575a04c98279c7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
