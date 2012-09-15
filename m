MIME-Version: 1.0
In-Reply-To: <CABoba9L=N7PGJZXFO75tR4enW7X4JmxVtc6JtzwrbzycjJRgJg@mail.gmail.com>
References: <CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
	<CABoba9L=N7PGJZXFO75tR4enW7X4JmxVtc6JtzwrbzycjJRgJg@mail.gmail.com>
Date: Fri, 14 Sep 2012 18:13:48 -0700
Message-ID: <CAFftDdpj75y+-4szwYnzPTWOVdnNAcqSKYW30Jn7DTrsCtu_bA@mail.gmail.com>
Subject: Re: clean up in android.c
From: William Roberts <bill.c.roberts@gmail.com>
To: Kenny Root <kroot@google.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=14dae9ccd510b1b0bd04c9b34083
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--14dae9ccd510b1b0bd04c9b34083
Content-Type: text/plain; charset=ISO-8859-1

It does not get compiled for non-android systems AFAIK and can tell.

If we can get this data directly without parsing in a guaranteed normalized
way, that would be great....we were hoping that getpwnam's implementation
would normalize it for us, but it does not. So it was either add the logic
to our code or change getpwnam's implementation and we did not know what
the implications of making that change would be.

I looked through system/core/include/private/android_filesystem_config.h
really quick and I don't see how we could get the username in a normalized
way from that, I missed it? I see it specifies the ID's for fixed things in
the system, but it does not specify a way to get username for a generic app.

What we do is normalize the username to app_*, mostly for matching rules in
seapp_contexts. This broke when you can run services in another process
space (android:isolatedProcess<http://developer.android.com/guide/topics/manifest/service-element.html#isolated>
). We normalize that back to the older app_ method and then extract the
number to use as the MLS category.

Bill

On Fri, Sep 14, 2012 at 5:21 PM, Kenny Root <kroot@google.com> wrote:

> It might just be better to provide the information directly. Right now
> getpwnam's implementation is in bionic/libc/bionic/stubs.cpp, but perhaps
> it's worth it to just include
> system/core/include/private/android_filesystem_config.h when available.
> Does this get compiled on non-Android platforms? I'd rather have it just
> get what it needs directly instead of parsing a string.
>
>
> On Fri, Sep 14, 2012 at 5:09 PM, William Roberts <bill.c.roberts@gmail.com
> > wrote:
>
>> Would anyone object to me cleaning up the setcon and setfilecon2 code
>> that does the mls level stuff:
>>
>> Currently the below code is duplicated:
>>
>> pw = getpwuid(uid);
>>  if (!pw)
>> goto err;
>> username = pw->pw_name;
>>
>> if (!strncmp(username, "app_", 4)) {
>> id = strtoul(username + 4, NULL, 10);
>>  if (id >= MLS_CATS)
>> goto err;
>> } else if (username[0] == 'u' && isdigit(username[1])) {
>>  unsigned long unused;
>> unused = strtoul(username+1, &end, 10);
>> if (end[0] != '_')
>>  goto err;
>> id = strtoul(end + 2, NULL, 10);
>> if (id >= MLS_CATS/2)
>>  goto err;
>> if (end[1] == 'i')
>> id += MLS_CATS/2;
>>  else if (end[1] != 'a')
>> goto err;
>> /* use app_ for matching on the user= field */
>>  username = "app_";
>> }
>>
>> I want to break it up into two functions.
>>
>> 1. that gets the normalized username
>> 2. that computes the id, takes username, returns -1 on error
>>
>>
>> This way of the username stuff changes again in the future, we can
>> normalize it one spot. The one that computes the id doesn't gain much by
>> putting it in a function, but I think it will make the code more readable.
>>
>> --
>> Respectfully,
>>
>> William C Roberts
>>
>>
>>
>
>
> --
>
> Kenny Root
>



-- 
Respectfully,

William C Roberts

--14dae9ccd510b1b0bd04c9b34083
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

