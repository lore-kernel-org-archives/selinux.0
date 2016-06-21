Subject: Re: Protect Xen Virtualization via SElinux.
To: Jason Long <hack3rcon@yahoo.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <785947670.864078.1466342123305.JavaMail.yahoo.ref@mail.yahoo.com>
 <785947670.864078.1466342123305.JavaMail.yahoo@mail.yahoo.com>
 <84f4eb19-85ee-17db-a7c6-64dd2ec1a021@tycho.nsa.gov>
 <1273112690.1326939.1466435174668.JavaMail.yahoo@mail.yahoo.com>
 <219ac57d-1542-92ac-d125-6e60a61d2271@tycho.nsa.gov>
 <287968083.1732087.1466501161282.JavaMail.yahoo@mail.yahoo.com>
 <e3b333f6-8583-4892-eef9-885202583c32@itechfrontiers.com>
 <65143331.1824795.1466505900439.JavaMail.yahoo@mail.yahoo.com>
From: "Patrick K., ITF" <cto@itechfrontiers.com>
Message-ID: <8844b70a-6315-35d2-17d4-ddb1b046a5bc@itechfrontiers.com>
Date: Tue, 21 Jun 2016 06:52:21 -0400
MIME-Version: 1.0
In-Reply-To: <65143331.1824795.1466505900439.JavaMail.yahoo@mail.yahoo.com>
Content-Type: multipart/alternative;
 boundary="------------CC3B77610E18F3EA5B56756B"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------CC3B77610E18F3EA5B56756B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Jason,


Please read it here:

https://openxt.atlassian.net/wiki/pages/viewpage.action?pageId=10747915


https://openxt.atlassian.net/wiki/display/OD/Getting+Started


Best Regards,

-- 
  Patrick
--

On 6/21/2016 6:45 AM, Jason Long wrote:
> No, I mean is how to drive it.
>
>
> On Tuesday, June 21, 2016 2:28 PM, "Patrick K., ITF" 
> <cto@itechfrontiers.com> wrote:
>
>
> Jason,
>
> The files are on Github here: https://github.com/OpenXT/openxt
> and here: *https://github.com/OpenXT/*
> Best Regards,
> -- 
>   Patrick
> --
> On 6/21/2016 5:26 AM, Jason Long wrote:
>> I can't find any example :( Can you show me some urls?
>>
>>
>>
>> On Monday, June 20, 2016 7:45 PM, Stephen Smalley<sds@tycho.nsa.gov> <mailto:sds@tycho.nsa.gov>  wrote:
>> On 06/20/2016 11:06 AM, Jason Long wrote:
>>> Can you show me some examples for both ?
>> I already pointed you to OpenXT; it is a worked example of both.
>>
>>
>>> On Monday, June 20, 2016 5:13 PM, Stephen Smalley<sds@tycho.nsa.gov> <mailto:sds@tycho.nsa.gov>  wrote:
>>> On 06/19/2016 09:15 AM, Jason Long wrote:
>>>
>>>> Hello.
>>>> How can I protect my Xen VM via SElinux? Can you show me some useful examples?
>>> I'm not entirely sure what you are asking, but possible answers:
>>>
>>> 1. If you want to apply SELinux-like controls over Xen virtual machines
>>> (domains), then you can use Xen Security Modules and the Flask security
>>> module (commonly abbreviated XSM/Flask) to define and enforce a policy
>>> over the hypervisor objects and operations.
>>>
>>> 2. If you want to use SELinux to harden the Xen domain-0 or specific
>>> domUs, you can just enable it in those domains and configure your policy
>>> accordingly.
>>>
>>> If you want a worked example of applying both XSM/Flask and SELinux,
>>> have a look at OpenXT,
>>> http://openxt.org/
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>>> To unsubscribe, send email toSelinux-leave@tycho.nsa.gov <mailto:Selinux-leave@tycho.nsa.gov>.
>>> To get help, send an email containing "help" toSelinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov>.
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>> To unsubscribe, send email toSelinux-leave@tycho.nsa.gov <mailto:Selinux-leave@tycho.nsa.gov>.
>> To get help, send an email containing "help" toSelinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov>.
>
>
>


