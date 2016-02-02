Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u12KdxFs032514
 for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2016 15:39:59 -0500
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com
 [209.85.215.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1D2AC5613C0
 for <selinux@tycho.nsa.gov>; Tue,  2 Feb 2016 21:39:51 +0100 (CET)
Received: by mail-lf0-f42.google.com with SMTP id m1so185536lfg.0
 for <selinux@tycho.nsa.gov>; Tue, 02 Feb 2016 12:39:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B0C54B.2080407@tycho.nsa.gov>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <56AFB25D.1070505@tycho.nsa.gov> <20160202062635.GA12699@meriadoc>
 <56B0C54B.2080407@tycho.nsa.gov>
Date: Tue, 2 Feb 2016 21:39:50 +0100
Message-ID: <CAJfZ7=nsdiZ0r4=Ph+_=gzunSKsna6ZBGD3MPtKM0Oe=JPUm4w@mail.gmail.com>
Subject: Re: genhomedircon uid template
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: SELinux List <selinux@tycho.nsa.gov>, Jason Zaman <jason@perfinion.com>
Content-Type: multipart/alternative; boundary=001a11411980c71782052acf800d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11411980c71782052acf800d
Content-Type: text/plain; charset=UTF-8

On Tue, Feb 2, 2016 at 4:03 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 02/02/2016 01:26 AM, Jason Zaman wrote:
>
>> On Mon, Feb 01, 2016 at 02:30:37PM -0500, Stephen Smalley wrote:
>>
>>> On 02/01/2016 04:36 AM, Jason Zaman wrote:
>>>
>>>> Hi all,
>>>>
>>>> XDG_RUNTIME_DIR is usually /run/user/$UID but there is no way to label
>>>> that in an fcontext file. It used to be /run/user/USER which is easy but
>>>> not UID.
>>>>
>>>> What template keyword should be used for such an entry? UID? USERID?
>>>>
>>>> USERID is perhaps more obvious but has to be replaced before USER but
>>>> that should be doable.
>>>>
>>>> https://github.com/SELinuxProject/selinux/blob/master/libsemanage/src/genhomedircon.c#L76
>>>>
>>>> UID does not conflict with USER but this line exists in refpol which
>>>> is problematic:
>>>> contrib/fetchmail.fc:13:/var/mail/\.fetchmail-UIDL-cache --
>>>> gen_context(system_u:object_r:fetchmail_uidl_cache_t,s0)
>>>>
>>>> This could also be used for several fcontexts in kerberos. It stores the
>>>> tickets in /tmp/krbcc_UID for example.
>>>>
>>>> If we choose a template name I can put together a patch to add it.
>>>>
>>>
>>> No strong preferences from me on the particular name, e.g. USERID is
>>> fine.  I think it highlights however the problems with the current
>>> approach; maybe we ought to be using ${USER} and ${UID} in .fc files
>>> instead?
>>>
>>
>> Yes there are definitely problems but fixing would mean refpol and
>> probably a lot of other things would need to be updated at the same
>> time.
>>
>> HOME_DIR and HOME_ROOT are not really problems since they are only
>> allowed in the beginning of an fcontext line and other lines start with
>> a /.
>>
>> USER, USERID, and possibly other things in future (GROUP, GROUPID?) can
>> appear at any point in the the line so a more unique token might be
>> better. %USERID might be better than $USERID since thats a thing in
>> shells.
>>
>> If we do go down this path, what are the steps? and what tokens do we
>> want?
>>
>
> I think we would provide backward compatibility for the existing tokens,
> at least for some time.  As far as I know, we only need to modify the
> refpolicy build process and libsemanage to support the new tokens.
>
> You need a way to mark the end of the token, either %USERID% or %{USERID}.


After reading this thread, I was wondering: should a way of escaping
placeholders be documented somewhere? For example, if I ever encounter a
file with "%USERID" in its name, I would use "[%]USERID" in the file
context pattern to give it a label. I find this quite hackish and I may
have missed a better way of handling it. Where are such things usually
documented?

By the way, on systems running systemd, /run/user/$UID is a tmpfs
mountpoint which would be relabeled by systemd-logind right after it is
created (using lsetfiecon with the label defined in the policy), but a
piece of code is missing to enable this on Arch Linux and Debian. I
reported this on https://github.com/systemd/systemd/pull/2508 .

Nicolas

--001a11411980c71782052acf800d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Feb 2, 2016 at 4:03 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-le=
ft-style:solid;padding-left:1ex"><div class=3D""><div class=3D"h5">On 02/02=
/2016 01:26 AM, Jason Zaman wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
On Mon, Feb 01, 2016 at 02:30:37PM -0500, Stephen Smalley wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
On 02/01/2016 04:36 AM, Jason Zaman wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Hi all,<br>
<br>
XDG_RUNTIME_DIR is usually /run/user/$UID but there is no way to label<br>
that in an fcontext file. It used to be /run/user/USER which is easy but<br=
>
not UID.<br>
<br>
What template keyword should be used for such an entry? UID? USERID?<br>
<br>
USERID is perhaps more obvious but has to be replaced before USER but<br>
that should be doable.<br>
<a href=3D"https://github.com/SELinuxProject/selinux/blob/master/libsemanag=
e/src/genhomedircon.c#L76" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/SELinuxProject/selinux/blob/master/libsemanage/src/genhomedircon.c#=
L76</a><br>
<br>
UID does not conflict with USER but this line exists in refpol which<br>
is problematic:<br>
contrib/fetchmail.fc:13:/var/mail/\.fetchmail-UIDL-cache -- gen_context(sys=
tem_u:object_r:fetchmail_uidl_cache_t,s0)<br>
<br>
This could also be used for several fcontexts in kerberos. It stores the<br=
>
tickets in /tmp/krbcc_UID for example.<br>
<br>
If we choose a template name I can put together a patch to add it.<br>
</blockquote>
<br>
No strong preferences from me on the particular name, e.g. USERID is<br>
fine.=C2=A0 I think it highlights however the problems with the current<br>
approach; maybe we ought to be using ${USER} and ${UID} in .fc files<br>
instead?<br>
</blockquote>
<br>
Yes there are definitely problems but fixing would mean refpol and<br>
probably a lot of other things would need to be updated at the same<br>
time.<br>
<br>
HOME_DIR and HOME_ROOT are not really problems since they are only<br>
allowed in the beginning of an fcontext line and other lines start with<br>
a /.<br>
<br>
USER, USERID, and possibly other things in future (GROUP, GROUPID?) can<br>
appear at any point in the the line so a more unique token might be<br>
better. %USERID might be better than $USERID since thats a thing in<br>
shells.<br>
<br>
If we do go down this path, what are the steps? and what tokens do we<br>
want?<br>
</blockquote>
<br></div></div>
I think we would provide backward compatibility for the existing tokens, at=
 least for some time.=C2=A0 As far as I know, we only need to modify the re=
fpolicy build process and libsemanage to support the new tokens.<br>
<br>
You need a way to mark the end of the token, either %USERID% or %{USERID}.<=
/blockquote><div><br></div><div>After reading this thread, I was wondering:=
 should a way of escaping placeholders be documented somewhere?=C2=A0For ex=
ample, if I ever encounter a file with &quot;%USERID&quot; in its name, I w=
ould use &quot;[%]USERID&quot; in the file context pattern to give it a lab=
el. I find this quite hackish and I may have missed a better way of handlin=
g it. Where are such things usually documented?</div><div><br></div><div>By=
 the way, on systems running systemd,=C2=A0<span style=3D"font-size:12.8px"=
>/run/user/$UID is a tmpfs mountpoint which would be=C2=A0relabeled=C2=A0by=
 systemd-logind right after it is created (using lsetfiecon with the label =
defined in the policy), but a piece of code is missing to enable this on Ar=
ch Linux and Debian. I reported this on=C2=A0<a href=3D"https://github.com/=
systemd/systemd/pull/2508">https://github.com/systemd/systemd/pull/2508</a>=
=C2=A0.</span></div><div><span style=3D"font-size:12.8px"><br></span></div>=
<div><span style=3D"font-size:12.8px">Nicolas</span></div></div></div></div=
>

--001a11411980c71782052acf800d--
