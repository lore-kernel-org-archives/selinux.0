Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w74CHhM2009990
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 08:17:45 -0400
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1C5E55607AF
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 14:16:31 +0200 (CEST)
Received: by mail-oi0-f44.google.com with SMTP id k12-v6so14468413oiw.8
 for <selinux@tycho.nsa.gov>; Sat, 04 Aug 2018 05:16:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180804093426.GA33404@baraddur.perfinion.com>
References: <20180804091147.19092-1-nicolas.iooss@m4x.org>
 <20180804093426.GA33404@baraddur.perfinion.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 4 Aug 2018 14:16:29 +0200
Message-ID: <CAJfZ7=mucohHDUZRGBWLOSjhbtC=KsJyH4Dbq_KVPy-A2P3Ong@mail.gmail.com>
To: Jason Zaman <jason@perfinion.com>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] python/semanage: fix Python syntax of
 catching several exceptions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Aug 4, 2018 at 11:34 AM, Jason Zaman <jason@perfinion.com> wrote:
> On Sat, Aug 04, 2018 at 11:11:47AM +0200, Nicolas Iooss wrote:
>> "except OSError, ImportError:" does not perform what it says: it is the
>> Python 2 syntax of catching OSError exceptions as "ImportError" (like
>> "except OSError, e:"), and this is indeed caught by Python3:
>>
>>       File "./python/semanage/seobject.py", line 143
>>         except OSError, ImportError:
>>                       ^
>>     SyntaxError: invalid syntax
>>
>> The correct syntax consists in using parentheses.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Jason Zaman <jason@perfinion.com>

Thanks. I will wait one business day before merging this (in order to
let other developers the possibility to comment, even though this
change is trivial).

>> ---
>> For the record, I found this while playing with flake8 Python's linter.
>> I am currently working on upstreaming a script which would run this on
>> our Travis-CI environment in order to catch Python syntax errors before
>> they are introduced.
>
> Awesome! more linters are always good. I really do need to find the time
> to kill seobject more thoroughly tho, its so slow compared to direct
> setools. :(

The more I look into flake8, the more I want to make it integrated to
our review process... I will send a few patches later today in order
to fix issues that it found in the Python code (for example "procotol"
instead of "protocol" in sepolicy/gui.py).

Cheers,
Nicolas
