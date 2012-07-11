Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6BKTpO1014062
	for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2012 16:29:51 -0400
Received: by pbbrr13 with SMTP id rr13so2517280pbb.12
        for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2012 13:29:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAO-4OdF09d2sC0y3yFxH81DXAtcGPMhxMLMs9-SYTaJW=CgDhQ@mail.gmail.com>
References: <CAO-4OdF09d2sC0y3yFxH81DXAtcGPMhxMLMs9-SYTaJW=CgDhQ@mail.gmail.com>
Date: Wed, 11 Jul 2012 13:29:50 -0700
Message-ID: <CAFftDdoh4vqLWX2Lv-CEjzCzxDjU39BxSeZoho4A3T6wMa98yQ@mail.gmail.com>
Subject: Re: The order of policies in file "seapp_context"
From: William Roberts <bill.c.roberts@gmail.com>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8ff244cf6f4ab904c493b52a
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff244cf6f4ab904c493b52a
Content-Type: text/plain; charset=ISO-8859-1

Its for the code doing the matching on fork and specialize in zygote, not
the ordering of the lines in the file.

On Wed, Jul 11, 2012 at 1:22 PM, Haiqing Jiang <hqjiang1988@gmail.com>wrote:

> Hi, all,
>
> According to the "Precedence Rules" of seapp contexts, the order of all
> the policies should follow:
> #         (1) isSystemServer=true before isSystemServer=false.
> #         (2) Specified user= string before unspecified user= string.
> #         (3) Fixed user= string before user= prefix (i.e. ending in *).
> #         (4) Longer user= prefix before shorter user= prefix.
> #         (5) Specified seinfo= string before unspecified seinfo= string.
> #         (6) Specified name= string before unspecified name= string.
>
> So, I don't think the current order is correct.
>
> isSystemServer=true domain=system
> user=system domain=system_app type=system_data_file
> user=nfc domain=nfc type=nfc_data_file
> user=radio domain=radio type=radio_data_file
> user=app_* domain=untrusted_app type=app_data_file levelFromUid=true
> user=app_* seinfo=platform domain=platform_app levelFromUid=true
> user=app_* seinfo=shared domain=shared_app levelFromUid=true
> user=app_* seinfo=media domain=media_app levelFromUid=true
> user=app_* seinfo=release domain=release_app levelFromUid=true
> user=app_* seinfo=release name=com.android.browser domain=browser_app
> levelFromUid=true
>
> For example, "user=app_* domain=untrusted_app type=app_data_file
> levelFromUid=true" should
> be the last one. And "user=app_* seinfo=release domain=release_app
> levelFromUid=true" should
> follow behind "user=app_* seinfo=release name=com.android.browser
> domain=browser_app levelFromUid=true".
>
> Could you help me to clarify that???? Thanks a lot.
>
> --
> -----------------------------------
> Haiqing Jiang, PH.D student
>
> Computer Science Department, North Carolina State University
>
>
>


-- 
Respectfully,

William C Roberts

--e89a8ff244cf6f4ab904c493b52a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Its for the code doing the matching on fork and=A0specialize=A0in zygote, n=
ot the ordering of the lines in the file.<br><br><div class=3D"gmail_quote"=
>On Wed, Jul 11, 2012 at 1:22 PM, Haiqing Jiang <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:hqjiang1988@gmail.com" target=3D"_blank">hqjiang1988@gmail.com=
</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi, all,<div><br></div><div>According to the=
 &quot;Precedence Rules&quot; of seapp contexts, the order of all the polic=
ies should follow:</div>
<div><div># =A0 =A0 =A0 =A0 (1) isSystemServer=3Dtrue before isSystemServer=
=3Dfalse.</div><div>
# =A0 =A0 =A0 =A0 (2) Specified user=3D string before unspecified user=3D s=
tring.</div><div># =A0 =A0 =A0 =A0 (3) Fixed user=3D string before user=3D =
prefix (i.e. ending in *).</div><div># =A0 =A0 =A0 =A0 (4) Longer user=3D p=
refix before shorter user=3D prefix.=A0</div>

<div># =A0 =A0 =A0 =A0 (5) Specified seinfo=3D string before unspecified se=
info=3D string.</div><div># =A0 =A0 =A0 =A0 (6) Specified name=3D string be=
fore unspecified name=3D string.</div></div><div><br></div><div>So, I don&#=
39;t think the current order is correct.=A0</div>

<div><br></div><div><div>isSystemServer=3Dtrue domain=3Dsystem</div><div>us=
er=3Dsystem domain=3Dsystem_app type=3Dsystem_data_file</div><div>user=3Dnf=
c domain=3Dnfc type=3Dnfc_data_file</div><div>user=3Dradio domain=3Dradio t=
ype=3Dradio_data_file</div>

<div>user=3Dapp_* domain=3Duntrusted_app type=3Dapp_data_file levelFromUid=
=3Dtrue</div><div>user=3Dapp_* seinfo=3Dplatform domain=3Dplatform_app leve=
lFromUid=3Dtrue</div><div>user=3Dapp_* seinfo=3Dshared domain=3Dshared_app =
levelFromUid=3Dtrue</div>

<div>user=3Dapp_* seinfo=3Dmedia domain=3Dmedia_app levelFromUid=3Dtrue</di=
v><div>user=3Dapp_* seinfo=3Drelease domain=3Drelease_app levelFromUid=3Dtr=
ue</div><div>user=3Dapp_* seinfo=3Drelease name=3Dcom.android.browser domai=
n=3Dbrowser_app levelFromUid=3Dtrue</div>

</div><div><br></div><div>For example, &quot;user=3Dapp_* domain=3Duntruste=
d_app type=3Dapp_data_file levelFromUid=3Dtrue&quot; should</div><div>be th=
e last one. And &quot;user=3Dapp_* seinfo=3Drelease domain=3Drelease_app le=
velFromUid=3Dtrue&quot; should=A0</div>

<div>follow behind &quot;user=3Dapp_* seinfo=3Drelease name=3Dcom.android.b=
rowser domain=3Dbrowser_app levelFromUid=3Dtrue&quot;. =A0=A0</div><div><br=
></div><div>Could you help me to clarify that???? Thanks a lot.=A0</div><sp=
an class=3D"HOEnZb"><font color=3D"#888888"><div>
<br>-- <br>
<div>-----------------------------------</div>Haiqing Jiang, PH.D student<d=
iv><br></div><div>Computer Science Department, North Carolina State Univers=
ity<br><div><br></div></div><br>
</div>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>

--e89a8ff244cf6f4ab904c493b52a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
