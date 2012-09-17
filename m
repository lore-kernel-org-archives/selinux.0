MIME-Version: 1.0
In-Reply-To: <CADQgGG1735_t8q=mA4hhGDPjkziviHE64hAJf2r0pMgjeiji=Q@mail.gmail.com>
References: <CAFftDdrSzB2Os0YbOZyHWSCoy64SGaaV9-jCTFLw5Ozn3KGSsw@mail.gmail.com>
	<CADQgGG1735_t8q=mA4hhGDPjkziviHE64hAJf2r0pMgjeiji=Q@mail.gmail.com>
Date: Mon, 17 Sep 2012 16:59:03 -0700
Message-ID: <CAFftDdotOM8pyZVJ_g0_56L3382uTvq+JpGsqzioJc+MRdXDKw@mail.gmail.com>
Subject: Re: signature clause in mac_permisions
From: William Roberts <bill.c.roberts@gmail.com>
To: Robert Craig <robertpcraig@gmail.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=bcaec51b97f9dd828004c9ee8ee3
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec51b97f9dd828004c9ee8ee3
Content-Type: text/plain; charset=ISO-8859-1

I should have RTFM, it is right on the wiki under install time mac
http://selinuxproject.org/page/SEAndroid



On Mon, Sep 17, 2012 at 4:22 PM, Robert Craig <robertpcraig@gmail.com>wrote:

> Just run the setool host tool. To build just 'make setool' and then to run
> just 'setool'. The help usage statement will guide you.
>
>
> On Mon, Sep 17, 2012 at 2:34 PM, William Roberts <bill.c.roberts@gmail.com
> > wrote:
>
>> How did you guys generate the hex encoded x509 string for a
>> signature clause in mac_permissions.xml?
>>
>> Did you use the Android "dumpkey.jar"?
>>
>> I have the signed apk's, the keystore used to sign them, .pem files which
>> have all the pub keys in them and a p12 and p8 file.
>>
>> Which one should I use?
>>
>> --
>> Respectfully,
>>
>> William C Roberts
>>
>>
>>
>


-- 
Respectfully,

William C Roberts

--bcaec51b97f9dd828004c9ee8ee3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I should have RTFM, it is right on the wiki under install time mac<div><a h=
ref=3D"http://selinuxproject.org/page/SEAndroid">http://selinuxproject.org/=
page/SEAndroid</a></div><div><br><div><br><br><div class=3D"gmail_quote">On=
 Mon, Sep 17, 2012 at 4:22 PM, Robert Craig <span dir=3D"ltr">&lt;<a href=
=3D"mailto:robertpcraig@gmail.com" target=3D"_blank">robertpcraig@gmail.com=
</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Just run the setool host tool. To build just=
 &#39;make setool&#39; and then to run just &#39;setool&#39;. The help usag=
e statement will guide you.<div class=3D"HOEnZb">
<div class=3D"h5"><br><br><div class=3D"gmail_quote">On Mon, Sep 17, 2012 a=
t 2:34 PM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.r=
oberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span>=
 wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">How did you guys=A0generate=A0the hex encode=
d x509 string for a signature=A0clause in mac_permissions.xml?<br clear=3D"=
all"><div>

<br></div><div>Did you use the Android &quot;dumpkey.jar&quot;?</div><div><=
br></div><div>I have the signed apk&#39;s, the keystore used to sign them, =
.pem files which have all the pub keys in them and a p12 and p8 file.</div>


<div><br></div><div>Which one should I use?</div><span><font color=3D"#8888=
88"><div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br=
>
</font></span></blockquote></div><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Respectfully,<br><br>William C Roberts<br><br><br>
</div></div>

--bcaec51b97f9dd828004c9ee8ee3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
