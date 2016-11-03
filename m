MIME-Version: 1.0
In-Reply-To: <c1572829-de3b-7902-ad4a-baf8cb3c7b89@tycho.nsa.gov>
References: <1478103573-19175-1-git-send-email-jwcart2@tycho.nsa.gov>
 <c1572829-de3b-7902-ad4a-baf8cb3c7b89@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Thu, 3 Nov 2016 19:02:36 +0100
Message-ID: <CAJfZ7=mLFY+YNBT_sctHwrBa=PAXBtsp4+7C_0MhB7eMvcQ7WA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Exit with an error for an unknown map
 permission
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1140241ada2b3e0540695c03
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140241ada2b3e0540695c03
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 3, 2016 at 6:39 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:

> On 11/02/2016 12:19 PM, James Carter wrote:
>
>> Nicholas Iooss discovered that using an unknown permission with a
>> map class will cause a segfault.
>>
>> CIL will only give a warning when it fails to resolve an unknown
>> permission to support the use of policy module packages that use
>> permissions that don't exit on the current system. When resolving
>> the unknown map class permission an empty list is used to represent
>> the unknown permission. When it is evaluated later the list is
>> assumed to be a permission and a segfault occurs.
>>
>> There is no reason to allow unknown class map permissions because
>> the class maps and permissions are defined by the policy.
>>
>> Exit with an error when failing to resolve a class map permission.
>>
>> Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
>>
>
> Applied.


Thanks. I have been running afl-fuzz on secilc with this patch and after a
few hours, it is still running with no crash.

Nicolas

--001a1140241ada2b3e0540695c03
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
hu, Nov 3, 2016 at 6:39 PM, James Carter <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:jwcart2@tycho.nsa.gov" target=3D"_blank">jwcart2@tycho.nsa.gov</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 11/02=
/2016 12:19 PM, James Carter wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Nicholas Iooss discovered that using an unknown permission with a<br>
map class will cause a segfault.<br>
<br>
CIL will only give a warning when it fails to resolve an unknown<br>
permission to support the use of policy module packages that use<br>
permissions that don&#39;t exit on the current system. When resolving<br>
the unknown map class permission an empty list is used to represent<br>
the unknown permission. When it is evaluated later the list is<br>
assumed to be a permission and a segfault occurs.<br>
<br>
There is no reason to allow unknown class map permissions because<br>
the class maps and permissions are defined by the policy.<br>
<br>
Exit with an error when failing to resolve a class map permission.<br>
<br>
Reported-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.org" tar=
get=3D"_blank">nicolas.iooss@m4x.org</a>&gt;<br>
Signed-off-by: James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov" ta=
rget=3D"_blank">jwcart2@tycho.nsa.gov</a>&gt;<br>
</blockquote>
<br></span>
Applied.</blockquote><div><br></div><div>Thanks. I have been running afl-fu=
zz on secilc with this patch and after a few hours, it is still running wit=
h no crash.</div><div><br></div><div>Nicolas</div></div></div></div>

--001a1140241ada2b3e0540695c03--
