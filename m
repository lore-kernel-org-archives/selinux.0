MIME-Version: 1.0
In-Reply-To: <55E60EAC.5010602@quarksecurity.com>
References: <1440462367.2737.4.camel@linux.vnet.ibm.com>
 <CALCETrXWBBdOKz-fSdM7YVu_sWQbA3YsHPeZAkRmtj+eawqZGQ@mail.gmail.com>
 <1440464705.2737.36.camel@linux.vnet.ibm.com>
 <14540.1440599584@warthog.procyon.org.uk>
 <31228.1440671938@warthog.procyon.org.uk>
 <36ddb60c1d22756234392a2d065a02cb.squirrel@twosheds.infradead.org>
 <20150827212907.GF8051@wotan.suse.de>
 <CAHC9VhQFDcMtvn1JU3E1rJ=9CCXT7ibUocgGS4tzfcy8oVUUMA@mail.gmail.com>
 <476DC76E7D1DF2438D32BFADF679FC560105ABD6@ORSMSX103.amr.corp.intel.com>
 <CAHC9VhRF-39ZbwawkM-aR+th2nRPEVF9-nR1NEHDPDmakpt4FQ@mail.gmail.com>
 <20150829020301.GM8051@wotan.suse.de>
 <CAHC9VhTTRr7N2bqU-7jm2oG72t5wgqH_SmXk4icqs3h3_=EMzg@mail.gmail.com>
 <55E5B257.6070205@quarksecurity.com>
 <476DC76E7D1DF2438D32BFADF679FC560105E5D3@ORSMSX103.amr.corp.intel.com>
 <55E60EAC.5010602@quarksecurity.com>
Date: Tue, 1 Sep 2015 15:17:40 -0700
Message-ID: <CAFftDdoLNErSHpGOS7m3qfagEpyf_BFTELa6TP8nov+t-QOapg@mail.gmail.com>
Subject: Re: Linux Firmware Signing
From: William Roberts <bill.c.roberts@gmail.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: "Roberts, William C" <william.c.roberts@intel.com>,
 Takashi Iwai <tiwai@suse.de>, Ming Lei <ming.lei@canonical.com>,
 David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "Schaufler, Casey" <casey.schaufler@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Matthew Garrett <mjg59@srcf.ucam.org>,
 Kees Cook <keescook@chromium.org>,
 =?UTF-8?Q?Vojtech_Pavl=C3=ADk?= <vojtech@suse.com>,
 Seth Forshee <seth.forshee@canonical.com>,
 "james.l.morris@oracle.com" <james.l.morris@oracle.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Joey Lee <jlee@suse.de>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Kyle McMartin <kyle@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 David Woodhouse <dwmw2@infradead.org>
Content-Type: multipart/alternative; boundary=001a1135dc781402b9051eb6eb41
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1135dc781402b9051eb6eb41
Content-Type: text/plain; charset=UTF-8

<snip>

> Yes I would say this is low on my end. Especially if we can kill off
>> Reloadable policy support on Android, my need for this goes away 100%.
>>
>>
> I'm not sure who "we" is as you are the only person I've heard advocating
> for removing that support.
>
>
Code support exists, but the ability to reload off of /data is on a
per-device basis. OEMs as of now
can override this. However, this shows a direction that may or may not be
taken on reload from /data.

https://android-review.googlesource.com/#/c/168046/



> The fact that there are so many userspace specific parts of the policy
>>> that never
>>> make it into the kernel precludes any meaningful verification anyway.
>>>
>>
>> Yes and no. On Android, if I was able to load a policy I could grant
>> myself capabilities that
>> We're not possible via the userspace portions, i.e. relabeling, etc.
>> Granted, not checking the
>> userspace portions Is not great. In an ideal world, everything is
>> checked. However, the main
>> reason to doing it in the kernel is where you want your trust to be. For
>> instance, If I trust that
>> userspace Loader, then I need to trust that + the kernel. In the case of
>> verifying the policy signature
>> In the kernel, I need to trust only the kernel.
>>
>
> Especially on Android, userspace files are very important. Changing
> seapp_contexts or property_contexts can easily get you a privilege
> escalation to let you do whatever. Checking only the kernel binary is a
> half-solution and should not even be considered.


I disagree, we can leave it at that.

--001a1135dc781402b9051eb6eb41
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>&lt;snip&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);=
border-left-style:solid;padding-left:1ex"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:=
rgb(204,204,204);border-left-style:solid;padding-left:1ex"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;=
padding-left:1ex"></blockquote></blockquote>
Yes I would say this is low on my end. Especially if we can kill off<br>
Reloadable policy support on Android, my need for this goes away 100%.<br>
<br>
</blockquote>
<br>
I&#39;m not sure who &quot;we&quot; is as you are the only person I&#39;ve =
heard advocating for removing that support.<br>
<br></blockquote><div><br></div><div>Code support exists, but the ability t=
o reload off of /data is on a per-device basis. OEMs as of now</div><div>ca=
n override this. However, this shows a direction that may or may not be tak=
en on reload from /data.</div><div>=C2=A0</div><div><a href=3D"https://andr=
oid-review.googlesource.com/#/c/168046/">https://android-review.googlesourc=
e.com/#/c/168046/</a><br></div><div><br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-l=
eft-style:solid;padding-left:1ex">
The fact that there are so many userspace specific parts of the policy that=
 never<br>
make it into the kernel precludes any meaningful verification anyway.<br>
</blockquote>
<br>
Yes and no. On Android, if I was able to load a policy I could grant myself=
 capabilities that<br>
We&#39;re not possible via the userspace portions, i.e. relabeling, etc. Gr=
anted, not checking the<br>
userspace portions Is not great. In an ideal world, everything is checked. =
However, the main<br>
reason to doing it in the kernel is where you want your trust to be. For in=
stance, If I trust that<br>
userspace Loader, then I need to trust that + the kernel. In the case of ve=
rifying the policy signature<br>
In the kernel, I need to trust only the kernel.<br>
</blockquote>
<br>
Especially on Android, userspace files are very important. Changing seapp_c=
ontexts or property_contexts can easily get you a privilege escalation to l=
et you do whatever. Checking only the kernel binary is a half-solution and =
should not even be considered.</blockquote></div><br clear=3D"all"><div>I d=
isagree, we can leave it at that.=C2=A0</div><div><br></div><div><br></div>=
<div><br></div><div class=3D"gmail_signature"><br></div>
</div></div>

--001a1135dc781402b9051eb6eb41--
