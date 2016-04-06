MIME-Version: 1.0
In-Reply-To: <CAFftDdouyxwppEM9KXqjrez0deN4k8CXztFUrisAYM3poDJFPg@mail.gmail.com>
References: <1459886787-19858-1-git-send-email-jeffv@google.com>
 <8908738.EEDhGzQ6mK@sifl>
 <CABXk95DTRN2gFKTpS6XQXhVaVJKHZ=5YiDQOrOfXFxZ_puvLTg@mail.gmail.com>
 <CAN1YQdHyo9gJXVcsbSuP7h0Gi2C8ox6mXCofEZZpV5dtO1fkUg@mail.gmail.com>
 <CAFftDdouyxwppEM9KXqjrez0deN4k8CXztFUrisAYM3poDJFPg@mail.gmail.com>
Date: Wed, 6 Apr 2016 06:16:35 -0700
Message-ID: <CAFftDdps15z=+LcmwT+1kavf8g4b0PcHwjgD088qArTE-Wg0gw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: restrict kernel module loading
From: William Roberts <bill.c.roberts@gmail.com>
To: Dennis Sherrell <sherrellconsulting@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 Jeff Vander Stoep <jeffv@google.com>, Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=047d7b3a953e7850e3052fd0c530
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b3a953e7850e3052fd0c530
Content-Type: text/plain; charset=UTF-8

On Apr 6, 2016 5:42 AM, "William Roberts" <bill.c.roberts@gmail.com> wrote:
>
>
> On Apr 6, 2016 03:01, "Dennis Sherrell" <sherrellconsulting@gmail.com>
wrote:
> >
> > Hello Jeff,
> >
> > We are a Wireless Consulting Firm conducting research for a U.S. Health
and Human Services Grant. We require Secure Mobile Devices. How much is a
license for Google Android SELinux and where do i go for the config?
>
> It's all open source in the aosp (Android Open Source Project) project.
There is essentially two paths you can go, Android branding and non Android
branding. An example of non-Android branded devices would be Amazon's
Kindle line or the Silent circle black phone. Also there are popular
aftermarket software ROMs based on aosp, like Cyanogenmod.
>
> If you want branding, then you have to go through Google since they own
the brand, they have various programs for that. This page might help
provide more detail: https://source.android.com/compatibility/index.html
>
> The only parts that are generally not available in the open are the
proprietary drivers that bridge Android to the hardware.
>
> You can download aosp at
https://source.android.com/source/downloading.html
>

FYI This question is off topic to the thread and mailing list. In the
future post a new topic to the seandroid mailing list.

> >
> > Dennis Sherrell
> > Sherrell Consulting
> > Company #136601
> > Wireless Security Consultant
> > Cisco Certified Wireless Specialist
> > DISA Mobile Device Administartor
> >
> >
> > On Tue, Apr 5, 2016, 1:33 PM Jeffrey Vander Stoep <jeffv@google.com>
wrote:
> >>>
> >>> You're missing the return type :)  No need to resend, I fixed it when
merging
> >>> your patch, see the selinux#next branch.
> >>
> >>
> >> Thanks for catching that.
> >>
> >> _______________________________________________
> >> Selinux mailing list
> >> Selinux@tycho.nsa.gov
> >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.
> >
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--047d7b3a953e7850e3052fd0c530
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Apr 6, 2016 5:42 AM, &quot;William Roberts&quot; &lt;<a href=3D"mailto:b=
ill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Apr 6, 2016 03:01, &quot;Dennis Sherrell&quot; &lt;<a href=3D"mailt=
o:sherrellconsulting@gmail.com">sherrellconsulting@gmail.com</a>&gt; wrote:=
<br>
&gt; &gt;<br>
&gt; &gt; Hello Jeff,<br>
&gt; &gt;<br>
&gt; &gt; We are a Wireless Consulting Firm conducting research for a U.S. =
Health and Human Services Grant. We require Secure Mobile Devices. How much=
 is a license for Google Android SELinux and where do i go for the config?<=
br>
&gt;<br>
&gt; It&#39;s all open source in the aosp (Android Open Source Project) pro=
ject. There is essentially two paths you can go, Android branding and non A=
ndroid branding. An example of non-Android branded devices would be Amazon&=
#39;s Kindle line or the Silent circle black phone. Also there are popular =
aftermarket software ROMs based on aosp, like Cyanogenmod.<br>
&gt;<br>
&gt; If you want branding, then you have to go through Google since they ow=
n the brand, they have various programs for that. This page might help prov=
ide more detail: <a href=3D"https://source.android.com/compatibility/index.=
html">https://source.android.com/compatibility/index.html</a><br>
&gt;<br>
&gt; The only parts that are generally not available in the open are the pr=
oprietary drivers that bridge Android to the hardware.<br>
&gt;<br>
&gt; You can download aosp at <a href=3D"https://source.android.com/source/=
downloading.html">https://source.android.com/source/downloading.html</a><br=
>
&gt;</p>
<p dir=3D"ltr">FYI This question is off topic to the thread and mailing lis=
t. In the future post a new topic to the seandroid mailing list.</p>
<p dir=3D"ltr">&gt; &gt;<br>
&gt; &gt; Dennis Sherrell<br>
&gt; &gt; Sherrell Consulting<br>
&gt; &gt; Company #136601<br>
&gt; &gt; Wireless Security Consultant<br>
&gt; &gt; Cisco Certified Wireless Specialist<br>
&gt; &gt; DISA Mobile Device Administartor<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Apr 5, 2016, 1:33 PM=C2=A0Jeffrey Vander Stoep &lt;<a hre=
f=3D"mailto:jeffv@google.com">jeffv@google.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; You&#39;re missing the return type :)=C2=A0 No need to re=
send, I fixed it when merging<br>
&gt; &gt;&gt;&gt; your patch, see the selinux#next branch.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks for catching that.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; Selinux mailing list<br>
&gt; &gt;&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.go=
v</a><br>
&gt; &gt;&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave=
@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt;&gt; To get help, send an email containing &quot;help&quot; to <a =
href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov=
</a>.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Selinux mailing list<br>
&gt; &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a=
><br>
&gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tyc=
ho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; To get help, send an email containing &quot;help&quot; to <a href=
=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>=
.<br>
</p>

--047d7b3a953e7850e3052fd0c530--