It does not get compiled for non-android systems AFAIK and can tell.<div><b=
r></div><div>If we can get this data directly without parsing in a=A0guaran=
teed=A0normalized way, that would be great....we were hoping that=A0getpwna=
m&#39;s implementation would normalize it for us, but it does not. So it wa=
s either add the logic to our code or change=A0getpwnam&#39;s implementatio=
n and we did not know what the implications of making that change would be.=
</div>
<div><br></div><div>I looked through=A0system/core/include/private/android_=
filesystem_config.h really quick and I don&#39;t see how we could get the u=
sername in a normalized way from that, I missed it? I see it specifies the =
ID&#39;s for fixed things in the system, but it does not specify a way to g=
et username for a generic app.</div>
<div><br></div><div>What we do is normalize the username to app_*, mostly f=
or matching rules in seapp_contexts. This broke when you can run services i=
n another process space (<span class=3D"atn" style=3D"font-family:&#39;cour=
ier new&#39;,courier,monospace;font-size:14px;line-height:1.5;color:rgb(136=
,34,136)">android:</span><span class=3D"atn" style=3D"font-family:&#39;cour=
ier new&#39;,courier,monospace;font-size:14px;line-height:1.5;text-decorati=
on:none;color:rgb(136,34,136)"><a href=3D"http://developer.android.com/guid=
e/topics/manifest/service-element.html#isolated" style=3D"font-family:&#39;=
courier new&#39;,courier,monospace;font-size:14px;line-height:1.5;color:rgb=
(37,138,175);text-decoration:none">isolatedProcess</a>)</span>. We normaliz=
e that back to the older app_ method and then extract the number to use as =
the MLS category.</div>
<div><br></div><div>Bill<br><br><div class=3D"gmail_quote">On Fri, Sep 14, =
2012 at 5:21 PM, Kenny Root <span dir=3D"ltr">&lt;<a href=3D"mailto:kroot@g=
oogle.com" target=3D"_blank">kroot@google.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
It might just be better to provide the information directly. Right now getp=
wnam&#39;s implementation is in bionic/libc/bionic/stubs.cpp, but perhaps i=
t&#39;s worth it to just include system/core/include/private/android_filesy=
stem_config.h when available. Does this get compiled on non-Android platfor=
ms? I&#39;d rather have it just get what it needs directly instead of parsi=
ng a string.<div class=3D"HOEnZb">
<div class=3D"h5"><br>
<br><div class=3D"gmail_quote">On Fri, Sep 14, 2012 at 5:09 PM, William Rob=
erts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" targ=
et=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">

Would anyone object to me cleaning up the setcon and setfilecon2 code that =
does the mls level stuff:<div><br></div><div>Currently the below code is du=
plicated:</div><div><br></div><div><div><span style=3D"white-space:pre-wrap=
">	</span>pw =3D getpwuid(uid);</div>


<div><span style=3D"white-space:pre-wrap">	</span>if (!pw)</div><div><span =
style=3D"white-space:pre-wrap">		</span>goto err;</div><div><span style=3D"=
white-space:pre-wrap">	</span>username =3D pw-&gt;pw_name;</div>
<div><br></div><div><span style=3D"white-space:pre-wrap">	</span>if (!strnc=
mp(username, &quot;app_&quot;, 4)) {</div><div><span style=3D"white-space:p=
re-wrap">		</span>id =3D strtoul(username + 4, NULL, 10);</div>
<div><span style=3D"white-space:pre-wrap">		</span>if (id &gt;=3D MLS_CATS)=
</div><div><span style=3D"white-space:pre-wrap">			</span>goto err;</div><d=
iv><span style=3D"white-space:pre-wrap">	</span>} else if (username[0] =3D=
=3D &#39;u&#39; &amp;&amp; isdigit(username[1])) {</div>


<div><span style=3D"white-space:pre-wrap">		</span>unsigned long unused;</d=
iv><div><span style=3D"white-space:pre-wrap">		</span>unused =3D strtoul(us=
ername+1, &amp;end, 10);</div><div><span style=3D"white-space:pre-wrap">		<=
/span>if (end[0] !=3D &#39;_&#39;)</div>


<div><span style=3D"white-space:pre-wrap">			</span>goto err;</div><div><sp=
an style=3D"white-space:pre-wrap">		</span>id =3D strtoul(end + 2, NULL, 10=
);</div><div><span style=3D"white-space:pre-wrap">		</span>if (id &gt;=3D M=
LS_CATS/2)</div>


<div><span style=3D"white-space:pre-wrap">			</span>goto err;</div><div><sp=
an style=3D"white-space:pre-wrap">		</span>if (end[1] =3D=3D &#39;i&#39;)</=
div><div><span style=3D"white-space:pre-wrap">			</span>id +=3D MLS_CATS/2;=
</div>
<div><span style=3D"white-space:pre-wrap">		</span>else if (end[1] !=3D &#3=
9;a&#39;)</div><div><span style=3D"white-space:pre-wrap">			</span>goto err=
;</div><div><span style=3D"white-space:pre-wrap">		</span>/* use app_ for m=
atching on the user=3D field */</div>


<div><span style=3D"white-space:pre-wrap">		</span>username =3D &quot;app_&=
quot;;</div><div><span style=3D"white-space:pre-wrap">	</span>}</div></div>=
<div><br></div><div>I want to break it up into two functions.</div>
<div><br></div><div>1. that gets the normalized username</div><div>2. that =
computes the id, takes username, returns -1 on error</div><div><br></div><d=
iv><div><br></div><div>This way of the username stuff changes again in the =
future, we can normalize it one spot. The one that computes the id doesn&#3=
9;t gain much by putting it in a function, but I think it will make the cod=
e more readable.</div>

<span><font color=3D"#888888">
<div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div></div></div><span c=
lass=3D"HOEnZb"><font color=3D"#888888">-- <br><br>Kenny Root<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--14dae9ccd510b1b0bd04c9b34083--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
