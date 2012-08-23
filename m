MIME-Version: 1.0
In-Reply-To: <CADQgGG2_7w1A6QO+nLN5GprrFWWkJuXExvtYgH-AkBnJbNoEwQ@mail.gmail.com>
References: <CAN93RkL87Hscd1pdG8SUKqpNjZiwZ6Xyih=g+8HhL-vtP549Hw@mail.gmail.com>
 <1345668870.7532.2.camel@moss-pluto.epoch.ncsc.mil> <CAN93Rk+5-kAjSE6rk0qy8Ez_23SQA76+b1+3t3CoXc3FG4a=TQ@mail.gmail.com>
 <CAFftDdqYRhn4n4r66Jhdazk77hNbY40-g0+0zgVKzS4k6mxsrQ@mail.gmail.com>
 <CAN93RkKE7Nuy3HLQZU6B7rX+omDG5L174qEKia-mA0sRKVuaYg@mail.gmail.com>
 <CAFftDdqR4-RukhCVxUCVv9hA3Hc-bnmJq4pyN7Rast7ttvdk=w@mail.gmail.com>
 <CAFftDdrqw9soo1xA-ysZGRa9knc0RCQxdVTvPvtMovMXKPc0EA@mail.gmail.com>
 <CAN93RkKztvm9tq-Bf=_SiuG1GpqLThLFA2Ly5qafRe=56aJ0Tw@mail.gmail.com>
 <1345722246.10773.3.camel@moss-pluto.epoch.ncsc.mil> <1345723737.10773.6.camel@moss-pluto.epoch.ncsc.mil>
 <CADQgGG2_7w1A6QO+nLN5GprrFWWkJuXExvtYgH-AkBnJbNoEwQ@mail.gmail.com>
From: Cesar Maiorino <cesar.maiorino@gmail.com>
Date: Thu, 23 Aug 2012 13:13:15 -0400
Message-ID: <CAN93Rk+KSf0cC4H=m8XdZ1vNkARQbCWa3B7HPGffTx2=eVDEsA@mail.gmail.com>
Subject: Re: Problems getting source using repo sync
To: Robert Craig <robertpcraig@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d04138a59fe0ee904c7f1fb9b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04138a59fe0ee904c7f1fb9b
Content-Type: text/plain; charset=ISO-8859-1

You are right on both points: I did see a lot of "v2" errors, and the
source all seems to be there (builds successfully).
Thanks everybody for the help. As you can probably guess from my questions,
I'm kinda new at this, and this has
saved me a lot of time and effort.

On Thu, Aug 23, 2012 at 12:29 PM, Robert Craig <robertpcraig@gmail.com>wrote:

> My assumption is that you should be seeing a lot more then just the one
> "v2" error. I've had issues like this in the past. You should still have
> the source downloaded even with those weird errors. I believe those errors
> have to do with incorrectly formatted headers when git creates bundles from
> some repositories .  I would proceed with building as if none of those
> messages were reported.
>
> On Thu, Aug 23, 2012 at 8:08 AM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>
>> On Thu, 2012-08-23 at 07:44 -0400, Stephen Smalley wrote:
>> > On Wed, 2012-08-22 at 18:51 -0400, Cesar Maiorino wrote:
>> > > I started clean and  used this sequence of commands (as per
>> > > selinuxproject.org/page/SEAndroid)
>> > >
>> > > git clone -b seandroid-4.0.4
>> https://bitbucket.org/seandroid/manifests.git
>> > > mkdir seandroid-4.0.4
>> > > cd seandroid-4.0.4
>> > > repo init -u https://android.googlesource.com/platform/manifest -b
>> android-4.0.4_r2.1
>> > > repo sync
>> > > cp ../manifests/local_manifest.xml .repo/
>> > > repo sync -j1
>> > >
>> > > local_manifest.xml is configured for bitbucket.
>> >
>> > You might want to try the ssh-based access instead.  Requires setting up
>> > an account on bitbucket.org and uploading a ssh public key.  Then you
>> > can do the following:
>> > cd manifests
>> > git checkout origin/seandroid-4.0.4-ssh
>> >
>> > and use the local_manifest.xml file that you'll find in that branch.
>>
>> BTW, are you sure you want to use 4.0.4?  4.1.1 is available.
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
>> the words "unsubscribe selinux" without quotes as the message.
>>
>
>

