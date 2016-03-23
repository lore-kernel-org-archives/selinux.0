MIME-Version: 1.0
References: <CAN=9EoR_QojJRY6egdWUQQHemEwxBKNdQE+6Lc7TdHboPeKDEQ@mail.gmail.com>
 <CAN=9EoQn6o+YY=jfxQJ_HOQbxv1=7a_brQkEyQ-+YpBOBv=VZA@mail.gmail.com>
 <56F1A180.8080104@tycho.nsa.gov> <56F24A34.6060404@redhat.com>
In-Reply-To: <56F24A34.6060404@redhat.com>
From: Dennis Sherrell <sherrellconsulting@gmail.com>
Date: Wed, 23 Mar 2016 09:29:50 +0000
Message-ID: <CAN1YQdFZNH-vwcySEQnTzUEiA0UN8ydA+you5uk4=zpr4WcPeA@mail.gmail.com>
Subject: Re: selinux-query
To: Miroslav Grepl <mgrepl@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Naina Emmanuel <nemmanuel1992@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113b024846e352052eb3f902
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113b024846e352052eb3f902
Content-Type: text/plain; charset=UTF-8

Miroslav,

We are intetested in the approved SELinux config listed in the NSA
Commercial Solutions for Classified Program.

Our goal is to eventually conduct research as a NISP Corporation. How do we
get hardcopies of sourced software and policies for Information Assurance?

Dennis Sherrell
Sherrell Consulting
Company #136601
Cisco Certified Wireless Specialist

On Wed, Mar 23, 2016, 12:56 AM Miroslav Grepl <mgrepl@redhat.com> wrote:

> On 03/22/2016 08:48 PM, Stephen Smalley wrote:
> > On 03/22/2016 01:51 PM, Naina Emmanuel wrote:
> >> Good evening!
> >> i am working on selinux, centos 7... i have downloaded some .te files
> >> from the internet (squid.te, ftp.te, rpc.te, samba.te .. etc)
> >> but when i compile these .te file through #make -f
> >> /usr/share/selinux/devel/include/MakeFile but shows error in all
> >> mentioned .te files
> >> not even getting installed through #semodule -i ftp.pp   (for all
> >> mentioned .te files) plz help me regarding this..
> >> thanks in advanced
> >
> > Please show the actual commands that you ran, and the actual error
> > output from those commands.
> >
> > However, downloading random .te files from the Internet and expecting
> > them to build or install on your system is probably not a good strategy.
> >  On CentOS, you should be able to download the .src.rpm file for
> > selinux-policy-targeted and work with the files it contains in order to
> > ensure that they match your base policy.
>
> Even more if you want to replace a module shipped by a distribution
> policy and you will miss some definitions which are used in other
> modules, you will also fail.
>
> So I would go with .src.rpm how Stephen wrote above. You can ask on
> selinux@lists.fedoraproject.org for more details.
>
> Thanks.
>
> >
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
> >
>
>
> --
> Miroslav Grepl
> Senior Software Engineer, SELinux Solutions
> Red Hat, Inc.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a113b024846e352052eb3f902
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Miroslav,</div><span>
</span><div><br></div><div>We are intetested in the approved SELinux config=
 listed in the NSA Commercial Solutions for Classified Program.</div><div><=
br></div><div>Our goal is to eventually conduct research as a NISP Corporat=
ion. How do we get hardcopies of sourced software and policies for Informat=
ion Assurance?</div><div><br></div><div>Dennis Sherrell</div><div>Sherrell =
Consulting</div><div>Company #136601</div><div>Cisco Certified Wireless Spe=
cialist</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Mar 23=
, 2016, 12:56 AM=C2=A0Miroslav Grepl &lt;<a href=3D"mailto:mgrepl@redhat.co=
m" target=3D"_blank">mgrepl@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">On 03/22/2016 08:48 PM, Stephen Smalley wrote:<br>
&gt; On 03/22/2016 01:51 PM, Naina Emmanuel wrote:<br>
&gt;&gt; Good evening!<br>
&gt;&gt; i am working on selinux, centos 7... i have downloaded some .te fi=
les<br>
&gt;&gt; from the internet (squid.te, ftp.te, rpc.te, samba.te .. etc)<br>
&gt;&gt; but when i compile these .te file through #make -f<br>
&gt;&gt; /usr/share/selinux/devel/include/MakeFile but shows error in all<b=
r>
&gt;&gt; mentioned .te files<br>
&gt;&gt; not even getting installed through #semodule -i ftp.pp=C2=A0 =C2=
=A0(for all<br>
&gt;&gt; mentioned .te files) plz help me regarding this..<br>
&gt;&gt; thanks in advanced<br>
&gt;<br>
&gt; Please show the actual commands that you ran, and the actual error<br>
&gt; output from those commands.<br>
&gt;<br>
&gt; However, downloading random .te files from the Internet and expecting<=
br>
&gt; them to build or install on your system is probably not a good strateg=
y.<br>
&gt;=C2=A0 On CentOS, you should be able to download the .src.rpm file for<=
br>
&gt; selinux-policy-targeted and work with the files it contains in order t=
o<br>
&gt; ensure that they match your base policy.<br>
<br>
Even more if you want to replace a module shipped by a distribution<br>
policy and you will miss some definitions which are used in other<br>
modules, you will also fail.<br>
<br>
So I would go with .src.rpm how Stephen wrote above. You can ask on<br>
<a href=3D"mailto:selinux@lists.fedoraproject.org" target=3D"_blank">selinu=
x@lists.fedoraproject.org</a> for more details.<br>
<br>
Thanks.<br>
<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tyc=
ho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tych=
o.nsa.gov</a>.<br>
&gt;<br>
<br>
<br>
--<br>
Miroslav Grepl<br>
Senior Software Engineer, SELinux Solutions<br>
Red Hat, Inc.<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</blockquote></div>

--001a113b024846e352052eb3f902--
