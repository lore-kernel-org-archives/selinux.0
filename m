MIME-Version: 1.0
In-Reply-To: <57EC3122.5040802@quarksecurity.com>
References: <CAFftDdqOWmwCihg4ujOz0qm3xWhRiTTT8dnD2dTPd-a903Ntkw@mail.gmail.com>
 <57EC2A2F.5030908@quarksecurity.com> <57EC2E10.4030207@quarksecurity.com>
 <CAFftDdo04U_xFSDwLvU_A1jW2C0F7Awdhsn=jMfqtXUMmz0uqg@mail.gmail.com>
 <57EC3122.5040802@quarksecurity.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Sep 2016 17:10:09 -0400
Message-ID: <CAFftDdpTRkNWpTF3dmNb=tkZ+izMjPL9s8ZHc2YhRCPW4z3sEg@mail.gmail.com>
Subject: Re: [RFC] Build ANDROID_HOST=y on mac
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 seandroid-list@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113edf345015d0053d97c944
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113edf345015d0053d97c944
Content-Type: text/plain; charset=UTF-8

On Sep 28, 2016 17:07, "Joshua Brindle" <brindle@quarksecurity.com> wrote:
>
> William Roberts wrote:
>>
>> On Sep 28, 2016 16:54, "Joshua Brindle"<brindle@quarksecurity.com>
wrote:
>>>
>>> Joshua Brindle wrote:
>>>>
>>>> William Roberts wrote:
>>>>>
>>>>>  From commit 35d702 on
>>>>> https://github.com/williamcroberts/selinux/tree/fix-mac
>>>>>
>>>>> I have a branch that is building on my elcapitan mac, requesting any
>>>>> comments anyone
>>>>> wishes to make, before I send them out.
>>>>>
>>>>> If you wish to test, this is the procedure
>>>>>
>>>>> 1. Build libsepol (assumes at root of tree)
>>>>> a, cd libsepol
>>>>> b. make
>>>>> 2. Build libselinux
>>>>> a. cd libselinux (assumes at root of tree)
>>>>> b. make ANDROID_HOST=y
>>>>>
>>>> This works for me.
>>>
>>>
>>> make install DESTDIR=/tmp/someidr mostly works, Mac ln does not support
>>
>> --relative so that fails. ANDROID_HOST also needs to be set in the top
>> level makefile so that it propagates down:
>>>
>>> ANDROID_HOST ?= n
>>
>>
>> Yeah install doesn't work on Mac, that's why for Darwin we just set the
>> path to the libsepol location for sefcontext_compile.
>>
>> As for ANDROID_HOST, why does it need to go higher? It's only used in
>> libselinux and is declared and used just like DISABLE_SETRANS...I'm not
>> following you?
>>
>
> Because I was building from the top, basically seeing if I could get a
usable toolchain out of it, but that looks like it would require a bit more
work.

Ahh yeah, that won't work yet, but that would be nice.

>
>
>>>
>>>>
>>>>> This essentially gets us to where a build server/maintainer
>>>>> can test patches quickly on mac, with some assurance
>>>>> it's not busted without downloading all of Android.
>>>>>
>>>>> It's still wise to check in an Android tree if possible IMHO.
>>>>>
>>
>

--001a113edf345015d0053d97c944
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 28, 2016 17:07, &quot;Joshua Brindle&quot; &lt;<a hre=
f=3D"mailto:brindle@quarksecurity.com">brindle@quarksecurity.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; William Roberts wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Sep 28, 2016 16:54, &quot;Joshua Brindle&quot;&lt;<a href=3D"ma=
ilto:brindle@quarksecurity.com">brindle@quarksecurity.com</a>&gt;=C2=A0 wro=
te:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Joshua Brindle wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; William Roberts wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0From commit 35d702 on<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"https://github.com/williamcroberts/selinux/=
tree/fix-mac">https://github.com/williamcroberts/selinux/tree/fix-mac</a><b=
r>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I have a branch that is building on my elcapitan mac, =
requesting any<br>
&gt;&gt;&gt;&gt;&gt; comments anyone<br>
&gt;&gt;&gt;&gt;&gt; wishes to make, before I send them out.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; If you wish to test, this is the procedure<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; 1. Build libsepol (assumes at root of tree)<br>
&gt;&gt;&gt;&gt;&gt; a, cd libsepol<br>
&gt;&gt;&gt;&gt;&gt; b. make<br>
&gt;&gt;&gt;&gt;&gt; 2. Build libselinux<br>
&gt;&gt;&gt;&gt;&gt; a. cd libselinux (assumes at root of tree)<br>
&gt;&gt;&gt;&gt;&gt; b. make ANDROID_HOST=3Dy<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This works for me.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; make install DESTDIR=3D/tmp/someidr mostly works, Mac ln does =
not support<br>
&gt;&gt;<br>
&gt;&gt; --relative so that fails. ANDROID_HOST also needs to be set in the=
 top<br>
&gt;&gt; level makefile so that it propagates down:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ANDROID_HOST ?=3D n<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Yeah install doesn&#39;t work on Mac, that&#39;s why for Darwin we=
 just set the<br>
&gt;&gt; path to the libsepol location for sefcontext_compile.<br>
&gt;&gt;<br>
&gt;&gt; As for ANDROID_HOST, why does it need to go higher? It&#39;s only =
used in<br>
&gt;&gt; libselinux and is declared and used just like DISABLE_SETRANS...I&=
#39;m not<br>
&gt;&gt; following you?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Because I was building from the top, basically seeing if I could get a=
 usable toolchain out of it, but that looks like it would require a bit mor=
e work.</p>
<p dir=3D"ltr">Ahh yeah, that won&#39;t work yet, but that would be nice.</=
p>
<p dir=3D"ltr">&gt;<br>
&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This essentially gets us to where a build server/maint=
ainer<br>
&gt;&gt;&gt;&gt;&gt; can test patches quickly on mac, with some assurance<b=
r>
&gt;&gt;&gt;&gt;&gt; it&#39;s not busted without downloading all of Android=
.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; It&#39;s still wise to check in an Android tree if pos=
sible IMHO.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;</p>

--001a113edf345015d0053d97c944--