--------------CC3B77610E18F3EA5B56756B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p>Jason,</p>
    <p><br>
    </p>
    <p>Please read it here:</p>
    <p><a class=3D"moz-txt-link-freetext" href=3D"https://openxt.atlassia=
n.net/wiki/pages/viewpage.action?pageId=3D10747915">https://openxt.atlass=
ian.net/wiki/pages/viewpage.action?pageId=3D10747915</a></p>
    <p><br>
    </p>
    <p><a class=3D"moz-txt-link-freetext" href=3D"https://openxt.atlassia=
n.net/wiki/display/OD/Getting+Started">https://openxt.atlassian.net/wiki/=
display/OD/Getting+Started</a></p>
    <p><br>
    </p>
    <p>Best Regards,</p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
 Patrick
--</pre>
    <div class=3D"moz-cite-prefix">On 6/21/2016 6:45 AM, Jason Long wrote=
:<br>
    </div>
    <blockquote
      cite=3D"mid:65143331.1824795.1466505900439.JavaMail.yahoo@mail.yaho=
o.com"
      type=3D"cite">
      <div style=3D"color:#000; background-color:#fff;
        font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial,
        Lucida Grande, sans-serif;font-size:16px">
        <div id=3D"yui_3_16_0_ym19_1_1466500304668_60598"><span>No, I mea=
n
            is how to drive it.</span></div>
        <div class=3D"qtdSeparateBR"><br>
          <br>
        </div>
        <div class=3D"yahoo_quoted" style=3D"display: block;">
          <div style=3D"font-family: HelveticaNeue, Helvetica Neue,
            Helvetica, Arial, Lucida Grande, sans-serif; font-size:
            16px;">
            <div style=3D"font-family: HelveticaNeue, Helvetica Neue,
              Helvetica, Arial, Lucida Grande, sans-serif; font-size:
              16px;">
              <div dir=3D"ltr"><font face=3D"Arial" size=3D"2"> On Tuesda=
y,
                  June 21, 2016 2:28 PM, "Patrick K., ITF"
                  <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:cto@i=
techfrontiers.com">&lt;cto@itechfrontiers.com&gt;</a> wrote:<br>
                </font></div>
              <br>
              <br>
              <div class=3D"y_msg_container">
                <div id=3D"yiv9999577738">
                  <div>
                    <div>Jason,</div>
                    <div><br clear=3D"none">
                    </div>
                    <div>The files are on Github here:=C2=A0 <a
                        moz-do-not-send=3D"true" rel=3D"nofollow"
                        shape=3D"rect"
                        class=3D"yiv9999577738moz-txt-link-freetext"
                        target=3D"_blank"
                        href=3D"https://github.com/OpenXT/openxt"><a clas=
s=3D"moz-txt-link-freetext" href=3D"https://github.com/OpenXT/openxt">htt=
ps://github.com/OpenXT/openxt</a></a></div>
                    <div>and here:=C2=A0 <b><a moz-do-not-send=3D"true"
                          rel=3D"nofollow" shape=3D"rect"
                          class=3D"yiv9999577738moz-txt-link-freetext"
                          target=3D"_blank"
                          href=3D"https://github.com/OpenXT/">https://git=
hub.com/OpenXT/</a></b></div>
                    <div>Best Regards,<br clear=3D"none">
                    </div>
                    <pre class=3D"yiv9999577738moz-signature">--=20
 Patrick
--</pre>
                    <div class=3D"yiv9999577738moz-cite-prefix">On
                      6/21/2016 5:26 AM, Jason Long wrote:<br
                        clear=3D"none">
                    </div>
                    <blockquote type=3D"cite">
                      <pre>I can't find any example :( Can you show me so=
me urls?



On Monday, June 20, 2016 7:45 PM, Stephen Smalley <a moz-do-not-send=3D"t=
rue" rel=3D"nofollow" shape=3D"rect" class=3D"yiv9999577738moz-txt-link-r=
fc2396E" ymailto=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank" href=3D"m=
ailto:sds@tycho.nsa.gov">&lt;sds@tycho.nsa.gov&gt;</a> wrote:
On 06/20/2016 11:06 AM, Jason Long wrote:
</pre>
                      <blockquote type=3D"cite">
                        <pre>Can you show me some examples for both ?
