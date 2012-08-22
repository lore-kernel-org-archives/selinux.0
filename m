MIME-Version: 1.0
In-Reply-To: <CAFftDdqR4-RukhCVxUCVv9hA3Hc-bnmJq4pyN7Rast7ttvdk=w@mail.gmail.com>
References: <CAN93RkL87Hscd1pdG8SUKqpNjZiwZ6Xyih=g+8HhL-vtP549Hw@mail.gmail.com>
	<1345668870.7532.2.camel@moss-pluto.epoch.ncsc.mil>
	<CAN93Rk+5-kAjSE6rk0qy8Ez_23SQA76+b1+3t3CoXc3FG4a=TQ@mail.gmail.com>
	<CAFftDdqYRhn4n4r66Jhdazk77hNbY40-g0+0zgVKzS4k6mxsrQ@mail.gmail.com>
	<CAN93RkKE7Nuy3HLQZU6B7rX+omDG5L174qEKia-mA0sRKVuaYg@mail.gmail.com>
	<CAFftDdqR4-RukhCVxUCVv9hA3Hc-bnmJq4pyN7Rast7ttvdk=w@mail.gmail.com>
Date: Wed, 22 Aug 2012 15:43:46 -0700
Message-ID: <CAFftDdrqw9soo1xA-ysZGRa9knc0RCQxdVTvPvtMovMXKPc0EA@mail.gmail.com>
Subject: Re: Problems getting source using repo sync
From: William Roberts <bill.c.roberts@gmail.com>
To: Cesar Maiorino <cesar.maiorino@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8f503b72c45c6704c7e2790e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8f503b72c45c6704c7e2790e
Content-Type: text/plain; charset=ISO-8859-1

Either way rm -rf .repo and the directory contents of Android  and try the
sync again.

What is the remote configured for in local_manifest.xml? Is it selinux or
bit bucket?
On Aug 22, 2012 5:40 PM, "William Roberts" <bill.c.roberts@gmail.com> wrote:

> Hmmm.... is this a new checkout or an update?
> On Aug 22, 2012 5:38 PM, "Cesar Maiorino" <cesar.maiorino@gmail.com>
> wrote:
>
>> > Make sure you have got version 1.7 or higher.
>> Yup. 1.7.4.1
>>
>

--e89a8f503b72c45c6704c7e2790e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Either way rm -rf .repo and the directory contents of Android=A0 and try=
 the sync again.</p>
<p>What is the remote configured for in local_manifest.xml? Is it selinux o=
r bit bucket?</p>
<div class=3D"gmail_quote">On Aug 22, 2012 5:40 PM, &quot;William Roberts&q=
uot; &lt;<a href=3D"mailto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.c=
om</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
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

--e89a8f503b72c45c6704c7e2790e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
