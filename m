Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n616j40x013078
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 02:45:06 -0400
Received: from mail-pz0-f177.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n616jddA026357
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 06:45:39 GMT
Received: by pzk7 with SMTP id 7so299627pzk.32
        for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 23:44:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A4B04DA.6000706@gmail.com>
References: <7b740b700906302215n2a6eb4f3y8e2e15419af33191@mail.gmail.com>
	 <4A4AFBC5.2010905@gmail.com>
	 <7b740b700906302318v31f292e1ha98ff6735eb1e3a2@mail.gmail.com>
	 <4A4B04DA.6000706@gmail.com>
Date: Wed, 1 Jul 2009 12:44:59 +0600
Message-ID: <7b740b700906302344rbeaf99yd48cdec3d9cc4939@mail.gmail.com>
Subject: Re: RBAC with SELinux MCS
From: Shaz <shazalive@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001636456fd612e9c3046d9f430b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636456fd612e9c3046d9f430b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Jul 1, 2009 at 12:40 PM, Justin P. Mattock
<justinmattock@gmail.com>wrote:

> Shaz wrote:
>
>
>>
>> On Wed, Jul 1, 2009 at 12:01 PM, Justin P. Mattock <
>> justinmattock@gmail.com <mailto:justinmattock@gmail.com>> wrote:
>>
>>    Shaz wrote:
>>
>>        Dear list,
>>
>>        I was studying some earlier work on RBAC and came across
>>        Kuhn98 [1], which says that RBAC can be implemented if some
>>        interface function is used to map privilege sets of RBAC with
>>        MCS. James Moris blog article on MCS [2] states that MCS is
>>        just dicretionary like DAC if hierarchies like of MLS levels
>>        are not used. It might be because of the implementation of
>>        current LSPP on Linux distros. So my question is that can RBAC
>>        be used with SELinux if the mapping function is provided?
>>
>>        Some further literature or existing work being pointed out
>>        will be appreciated.
>>
>>        Thank you.
>>
>>        [1]
>>
>> http://csrc.nist.gov/groups/SNS/rbac/documents/design_implementation/kuhn-98.pdf
>>        [2] http://james-morris.livejournal.com/5583.html
>>
>>        --        Shaz
>>
>>    Im guessing the mapping function is "newrole" right!
>>    if then yeah you should be able too i.g.
>>    newrole -r  *_r -- -c /usr/bin/* (or wherever/whatever your
>>    wanting to use in that role).
>>    might get complicated with the sensitivity
>>    levels and categories(that is if you really tweak them).
>>
>>
>> Is this consistent with NIST RBAC standard to a greater extent? Never use
>> roles in SELinux because thought it was just grouping of users.
>>
>>
>>
>>    Justin P. Mattock
>>
>>
>>
>>
>> --
>> Shaz
>>
>>  It should be of standard to NIST(if not then they should fix that)
> I don't see it as grouping users(but could be wrong),
> I see it as a way of confining the situation i.g.
> if  you run an application in certain role, it's confined to
> that role and only the privileges that role provides.


Those privileges depend on the kind of object defined by the "class" and
enforced by the object manager. I think its making sense to my stupid mind
now :) I will appreciate if someone can clear out if this is consistent with
the NIST standards.

Thanks Justin.


>
>
> Justin P. Mattock
>
>
>
>


-- 
Shaz

--001636456fd612e9c3046d9f430b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jul 1, 2009 at 12:40 PM, Justin =
P. Mattock <span dir=3D"ltr">&lt;<a href=3D"mailto:justinmattock@gmail.com"=
>justinmattock@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
Shaz wrote:<div><div></div><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<br>
On Wed, Jul 1, 2009 at 12:01 PM, Justin P. Mattock &lt;<a href=3D"mailto:ju=
stinmattock@gmail.com" target=3D"_blank">justinmattock@gmail.com</a> &lt;ma=
ilto:<a href=3D"mailto:justinmattock@gmail.com" target=3D"_blank">justinmat=
tock@gmail.com</a>&gt;&gt; wrote:<br>

<br>
 =A0 =A0Shaz wrote:<br>
<br>
 =A0 =A0 =A0 =A0Dear list,<br>
<br>
 =A0 =A0 =A0 =A0I was studying some earlier work on RBAC and came across<br=
>
 =A0 =A0 =A0 =A0Kuhn98 [1], which says that RBAC can be implemented if some=
<br>
 =A0 =A0 =A0 =A0interface function is used to map privilege sets of RBAC wi=
th<br>
 =A0 =A0 =A0 =A0MCS. James Moris blog article on MCS [2] states that MCS is=
<br>
 =A0 =A0 =A0 =A0just dicretionary like DAC if hierarchies like of MLS level=
s<br>
 =A0 =A0 =A0 =A0are not used. It might be because of the implementation of<=
br>
 =A0 =A0 =A0 =A0current LSPP on Linux distros. So my question is that can R=
BAC<br>
 =A0 =A0 =A0 =A0be used with SELinux if the mapping function is provided?<b=
r>
<br>
 =A0 =A0 =A0 =A0Some further literature or existing work being pointed out<=
br>
 =A0 =A0 =A0 =A0will be appreciated.<br>
<br>
 =A0 =A0 =A0 =A0Thank you.<br>
<br>
 =A0 =A0 =A0 =A0[1]<br>
 =A0 =A0 =A0 =A0<a href=3D"http://csrc.nist.gov/groups/SNS/rbac/documents/d=
esign_implementation/kuhn-98.pdf" target=3D"_blank">http://csrc.nist.gov/gr=
oups/SNS/rbac/documents/design_implementation/kuhn-98.pdf</a><br>
 =A0 =A0 =A0 =A0[2] <a href=3D"http://james-morris.livejournal.com/5583.htm=
l" target=3D"_blank">http://james-morris.livejournal.com/5583.html</a><br>
<br>
 =A0 =A0 =A0 =A0--  =A0 =A0 =A0 =A0Shaz<br>
<br>
 =A0 =A0Im guessing the mapping function is &quot;newrole&quot; right!<br>
 =A0 =A0if then yeah you should be able too i.g.<br>
 =A0 =A0newrole -r =A0*_r -- -c /usr/bin/* (or wherever/whatever your<br>
 =A0 =A0wanting to use in that role).<br>
 =A0 =A0might get complicated with the sensitivity<br>
 =A0 =A0levels and categories(that is if you really tweak them).<br>
<br>
<br>
Is this consistent with NIST RBAC standard to a greater extent? Never use r=
oles in SELinux because thought it was just grouping of users.<br>
<br>
<br>
<br>
 =A0 =A0Justin P. Mattock<br>
<br>
<br>
<br>
<br>
-- <br>
Shaz<br>
<br>
</blockquote></div></div>
It should be of standard to NIST(if not then they should fix that)<br>
I don&#39;t see it as grouping users(but could be wrong),<br>
I see it as a way of confining the situation i.g.<br>
if =A0you run an application in certain role, it&#39;s confined to<br>
that role and only the privileges that role provides.</blockquote><div><br>=
Those privileges depend on the kind of object defined by the &quot;class&qu=
ot; and enforced by the object manager. I think its making sense to my stup=
id mind now :) I will appreciate if someone can clear out if this is consis=
tent with the NIST standards.<br>
<br>Thanks Justin.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;"><br><font color=3D"#888888">
<br>
Justin P. Mattock<br>
<br>
<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Shaz<br><br>

--001636456fd612e9c3046d9f430b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
