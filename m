Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w59JQBX6000390
 for <selinux@tycho.nsa.gov>; Sat, 9 Jun 2018 15:26:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 4138QS06ykzg473
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 19:26:08 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 4138QQ60FRzg46x
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 19:26:06 +0000 (UTC)
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E64625613BA
 for <selinux@tycho.nsa.gov>; Sat,  9 Jun 2018 21:26:00 +0200 (CEST)
Received: by mail-oi0-f48.google.com with SMTP id i205-v6so14696886oib.1
 for <selinux@tycho.nsa.gov>; Sat, 09 Jun 2018 12:26:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605143405.4491-4-jzarsky@redhat.com>
References: <20180605143405.4491-1-jzarsky@redhat.com>
 <20180605143405.4491-4-jzarsky@redhat.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 9 Jun 2018 21:25:59 +0200
Message-ID: <CAJfZ7==4xn3ypPJGFzLOPMsD9HRmRUWFZWsUnqeiRHpjndkoDA@mail.gmail.com>
To: Jan Zarsky <jzarsky@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 3/3] python: add xperms support to audit2allow
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2018-06-05 16:34 GMT+02:00 Jan Zarsky <jzarsky@redhat.com>:
> Add support for extended permissions to audit2allow. Extend AuditParser
> to parse the 'ioctlcmd' field in AVC message. Extend PolicyGenerator to
> generate allowxperm rules. Add the '-x'/'--xperms' option to audit2allow
> to turn on generating of extended permission AV rules.
>
> AVCMessage parses the ioctlcmd field in AVC messages. AuditParser
> converts the ioctlcmd values into generic representation of extended
> permissions that is stored in access vectors.
>
> Extended permissions are represented by operations (currently only
> 'ioctl') and values associated to the operations. Values (for example
> '~{ 0x42 1234 23-34 }') are stored in the XpermSet class.
>
> PolicyGenerator contains new method to turn on generating of xperms.
> When turned on, for each access vector, standard AV rule and possibly
> several xperm AV rules are generated. Xperm AV rules are represented by
> the AVExtRule class.
>
> With xperm generating turned off, PolicyGenerator provides comments
> about extended permissions in certain situations. When the AVC message
> contains the ioctlcmd field and the access would be allowed according to
> the policy, PolicyGenerator warns about xperm rules being the possible
> cause of the denial.
>
> Signed-off-by: Jan Zarsky <jzarsky@redhat.com>

Hello,
Thanks for these patches. The first two look good to me and I will
merge them if nobody else has a comment on them. On the third one, it
is really nice it introduces more tests :) I have successfully run
them.

On the code itself, please find some comments below (one Python syntax
and two minor whitespace issues).

> diff --git a/python/sepolgen/src/sepolgen/audit.py b/python/sepolgen/src/sepolgen/audit.py
> index 26ce6c92..aae41e89 100644
> --- a/python/sepolgen/src/sepolgen/audit.py
> +++ b/python/sepolgen/src/sepolgen/audit.py
> @@ -237,6 +239,11 @@ class AVCMessage(AuditMessage):
>                  self.exe = fields[1][1:-1]
>              elif fields[0] == "name":
>                  self.name = fields[1][1:-1]
> +            elif fields[0] == "ioctlcmd":
> +                try:
> +                    self.ioctlcmd = int(fields[1], 16)
> +                except:
> +                    pass

Please do not introduce new bare "except". It also intercepts
KeyboardInterrupt which may cause issues when the command takes too
much time. It is quite difficult to change the existing ones in the
code because there may be some tricky exceptions which are
legitimately caught, but here, a "except ValueError" is better.


> diff --git a/python/sepolgen/tests/test_access.py b/python/sepolgen/tests/test_access.py
> index d45a823e..39424539 100644
> --- a/python/sepolgen/tests/test_access.py
> +++ b/python/sepolgen/tests/test_access.py
[...]
> +        s.add_av = test_add_av
> +
> +        s.add("foo", "bar", "file", refpolicy.IdSet(["read"]),
> +              audit_msg='test message', avc_type=42, data='test data')
> +

There is a stray end of line here. My git reports:

    <stdin>:159: new blank line at EOF.
    +
    warning: 1 line adds whitespace errors.

> diff --git a/python/sepolgen/tests/test_refpolicy.py b/python/sepolgen/tests/test_refpolicy.py
> index 16e66806..0bcbd8e0 100644
> --- a/python/sepolgen/tests/test_refpolicy.py
> +++ b/python/sepolgen/tests/test_refpolicy.py
[...]
> +class TestAVExtRule(unittest.TestCase):
> +    def test_init(self):
> +        """ Test initialization of attributes """
> +        a = refpolicy.AVExtRule()
> +        self.assertEqual(a.rule_type, a.ALLOWXPERM)
> +        self.assertIsInstance(a.src_types, set)
> +        self.assertIsInstance(a.tgt_types, set)
> +        self.assertIsInstance(a.obj_classes, set)
> +        self.assertIsNone(a.operation)
> +        self.assertIsInstance(a.xperms, refpolicy.XpermSet)
> +
> +    def test_rule_type_str(self):

There is a empty line with whitespaces right before this function. My
git reports:

    <stdin>:102: trailing whitespace.

    warning: 1 line adds whitespace errors.


If you send a new patch which fixes these comments, I will gladly merge it.

Thanks!
Nicolas
