Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6I0MMXL000644
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2012 20:22:22 -0400
Received: by pbbrr13 with SMTP id rr13so1593760pbb.12
        for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2012 17:22:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <33006C99F5A5194A9B7A7715DFA3E3836507E650@ALA-MBB.corp.ad.wrs.com>
References: <CAFftDdrefoeyaFQsr-OXQdAXU9CRgvqbMg+gZ+WUEuRnb2dfEQ@mail.gmail.com>
	<33006C99F5A5194A9B7A7715DFA3E3836507E650@ALA-MBB.corp.ad.wrs.com>
Date: Tue, 17 Jul 2012 17:22:19 -0700
Message-ID: <CAFftDdr+4CT-MgMoTUOtkeM3rBGw1S7s1N7evE7JXf9E=9meQA@mail.gmail.com>
Subject: Re: Change-Id: I61d34a9fd6975f23023f70f205a510e3357d843c
From: William Roberts <bill.c.roberts@gmail.com>
To: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        rpcraig <rpcraig@tycho.ncsc.mil>
Content-Type: multipart/alternative; boundary=047d7b10ce63ee48e404c50fa703
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b10ce63ee48e404c50fa703
Content-Type: text/plain; charset=ISO-8859-1

Yes, it took me a few minutes to realize it was in mac-policy today after
the "merge" with master. It doesn't make sense there.

Any thoughts on breaking up the change id?

On Tue, Jul 17, 2012 at 5:20 PM, Radzykewycz, T (Radzy) <radzy@windriver.com
> wrote:

> > I am also wondering if we really need mac_permisions.xml to be
> > in in it's own repo. I think it should be in sepolicy since it
> > is part of the policy of the device, like seapp_contexts.
>
> I would like to see all policy be contained within a single git project.
>  It
> could be divided into subdirectories, such as external/sepolicy/base and
> external/sepolicy/mmac or something.  But having it all in one place
> would be more convenient for overall system policy analysis.
>
> ________________________________________
> From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf
> of William Roberts [bill.c.roberts@gmail.com]
> Sent: Tuesday, July 17, 2012 4:43 PM
> To: selinux@tycho.nsa.gov
> Cc: rpcraig
> Subject: Change-Id: I61d34a9fd6975f23023f70f205a510e3357d843c
>
> I think we need to discuss this change id further.
> Commit sha b263780156624c38b23d638be6a2d8bdd17511f8 on master
> selinuxproject/master.
>
> It really provides two functions:
>
> 1. x.509 cert to seinfo string mapping for seapp_contexts so the zygote
> spawns it in the right domain...
> 2. install time permission checking
>
> I think these should be submitted as two different patch sets to AOSP
> respective of their functionality. I think the x.509 cert checks will get
> pulled in and I am not sure on the install time permission checking.
>
> I am also wondering if we really need mac_permisions.xml to be in in it's
> own repo. I think it should be in sepolicy since it is part of the policy
> of the device, like seapp_contexts.
>
> What are the communities opinions on these comments?
>
> --
> Respectfully,
>
> William C Roberts
>
>
>


-- 
Respectfully,

William C Roberts

--047d7b10ce63ee48e404c50fa703
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes, it took me a few minutes to realize it was in mac-policy today after t=
he &quot;merge&quot; with master. It doesn&#39;t make sense there.<div><br>=
</div><div>Any thoughts on breaking up the change id?<br><br><div class=3D"=
gmail_quote">
On Tue, Jul 17, 2012 at 5:20 PM, Radzykewycz, T (Radzy) <span dir=3D"ltr">&=
lt;<a href=3D"mailto:radzy@windriver.com" target=3D"_blank">radzy@windriver=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">&gt; I am also wondering if we really need mac_permisions=
.xml to be<br>
&gt; in in it&#39;s own repo. I think it should be in sepolicy since it<br>
&gt; is part of the policy of the device, like seapp_contexts.<br>
<br>
</div>I would like to see all policy be contained within a single git proje=
ct. =A0It<br>
could be divided into subdirectories, such as external/sepolicy/base and<br=
>
external/sepolicy/mmac or something. =A0But having it all in one place<br>
would be more convenient for overall system policy analysis.<br>
<br>
________________________________________<br>
From: <a href=3D"mailto:owner-selinux@tycho.nsa.gov">owner-selinux@tycho.ns=
a.gov</a> [<a href=3D"mailto:owner-selinux@tycho.nsa.gov">owner-selinux@tyc=
ho.nsa.gov</a>] on behalf of William Roberts [<a href=3D"mailto:bill.c.robe=
rts@gmail.com">bill.c.roberts@gmail.com</a>]<br>

Sent: Tuesday, July 17, 2012 4:43 PM<br>
To: <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a><br>
Cc: rpcraig<br>
Subject: Change-Id: I61d34a9fd6975f23023f70f205a510e3357d843c<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
I think we need to discuss this change id further.<br>
Commit sha b263780156624c38b23d638be6a2d8bdd17511f8 on master selinuxprojec=
t/master.<br>
<br>
It really provides two functions:<br>
<br>
1. x.509 cert to seinfo string mapping for seapp_contexts so the zygote spa=
wns it in the right domain...<br>
2. install time permission checking<br>
<br>
I think these should be submitted as two different patch sets to AOSP respe=
ctive of their functionality. I think the x.509 cert checks will get pulled=
 in and I am not sure on the install time permission checking.<br>
<br>
I am also wondering if we really need mac_permisions.xml to be in in it&#39=
;s own repo. I think it should be in sepolicy since it is part of the polic=
y of the device, like seapp_contexts.<br>
<br>
What are the communities opinions on these comments?<br>
<br>
--<br>
Respectfully,<br>
<br>
William C Roberts<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--047d7b10ce63ee48e404c50fa703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
