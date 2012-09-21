MIME-Version: 1.0
In-Reply-To: <1348152509.13835.23.camel@moss-pluto.epoch.ncsc.mil>
References: <CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	<1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
	<1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3PuokYYQxCwf+SGga7UuguXBR14ZSneFMOfFQ-g0qX5btMA@mail.gmail.com>
	<1348149606.13835.21.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3Puo9rREhxm_CTEYaRJtZJKf2XdK=EO0-jjDE+cQ12g-Zrg@mail.gmail.com>
	<1348152509.13835.23.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 21 Sep 2012 10:05:13 +0200
Message-ID: <CAKi3Puq_+QXKKR+YoNJ1M0niBtdOGJY5JuRV9nP0cnjsAB3qEw@mail.gmail.com>
Subject: Re: seandroid 4.1.1
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d043c7f381904b004ca31b3bc
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d043c7f381904b004ca31b3bc
Content-Type: text/plain; charset=ISO-8859-1

The output of
adb shell
su
dmesg

is

"klogctl: Operation not permitted"


On Thu, Sep 20, 2012 at 4:48 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-09-20 at 16:10 +0200, Alexandra Test wrote:
> > effectively I have a problem with dmesg
> > is it possible I don't have the package installed?
> > this is the output....
> > adb shell su 0 dmsg
> > Usage: su [options] [LOGIN]
> >
> > Options:
> >   -c, --command COMMAND         pass COMMAND to the invoked shell
> >   -h, --help                    display this help message and exit
> >   -, -l, --login                make the shell a login shell
> >   -s, --shell SHELL             use SHELL instead of the default in
> > passwd
> >   -v, --version                 display version number and exit
> >   -V                            display version code and exit. this is
> >                                 used almost exclusively by
> > Superuser.apk
> > root@alexandra:~/new/external/sepolicy# adb shell su 0 dmesg
>
> You aren't using the AOSP-provided su command there - that is
> Superuser.apk from CM.  Anyway, you should be able to do this:
> adb shell
> su
> dmesg
>
>
> --
> Stephen Smalley
> National Security Agency
>
>

--f46d043c7f381904b004ca31b3bc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The output of <br>adb shell<br>
su<br>
dmesg<br><br>is <br><br>&quot;klogctl: Operation not permitted&quot;<br><br=
><br><div class=3D"gmail_quote">On Thu, Sep 20, 2012 at 4:48 PM, Stephen Sm=
alley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"=
_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Thu, 2012-09-20 at 16:1=
0 +0200, Alexandra Test wrote:<br>
&gt; effectively I have a problem with dmesg<br>
&gt; is it possible I don&#39;t have the package installed?<br>
&gt; this is the output....<br>
&gt; adb shell su 0 dmsg<br>
&gt; Usage: su [options] [LOGIN]<br>
&gt;<br>
&gt; Options:<br>
&gt; =A0 -c, --command COMMAND =A0 =A0 =A0 =A0 pass COMMAND to the invoked =
shell<br>
&gt; =A0 -h, --help =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0display this hel=
p message and exit<br>
&gt; =A0 -, -l, --login =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0make the shell a log=
in shell<br>
&gt; =A0 -s, --shell SHELL =A0 =A0 =A0 =A0 =A0 =A0 use SHELL instead of the=
 default in<br>
&gt; passwd<br>
&gt; =A0 -v, --version =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 display version numb=
er and exit<br>
&gt; =A0 -V =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0display =
version code and exit. this is<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 used a=
lmost exclusively by<br>
&gt; Superuser.apk<br>
&gt; root@alexandra:~/new/external/sepolicy# adb shell su 0 dmesg<br>
<br>
</div>You aren&#39;t using the AOSP-provided su command there - that is<br>
Superuser.apk from CM. =A0Anyway, you should be able to do this:<br>
adb shell<br>
su<br>
dmesg<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>

--f46d043c7f381904b004ca31b3bc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
