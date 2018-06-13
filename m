Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5DJOHX5011262
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 15:24:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 415cBP31W9zrKYX
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 19:24:13 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 415cBN5RVlzrKYY
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 19:24:12 +0000 (UTC)
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so5674668lfc.2
 for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2018 12:24:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ae0ff4a782ed824fc92fa6fe4795c9c35c13967d.camel@btinternet.com>
References: <20180413101315.21749-1-richard_c_haines@btinternet.com>
 <CAHC9VhRL54-kuytrqGCMG0AdL_nBNL9S2rFuFHbkh12F=STxjw@mail.gmail.com>
 <ae0ff4a782ed824fc92fa6fe4795c9c35c13967d.camel@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Jun 2018 15:23:09 -0400
Message-ID: <CAHC9VhS+QMG26daM1C61eCmmbi280_8xb3SztCWb_n=7FaNWQg@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux-testsuite: Enhance inet_socket tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jun 13, 2018 at 12:46 PM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Tue, 2018-06-12 at 18:02 -0400, Paul Moore wrote:
>> On Fri, Apr 13, 2018 at 6:13 AM, Richard Haines via Selinux
>> <selinux@tycho.nsa.gov> wrote:
>> > Enhance the tests as follows:
>> > 1) Determine number of tests to run with current config.
>> > 2) Add CALIPSO STREAM tests (DGRAM not supported in kernel. See
>> > [1]).
>> > 3) Add support for CIPSO TAGS 1 & 2. Closes [2].
>> > 4) Run scripts using /bin/sh.
>> > 5) Shorten sleep time as more tests.
>> >
>> > [1] https://github.com/SELinuxProject/selinux-kernel/issues/24
>> > [2] https://github.com/SELinuxProject/selinux-testsuite/issues/1
>> >
>> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> > ---
>> >  tests/inet_socket/calipso-flush                 |   5 +
>> >  tests/inet_socket/calipso-load                  |   7 +
>> >  tests/inet_socket/cipso-fl-flush                |   0
>> >  tests/inet_socket/cipso-fl-load                 |   0
>> >  tests/inet_socket/cipso-flush                   |   0
>> >  tests/inet_socket/cipso-load-t1                 |  11 +
>> >  tests/inet_socket/cipso-load-t2                 |  11 +
>> >  tests/inet_socket/{cipso-load => cipso-load-t5} |   0
>> >  tests/inet_socket/ipsec-flush                   |   0
>> >  tests/inet_socket/ipsec-load                    |   0
>> >  tests/inet_socket/iptables-flush                |   0
>> >  tests/inet_socket/iptables-load                 |   0
>> >  tests/inet_socket/server.c                      |  16 +-
>> >  tests/inet_socket/test                          | 348
>> > ++++++++++++++++++------
>> >  14 files changed, 310 insertions(+), 88 deletions(-)
>> >  create mode 100644 tests/inet_socket/calipso-flush
>> >  create mode 100644 tests/inet_socket/calipso-load
>> >  mode change 100755 => 100644 tests/inet_socket/cipso-fl-flush
>> >  mode change 100755 => 100644 tests/inet_socket/cipso-fl-load
>> >  mode change 100755 => 100644 tests/inet_socket/cipso-flush
>> >  create mode 100644 tests/inet_socket/cipso-load-t1
>> >  create mode 100644 tests/inet_socket/cipso-load-t2
>> >  rename tests/inet_socket/{cipso-load => cipso-load-t5} (100%)
>> >  mode change 100755 => 100644
>> >  mode change 100755 => 100644 tests/inet_socket/ipsec-flush
>> >  mode change 100755 => 100644 tests/inet_socket/ipsec-load
>> >  mode change 100755 => 100644 tests/inet_socket/iptables-flush
>> >  mode change 100755 => 100644 tests/inet_socket/iptables-load
>> >  mode change 100755 => 100644 tests/inet_socket/test
>>
>> I had to fixup the file mode bits on tests/inet_socket/test, but
>> other
>> than that this looks fine to me, merged.  Thanks.
>
> The reason I have not been setting +x on the tests/*/test scripts is
> that the tests/Makefile does it for you. However as all the others are
> set, I'll set +x in future (as you flagged this on the sctp and binder
> patches I sent).

Please do.  The issue is that whenever you run the tests it changes
the mode bits from how they are in the git repository.  While not
really a problem for people who just take a snapshot of the tests, it
does cause problems for those of us who push/pull from the repo as it
registers as a change (check "git status").

>> I remain a little wary about the reduced sleep times (1s to 0.25s),
>> but I'm never comfortable with arbitrary sleep-and-hope-it-works
>> tricks anyway.
>
> I've been using this value in the SCTP tests for some time and not had
> any problems, that's why I used it for the inet tests (probably better
> to have the client try connecting x times and do away with the wait)

It's working on my test VMs, so from a selfish point of view I'm fine
with it for right now :)  My concern isn't from an observed failure
with the change, but rather bad experiences with similar approaches on
other projects.  In other words, I'm just being cranky.

-- 
paul moore
www.paul-moore.com
