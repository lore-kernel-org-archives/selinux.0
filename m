Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7M60KFp017557
 for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2018 02:00:22 -0400
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 402415613B9
 for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2018 07:59:37 +0200 (CEST)
Received: by mail-oi0-f52.google.com with SMTP id z185-v6so877545oia.5
 for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2018 22:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180819184901.6395-1-nicolas.iooss@m4x.org>
 <20180819184901.6395-3-nicolas.iooss@m4x.org>
 <CAFftDdqrOxwdTVYeZkHckgkrTpLrA=jmjU+DvGneOLb+M+Euzg@mail.gmail.com>
In-Reply-To: <CAFftDdqrOxwdTVYeZkHckgkrTpLrA=jmjU+DvGneOLb+M+Euzg@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 22 Aug 2018 07:59:25 +0200
Message-ID: <CAJfZ7=mfdPdZGau=1M7EB7GVeWTDzY-GuffwJeeP9K+LTEpixw@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 3/3] python: remove semicolon from end of lines
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 20, 2018 at 11:51 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> Ack on these as well

Thanks, I applied these patches and the previous ones I sent.

Nicolas

>
> On Sun, Aug 19, 2018 at 11:49 AM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>
>> Python does not need to end a statement with a semicolon. Doing this
>> gets reported by linters such as flake8 ("E703 statement ends with a
>> semicolon").
>>
>> Remove such semicolons in the code and enable this warning in
>> scripts/run-flake8.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>  python/sepolgen/src/sepolgen/audit.py | 2 +-
>>  python/sepolgen/src/sepolgen/yacc.py  | 8 ++++----
>>  python/sepolicy/sepolicy/manpage.py   | 2 +-
>>  scripts/run-flake8                    | 1 -
>>  4 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/python/sepolgen/src/sepolgen/audit.py b/python/sepolgen/src/sepolgen/audit.py
>> index daed58ce9643..4adb851f3e93 100644
>> --- a/python/sepolgen/src/sepolgen/audit.py
>> +++ b/python/sepolgen/src/sepolgen/audit.py
>> @@ -258,7 +258,7 @@ class AVCMessage(AuditMessage):
>>          if (scontext, tcontext, self.tclass, access_tuple) in avcdict.keys():
>>              self.type, self.data = avcdict[(scontext, tcontext, self.tclass, access_tuple)]
>>          else:
>> -            self.type, self.data = audit2why.analyze(scontext, tcontext, self.tclass, self.accesses);
>> +            self.type, self.data = audit2why.analyze(scontext, tcontext, self.tclass, self.accesses)
>>              if self.type == audit2why.NOPOLICY:
>>                  self.type = audit2why.TERULE
>>              if self.type == audit2why.BADTCON:
>> diff --git a/python/sepolgen/src/sepolgen/yacc.py b/python/sepolgen/src/sepolgen/yacc.py
>> index f00635469af1..afef174849f2 100644
>> --- a/python/sepolgen/src/sepolgen/yacc.py
>> +++ b/python/sepolgen/src/sepolgen/yacc.py
>> @@ -1864,10 +1864,10 @@ del _lr_action_items
>>  """)
>>
>>          else:
>> -            f.write("\n_lr_action = { ");
>> +            f.write("\n_lr_action = { ")
>>              for k,v in _lr_action.items():
>>                  f.write("(%r,%r):%r," % (k[0],k[1],v))
>> -            f.write("}\n");
>> +            f.write("}\n")
>>
>>          if smaller:
>>              # Factor out names to try and make smaller
>> @@ -1901,10 +1901,10 @@ for _k, _v in _lr_goto_items.items():
>>  del _lr_goto_items
>>  """)
>>          else:
>> -            f.write("\n_lr_goto = { ");
>> +            f.write("\n_lr_goto = { ")
>>              for k,v in _lr_goto.items():
>>                  f.write("(%r,%r):%r," % (k[0],k[1],v))
>> -            f.write("}\n");
>> +            f.write("}\n")
>>
>>          # Write production table
>>          f.write("_lr_productions = [\n")
>> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
>> index cb211ba083ca..cfcb7c3932d7 100755
>> --- a/python/sepolicy/sepolicy/manpage.py
>> +++ b/python/sepolicy/sepolicy/manpage.py
>> @@ -539,7 +539,7 @@ class ManPage:
>>                      self.fd = fd
>>                      self.man_page_path = man_page_path
>>              except KeyError:
>> -                continue;
>> +                continue
>>              self.attributes[domain_type] = next(sepolicy.info(sepolicy.TYPE, ("%s") % domain_type))["attributes"]
>>
>>          self._header()
>> diff --git a/scripts/run-flake8 b/scripts/run-flake8
>> index 8a1f490b8a62..207edd20dd89 100755
>> --- a/scripts/run-flake8
>> +++ b/scripts/run-flake8
>> @@ -14,7 +14,6 @@ IGNORE_LIST=''
>>  IGNORE_LIST="$IGNORE_LIST,W191" # indentation contains tabs
>>
>>  IGNORE_LIST="$IGNORE_LIST,E101" # indentation contains mixed spaces and tabs
>> -IGNORE_LIST="$IGNORE_LIST,E703" # statement ends with a semicolon
>>  IGNORE_LIST="$IGNORE_LIST,E711" # comparison to None should be 'if cond is not None:'
>>  IGNORE_LIST="$IGNORE_LIST,E712" # comparison to False should be 'if cond is False:' or 'if not cond:'
>>  IGNORE_LIST="$IGNORE_LIST,E722" # do not use bare 'except'
>> --
>> 2.18.0
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
