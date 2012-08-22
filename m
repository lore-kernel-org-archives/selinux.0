MIME-Version: 1.0
In-Reply-To: <CAFftDdrqw9soo1xA-ysZGRa9knc0RCQxdVTvPvtMovMXKPc0EA@mail.gmail.com>
References: <CAN93RkL87Hscd1pdG8SUKqpNjZiwZ6Xyih=g+8HhL-vtP549Hw@mail.gmail.com>
 <1345668870.7532.2.camel@moss-pluto.epoch.ncsc.mil> <CAN93Rk+5-kAjSE6rk0qy8Ez_23SQA76+b1+3t3CoXc3FG4a=TQ@mail.gmail.com>
 <CAFftDdqYRhn4n4r66Jhdazk77hNbY40-g0+0zgVKzS4k6mxsrQ@mail.gmail.com>
 <CAN93RkKE7Nuy3HLQZU6B7rX+omDG5L174qEKia-mA0sRKVuaYg@mail.gmail.com>
 <CAFftDdqR4-RukhCVxUCVv9hA3Hc-bnmJq4pyN7Rast7ttvdk=w@mail.gmail.com> <CAFftDdrqw9soo1xA-ysZGRa9knc0RCQxdVTvPvtMovMXKPc0EA@mail.gmail.com>
From: Cesar Maiorino <cesar.maiorino@gmail.com>
Date: Wed, 22 Aug 2012 18:51:48 -0400
Message-ID: <CAN93RkKztvm9tq-Bf=_SiuG1GpqLThLFA2Ly5qafRe=56aJ0Tw@mail.gmail.com>
Subject: Re: Problems getting source using repo sync
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=000e0cd401c0f17c4e04c7e298cf
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd401c0f17c4e04c7e298cf
Content-Type: text/plain; charset=ISO-8859-1

I started clean and  used this sequence of commands (as per
selinuxproject.org/page/SEAndroid)

git clone -b seandroid-4.0.4 https://bitbucket.org/seandroid/manifests.git
mkdir seandroid-4.0.4
cd seandroid-4.0.4
repo init -u https://android.googlesource.com/platform/manifest -b
android-4.0.4_r2.1
repo sync
cp ../manifests/local_manifest.xml .repo/
repo sync -j1


local_manifest.xml is configured for bitbucket.


On Wed, Aug 22, 2012 at 6:43 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> Either way rm -rf .repo and the directory contents of Android  and try the
> sync again.
>
> What is the remote configured for in local_manifest.xml? Is it selinux or
> bit bucket?
> On Aug 22, 2012 5:40 PM, "William Roberts" <bill.c.roberts@gmail.com>
> wrote:
>
>> Hmmm.... is this a new checkout or an update?
>> On Aug 22, 2012 5:38 PM, "Cesar Maiorino" <cesar.maiorino@gmail.com>
>> wrote:
>>
>>> > Make sure you have got version 1.7 or higher.
>>> Yup. 1.7.4.1
>>>
>>

--000e0cd401c0f17c4e04c7e298cf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I started clean and=A0 used this sequence of commands (as per <a href=3D"ht=
tp://selinuxproject.org/page/SEAndroid">selinuxproject.org/page/SEAndroid</=
a>)<br><br><pre>git clone -b seandroid-4.0.4 <a href=3D"https://bitbucket.o=
rg/seandroid/manifests.git">https://bitbucket.org/seandroid/manifests.git</=
a>
mkdir seandroid-4.0.4
cd seandroid-4.0.4
repo init -u <a href=3D"https://android.googlesource.com/platform/manifest"=
>https://android.googlesource.com/platform/manifest</a> -b android-4.0.4_r2=
.1
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

--000e0cd401c0f17c4e04c7e298cf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
