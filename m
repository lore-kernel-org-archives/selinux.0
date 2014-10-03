Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s93Irn2T000400
 for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2014 14:53:49 -0400
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com
 [209.85.192.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3A6101408EEE4
 for <selinux@tycho.nsa.gov>; Fri,  3 Oct 2014 20:53:53 +0200 (CEST)
Received: by mail-qg0-f46.google.com with SMTP id z60so1372202qgd.5
 for <selinux@tycho.nsa.gov>; Fri, 03 Oct 2014 11:53:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <542C490C.40506@tresys.com>
References: <1410375688-13335-1-git-send-email-nicolas.iooss@m4x.org>
 <542C490C.40506@tresys.com>
Date: Fri, 3 Oct 2014 20:53:51 +0200
Message-ID: <CAJfZ7=kgvSy3E_u3u=W=hihZstn2bYaOdz20mFzp4Zexof5fxw@mail.gmail.com>
Subject: Re: [PATCH] Use $(PYTHON) instead of "python" in every Makefile
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: Steve Lawrence <slawrence@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2014-10-01 20:33 GMT+02:00 Steve Lawrence <slawrence@tresys.com>:
> On 09/10/2014 03:01 PM, Nicolas Iooss wrote:
>> diff --git a/policycoreutils/sandbox/Makefile b/policycoreutils/sandbox/Makefile
>> index 567117038d4e..a6fb3435feb6 100644
>> --- a/policycoreutils/sandbox/Makefile
>> +++ b/policycoreutils/sandbox/Makefile
>
> I believe this file needs a "PYTHON ?= python" statement, right?
>
> Otherwise, this patch looks good to me.

You're right, I forgot to add this statement when I modified this file.

Thanks for having applied my patches

Nicolas