</pre>
                      </blockquote>
                      <pre>I already pointed you to OpenXT; it is a worke=
d example of both.


</pre>
                      <blockquote type=3D"cite">
                        <pre>On Monday, June 20, 2016 5:13 PM, Stephen Sm=
alley <a moz-do-not-send=3D"true" rel=3D"nofollow" shape=3D"rect" class=3D=
"yiv9999577738moz-txt-link-rfc2396E" ymailto=3D"mailto:sds@tycho.nsa.gov"=
 target=3D"_blank" href=3D"mailto:sds@tycho.nsa.gov">&lt;sds@tycho.nsa.go=
v&gt;</a> wrote:
On 06/19/2016 09:15 AM, Jason Long wrote:

</pre>
                        <blockquote type=3D"cite">
                          <pre>Hello.
How can I protect my Xen VM via SElinux? Can you show me some useful exam=
ples?
</pre>
                        </blockquote>
                        <pre>I'm not entirely sure what you are asking, b=
ut possible answers:

1. If you want to apply SELinux-like controls over Xen virtual machines
(domains), then you can use Xen Security Modules and the Flask security
module (commonly abbreviated XSM/Flask) to define and enforce a policy
over the hypervisor objects and operations.

2. If you want to use SELinux to harden the Xen domain-0 or specific
domUs, you can just enable it in those domains and configure your policy
accordingly.

If you want a worked example of applying both XSM/Flask and SELinux,
have a look at OpenXT,
<a moz-do-not-send=3D"true" rel=3D"nofollow" shape=3D"rect" class=3D"yiv9=
999577738moz-txt-link-freetext" target=3D"_blank" href=3D"http://openxt.o=
rg/">http://openxt.org/</a>
_______________________________________________
Selinux mailing list
<a moz-do-not-send=3D"true" rel=3D"nofollow" shape=3D"rect" class=3D"yiv9=
999577738moz-txt-link-abbreviated" ymailto=3D"mailto:Selinux@tycho.nsa.go=
v" target=3D"_blank" href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.=
nsa.gov</a>
To unsubscribe, send email to <a moz-do-not-send=3D"true" rel=3D"nofollow=
" shape=3D"rect" class=3D"yiv9999577738moz-txt-link-abbreviated" ymailto=3D=
"mailto:Selinux-leave@tycho.nsa.gov" target=3D"_blank" href=3D"mailto:Sel=
inux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a moz-do-not-send=3D"tru=
e" rel=3D"nofollow" shape=3D"rect" class=3D"yiv9999577738moz-txt-link-abb=
reviated" ymailto=3D"mailto:Selinux-request@tycho.nsa.gov" target=3D"_bla=
nk" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.n=
sa.gov</a>.
</pre>
                      </blockquote>
                      <blockquote type=3D"cite"> </blockquote>
                      <pre>______________________________________________=
_
Selinux mailing list
<a moz-do-not-send=3D"true" rel=3D"nofollow" shape=3D"rect" class=3D"yiv9=
999577738moz-txt-link-abbreviated" ymailto=3D"mailto:Selinux@tycho.nsa.go=
v" target=3D"_blank" href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.=
nsa.gov</a>
To unsubscribe, send email to <a moz-do-not-send=3D"true" rel=3D"nofollow=
" shape=3D"rect" class=3D"yiv9999577738moz-txt-link-abbreviated" ymailto=3D=
"mailto:Selinux-leave@tycho.nsa.gov" target=3D"_blank" href=3D"mailto:Sel=
inux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a moz-do-not-send=3D"tru=
e" rel=3D"nofollow" shape=3D"rect" class=3D"yiv9999577738moz-txt-link-abb=
reviated" ymailto=3D"mailto:Selinux-request@tycho.nsa.gov" target=3D"_bla=
nk" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.n=
sa.gov</a>.
</pre>
                    </blockquote>
                    <div class=3D"yiv9999577738yqt1728867965"
                      id=3D"yiv9999577738yqtfd26661"><br clear=3D"none">
                    </div>
                  </div>
                </div>
                <br>
                <br>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------CC3B77610E18F3EA5B56756B--
