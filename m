Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7T5w1qx014970
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2012 01:58:01 -0400
Received: by qaas11 with SMTP id s11so186480qaa.12
        for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2012 22:57:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <503D9A5D.9090307@itechfrontiers.com>
References: <CAE_4iW8xF5NLvjrXKpSExgstbFx8JKfx38F5PBN0YP3VaPFz4Q@mail.gmail.com>
	<503D8F58.3010207@itechfrontiers.com>
	<CAFftDdo1286WZaKfgeJK8xe=N4DE6F3HyQe-X5FM2kpUQD3rxA@mail.gmail.com>
	<503D9A5D.9090307@itechfrontiers.com>
Date: Tue, 28 Aug 2012 22:57:59 -0700
Message-ID: <CAFftDdrfDU69Bpa1VJUvxABMdyg1UmR3NUqeS0xgf2JY7554=Q@mail.gmail.com>
Subject: Re: proof selinux
From: William Roberts <bill.c.roberts@gmail.com>
To: "Patrick K., ITF" <cto@itechfrontiers.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=00248c768f9eb5715c04c8613d18
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00248c768f9eb5715c04c8613d18
Content-Type: text/plain; charset=ISO-8859-1

I never said it stops an overflow from occurring, it merely mitigates an
attack that was accomplished through an overflow....or similar memory
corruption error.
On Aug 28, 2012 9:28 PM, "Patrick K., ITF" <cto@itechfrontiers.com> wrote:

> Bill,
>
> The demonstration for SEAndroid you referred to is not to prevent the
> overflow, SELinux is not a tool such as StackGuard or ProPolice;
>
> Such prevention is in gaining access and elevation of privileges, SELinux
> is there to compartmentalize things if correctly used, So technically it is
> not for preventing from buffer overflow or even preventing exploits, it is
> to confine, isolate, restrict and limit the damage (in GingerBreak case
> preventing Elevation of access -Root access-)
>
> I believe you referred to this page:
>
> http://selinuxproject.org/~**jmorris/lss2011_slides/**caseforseandroid.pdf<http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandroid.pdf>
>
> Best Regards,
>
> Patrick K.
>
> On 8/29/2012 12:10 AM, William Roberts wrote:
>
>> As far as demo at preventing attacks based on overflow stephen smalley
>> does a nice job showing how SEAndroid prevented ginger break. Look at
>> the SEAndroid web page(Google it)
>>
>> On Aug 28, 2012 8:45 PM, "Patrick K., ITF" <cto@itechfrontiers.com
>> <mailto:cto@itechfrontiers.com**>> wrote:
>>
>>     Hi Raul,
>>
>>     I'm not sure if we are on the same page about SELinux.
>>
>>     SELinux is not there to prevent from buffer overflow or such exploits,
>>
>>     If you run a process in some kind of Role or Context, you confine it
>>     to the limitations you defined in that context (using SELinux
>> Policies),
>>
>>     How effective SELinux would be, depends on your policies actually.
>>
>>     The effectiveness of SELinux has nothing to do with exploits, unless
>>     of course you meant attacking SELinux code or kernel LSM or Kernel
>>     itself.
>>
>>
>>     Testing SELinux is easy, simply assign whatever role or policy you
>>     want to a process and user or group,  the ultimate exploit of a
>>     process gives total control of that role or policy to that user. So
>>     the attackers become as privileged as the role or user or context of
>>     the policy.
>>
>>
>>     Sincerely,
>>
>>     Patrick K.
>>
>>     On 8/28/2012 10:50 PM, Raul da Silva {Sp4wn} wrote:
>>
>>         hi guys,
>>
>>         I know that we have a lot of ways to prove how effective is
>>         SELinux as
>>         cgi, perl, shell scripts and I know that is effective but I'd
>>         like to
>>         know if someone already tested some kind of exploit of buffer
>>         overflow
>>         attack as demo to show how effective could be SELinux.
>>         Any information I really appreciate
>>
>>         Thanks
>>
>>
>>
>>         Raul Leite
>>         sp4wn.root@gmail.com <mailto:sp4wn.root@gmail.com>
>>         <mailto:sp4wn.root@gmail.com <mailto:sp4wn.root@gmail.com>>
>>
>>
>>
>>     --
>>     This message was distributed to subscribers of the selinux mailing
>> list.
>>     If you no longer wish to subscribe, send mail to
>>     majordomo@tycho.nsa.gov <mailto:majordomo@tycho.nsa.**gov<majordomo@tycho.nsa.gov>>
>> with
>>     the words "unsubscribe selinux" without quotes as the message.
>>
>>

--00248c768f9eb5715c04c8613d18
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>I never said it stops an overflow from occurring, it merely mitigates an=
 attack that was accomplished through an overflow....or similar memory corr=
uption error. </p>
<div class=3D"gmail_quote">On Aug 28, 2012 9:28 PM, &quot;Patrick K., ITF&q=
uot; &lt;<a href=3D"mailto:cto@itechfrontiers.com">cto@itechfrontiers.com</=
a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Bill,<br>
<br>
The demonstration for SEAndroid you referred to is not to prevent the overf=
low, SELinux is not a tool such as StackGuard or ProPolice;<br>
<br>
Such prevention is in gaining access and elevation of privileges, SELinux i=
s there to compartmentalize things if correctly used, So technically it is =
not for preventing from buffer overflow or even preventing exploits, it is =
to confine, isolate, restrict and limit the damage (in GingerBreak case pre=
venting Elevation of access -Root access-)<br>

