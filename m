MIME-Version: 1.0
In-Reply-To: <CAN93RkKztvm9tq-Bf=_SiuG1GpqLThLFA2Ly5qafRe=56aJ0Tw@mail.gmail.com>
References: <CAN93RkL87Hscd1pdG8SUKqpNjZiwZ6Xyih=g+8HhL-vtP549Hw@mail.gmail.com>
	<1345668870.7532.2.camel@moss-pluto.epoch.ncsc.mil>
	<CAN93Rk+5-kAjSE6rk0qy8Ez_23SQA76+b1+3t3CoXc3FG4a=TQ@mail.gmail.com>
	<CAFftDdqYRhn4n4r66Jhdazk77hNbY40-g0+0zgVKzS4k6mxsrQ@mail.gmail.com>
	<CAN93RkKE7Nuy3HLQZU6B7rX+omDG5L174qEKia-mA0sRKVuaYg@mail.gmail.com>
	<CAFftDdqR4-RukhCVxUCVv9hA3Hc-bnmJq4pyN7Rast7ttvdk=w@mail.gmail.com>
	<CAFftDdrqw9soo1xA-ysZGRa9knc0RCQxdVTvPvtMovMXKPc0EA@mail.gmail.com>
	<CAN93RkKztvm9tq-Bf=_SiuG1GpqLThLFA2Ly5qafRe=56aJ0Tw@mail.gmail.com>
Date: Wed, 22 Aug 2012 15:56:34 -0700
Message-ID: <CAFftDdr-Fgim0Zeqv12sHkhcS9DKvfsiUPAXFndSw2wnWinW+A@mail.gmail.com>
Subject: Re: Problems getting source using repo sync
From: William Roberts <bill.c.roberts@gmail.com>
To: Cesar Maiorino <cesar.maiorino@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf307c9fd88dd1c804c7e2a729
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf307c9fd88dd1c804c7e2a729
Content-Type: text/plain; charset=ISO-8859-1

That's strange. Right now my only suggestion is to start over...or keep
trying. Last time I encountered this issue a few attempts at repo sync
finally finished successfully. You may also want to go to the .repo dir
that has the repo command python scripts and try a different version of
repo. See the git tags there.
On Aug 22, 2012 5:52 PM, "Cesar Maiorino" <cesar.maiorino@gmail.com> wrote:

> I started clean and  used this sequence of commands (as per
> selinuxproject.org/page/SEAndroid)
>
> git clone -b seandroid-4.0.4 https://bitbucket.org/seandroid/manifests.git
> mkdir seandroid-4.0.4
> cd seandroid-4.0.4
> repo init -u https://android.googlesource.com/platform/manifest -b android-4.0.4_r2.1
> repo sync
> cp ../manifests/local_manifest.xml .repo/
> repo sync -j1
>
>
> local_manifest.xml is configured for bitbucket.
>
>
> On Wed, Aug 22, 2012 at 6:43 PM, William Roberts <bill.c.roberts@gmail.com
> > wrote:
>
>> Either way rm -rf .repo and the directory contents of Android  and try
>> the sync again.
>>
>> What is the remote configured for in local_manifest.xml? Is it selinux or
>> bit bucket?
>> On Aug 22, 2012 5:40 PM, "William Roberts" <bill.c.roberts@gmail.com>
>> wrote:
>>
>>> Hmmm.... is this a new checkout or an update?
>>> On Aug 22, 2012 5:38 PM, "Cesar Maiorino" <cesar.maiorino@gmail.com>
>>> wrote:
>>>
>>>> > Make sure you have got version 1.7 or higher.
>>>> Yup. 1.7.4.1
>>>>
>>>
>

--20cf307c9fd88dd1c804c7e2a729
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>That&#39;s strange. Right now my only suggestion is to start over...or k=
eep trying. Last time I encountered this issue a few attempts at repo sync =
finally finished successfully. You may also want to go to the .repo dir tha=
t has the repo command python scripts and try a different version of repo. =
See the git tags there.</p>

<div class=3D"gmail_quote">On Aug 22, 2012 5:52 PM, &quot;Cesar Maiorino&qu=
ot; &lt;<a href=3D"mailto:cesar.maiorino@gmail.com">cesar.maiorino@gmail.co=
m</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
I started clean and=A0 used this sequence of commands (as per <a href=3D"ht=
tp://selinuxproject.org/page/SEAndroid" target=3D"_blank">selinuxproject.or=
g/page/SEAndroid</a>)<br><br><pre>git clone -b seandroid-4.0.4 <a href=3D"h=
ttps://bitbucket.org/seandroid/manifests.git" target=3D"_blank">https://bit=
bucket.org/seandroid/manifests.git</a>
mkdir seandroid-4.0.4
cd seandroid-4.0.4
repo init -u <a href=3D"https://android.googlesource.com/platform/manifest"=
 target=3D"_blank">https://android.googlesource.com/platform/manifest</a> -=
b android-4.0.4_r2.1
repo sync
cp ../manifests/local_manifest.xml .repo/
repo sync -j1</pre><br>local_manifest.xml is configured for bitbucket.<br><=
br><br><div class=3D"gmail_quote">On Wed, Aug 22, 2012 at 6:43 PM, William =
Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" t=
arget=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br>



<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><p>Either way rm -rf .repo and the directory=
 contents of Android=A0 and try the sync again.</p>
<p>What is the remote configured for in local_manifest.xml? Is it selinux o=
r bit bucket?</p><div><div>
<div class=3D"gmail_quote">On Aug 22, 2012 5:40 PM, &quot;William Roberts&q=
uot; &lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill=
.c.roberts@gmail.com</a>&gt; wrote:<br type=3D"attribution"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">




<p>Hmmm.... is this a new checkout or an update?</p>
<div class=3D"gmail_quote">On Aug 22, 2012 5:38 PM, &quot;Cesar Maiorino&qu=
ot; &lt;<a href=3D"mailto:cesar.maiorino@gmail.com" target=3D"_blank">cesar=
.maiorino@gmail.com</a>&gt; wrote:<br type=3D"attribution"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">





&gt; Make sure you have got version 1.7 or higher.<div class=3D"gmail_quote=
"><div>Yup. 1.7.4.1 <br></div></div>
</blockquote></div>
</blockquote></div>
</div></div></blockquote></div><br>
</blockquote></div>

--20cf307c9fd88dd1c804c7e2a729--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
