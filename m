Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5LAm8tS032735
 for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2016 06:48:08 -0400
Date: Tue, 21 Jun 2016 10:45:00 +0000 (UTC)
From: Jason Long <hack3rcon@yahoo.com>
Reply-To: Jason Long <hack3rcon@yahoo.com>
To: "Patrick K., ITF" <cto@itechfrontiers.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <65143331.1824795.1466505900439.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <e3b333f6-8583-4892-eef9-885202583c32@itechfrontiers.com>
References: <785947670.864078.1466342123305.JavaMail.yahoo.ref@mail.yahoo.com>
 <785947670.864078.1466342123305.JavaMail.yahoo@mail.yahoo.com>
 <84f4eb19-85ee-17db-a7c6-64dd2ec1a021@tycho.nsa.gov>
 <1273112690.1326939.1466435174668.JavaMail.yahoo@mail.yahoo.com>
 <219ac57d-1542-92ac-d125-6e60a61d2271@tycho.nsa.gov>
 <287968083.1732087.1466501161282.JavaMail.yahoo@mail.yahoo.com>
 <e3b333f6-8583-4892-eef9-885202583c32@itechfrontiers.com>
Subject: Re: Protect Xen Virtualization via SElinux.
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_1824794_225943891.1466505900435"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

------=_Part_1824794_225943891.1466505900435
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

No, I mean is how to drive it.=20

    On Tuesday, June 21, 2016 2:28 PM, "Patrick K., ITF" <cto@itechfrontier=
s.com> wrote:
=20

  Jason,=20
  The files are on Github here:=C2=A0 https://github.com/OpenXT/openxt and =
here:=C2=A0 https://github.com/OpenXT/ Best Regards,
  --=20
 Patrick
-- On 6/21/2016 5:26 AM, Jason Long wrote:
 =20
 I can't find any example :( Can you show me some urls?



On Monday, June 20, 2016 7:45 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote=
:
On 06/20/2016 11:06 AM, Jason Long wrote:
=20
 Can you show me some examples for both ?
=20
 I already pointed you to OpenXT; it is a worked example of both.


=20
 On Monday, June 20, 2016 5:13 PM, Stephen Smalley <sds@tycho.nsa.gov> wrot=
e:
On 06/19/2016 09:15 AM, Jason Long wrote:

=20
 Hello.
How can I protect my Xen VM via SElinux? Can you show me some useful exampl=
es?
=20
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
http://openxt.org/
_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to Selinux-request@tycho.nsa.g=
ov.
=20
 =20
 =20
 _______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to Selinux-request@tycho.nsa.g=
ov.
=20
=20
=20

  
------=_Part_1824794_225943891.1466505900435
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head></head><body><div style="color:#000; background-color:#fff; font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px"><div id="yui_3_16_0_ym19_1_1466500304668_60598"><span>No, I mean is how to drive it.</span></div> <div class="qtdSeparateBR"><br><br></div><div class="yahoo_quoted" style="display: block;"> <div style="font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;"> <div style="font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;"> <div dir="ltr"><font size="2" face="Arial"> On Tuesday, June 21, 2016 2:28 PM, "Patrick K., ITF" &lt;cto@itechfrontiers.com&gt; wrote:<br></font></div>  <br><br> <div class="y_msg_container"><div id="yiv9999577738"><div>
    <div>Jason,</div>
    <div><br clear="none">
    </div>
    <div>The files are on Github here:&nbsp; <a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-freetext" target="_blank" href="https://github.com/OpenXT/openxt">https://github.com/OpenXT/openxt</a></div>
    <div>and here:&nbsp; <b><a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-freetext" target="_blank" href="https://github.com/OpenXT/">https://github.com/OpenXT/</a></b></div>
    <div>Best Regards,<br clear="none">
    </div>
    <pre class="yiv9999577738moz-signature">-- 
 Patrick
--</pre>
    <div class="yiv9999577738moz-cite-prefix">On 6/21/2016 5:26 AM, Jason Long wrote:<br clear="none">
    </div>
    <blockquote type="cite">
      <pre>I can't find any example :( Can you show me some urls?



On Monday, June 20, 2016 7:45 PM, Stephen Smalley <a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-rfc2396E" ymailto="mailto:sds@tycho.nsa.gov" target="_blank" href="mailto:sds@tycho.nsa.gov">&lt;sds@tycho.nsa.gov&gt;</a> wrote:
On 06/20/2016 11:06 AM, Jason Long wrote:
</pre>
      <blockquote type="cite">
        <pre>Can you show me some examples for both ?
</pre>
      </blockquote>
      <pre>I already pointed you to OpenXT; it is a worked example of both.


</pre>
      <blockquote type="cite">
        <pre>On Monday, June 20, 2016 5:13 PM, Stephen Smalley <a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-rfc2396E" ymailto="mailto:sds@tycho.nsa.gov" target="_blank" href="mailto:sds@tycho.nsa.gov">&lt;sds@tycho.nsa.gov&gt;</a> wrote:
On 06/19/2016 09:15 AM, Jason Long wrote:

</pre>
        <blockquote type="cite">
          <pre>Hello.
How can I protect my Xen VM via SElinux? Can you show me some useful examples?
</pre>
        </blockquote>
        <pre>I'm not entirely sure what you are asking, but possible answers:

1. If you want to apply SELinux-like controls over Xen virtual machines
(domains), then you can use Xen Security Modules and the Flask security
module (commonly abbreviated XSM/Flask) to define and enforce a policy
over the hypervisor objects and operations.

2. If you want to use SELinux to harden the Xen domain-0 or specific
domUs, you can just enable it in those domains and configure your policy
accordingly.

If you want a worked example of applying both XSM/Flask and SELinux,
have a look at OpenXT,
<a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-freetext" target="_blank" href="http://openxt.org/">http://openxt.org/</a>
_______________________________________________
Selinux mailing list
<a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-abbreviated" ymailto="mailto:Selinux@tycho.nsa.gov" target="_blank" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-abbreviated" ymailto="mailto:Selinux-leave@tycho.nsa.gov" target="_blank" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-abbreviated" ymailto="mailto:Selinux-request@tycho.nsa.gov" target="_blank" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.
</pre>
      </blockquote>
      <pre></pre>
      <blockquote type="cite">
        <pre></pre>
      </blockquote>
      <pre>_______________________________________________
Selinux mailing list
<a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-abbreviated" ymailto="mailto:Selinux@tycho.nsa.gov" target="_blank" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-abbreviated" ymailto="mailto:Selinux-leave@tycho.nsa.gov" target="_blank" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a rel="nofollow" shape="rect" class="yiv9999577738moz-txt-link-abbreviated" ymailto="mailto:Selinux-request@tycho.nsa.gov" target="_blank" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.
</pre>
    </blockquote>
    <div class="yiv9999577738yqt1728867965" id="yiv9999577738yqtfd26661"><br clear="none">
  </div></div></div><br><br></div>  </div> </div>  </div></div></body></html>
------=_Part_1824794_225943891.1466505900435--
