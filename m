MIME-Version: 1.0
In-Reply-To: <CAN1YQdHyo9gJXVcsbSuP7h0Gi2C8ox6mXCofEZZpV5dtO1fkUg@mail.gmail.com>
References: <1459886787-19858-1-git-send-email-jeffv@google.com>
 <8908738.EEDhGzQ6mK@sifl>
 <CABXk95DTRN2gFKTpS6XQXhVaVJKHZ=5YiDQOrOfXFxZ_puvLTg@mail.gmail.com>
 <CAN1YQdHyo9gJXVcsbSuP7h0Gi2C8ox6mXCofEZZpV5dtO1fkUg@mail.gmail.com>
Date: Wed, 6 Apr 2016 05:42:19 -0700
Message-ID: <CAFftDdouyxwppEM9KXqjrez0deN4k8CXztFUrisAYM3poDJFPg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: restrict kernel module loading
From: William Roberts <bill.c.roberts@gmail.com>
To: Dennis Sherrell <sherrellconsulting@gmail.com>
Cc: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov,
 sds@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=001a11c1e7eae59fe8052fd04af6
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c1e7eae59fe8052fd04af6
Content-Type: text/plain; charset=UTF-8

On Apr 6, 2016 03:01, "Dennis Sherrell" <sherrellconsulting@gmail.com>
wrote:
>
> Hello Jeff,
>
> We are a Wireless Consulting Firm conducting research for a U.S. Health
and Human Services Grant. We require Secure Mobile Devices. How much is a
license for Google Android SELinux and where do i go for the config?

It's all open source in the aosp (Android Open Source Project) project.
There is essentially two paths you can go, Android branding and non Android
branding. An example of non-Android branded devices would be Amazon's
Kindle line or the Silent circle black phone. Also there are popular
aftermarket software ROMs based on aosp, like Cyanogenmod.

If you want branding, then you have to go through Google since they own the
brand, they have various programs for that. This page might help provide
more detail: https://source.android.com/compatibility/index.html

The only parts that are generally not available in the open are the
proprietary drivers that bridge Android to the hardware.

You can download aosp at https://source.android.com/source/downloading.html

>
> Dennis Sherrell
> Sherrell Consulting
> Company #136601
> Wireless Security Consultant
> Cisco Certified Wireless Specialist
> DISA Mobile Device Administartor
>
>
> On Tue, Apr 5, 2016, 1:33 PM Jeffrey Vander Stoep <jeffv@google.com>
wrote:
>>>
>>> You're missing the return type :)  No need to resend, I fixed it when
merging
>>> your patch, see the selinux#next branch.
>>
>>
>> Thanks for catching that.
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a11c1e7eae59fe8052fd04af6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Apr 6, 2016 03:01, &quot;Dennis Sherrell&quot; &lt;<a href=3D"mailto:she=
rrellconsulting@gmail.com">sherrellconsulting@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello Jeff,<br>
&gt;<br>
&gt; We are a Wireless Consulting Firm conducting research for a U.S. Healt=
h and Human Services Grant. We require Secure Mobile Devices. How much is a=
 license for Google Android SELinux and where do i go for the config?</p>
<p dir=3D"ltr">It&#39;s all open source in the aosp (Android Open Source Pr=
oject) project. There is essentially two paths you can go, Android branding=
 and non Android branding. An example of non-Android branded devices would =
be Amazon&#39;s Kindle line or the Silent circle black phone. Also there ar=
e popular aftermarket software ROMs based on aosp, like Cyanogenmod.</p>
<p dir=3D"ltr">If you want branding, then you have to go through Google sin=
ce they own the brand, they have various programs for that. This page might=
 help provide more detail: <a href=3D"https://source.android.com/compatibil=
ity/index.html">https://source.android.com/compatibility/index.html</a></p>
<p dir=3D"ltr">The only parts that are generally not available in the open =
are the proprietary drivers that bridge Android to the hardware.</p>
<p dir=3D"ltr">You can download aosp at <a href=3D"https://source.android.c=
om/source/downloading.html">https://source.android.com/source/downloading.h=
tml</a></p>
<p dir=3D"ltr">&gt;<br>
&gt; Dennis Sherrell<br>
&gt; Sherrell Consulting<br>
&gt; Company #136601<br>
&gt; Wireless Security Consultant<br>
&gt; Cisco Certified Wireless Specialist<br>
&gt; DISA Mobile Device Administartor<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Apr 5, 2016, 1:33 PM=C2=A0Jeffrey Vander Stoep &lt;<a href=3D"=
mailto:jeffv@google.com">jeffv@google.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You&#39;re missing the return type :)=C2=A0 No need to resend,=
 I fixed it when merging<br>
&gt;&gt;&gt; your patch, see the selinux#next branch.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks for catching that.<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Selinux mailing list<br>
&gt;&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>=
<br>
&gt;&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tych=
o.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt;&gt; To get help, send an email containing &quot;help&quot; to <a href=
=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>=
.<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</p>

--001a11c1e7eae59fe8052fd04af6--
