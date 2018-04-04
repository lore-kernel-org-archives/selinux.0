Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w34GHxFp028506
 for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2018 12:17:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id 188-v6so19750656oih.8
 for <selinux@tycho.nsa.gov>; Wed, 04 Apr 2018 09:16:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdpPLW1ysWF5gFPCZghDPo3ruwbbWjizJ60ZVyQ10=bc0g@mail.gmail.com>
References: <20180330001642.2374-1-ykhodo@gmail.com>
 <CAFftDdpPLW1ysWF5gFPCZghDPo3ruwbbWjizJ60ZVyQ10=bc0g@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 4 Apr 2018 11:09:50 -0500
Message-ID: <CAFftDdoT_MqQ0YVQbPk_3omz1L1NC4ei02SwUa4Y=sA-igk=bA@mail.gmail.com>
To: Yuli Khodorkovskiy <ykhodo@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v3 0/2] restorecon context validation improvement
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 30, 2018 at 11:59 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Thu, Mar 29, 2018 at 5:16 PM, Yuli Khodorkovskiy <ykhodo@gmail.com> wrote:
>> In permissive, if a bad label is written to a file_context file,
>> restorecon will not verify the label before succesfully applying the
>> context. These patches fix validation of labels during restorecon
>> while not breaking current behavior of lazy validation.
>>
>> Changes since V1:
>> - Continue using lazy validation for restorecon that was broken in V1 of
>> the patch.
>> - Add line number tracking for error messages in restorecon.
>>
>> Changes since V2:
>> - Fix compiler error caused by unused variable in selabel_validate()
>>
>> Yuli Khodorkovskiy (2):
>>   libselinux: verify file_contexts when using restorecon
>>   libselinux: echo line number of bad label in selabel_fini()
>>
>>  libselinux/src/label.c                  | 7 +++----
>>  libselinux/src/label_backends_android.c | 2 +-
>>  libselinux/src/label_file.c             | 2 +-
>>  libselinux/src/label_file.h             | 3 ++-
>>  libselinux/src/label_internal.h         | 7 +++----
>>  libselinux/src/matchpathcon.c           | 5 ++---
>>  6 files changed, 12 insertions(+), 14 deletions(-)
>>
>> --
>> 2.14.3
>>
>>
>
> These look good to me and pass all my testing. I have them on
> github passing CI as well:
> https://github.com/SELinuxProject/selinux/pull/90
>
> ack. Unless someone finds an issue, will merge
> on 4/3.

merged. Thank you.
