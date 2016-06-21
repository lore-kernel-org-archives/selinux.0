Subject: Re: Protect Xen Virtualization via SElinux.
To: Jason Long <hack3rcon@yahoo.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <785947670.864078.1466342123305.JavaMail.yahoo.ref@mail.yahoo.com>
 <785947670.864078.1466342123305.JavaMail.yahoo@mail.yahoo.com>
 <84f4eb19-85ee-17db-a7c6-64dd2ec1a021@tycho.nsa.gov>
 <1273112690.1326939.1466435174668.JavaMail.yahoo@mail.yahoo.com>
 <219ac57d-1542-92ac-d125-6e60a61d2271@tycho.nsa.gov>
 <287968083.1732087.1466501161282.JavaMail.yahoo@mail.yahoo.com>
From: "Patrick K., ITF" <cto@itechfrontiers.com>
Message-ID: <e3b333f6-8583-4892-eef9-885202583c32@itechfrontiers.com>
Date: Tue, 21 Jun 2016 05:57:51 -0400
MIME-Version: 1.0
In-Reply-To: <287968083.1732087.1466501161282.JavaMail.yahoo@mail.yahoo.com>
Content-Type: multipart/alternative;
 boundary="------------33AA3F6C5AF8986F1EF2FDD4"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------33AA3F6C5AF8986F1EF2FDD4
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Jason,


The files are on Github here:  https://github.com/OpenXT/openxt

and here: *https://github.com/OpenXT/*

Best Regards,

-- 
  Patrick
--

On 6/21/2016 5:26 AM, Jason Long wrote:
> I can't find any example :( Can you show me some urls?
>
>
>
> On Monday, June 20, 2016 7:45 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 06/20/2016 11:06 AM, Jason Long wrote:
>> Can you show me some examples for both ?
> I already pointed you to OpenXT; it is a worked example of both.
>
>
>> On Monday, June 20, 2016 5:13 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 06/19/2016 09:15 AM, Jason Long wrote:
>>
>>> Hello.
>>> How can I protect my Xen VM via SElinux? Can you show me some useful examples?
>> I'm not entirely sure what you are asking, but possible answers:
>>
>> 1. If you want to apply SELinux-like controls over Xen virtual machines
>> (domains), then you can use Xen Security Modules and the Flask security
>> module (commonly abbreviated XSM/Flask) to define and enforce a policy
>> over the hypervisor objects and operations.
>>
>> 2. If you want to use SELinux to harden the Xen domain-0 or specific
>> domUs, you can just enable it in those domains and configure your policy
>> accordingly.
>>
>> If you want a worked example of applying both XSM/Flask and SELinux,
>> have a look at OpenXT,
>> http://openxt.org/
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--------------33AA3F6C5AF8986F1EF2FDD4
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p>Jason,</p>
    <p><br>
    </p>
    <p>The files are on Github here:=A0 <a class=3D"moz-txt-link-freetext=
" href=3D"https://github.com/OpenXT/openxt">https://github.com/OpenXT/ope=
nxt</a></p>
    <p>and here:=A0 <b><a class=3D"moz-txt-link-freetext" href=3D"https:/=
/github.com/OpenXT/">https://github.com/OpenXT/</a></b></p>
    <p>Best Regards,<br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
 Patrick
--</pre>
    <div class=3D"moz-cite-prefix">On 6/21/2016 5:26 AM, Jason Long wrote=
:<br>
    </div>
    <blockquote
      cite=3D"mid:287968083.1732087.1466501161282.JavaMail.yahoo@mail.yah=
oo.com"
      type=3D"cite">
      <pre wrap=3D"">I can't find any example :( Can you show me some url=
s?



On Monday, June 20, 2016 7:45 PM, Stephen Smalley <a class=3D"moz-txt-lin=
k-rfc2396E" href=3D"mailto:sds@tycho.nsa.gov">&lt;sds@tycho.nsa.gov&gt;</=
a> wrote:
On 06/20/2016 11:06 AM, Jason Long wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Can you show me some examples for both ?
</pre>
      </blockquote>
      <pre wrap=3D"">
I already pointed you to OpenXT; it is a worked example of both.


</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">On Monday, June 20, 2016 5:13 PM, Stephen Smalley =
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:sds@tycho.nsa.gov">&lt;=
sds@tycho.nsa.gov&gt;</a> wrote:
On 06/19/2016 09:15 AM, Jason Long wrote:

</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">Hello.
How can I protect my Xen VM via SElinux? Can you show me some useful exam=
ples?
</pre>
        </blockquote>
        <pre wrap=3D"">
I'm not entirely sure what you are asking, but possible answers:

1. If you want to apply SELinux-like controls over Xen virtual machines
(domains), then you can use Xen Security Modules and the Flask security
module (commonly abbreviated XSM/Flask) to define and enforce a policy
over the hypervisor objects and operations.

2. If you want to use SELinux to harden the Xen domain-0 or specific
domUs, you can just enable it in those domains and configure your policy
accordingly.

If you want a worked example of applying both XSM/Flask and SELinux,
have a look at OpenXT,
<a class=3D"moz-txt-link-freetext" href=3D"http://openxt.org/">http://ope=
nxt.org/</a>
_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.go=
v">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link-=
abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-reques=
t@tycho.nsa.gov</a>.
</pre>
      </blockquote>
      <pre wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">
</pre>
      </blockquote>
      <pre wrap=3D"">_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.go=
v">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link-=
abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-reques=
t@tycho.nsa.gov</a>.
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------33AA3F6C5AF8986F1EF2FDD4--
