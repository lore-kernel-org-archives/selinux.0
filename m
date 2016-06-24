MIME-Version: 1.0
In-Reply-To: <CABXk95BLUdqSFf+ijNd=TmHMbf9+U8vj4WuKPMvHgFCvL9KD9g@mail.gmail.com>
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
 <395eab36-6606-ff45-ee57-959538a58d65@tycho.nsa.gov>
 <CABXk95BLUdqSFf+ijNd=TmHMbf9+U8vj4WuKPMvHgFCvL9KD9g@mail.gmail.com>
From: Ravi Kumar <nxp.ravi@gmail.com>
Date: Fri, 24 Jun 2016 21:48:20 +0530
Message-ID: <CACikiw3ko5hOg=uo=r33K1V1d0OHGPXi5KNWwbuYZ57q0Rh76Q@mail.gmail.com>
Subject: Re: New rules on restrict kernel module loading
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, seandroid-list@tycho.nsa.gov,
 SELinux <Selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=089e0122e9bcf062d40536088467
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e0122e9bcf062d40536088467
Content-Type: text/plain; charset=UTF-8

Thanks Stephen and Jeffrey  that  really helped.

Regards,
Ravi

On Thu, Jun 23, 2016 at 10:59 PM, Jeffrey Vander Stoep <jeffv@google.com>
wrote:

> Here's an example migrating code from init_module to finit_module:
> https://android-review.googlesource.com/#/c/210691/
>
> On Thu, Jun 23, 2016 at 10:22 AM Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>
>> On 06/22/2016 03:02 PM, Jeffrey Vander Stoep wrote:
>> > selinux@tycho.nsa.gov <mailto:selinux@tycho.nsa.gov> to bcc
>> >
>> > Hi Ravi,
>> >
>> > The intent is not to restrict which processes may load modules, but to
>> > place restrictions on the origin of the module itself. Modules, like the
>> > kernel, should live on a verity protected partition.
>> >
>> > If you want system apps to load a kernel module from the system
>> > partition you just need to add an allow rule. e.g.
>> >
>> > # system_app loads /system/lib/module/wlan.ko
>> > allow system_app system_file:system module_load;
>> >
>> > Similar rules may be added for platform_app or system_server.
>>
>> Actually, that probably won't work for any app domains, as they can't
>> pass the sys_module capability check.  So hopefully you only truly need
>> it for system_server.
>>
>>
>>
>>

--089e0122e9bcf062d40536088467
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Stephen and Jeffrey =C2=A0that =C2=A0really helped.=
<div><br></div><div>Regards,<br>Ravi=C2=A0</div></div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Thu, Jun 23, 2016 at 10:59 PM, Jeff=
rey Vander Stoep <span dir=3D"ltr">&lt;<a href=3D"mailto:jeffv@google.com" =
target=3D"_blank">jeffv@google.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div dir=3D"ltr">Here&#39;s an example migrating code from =
init_module to finit_module: <a href=3D"https://android-review.googlesource=
.com/#/c/210691/" target=3D"_blank">https://android-review.googlesource.com=
/#/c/210691/</a></div><div class=3D"HOEnZb"><div class=3D"h5"><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr">On Thu, Jun 23, 2016 at 10:22 AM Stephen=
 Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tyc=
ho.nsa.gov</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 06/22=
/2016 03:02 PM, Jeffrey Vander Stoep wrote:<br>
&gt; <a href=3D"mailto:selinux@tycho.nsa.gov" target=3D"_blank">selinux@tyc=
ho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:selinux@tycho.nsa.gov" target=
=3D"_blank">selinux@tycho.nsa.gov</a>&gt; to bcc<br>
&gt;<br>
&gt; Hi Ravi,<br>
&gt;<br>
&gt; The intent is not to restrict which processes may load modules, but to=
<br>
&gt; place restrictions on the origin of the module itself. Modules, like t=
he<br>
&gt; kernel, should live on a verity protected partition.<br>
&gt;<br>
&gt; If you want system apps to load a kernel module from the system<br>
&gt; partition you just need to add an allow rule. e.g.<br>
&gt;<br>
&gt; # system_app loads /system/lib/module/wlan.ko<br>
&gt; allow system_app system_file:system module_load;<br>
&gt;<br>
&gt; Similar rules may be added for platform_app or system_server.<br>
<br>
Actually, that probably won&#39;t work for any app domains, as they can&#39=
;t<br>
pass the sys_module capability check.=C2=A0 So hopefully you only truly nee=
d<br>
it for system_server.<br>
<br>
<br>
<br>
</blockquote></div>
</div></div></blockquote></div><br></div>

--089e0122e9bcf062d40536088467--
