MIME-Version: 1.0
In-Reply-To: <1264617201.17372.2.camel@moss-pluto.epoch.ncsc.mil>
References: <bb74313d1001261320n8694abel857f6eba1066c560@mail.gmail.com>
	 <1264541641.19890.77.camel@moss-pluto.epoch.ncsc.mil>
	 <1264542993.19890.88.camel@moss-pluto.epoch.ncsc.mil>
	 <bb74313d1001270640s43b6c88dmafdb6aa9d3cf3015@mail.gmail.com>
	 <1264617201.17372.2.camel@moss-pluto.epoch.ncsc.mil>
Date: Sat, 30 Jan 2010 12:03:18 +0330
Message-ID: <bb74313d1001300033g189165b9t7705614dcab0ced3@mail.gmail.com>
Subject: Re: access decision API
From: michel m <michel.mcgregor@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=00504502d497a94d62047e5d9a1c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504502d497a94d62047e5d9a1c
Content-Type: text/plain; charset=ISO-8859-1

as the last question,
what I need, is to ask the security server if a data residing in userspace
owning a context, can be written to a file in OS.
does it make sense if I do it in this way :
    avc_has_perm(data_sid  ,file_sid,  SECLASS_FILE , null, null)

I am confused, because I guessed using such a syntax means if a process is
able to write to file, but here we are going to check if data can be *written
*to file.

if everything ok, how the action is specified, that is write?
Regards.


On Wed, Jan 27, 2010 at 10:03 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2010-01-27 at 18:10 +0330, michel m wrote:
> > thanks for guidance, but here I am with a question. what should be
> > used as object class in avc_has_perm(3) when using it for
> > inter-object. is there any sample for inter-object access decision?
> > can it be null?
> >
> > on the other hand, access decision taken by avc_has_perm(), does it
> > include MLS too?
>
> Yes, the avc_has_perm() or security_compute_av() decision takes into
> account all policy models implemented within the security server,
> including RBAC, TE, and MLS.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--00504502d497a94d62047e5d9a1c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

as the last question, <br>what I need, is to ask the security server if a d=
ata residing in userspace owning a context, can be written to a file in OS.=
<br>does it make sense if I do it in this way :<br>=A0 =A0 avc_has_perm(dat=
a_sid=A0 ,file_sid,=A0 SECLASS_FILE , null, null)<br>
<br>I am confused, because I guessed using such a syntax means if a process=
 is able to write to file, but here we are going to check if data can be <b=
><i>written </i></b>to file.<br><br>if everything ok, how the action is spe=
cified, that is write?<br>
Regards.<br><br><br><div class=3D"gmail_quote">On Wed, Jan 27, 2010 at 10:0=
3 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa=
.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Wed, 2010-01-27 at 18:10 +0330, michel m wrote:<br>
</div><div class=3D"im">&gt; thanks for guidance, but here I am with a ques=
tion. what should be<br>
&gt; used as object class in avc_has_perm(3) when using it for<br>
&gt; inter-object. is there any sample for inter-object access decision?<br=
>
&gt; can it be null?<br>
&gt;<br>
&gt; on the other hand, access decision taken by avc_has_perm(), does it<br=
>
&gt; include MLS too?<br>
<br>
</div>Yes, the avc_has_perm() or security_compute_av() decision takes into<=
br>
account all policy models implemented within the security server,<br>
including RBAC, TE, and MLS.<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"h5">Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>

--00504502d497a94d62047e5d9a1c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
