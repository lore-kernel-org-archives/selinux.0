Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s466puV4030595
 for <selinux@tycho.nsa.gov>; Tue, 6 May 2014 02:51:56 -0400
Received: by mail-ig0-f170.google.com with SMTP id r10so5429929igi.1
 for <selinux@tycho.nsa.gov>; Mon, 05 May 2014 23:51:57 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.87.30])
 by mx.google.com with ESMTPSA id m1sm35649894igx.13.2014.05.05.23.51.55
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 05 May 2014 23:51:56 -0700 (PDT)
Message-ID: <536885EE.7020903@gmail.com>
Date: Tue, 06 May 2014 12:19:18 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: How does policy loading work at bootup?
References: <5365CECF.5010808@gmail.com> <53677D27.9040802@tresys.com>
In-Reply-To: <53677D27.9040802@tresys.com>
Content-Type: multipart/alternative;
 boundary="------------020901040004060504040306"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------020901040004060504040306
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/05/14 17:29, Christopher J. PeBenito wrote:
> On 05/04/2014 01:23 AM, dE wrote:
>> Does the kernel automatically searches for and reads the policies in hard coded locations or does some userspace tool does that at startup via init/systemd scripts/units?
> A long long time ago (before SELinux was accepted into Linus's tree), the kernel used to read the policy itself.  Now it is loaded by userspace, typically either by the init program, or by the initramfs.
>

Got it. It's load_policy.

Thanks for the assistance.

--------------020901040004060504040306
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 05/05/14 17:29, Christopher J.
      PeBenito wrote:<br>
    </div>
    <blockquote cite="mid:53677D27.9040802@tresys.com" type="cite">
      <pre wrap="">On 05/04/2014 01:23 AM, dE wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Does the kernel automatically searches for and reads the policies in hard coded locations or does some userspace tool does that at startup via init/systemd scripts/units?
</pre>
      </blockquote>
      <pre wrap="">
A long long time ago (before SELinux was accepted into Linus's tree), the kernel used to read the policy itself.  Now it is loaded by userspace, typically either by the init program, or by the initramfs.

</pre>
    </blockquote>
    <br>
    Got it. It's load_policy.<br>
    <br>
    Thanks for the assistance.
    <title></title>
    <meta name="GENERATOR" content="LibreOffice 4.1.4.2 (Linux)">
    <style type="text/css">
	<!--
		@page { margin: 0.79in }
		P { margin-bottom: 0.12in }
		P.western { font-family: "Calibri", sans-serif; font-size: 14pt }
	-->
	</style>
  </body>
</html>

--------------020901040004060504040306--
