MIME-Version: 1.0
In-Reply-To: <CAPihp9nUv8+pu5Zx1SJf2G0dNood9xLGvB+ik2Lw9mLSPj89vw@mail.gmail.com>
References: <CAFC8oadn76ZLU2T0BAJyrceAzuVAtB+Yincvt7m7=29kbOrFNg@mail.gmail.com>
 <CAPihp9nUv8+pu5Zx1SJf2G0dNood9xLGvB+ik2Lw9mLSPj89vw@mail.gmail.com>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Sat, 20 Aug 2016 06:33:25 +0500
Message-ID: <CAFC8oacf6tQpLHtBx2N55PeSSTcZK09TaF0xxGh_a2cHTAKFhg@mail.gmail.com>
Subject: Re: (How to ) Change the context of user
To: masoom alam <masoom.alam@gmail.com>
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c0949e620bfdc053a76cd76
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c0949e620bfdc053a76cd76
Content-Type: text/plain; charset=UTF-8

i mean persistent change in the context of root user

On Sat, Aug 20, 2016 at 6:25 AM, masoom alam <masoom.alam@gmail.com> wrote:

> U mean permanently?
>
> I am wondering if this is possible
>
> sorry for typos....sent from mob
> On Aug 20, 2016 5:57 AM, "Kashif ali" <kashif.ali.9498@gmail.com> wrote:
>
>> Hi
>>   * I'm facing a problem while changing the context of root user in
>> selinux, Selinux is in enforced and targeted policy. By default Selinux
>> assign user =>"unconfined_u:unconfiend_r:unconfined_t:"
>> context for the user i have changed the selinux mapped root user
>> "unconifined_u" into "system_u" for root user with the help of command
>> =>"semanage login -a -s system_u root"
>> after executing this command the root user context is changed into
>> "system_u:unconfined_r:unconfined_t:".
>>
>> * Now i have changed the root user role and domain type so i execute this
>> command
>> =>"newrole -r system_r -t initrc_t:"
>> and change the root user context into "system_u:system_r:initrc_t:" but
>> this change is temporary after rebooting the system the context of root
>> user is changed back to "system_u:unconfined_r:unconfined_t:"
>>
>> * what i need is to change the root user context permanently into
>> "system_u:system_r:initrc_t:".
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>>
>

--94eb2c0949e620bfdc053a76cd76
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">i mean=C2=A0persistent change in the context of root user<=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Aug =
20, 2016 at 6:25 AM, masoom alam <span dir=3D"ltr">&lt;<a href=3D"mailto:ma=
soom.alam@gmail.com" target=3D"_blank">masoom.alam@gmail.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr">U mean permanently=
? </p>
<p dir=3D"ltr">I am wondering if this is possible<br><br></p>
<p dir=3D"ltr">sorry for typos....sent from mob</p>
<div class=3D"gmail_quote"><div><div class=3D"h5">On Aug 20, 2016 5:57 AM, =
&quot;Kashif ali&quot; &lt;<a href=3D"mailto:kashif.ali.9498@gmail.com" tar=
get=3D"_blank">kashif.ali.9498@gmail.com</a>&gt; wrote:<br type=3D"attribut=
ion"></div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5"><div=
 dir=3D"ltr">Hi<div>=C2=A0 * I&#39;m facing a problem while changing the co=
ntext of root user in selinux, Selinux is in enforced and targeted policy. =
By default Selinux assign user =3D&gt;&quot;unconfined_u:unconfiend_r:u<wbr=
>nconfined_t:&quot;=C2=A0</div><div>context for the user i have changed the=
 selinux mapped root user &quot;unconifined_u&quot; into &quot;system_u&quo=
t; for root user with the help of command=C2=A0</div><div>=3D&gt;&quot;sema=
nage login -a -s system_u root&quot;=C2=A0</div><div>after executing this c=
ommand the root user context is changed into &quot;system_u:unconfined_r:un=
confi<wbr>ned_t:&quot;.</div><div><br></div><div>* Now i have changed the r=
oot user role and domain type so i execute this command=C2=A0</div><div>=3D=
&gt;&quot;newrole -r system_r -t initrc_t:&quot;=C2=A0</div><div>and change=
 the root user context into &quot;system_u:system_r:initrc_t:&quot; but thi=
s change is temporary after rebooting the system the context of root user i=
s changed back to &quot;system_u:unconfined_r:unconfi<wbr>ned_t:&quot;</div=
><div><br></div><div>* what i need is to change the root user context perma=
nently into &quot;system_u:system_r:initrc_t:&quot;.</div><div><br></div></=
div>
<br></div></div>______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br></blockquote></div>
</blockquote></div><br></div>

--94eb2c0949e620bfdc053a76cd76--
