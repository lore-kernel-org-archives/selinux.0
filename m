Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4IA0GYr030929
 for <selinux@tycho.nsa.gov>; Wed, 18 May 2016 06:00:16 -0400
Received: by mail-wm0-f43.google.com with SMTP id g17so70882755wme.1
 for <selinux@tycho.nsa.gov>; Wed, 18 May 2016 03:00:14 -0700 (PDT)
Subject: Re: [PATCH] semodule: Fix the --list-modules=full example in the
 manpage
To: Petr Lautrbach <plautrba@redhat.com>,
 Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <1463498859-5911-1-git-send-email-bigon@debian.org>
 <d0b9cdf7-a58f-5639-805b-721412d1ed76@redhat.com>
From: =?UTF-8?B?RGFsaWJvciBQb3Nww63FoWls?= <dapospis@redhat.com>
Message-ID: <627d6669-9b12-890f-0498-ec24c878daf8@redhat.com>
Date: Wed, 18 May 2016 12:00:11 +0200
MIME-Version: 1.0
In-Reply-To: <d0b9cdf7-a58f-5639-805b-721412d1ed76@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------1CF87C6236686F40E115904E"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------1CF87C6236686F40E115904E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

*Date: *Wed May 18 2016 09:57:47 GMT+0200 (CEST)
> On 05/17/2016 05:27 PM, Laurent Bigonville wrote:
>> From: Laurent Bigonville <bigon@bigon.be>
>>
>> ---
>>   policycoreutils/semodule/semodule.8 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
>> index 68e95ab..7b07c45 100644
>> --- a/policycoreutils/semodule/semodule.8
>> +++ b/policycoreutils/semodule/semodule.8
>> @@ -116,7 +116,7 @@ $ semodule \-d alsa
>>   # Install a module at a specific priority.
>>   $ semodule \-X 100 \-i alsa.pp
>>   # List all modules.
>> -$ semodule \-l full
>> +$ semodule \-\-list-modules=full
> It works without " " before full:
>
> $ semodule -lfull
>
> What about:
>
> policycoreutils/semodule/semodule.8:
>
>   .TP
> -.B  \-l,\-\-list-modules=[KIND]
> +.B  \-l[KIND],\-\-list-modules[=KIND]
>   display list of installed modules (other than base)
>
>   # List all modules.
> -$ semodule \-l full
> +$ semodule \-lfull
Wouldn't it be more natural to use 'all' instead of 'full' to express listing of all modules? I would expect 'full' as an option to some kind of formatting, like displaying full details.
>   # Set an alternate path for the policy root
>
>
> policycoreutils/semodule/semodule.c:
>
>          printf("  -r,--remove=MODULE_NAME   remove existing module\n");
> -       printf("  -l,--list-modules=[KIND]  display list of installed
> modules\n");
> +       printf("  -l[KIND],--list-modules[=KIND]  display list of
> installed modules\n");
>          printf("     KIND:  standard  list highest priority, enabled
> modules\n");
>
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--------------1CF87C6236686F40E115904E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <b>Date: </b>Wed May 18 2016 09:57:47 GMT+0200 (CEST)<br>
    <blockquote
      cite="mid:d0b9cdf7-a58f-5639-805b-721412d1ed76@redhat.com"
      type="cite">
      <pre wrap="">On 05/17/2016 05:27 PM, Laurent Bigonville wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">From: Laurent Bigonville <a class="moz-txt-link-rfc2396E" href="mailto:bigon@bigon.be">&lt;bigon@bigon.be&gt;</a>

---
 policycoreutils/semodule/semodule.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 68e95ab..7b07c45 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -116,7 +116,7 @@ $ semodule \-d alsa
 # Install a module at a specific priority.
 $ semodule \-X 100 \-i alsa.pp
 # List all modules.
-$ semodule \-l full
+$ semodule \-\-list-modules=full
</pre>
      </blockquote>
      <pre wrap="">
It works without " " before full:

$ semodule -lfull

What about:

policycoreutils/semodule/semodule.8:

 .TP
-.B  \-l,\-\-list-modules=[KIND]
+.B  \-l[KIND],\-\-list-modules[=KIND]
 display list of installed modules (other than base)

 # List all modules.
-$ semodule \-l full
+$ semodule \-lfull</pre>
    </blockquote>
    Wouldn't it be more natural to use 'all' instead of 'full' to
    express listing of all modules? I would expect 'full' as an option
    to some kind of formatting, like displaying full details.<br>
    <blockquote
      cite="mid:d0b9cdf7-a58f-5639-805b-721412d1ed76@redhat.com"
      type="cite">
      <pre wrap="">
 # Set an alternate path for the policy root


policycoreutils/semodule/semodule.c:

        printf("  -r,--remove=MODULE_NAME   remove existing module\n");
-       printf("  -l,--list-modules=[KIND]  display list of installed
modules\n");
+       printf("  -l[KIND],--list-modules[=KIND]  display list of
installed modules\n");
        printf("     KIND:  standard  list highest priority, enabled
modules\n");



</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Selinux mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------1CF87C6236686F40E115904E--
