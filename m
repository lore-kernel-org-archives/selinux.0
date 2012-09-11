MIME-Version: 1.0
In-Reply-To: <504F57CB.30502@manicmethod.com>
References: <504F43EF.4030900@manicmethod.com>
	<1347375110.18749.2.camel@moss-pluto.epoch.ncsc.mil>
	<504F5778.4010600@manicmethod.com>
	<504F57CB.30502@manicmethod.com>
Date: Tue, 11 Sep 2012 12:39:12 -0400
Message-ID: <CADQgGG0n50XFUGf0htH2ys1TNh=vcGyK01f7gorAvB9cjVGX5Q@mail.gmail.com>
Subject: Re: mmac-4.1.1?
From: Robert Craig <robertpcraig@gmail.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=f46d044303facf560004c96fb631
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d044303facf560004c96fb631
Content-Type: text/plain; charset=ISO-8859-1

The commit you mentioned in your prior email is the only one. We moved away
from allowing users the ability to revoke permissions and thus the changes
only dealt with the PMS.

On Tue, Sep 11, 2012 at 11:24 AM, Joshua Brindle <method@manicmethod.com>wrote:

> Joshua Brindle wrote:
>
>> Stephen Smalley wrote:
>>
>>> On Tue, 2012-09-11 at 10:00 -0400, Joshua Brindle wrote:
>>>
>>>> I'm wondering if there are plans for an mmac-4.1.1 branch? I see
>>>> mmac-4.0.4 and mmac (which I assume tracks master). I'd like
>>>> install-time and revocation mmac in 4.1.1. Perhaps I'm missing a branch
>>>> that provides that?
>>>>
>>>
>>> We merged the install-time MAC support into our main seandroid branches
>>> (i.e. seandroid, seandroid-4.0.4, and seandroid-4.1.1) back in July.
>>> Since that time, mmac and mmac-4.0.4 haven't been maintained - they are
>>> dead (and I don't think they even exist on bitbucket).
>>>
>>> We did recently create revoke-perms-jb and tagprop-jb branches with
>>> rebased versions of the revoke-perms and tagprop changes. You should in
>>> theory be able to cherry-pick changes from those branches onto
>>> seandroid-4.1.1. But we haven't been doing much with them of late.
>>>
>>>
>> Okay. Looking at the log of revoke-perms-jb it seems like the only
>> commit of interest is this one, is that correct?
>>
>> commit 5ab263eb610d30528134bb28fee5fd**83a0bb98aa
>> Author: rpcraig <rpcraig@tycho.ncsc.mil>
>> Date: Fri Aug 24 06:59:51 2012 -0400
>>
>> Add revoke permission ability.
>>
>> Functionality is driven by policy file. This is a
>> departure from the CyanogenMod-esque way of doing
>> revocation. No user involvment.
>>
>
> Silly me, that was framework/base, do you know offhand which other
> projects I should look at?
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--f46d044303facf560004c96fb631
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The commit you mentioned in your prior email is the only one. We moved away=
 from allowing users the ability to revoke permissions and thus the changes=
 only dealt with the PMS.=A0<br><br><div class=3D"gmail_quote">On Tue, Sep =
11, 2012 at 11:24 AM, Joshua Brindle <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:method@manicmethod.com" target=3D"_blank">method@manicmethod.com</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">Joshua Brindle wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Stephen Smalley wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Tue, 2012-09-11 at 10:00 -0400, Joshua Brindle wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I&#39;m wondering if there are plans for an mmac-4.1.1 branch? I see<br>
mmac-4.0.4 and mmac (which I assume tracks master). I&#39;d like<br>
install-time and revocation mmac in 4.1.1. Perhaps I&#39;m missing a branch=
<br>
that provides that?<br>
</blockquote>
<br>
We merged the install-time MAC support into our main seandroid branches<br>
(i.e. seandroid, seandroid-4.0.4, and seandroid-4.1.1) back in July.<br>
Since that time, mmac and mmac-4.0.4 haven&#39;t been maintained - they are=
<br>
dead (and I don&#39;t think they even exist on bitbucket).<br>
<br>
We did recently create revoke-perms-jb and tagprop-jb branches with<br>
rebased versions of the revoke-perms and tagprop changes. You should in<br>
theory be able to cherry-pick changes from those branches onto<br>
seandroid-4.1.1. But we haven&#39;t been doing much with them of late.<br>
<br>
</blockquote>
<br>
Okay. Looking at the log of revoke-perms-jb it seems like the only<br>
commit of interest is this one, is that correct?<br>
<br>
commit 5ab263eb610d30528134bb28fee5fd<u></u>83a0bb98aa<br>
Author: rpcraig &lt;<a href=3D"mailto:rpcraig@tycho.ncsc.mil" target=3D"_bl=
ank">rpcraig@tycho.ncsc.mil</a>&gt;<br>
Date: Fri Aug 24 06:59:51 2012 -0400<br>
<br>
Add revoke permission ability.<br>
<br>
Functionality is driven by policy file. This is a<br>
departure from the CyanogenMod-esque way of doing<br>
revocation. No user involvment.<br>
</blockquote>
<br></div>
Silly me, that was framework/base, do you know offhand which other projects=
 I should look at?<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</div></div></blockquote></div><br>

--f46d044303facf560004c96fb631--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
