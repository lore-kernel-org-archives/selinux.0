MIME-Version: 1.0
In-Reply-To: <CAOFt0CQ5dV1c-87A+0nBk53xqxGB0FJCW0L4Koeb_7CXag0b8Q@mail.gmail.com>
References: <CAOFt0CQYn+Sku39NOHn4ggX1_8O3y6uvZLtfS1_TQJhirANfNQ@mail.gmail.com>
 <5311E855.1070608@quarksecurity.com>
 <CAOFt0CQ5dV1c-87A+0nBk53xqxGB0FJCW0L4Koeb_7CXag0b8Q@mail.gmail.com>
Date: Sat, 1 Mar 2014 18:13:30 +0100
Message-ID: <CAOFt0CTt=w6zWM0dkjL-YGKM_y3-a18O1KPAQkgiYY5+DUYrwg@mail.gmail.com>
Subject: Re: What is Type Enforcement Model in SELinux?
From: Kernel freak <kernelfreak@gmail.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Content-Type: multipart/alternative; boundary=001a11c364ba736d4204f38eac51
Cc: "selinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c364ba736d4204f38eac51
Content-Type: text/plain; charset=ISO-8859-1

Hello Friends,
                    I had already read the *inevitability* paper before, so
I went to the next paper as mentioned by Branden. Unfortunately, it
discusses TE ACM and TE policies.
As for the flask papers, SELinux inherits FLASK features, but nothing
relevant to TE model was found.
I am still looking for an explanation for this, anything more would be
helpful. Thank you very much for your time and patience guys.


On Sat, Mar 1, 2014 at 3:08 PM, Kernel freak <kernelfreak@gmail.com> wrote:

> Hello all,
>                   Thank you very much for the information. I will read and
> get back. You were right Joshua, I cannot find a description of the model.
>
>
> On Sat, Mar 1, 2014 at 3:01 PM, Joshua Brindle <brindle@quarksecurity.com>wrote:
>
>> Kernel freak wrote:
>>
>>> Hello Friends,
>>>                       I am writing a report and I need to write about TE
>>> model in SELinux. I searched around the net, but all the articles I read
>>> beat around the bush and never say like ok, this is TE model for SELinux.
>>> Can anyone be so kind and please point me out to some links which say
>>> about TE model in SELinux and if possible an appropriate model. Thank
>>> you for your time and patience.
>>>
>>>
>> You are probably having problems finding a succinct description of the
>> model because, to my knowledge, there is no complete description as it
>> exists today.
>>
>> I'm sure Stephen will have other suggestions but you can start with the
>> old Flask papers:
>> http://www.cs.utah.edu/flux/fluke/html/flask.html
>>
>> The type enforcement access matrix model hasn't much changed since then
>> but various things related to what that means on a system have (such as
>> constraints, network access control, named transitions) evolved over time.
>>
>
>

--001a11c364ba736d4204f38eac51
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello Friends,<br></div>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I had already read the <i>inevitabi=
lity</i> paper before, so I went to the next paper as mentioned by Branden.=
 Unfortunately, it discusses TE ACM and TE policies. <br>
</div>As for the flask papers, SELinux inherits FLASK features, but nothing=
 relevant to TE model was found. <br></div>I am still looking for an explan=
ation for this, anything more would be helpful. Thank you very much for you=
r time and patience guys.<br>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Sat,=
 Mar 1, 2014 at 3:08 PM, Kernel freak <span dir=3D"ltr">&lt;<a href=3D"mail=
to:kernelfreak@gmail.com" target=3D"_blank">kernelfreak@gmail.com</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hello all,<br></div>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Thank you very much for=
 the information. I will read and get back. You were right Joshua, I cannot=
 find a description of the model. <br>
</div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra">
<br><br><div class=3D"gmail_quote">On Sat, Mar 1, 2014 at 3:01 PM, Joshua B=
rindle <span dir=3D"ltr">&lt;<a href=3D"mailto:brindle@quarksecurity.com" t=
arget=3D"_blank">brindle@quarksecurity.com</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">

<div><div>Kernel freak wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello Friends,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I am writing a report and I nee=
d to write about TE<br>
model in SELinux. I searched around the net, but all the articles I read<br=
>
beat around the bush and never say like ok, this is TE model for SELinux.<b=
r>
Can anyone be so kind and please point me out to some links which say<br>
about TE model in SELinux and if possible an appropriate model. Thank<br>
you for your time and patience.<br>
<br>
</blockquote>
<br></div></div>
You are probably having problems finding a succinct description of the mode=
l because, to my knowledge, there is no complete description as it exists t=
oday.<br>
<br>
I&#39;m sure Stephen will have other suggestions but you can start with the=
 old Flask papers:<br>
<a href=3D"http://www.cs.utah.edu/flux/fluke/html/flask.html" target=3D"_bl=
ank">http://www.cs.utah.edu/flux/<u></u>fluke/html/flask.html</a><br>
<br>
The type enforcement access matrix model hasn&#39;t much changed since then=
 but various things related to what that means on a system have (such as co=
nstraints, network access control, named transitions) evolved over time.<br=
>


</blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a11c364ba736d4204f38eac51--
