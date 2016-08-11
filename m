MIME-Version: 1.0
In-Reply-To: <CAFftDdqs56JXJrhs79zsU6h7_veWFG7nsMrywsNRd8Zg6riSWA@mail.gmail.com>
References: <1470868560-31328-1-git-send-email-william.c.roberts@intel.com>
 <1470868560-31328-5-git-send-email-william.c.roberts@intel.com>
 <a41ef281-f0c6-ebc3-28c3-29d7bfe9bde3@tycho.nsa.gov>
 <CAFftDdqs56JXJrhs79zsU6h7_veWFG7nsMrywsNRd8Zg6riSWA@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 11 Aug 2016 14:22:40 -0700
Message-ID: <CAFftDdpu40pyM+bFd0jN73z7d5fYDA7OTXvvcrm2ewmcVvqcKw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] libsepol: fix overflow and 0 length allocations
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c05aa2aa45e290539d25df9
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c05aa2aa45e290539d25df9
Content-Type: text/plain; charset=UTF-8

<snip>

> Interesting, i'm not seeing these, ill roll these into v3 and see if I can
> reproduce to make sure they
> don't come back.
>

OK, I have them reproduced and fixed for v3. I also have another patch
locally for fixes with the fuzzer
running the longest run yet with no issues (14 hours).

Ill let these patches sit, and aggregate any other comments/concerns and
send out v3 on Monday
August 15


<snip>

--94eb2c05aa2aa45e290539d25df9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>&lt;snip&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);=
border-left-style:solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote"><div><div class=3D"h5"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1e=
x"></blockquote></div></div><div>Interesting, i&#39;m not seeing these, ill=
 roll these into v3 and see if I can reproduce to make sure they</div><div>=
don&#39;t come back.</div></div></div></div></blockquote><div><br></div><di=
v>OK, I have them reproduced and fixed for v3. I also have another patch lo=
cally for fixes with the fuzzer<br>running the longest run yet with no issu=
es (14 hours).<br><br>Ill let these patches sit, and aggregate any other co=
mments/concerns and send out v3 on Monday<br>August 15<br><br></div><div><b=
r></div><div>&lt;snip&gt;<br></div></div>
</div></div>

--94eb2c05aa2aa45e290539d25df9--
