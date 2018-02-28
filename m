Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1SJePXF029505
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 14:40:25 -0500
Received: by mail-oi0-f66.google.com with SMTP id a207so2662464oii.10
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 11:37:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdpu+8euQiny3LC2DSgVtCYO+P4+SziGfg9bbfESbDg_3A@mail.gmail.com>
References: <20180228121253.28440-1-vmojzis@redhat.com>
 <CAFftDdpu+8euQiny3LC2DSgVtCYO+P4+SziGfg9bbfESbDg_3A@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Feb 2018 11:37:47 -0800
Message-ID: <CAFftDdo8qNTe2Li1kd0c5gTkcHd2Ut6Xb7P-bCScfkAasbWGrA@mail.gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libsemanage: Improve warning for installing
 disabled module
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 28, 2018 at 9:44 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Wed, Feb 28, 2018 at 4:12 AM, Vit Mojzis <vmojzis@redhat.com> wrote:
>> Resolves: rhbz#1337199
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>>  libsemanage/src/direct_api.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>> index 88873c43..9c305c75 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -2797,7 +2797,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
>>                 if (higher_info->enabled == 0 && modinfo->enabled == -1) {
>>                         errno = 0;
>>                         WARN(sh,
>> -                            "%s module will be disabled after install due to default enabled status.",
>> +                            "%s module will be disabled after install as there is a disabled instance of this module present in the system.",
>>                              modinfo->name);
>>                 }
>>         }
>> --
>> 2.14.3
>>
>>
>
> ack

merged: https://github.com/SELinuxProject/selinux/pull/82