<br>
I believe you referred to this page:<br>
<br>
<a href=3D"http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandro=
id.pdf" target=3D"_blank">http://selinuxproject.org/~<u></u>jmorris/lss2011=
_slides/<u></u>caseforseandroid.pdf</a><br>
<br>
Best Regards,<br>
<br>
Patrick K.<br>
<br>
On 8/29/2012 12:10 AM, William Roberts wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
As far as demo at preventing attacks based on overflow stephen smalley<br>
does a nice job showing how SEAndroid prevented ginger break. Look at<br>
the SEAndroid web page(Google it)<br>
<br>
On Aug 28, 2012 8:45 PM, &quot;Patrick K., ITF&quot; &lt;<a href=3D"mailto:=
cto@itechfrontiers.com" target=3D"_blank">cto@itechfrontiers.com</a><br>
&lt;mailto:<a href=3D"mailto:cto@itechfrontiers.com" target=3D"_blank">cto@=
itechfrontiers.com</a><u></u>&gt;&gt; wrote:<br>
<br>
=A0 =A0 Hi Raul,<br>
<br>
=A0 =A0 I&#39;m not sure if we are on the same page about SELinux.<br>
<br>
=A0 =A0 SELinux is not there to prevent from buffer overflow or such exploi=
ts,<br>
<br>
=A0 =A0 If you run a process in some kind of Role or Context, you confine i=
t<br>
=A0 =A0 to the limitations you defined in that context (using SELinux Polic=
ies),<br>
<br>
=A0 =A0 How effective SELinux would be, depends on your policies actually.<=
br>
<br>
=A0 =A0 The effectiveness of SELinux has nothing to do with exploits, unles=
s<br>
=A0 =A0 of course you meant attacking SELinux code or kernel LSM or Kernel<=
br>
=A0 =A0 itself.<br>
<br>
<br>
=A0 =A0 Testing SELinux is easy, simply assign whatever role or policy you<=
br>
=A0 =A0 want to a process and user or group, =A0the ultimate exploit of a<b=
r>
=A0 =A0 process gives total control of that role or policy to that user. So=
<br>
=A0 =A0 the attackers become as privileged as the role or user or context o=
f<br>
=A0 =A0 the policy.<br>
<br>
<br>
=A0 =A0 Sincerely,<br>
<br>
=A0 =A0 Patrick K.<br>
<br>
=A0 =A0 On 8/28/2012 10:50 PM, Raul da Silva {Sp4wn} wrote:<br>
<br>
=A0 =A0 =A0 =A0 hi guys,<br>
<br>
=A0 =A0 =A0 =A0 I know that we have a lot of ways to prove how effective is=
<br>
=A0 =A0 =A0 =A0 SELinux as<br>
=A0 =A0 =A0 =A0 cgi, perl, shell scripts and I know that is effective but I=
&#39;d<br>
=A0 =A0 =A0 =A0 like to<br>
=A0 =A0 =A0 =A0 know if someone already tested some kind of exploit of buff=
er<br>
=A0 =A0 =A0 =A0 overflow<br>
=A0 =A0 =A0 =A0 attack as demo to show how effective could be SELinux.<br>
=A0 =A0 =A0 =A0 Any information I really appreciate<br>
<br>
=A0 =A0 =A0 =A0 Thanks<br>
<br>
<br>
<br>
=A0 =A0 =A0 =A0 Raul Leite<br>
=A0 =A0 =A0 =A0 <a href=3D"mailto:sp4wn.root@gmail.com" target=3D"_blank">s=
p4wn.root@gmail.com</a> &lt;mailto:<a href=3D"mailto:sp4wn.root@gmail.com" =
target=3D"_blank">sp4wn.root@gmail.com</a>&gt;<br>
=A0 =A0 =A0 =A0 &lt;mailto:<a href=3D"mailto:sp4wn.root@gmail.com" target=
=3D"_blank">sp4wn.root@gmail.com</a> &lt;mailto:<a href=3D"mailto:sp4wn.roo=
t@gmail.com" target=3D"_blank">sp4wn.root@gmail.com</a>&gt;&gt;<br>
<br>
<br>
<br>
=A0 =A0 --<br>
=A0 =A0 This message was distributed to subscribers of the selinux mailing =
list.<br>
=A0 =A0 If you no longer wish to subscribe, send mail to<br>
=A0 =A0 <a href=3D"mailto:majordomo@tycho.nsa.gov" target=3D"_blank">majord=
omo@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:majordomo@tycho.nsa.gov"=
 target=3D"_blank">majordomo@tycho.nsa.<u></u>gov</a>&gt; with<br>
=A0 =A0 the words &quot;unsubscribe selinux&quot; without quotes as the mes=
sage.<br>
<br>
</blockquote>
</blockquote></div>

--00248c768f9eb5715c04c8613d18--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
