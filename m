Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5GDHXJk024156
 for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2018 09:17:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 417Hvv2qs4zJ33s
 for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2018 13:17:31 +0000 (UTC)
Received: from UPBD19PA06.eemsg.mil (unknown [192.168.18.7])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 417Hvt2lKHzJ33t
 for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2018 13:17:30 +0000 (UTC)
Received: from mail-ot0-f171.google.com (mail-ot0-f171.google.com
 [74.125.82.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5900556467B
 for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2018 15:16:47 +0200 (CEST)
Received: by mail-ot0-f171.google.com with SMTP id v24-v6so5398421otk.13
 for <selinux@tycho.nsa.gov>; Sat, 16 Jun 2018 06:16:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612090659.5429-1-jzarsky@redhat.com>
References: <CAJfZ7==4xn3ypPJGFzLOPMsD9HRmRUWFZWsUnqeiRHpjndkoDA@mail.gmail.com>
 <20180612090659.5429-1-jzarsky@redhat.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sat, 16 Jun 2018 15:16:45 +0200
Message-ID: <CAJfZ7==GyKYn6V4oXz+NWF-W7RLKVUZjPjz1e7mNAr37z=iXeg@mail.gmail.com>
To: Jan Zarsky <jzarsky@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V2 3/3] python: add xperms support to audit2allow
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2018-06-12 11:06 GMT+02:00 Jan Zarsky <jzarsky@redhat.com>:
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
> ---
>
> V2 fixes two whitespace issues, in audit.py uses 'except ValueError'
> instead of bare except, and fixes typo in error message in policygen.py

Thanks. I have applied your three patches.

Nicolas
