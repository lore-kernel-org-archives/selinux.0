MIME-Version: 1.0
In-Reply-To: <57EC2E10.4030207@quarksecurity.com>
References: <CAFftDdqOWmwCihg4ujOz0qm3xWhRiTTT8dnD2dTPd-a903Ntkw@mail.gmail.com>
 <57EC2A2F.5030908@quarksecurity.com> <57EC2E10.4030207@quarksecurity.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Sep 2016 17:03:28 -0400
Message-ID: <CAFftDdo04U_xFSDwLvU_A1jW2C0F7Awdhsn=jMfqtXUMmz0uqg@mail.gmail.com>
Subject: Re: [RFC] Build ANDROID_HOST=y on mac
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: seandroid-list@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113eca6c69f15c053d97b187
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113eca6c69f15c053d97b187
Content-Type: text/plain; charset=UTF-8

On Sep 28, 2016 16:54, "Joshua Brindle" <brindle@quarksecurity.com> wrote:
>
> Joshua Brindle wrote:
>>
>> William Roberts wrote:
>>>
>>> From commit 35d702 on
>>> https://github.com/williamcroberts/selinux/tree/fix-mac
>>>
>>> I have a branch that is building on my elcapitan mac, requesting any
>>> comments anyone
>>> wishes to make, before I send them out.
>>>
>>> If you wish to test, this is the procedure
>>>
>>> 1. Build libsepol (assumes at root of tree)
>>> a, cd libsepol
>>> b. make
>>> 2. Build libselinux
>>> a. cd libselinux (assumes at root of tree)
>>> b. make ANDROID_HOST=y
>>>
>>
>> This works for me.
>
>
> make install DESTDIR=/tmp/someidr mostly works, Mac ln does not support
--relative so that fails. ANDROID_HOST also needs to be set in the top
level makefile so that it propagates down:
>
> ANDROID_HOST ?= n

Yeah install doesn't work on Mac, that's why for Darwin we just set the
path to the libsepol location for sefcontext_compile.

As for ANDROID_HOST, why does it need to go higher? It's only used in
libselinux and is declared and used just like DISABLE_SETRANS...I'm not
following you?

>
>
>>
>>
>>> This essentially gets us to where a build server/maintainer
>>> can test patches quickly on mac, with some assurance
>>> it's not busted without downloading all of Android.
>>>
>>> It's still wise to check in an Android tree if possible IMHO.
>>>
>>
>

--001a113eca6c69f15c053d97b187
Content-Type: text/html; charset=UTF-8

<p dir="ltr"></p>
<p dir="ltr">On Sep 28, 2016 16:54, &quot;Joshua Brindle&quot; &lt;<a href="mailto:brindle@quarksecurity.com">brindle@quarksecurity.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Joshua Brindle wrote:<br>
&gt;&gt;<br>
&gt;&gt; William Roberts wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; From commit 35d702 on<br>
&gt;&gt;&gt; <a href="https://github.com/williamcroberts/selinux/tree/fix-mac">https://github.com/williamcroberts/selinux/tree/fix-mac</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I have a branch that is building on my elcapitan mac, requesting any<br>
&gt;&gt;&gt; comments anyone<br>
&gt;&gt;&gt; wishes to make, before I send them out.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If you wish to test, this is the procedure<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 1. Build libsepol (assumes at root of tree)<br>
&gt;&gt;&gt; a, cd libsepol<br>
&gt;&gt;&gt; b. make<br>
&gt;&gt;&gt; 2. Build libselinux<br>
&gt;&gt;&gt; a. cd libselinux (assumes at root of tree)<br>
&gt;&gt;&gt; b. make ANDROID_HOST=y<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; This works for me.<br>
&gt;<br>
&gt;<br>
&gt; make install DESTDIR=/tmp/someidr mostly works, Mac ln does not support --relative so that fails. ANDROID_HOST also needs to be set in the top level makefile so that it propagates down:<br>
&gt;<br>
&gt; ANDROID_HOST ?= n</p>
<p dir="ltr">Yeah install doesn&#39;t work on Mac, that&#39;s why for Darwin we just set the path to the libsepol location for sefcontext_compile.</p>
<p dir="ltr">As for ANDROID_HOST, why does it need to go higher? It&#39;s only used in libselinux and is declared and used just like DISABLE_SETRANS...I&#39;m not following you?</p>
<p dir="ltr">&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; This essentially gets us to where a build server/maintainer<br>
&gt;&gt;&gt; can test patches quickly on mac, with some assurance<br>
&gt;&gt;&gt; it&#39;s not busted without downloading all of Android.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; It&#39;s still wise to check in an Android tree if possible IMHO.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;</p>

--001a113eca6c69f15c053d97b187--
