Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w76KAWxY022791
 for <selinux@tycho.nsa.gov>; Mon, 6 Aug 2018 16:10:34 -0400
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id C0D7F564847
 for <selinux@tycho.nsa.gov>; Mon,  6 Aug 2018 22:08:45 +0200 (CEST)
Received: by mail-oi0-f48.google.com with SMTP id y207-v6so24373422oie.13
 for <selinux@tycho.nsa.gov>; Mon, 06 Aug 2018 13:08:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mucohHDUZRGBWLOSjhbtC=KsJyH4Dbq_KVPy-A2P3Ong@mail.gmail.com>
References: <20180804091147.19092-1-nicolas.iooss@m4x.org>
 <20180804093426.GA33404@baraddur.perfinion.com>
 <CAJfZ7=mucohHDUZRGBWLOSjhbtC=KsJyH4Dbq_KVPy-A2P3Ong@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Mon, 6 Aug 2018 22:08:44 +0200
Message-ID: <CAJfZ7=kGiqQuHSzEVbuBbr10bePt=fa3ide++n9e+ONZnBVYKw@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] python/semanage: fix Python syntax of
 catching several exceptions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Aug 4, 2018 at 2:16 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On Sat, Aug 4, 2018 at 11:34 AM, Jason Zaman <jason@perfinion.com> wrote:
>> On Sat, Aug 04, 2018 at 11:11:47AM +0200, Nicolas Iooss wrote:
>>> "except OSError, ImportError:" does not perform what it says: it is the
>>> Python 2 syntax of catching OSError exceptions as "ImportError" (like
>>> "except OSError, e:"), and this is indeed caught by Python3:
>>>
>>>       File "./python/semanage/seobject.py", line 143
>>>         except OSError, ImportError:
>>>                       ^
>>>     SyntaxError: invalid syntax
>>>
>>> The correct syntax consists in using parentheses.
>>>
>>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>>
>> Acked-by: Jason Zaman <jason@perfinion.com>
>
> Thanks. I will wait one business day before merging this (in order to
> let other developers the possibility to comment, even though this
> change is trivial).

I applied this patch.
Nicolas
