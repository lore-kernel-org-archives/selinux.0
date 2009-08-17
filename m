MIME-Version: 1.0
In-Reply-To: <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com>
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com>
Date: Mon, 17 Aug 2009 07:54:28 -0700
Message-ID: <81092d890908170754h76b5b3d7rab139e7759dce09d@mail.gmail.com>
Subject: Re: checking user status
From: Larry Ross <selinux.larry@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0023545bef7020b8c104715794ed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0023545bef7020b8c104715794ed
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Aug 17, 2009 at 7:47 AM, Larry Ross <selinux.larry@gmail.com> wrote:

>  On Mon, Aug 17, 2009 at 5:29 AM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>
>> On Sun, 2009-08-16 at 11:53 -0700, Larry Ross wrote:
>> > Using the RHEL5.3 strict policy I am trying to allow a custom selinux
>> > user permission to use the passwd and chage commands to get the status
>> > of a local user.
>> >
>> > With selinux in permissive it works as expected, with selinux in
>> > enforcing, all I get are cryptic error messages.  I installed the
>> > enableaudit.pp base policy module, still no denials.
>> >
>> > Does anyone know what permissions I need to add or what I could
>> > be doing wrong?  Is this even possible?
>>
>
>  Stephen,
> Thank you for your response.
>
>
>
>> Did you allow the :passwd permission to the custom selinux user's
>> domain?
>
>
>> allow <userdomain> self:passwd { passwd };
>
>
>  I would have if I had know about it, is this documented somewhere?.
>
> That worked for "passwd -S", is there something similar to allow a user to
> use the chage command?
>

Stephen,
  Sorry for the off list reply.  I think I found it: "rootok".  It works,
but I'm not sure what it means.  Could you explain what the rootok
permission means?  Is it intended for this use?

  Thank you,
  Larry



>
>    Thank you,
>    Larry
>
>
>
>>
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>>
>

--0023545bef7020b8c104715794ed
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Aug 17, 2009 at 7:47 AM, Larry Ross <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:selinux.larry@gmail.com">selinux.larry@=
gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"gmail_quote">
<div class=3D"im">On Mon, Aug 17, 2009 at 5:29 AM, Stephen Smalley <span di=
r=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@ty=
cho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>On Sun, 2009-08-16 at 11:53 -0700, Larry Ross wrote:<br>&gt; Using the=
 RHEL5.3 strict policy I am trying to allow a custom selinux<br>&gt; user p=
ermission to use the passwd and chage commands to get the status<br>&gt; of=
 a local user.<br>
&gt;<br>&gt; With selinux in permissive it works as expected, with selinux =
in<br>&gt; enforcing, all I get are cryptic error messages. =A0I installed =
the<br>&gt; enableaudit.pp base policy module, still no denials.<br>&gt;<br=
>
&gt; Does anyone know what permissions I need to add or what I could<br>&gt=
; be doing wrong? =A0Is this even possible?</div></blockquote>
<div>=A0</div></div>
<div>
<div>Stephen,</div>
<div>Thank you for your response.</div>
<div><br>=A0</div></div>
<div class=3D"im">
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Did you allow the :passwd permis=
sion to the custom selinux user&#39;s<br>domain?=A0</blockquote>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>allow &lt;userdomain&gt; sel=
f:passwd { passwd };</blockquote>
<div>=A0</div></div>
<div>
<div>I would have if I had know about it, is this documented somewhere?.=A0=
 </div>
<div>=A0</div>
<div>That worked for &quot;passwd -S&quot;, is there something similar to a=
llow a user to use=A0the chage command?</div></div></div></blockquote>
<div>=A0</div>
<div>Stephen,</div>
<div>=A0 Sorry for the off list reply.=A0 I think I found it: &quot;rootok&=
quot;.=A0 It works, but I&#39;m not sure what it means.=A0 Could you explai=
n what the rootok permission means?=A0 Is it intended for this use?</div>
<div>=A0</div>
<div>=A0 Thank you,</div>
<div>=A0 Larry</div>
<div>=A0</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"gmail_quote">
<div>
<div><span id=3D""></span></div>
<div>=A0</div>
<div>=A0=A0 Thank you,</div>
<div>=A0=A0 Larry</div>
<div>=A0</div></div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span></span><br><font color=3D"=
#888888"><br>--=20
<div class=3D"im"><br>Stephen Smalley<br>National Security Agency<br><br></=
div></font></blockquote></div><br></blockquote></div><br>

--0023545bef7020b8c104715794ed--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