--f46d04138a59fe0ee904c7f1fb9b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

You are right on both points: I did see a lot of &quot;v2&quot; errors, and=
 the source all seems to be there (builds successfully).<br>Thanks everybod=
y for the help. As you can probably guess from my questions, I&#39;m kinda =
new at this, and this has<br>

saved me a lot of time and effort.<br><br><div class=3D"gmail_quote">On Thu=
, Aug 23, 2012 at 12:29 PM, Robert Craig <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:robertpcraig@gmail.com" target=3D"_blank">robertpcraig@gmail.com</a>&=
gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">My assumption is that you should be seeing a=
 lot more then just the one &quot;v2&quot; error. I&#39;ve had issues like =
this in the past. You should still have the source downloaded even with tho=
se weird errors. I believe those errors have to do with=A0incorrectly forma=
tted headers when git creates bundles from some repositories=A0. =A0I would=
 proceed with building as if none of those messages were reported.<div>




<div><div><br><div class=3D"gmail_quote"><div><div class=3D"h5">On Thu, Aug=
 23, 2012 at 8:08 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mail=
to:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wr=
ote:<br>

</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5">


<div>On Thu, 2012-08-23 at 07:44 -0400, Stephen Smalley wrote:<br>
&gt; On Wed, 2012-08-22 at 18:51 -0400, Cesar Maiorino wrote:<br>
&gt; &gt; I started clean and =A0used this sequence of commands (as per<br>
&gt; &gt; <a href=3D"http://selinuxproject.org/page/SEAndroid" target=3D"_b=
lank">selinuxproject.org/page/SEAndroid</a>)<br>
&gt; &gt;<br>
&gt; &gt; git clone -b seandroid-4.0.4 <a href=3D"https://bitbucket.org/sea=
ndroid/manifests.git" target=3D"_blank">https://bitbucket.org/seandroid/man=
ifests.git</a><br>
&gt; &gt; mkdir seandroid-4.0.4<br>
&gt; &gt; cd seandroid-4.0.4<br>
&gt; &gt; repo init -u <a href=3D"https://android.googlesource.com/platform=
/manifest" target=3D"_blank">https://android.googlesource.com/platform/mani=
fest</a> -b android-4.0.4_r2.1<br>
&gt; &gt; repo sync<br>
&gt; &gt; cp ../manifests/local_manifest.xml .repo/<br>
&gt; &gt; repo sync -j1<br>
&gt; &gt;<br>
&gt; &gt; local_manifest.xml is configured for bitbucket.<br>
&gt;<br>
&gt; You might want to try the ssh-based access instead. =A0Requires settin=
g up<br>
&gt; an account on <a href=3D"http://bitbucket.org" target=3D"_blank">bitbu=
cket.org</a> and uploading a ssh public key. =A0Then you<br>
&gt; can do the following:<br>
&gt; cd manifests<br>
&gt; git checkout origin/seandroid-4.0.4-ssh<br>
&gt;<br>
&gt; and use the local_manifest.xml file that you&#39;ll find in that branc=
h.<br>
<br>
</div>BTW, are you sure you want to use 4.0.4? =A04.1.1 is available.<br>
</div></div><div><div><div><div class=3D"h5"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
<br></div></div><span class=3D"HOEnZb"><font color=3D"#888888">
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></span></div></div></blockquote></div><br></div></div></div>
</blockquote></div><br>

--f46d04138a59fe0ee904c7f1fb9b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
