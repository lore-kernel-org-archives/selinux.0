Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n616IPpY009868
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 02:18:25 -0400
Received: from wa-out-1112.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n616I81Y019919
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 06:18:08 GMT
Received: by wa-out-1112.google.com with SMTP id k17so127711waf.18
        for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 23:18:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A4AFBC5.2010905@gmail.com>
References: <7b740b700906302215n2a6eb4f3y8e2e15419af33191@mail.gmail.com>
	 <4A4AFBC5.2010905@gmail.com>
Date: Wed, 1 Jul 2009 12:18:23 +0600
Message-ID: <7b740b700906302318v31f292e1ha98ff6735eb1e3a2@mail.gmail.com>
Subject: Re: RBAC with SELinux MCS
From: Shaz <shazalive@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001636417b8ffb4669046d9ee3db
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636417b8ffb4669046d9ee3db
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Jul 1, 2009 at 12:01 PM, Justin P. Mattock
<justinmattock@gmail.com>wrote:

> Shaz wrote:
>
>> Dear list,
>>
>> I was studying some earlier work on RBAC and came across Kuhn98 [1], which
>> says that RBAC can be implemented if some interface function is used to map
>> privilege sets of RBAC with MCS. James Moris blog article on MCS [2] states
>> that MCS is just dicretionary like DAC if hierarchies like of MLS levels are
>> not used. It might be because of the implementation of current LSPP on Linux
>> distros. So my question is that can RBAC be used with SELinux if the mapping
>> function is provided?
>>
>> Some further literature or existing work being pointed out will be
>> appreciated.
>>
>> Thank you.
>>
>> [1]
>> http://csrc.nist.gov/groups/SNS/rbac/documents/design_implementation/kuhn-98.pdf
>> [2] http://james-morris.livejournal.com/5583.html
>>
>> --
>> Shaz
>>
>>  Im guessing the mapping function is "newrole" right!
> if then yeah you should be able too i.g.
> newrole -r  *_r -- -c /usr/bin/* (or wherever/whatever your
> wanting to use in that role).
> might get complicated with the sensitivity
> levels and categories(that is if you really tweak them).


Is this consistent with NIST RBAC standard to a greater extent? Never use
roles in SELinux because thought it was just grouping of users.


>
>
> Justin P. Mattock
>
>


-- 
Shaz

--001636417b8ffb4669046d9ee3db
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jul 1, 2009 at 12:01 PM, Justin =
P. Mattock <span dir=3D"ltr">&lt;<a href=3D"mailto:justinmattock@gmail.com"=
>justinmattock@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">Shaz wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dear list,<br>
<br>
I was studying some earlier work on RBAC and came across Kuhn98 [1], which =
says that RBAC can be implemented if some interface function is used to map=
 privilege sets of RBAC with MCS. James Moris blog article on MCS [2] state=
s that MCS is just dicretionary like DAC if hierarchies like of MLS levels =
are not used. It might be because of the implementation of current LSPP on =
Linux distros. So my question is that can RBAC be used with SELinux if the =
mapping function is provided?<br>

<br>
Some further literature or existing work being pointed out will be apprecia=
ted.<br>
<br>
Thank you.<br>
<br>
[1] <a href=3D"http://csrc.nist.gov/groups/SNS/rbac/documents/design_implem=
entation/kuhn-98.pdf" target=3D"_blank">http://csrc.nist.gov/groups/SNS/rba=
c/documents/design_implementation/kuhn-98.pdf</a><br>
[2] <a href=3D"http://james-morris.livejournal.com/5583.html" target=3D"_bl=
ank">http://james-morris.livejournal.com/5583.html</a><br>
<br>
-- <br>
Shaz<br>
<br>
</blockquote></div></div>
Im guessing the mapping function is &quot;newrole&quot; right!<br>
if then yeah you should be able too i.g.<br>
newrole -r =A0*_r -- -c /usr/bin/* (or wherever/whatever your<br>
wanting to use in that role).<br>
might get complicated with the sensitivity<br>
levels and categories(that is if you really tweak them).</blockquote><div><=
br>Is this consistent with NIST RBAC standard to a greater extent? Never us=
e roles in SELinux because thought it was just grouping of users.<br>=A0</d=
iv>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br><font color=
=3D"#888888">
<br>
Justin P. Mattock<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Shaz<br><br>

--001636417b8ffb4669046d9ee3db--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
