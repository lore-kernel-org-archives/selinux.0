MIME-Version: 1.0
In-Reply-To: <5058A8E4.6080105@manicmethod.com>
References: <CAFftDdrSzB2Os0YbOZyHWSCoy64SGaaV9-jCTFLw5Ozn3KGSsw@mail.gmail.com>
	<CADQgGG1735_t8q=mA4hhGDPjkziviHE64hAJf2r0pMgjeiji=Q@mail.gmail.com>
	<CAFftDdotOM8pyZVJ_g0_56L3382uTvq+JpGsqzioJc+MRdXDKw@mail.gmail.com>
	<5058A8E4.6080105@manicmethod.com>
Date: Tue, 18 Sep 2012 10:48:17 -0700
Message-ID: <CAFftDdp5AgAzh50AwDWz2xSox9XBB_8N0cV1_nGyiC3PHvXtxA@mail.gmail.com>
Subject: Re: signature clause in mac_permisions
From: William Roberts <bill.c.roberts@gmail.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Robert Craig <robertpcraig@gmail.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=bcaec51b97f9be8a3604c9fd7e6a
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec51b97f9be8a3604c9fd7e6a
Content-Type: text/plain; charset=ISO-8859-1

Thanks,
I was playing with opensll myself but couldn't come up with he correct
commandline foo for it.
Bill

On Tue, Sep 18, 2012 at 10:01 AM, Joshua Brindle <method@manicmethod.com>wrote:

> If you want to go straight from cert to hex encoding without having to
> sign an app (i.e., you are generating certs and policies at the same time)
> you can use this:
>
> $openssl x509 -inform PEM -in <certname>.x509.pem -outform DER
>
> Script to encode:
>
> #!/usr/bin/env python
>
> import sys
> content = sys.stdin.read().strip()
> foo = content.encode("hex")
> sys.stdout.write(foo)
>
>
> The script to encode has to be very careful about padding or null
> terminating, hence why I couldn't just use some random command line tool.
>
> William Roberts wrote:
>
>> I should have RTFM, it is right on the wiki under install time mac
>> http://selinuxproject.org/**page/SEAndroid<http://selinuxproject.org/page/SEAndroid>
>>
>>
>>
>> On Mon, Sep 17, 2012 at 4:22 PM, Robert Craig <robertpcraig@gmail.com
>> <mailto:robertpcraig@gmail.com**>> wrote:
>>
>>     Just run the setool host tool. To build just 'make setool' and then
>>     to run just 'setool'. The help usage statement will guide you.
>>
>>
>>     On Mon, Sep 17, 2012 at 2:34 PM, William Roberts
>>     <bill.c.roberts@gmail.com <mailto:bill.c.roberts@gmail.**com<bill.c.roberts@gmail.com>>>
>> wrote:
>>
>>         How did you guys generate the hex encoded x509 string for a
>>         signature clause in mac_permissions.xml?
>>
>>         Did you use the Android "dumpkey.jar"?
>>
>>         I have the signed apk's, the keystore used to sign them, .pem
>>         files which have all the pub keys in them and a p12 and p8 file.
>>
>>         Which one should I use?
>>
>>         --
>>         Respectfully,
>>
>>         William C Roberts
>>
>>
>>
>>
>>
>>
>> --
>> Respectfully,
>>
>> William C Roberts
>>
>>
>>


-- 
Respectfully,

William C Roberts

--bcaec51b97f9be8a3604c9fd7e6a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks,<div>I was playing with opensll myself but couldn&#39;t come up=A0wi=
th=A0he correct commandline foo for it.</div><div>Bill<br><br><div class=3D=
"gmail_quote">On Tue, Sep 18, 2012 at 10:01 AM, Joshua Brindle <span dir=3D=
"ltr">&lt;<a href=3D"mailto:method@manicmethod.com" target=3D"_blank">metho=
d@manicmethod.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">If you want to go straight from cert to hex =
encoding without having to sign an app (i.e., you are generating certs and =
policies at the same time) you can use this:<br>

<br>
$openssl x509 -inform PEM -in &lt;certname&gt;.x509.pem -outform DER<br>
<br>
Script to encode:<br>
<br>
#!/usr/bin/env python<br>
<br>
import sys<br>
content =3D sys.stdin.read().strip()<br>
foo =3D content.encode(&quot;hex&quot;)<br>
sys.stdout.write(foo)<br>
<br>
<br>
The script to encode has to be very careful about padding or null terminati=
ng, hence why I couldn&#39;t just use some random command line tool.<br>
<br>
William Roberts wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">
I should have RTFM, it is right on the wiki under install time mac<br>
<a href=3D"http://selinuxproject.org/page/SEAndroid" target=3D"_blank">http=
://selinuxproject.org/<u></u>page/SEAndroid</a><br>
<br>
<br>
<br>
On Mon, Sep 17, 2012 at 4:22 PM, Robert Craig &lt;<a href=3D"mailto:robertp=
craig@gmail.com" target=3D"_blank">robertpcraig@gmail.com</a><br></div><div=
 class=3D"im">
&lt;mailto:<a href=3D"mailto:robertpcraig@gmail.com" target=3D"_blank">robe=
rtpcraig@gmail.com</a><u></u>&gt;&gt; wrote:<br>
<br>
=A0 =A0 Just run the setool host tool. To build just &#39;make setool&#39; =
and then<br>
=A0 =A0 to run just &#39;setool&#39;. The help usage statement will guide y=
ou.<br>
<br>
<br>
=A0 =A0 On Mon, Sep 17, 2012 at 2:34 PM, William Roberts<br></div><div clas=
s=3D"im">
=A0 =A0 &lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">b=
ill.c.roberts@gmail.com</a> &lt;mailto:<a href=3D"mailto:bill.c.roberts@gma=
il.com" target=3D"_blank">bill.c.roberts@gmail.<u></u>com</a>&gt;&gt; wrote=
:<br>
<br>
=A0 =A0 =A0 =A0 How did you guys generate the hex encoded x509 string for a=
<br>
=A0 =A0 =A0 =A0 signature clause in mac_permissions.xml?<br>
<br>
=A0 =A0 =A0 =A0 Did you use the Android &quot;dumpkey.jar&quot;?<br>
<br>
=A0 =A0 =A0 =A0 I have the signed apk&#39;s, the keystore used to sign them=
, .pem<br>
=A0 =A0 =A0 =A0 files which have all the pub keys in them and a p12 and p8 =
file.<br>
<br>
=A0 =A0 =A0 =A0 Which one should I use?<br>
<br>
=A0 =A0 =A0 =A0 --<br>
=A0 =A0 =A0 =A0 Respectfully,<br>
<br>
=A0 =A0 =A0 =A0 William C Roberts<br>
<br>
<br>
<br>
<br>
<br>
<br>
--<br>
Respectfully,<br>
<br>
William C Roberts<br>
<br>
<br>
</div></blockquote>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Respectfully=
,<br><br>William C Roberts<br><br><br>
</div>

--bcaec51b97f9be8a3604c9fd7e6a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
