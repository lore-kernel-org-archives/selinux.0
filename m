MIME-Version: 1.0
In-Reply-To: <1345722246.10773.3.camel@moss-pluto.epoch.ncsc.mil>
References: <CAN93RkL87Hscd1pdG8SUKqpNjZiwZ6Xyih=g+8HhL-vtP549Hw@mail.gmail.com>
 <1345668870.7532.2.camel@moss-pluto.epoch.ncsc.mil> <CAN93Rk+5-kAjSE6rk0qy8Ez_23SQA76+b1+3t3CoXc3FG4a=TQ@mail.gmail.com>
 <CAFftDdqYRhn4n4r66Jhdazk77hNbY40-g0+0zgVKzS4k6mxsrQ@mail.gmail.com>
 <CAN93RkKE7Nuy3HLQZU6B7rX+omDG5L174qEKia-mA0sRKVuaYg@mail.gmail.com>
 <CAFftDdqR4-RukhCVxUCVv9hA3Hc-bnmJq4pyN7Rast7ttvdk=w@mail.gmail.com>
 <CAFftDdrqw9soo1xA-ysZGRa9knc0RCQxdVTvPvtMovMXKPc0EA@mail.gmail.com>
 <CAN93RkKztvm9tq-Bf=_SiuG1GpqLThLFA2Ly5qafRe=56aJ0Tw@mail.gmail.com> <1345722246.10773.3.camel@moss-pluto.epoch.ncsc.mil>
From: Cesar Maiorino <cesar.maiorino@gmail.com>
Date: Thu, 23 Aug 2012 10:24:24 -0400
Message-ID: <CAN93RkKUP7ukTWmKX6bbntoP8M5rsEuCL1m2HHe3-rs681cNPw@mail.gmail.com>
Subject: Re: Problems getting source using repo sync
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00504502d5312cb79704c7efa033
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504502d5312cb79704c7efa033
Content-Type: text/plain; charset=ISO-8859-1

> You might want to try the ssh-based access instead.  Requires setting up
> an account on bitbucket.org and uploading a ssh public key.  Then you
> can do the following:
> cd manifests
> git checkout origin/seandroid-4.0.4-ssh

> and use the local_manifest.xml file that you'll find in that branch.

I'll try this next. Thanks.

BTW, I am using 4.0.4 because that is what is currently supplied by the OEM
I am dealing with, and
I want to change as little as possible until I get things working.

On that note, I have another question. I'll want to extract patches to
apply to my code base. I see
an example on selinuxproject.org:

cd seandroid-4.0.4/frameworks/base
git format-patch android-4.0.4_r2.1

I assume I need to do this for each of the git projects that contain
seandroid changes. Is there an easy
way to figure out which projects those are?

--00504502d5312cb79704c7efa033
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&gt; You might want to try the ssh-based access instead. =A0Requires settin=
g up<br>
&gt; an account on <a href=3D"http://bitbucket.org" target=3D"_blank">bitbu=
cket.org</a> and uploading a ssh public key. =A0Then you<br>
&gt; can do the following:<br>
&gt; cd manifests<br>
&gt; git checkout origin/seandroid-4.0.4-ssh<br>
<br>
&gt; and use the local_manifest.xml file that you&#39;ll find in that branc=
h.<br><br>I&#39;ll try this next. Thanks.<br><br>BTW, I am using 4.0.4 beca=
use that is what is currently supplied by the OEM I am dealing with, and<br=
>

I want to change as little as possible until I get things working.<br><br>O=
n that note, I have another question. I&#39;ll want to extract patches to a=
pply to my code base. I see<br>an example on <a href=3D"http://selinuxproje=
ct.org">selinuxproject.org</a>:<br>

<pre>cd seandroid-4.0.4/frameworks/base
git format-patch android-4.0.4_r2.1<br><br></pre>I assume I need to do this=
 for each of the git projects that contain seandroid changes. Is there an e=
asy<br>way to figure out which projects those are?<br>
<pre><br></pre>

--00504502d5312cb79704c7efa033--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
