Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3PHIPlF025907
 for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2018 13:18:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID14.oob.disa.mil (Postfix) with SMTP id 40WRjq3hszz3dvtf
 for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2018 17:18:23 +0000 (UTC)
Received: from USFB19PA08.eemsg.mil (unknown [192.168.16.5])
 by USFBF3ID14.oob.disa.mil (Postfix) with ESMTP id 40WRjp1vrbz3dvtc
 for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2018 17:18:22 +0000 (UTC)
Received: by mail-oi0-f49.google.com with SMTP id n65-v6so21555006oig.6
 for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2018 10:18:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdr+rtJ8=FNS00CvdGXKGZf6K_Kix4J3FQvpxMnF7j9EZw@mail.gmail.com>
References: <20180422193032.8132-1-nicolas.iooss@m4x.org>
 <CAFftDdr+rtJ8=FNS00CvdGXKGZf6K_Kix4J3FQvpxMnF7j9EZw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 25 Apr 2018 10:09:30 -0700
Message-ID: <CAFftDdo1wmExpQmgjGnL1va4uFiZts3m2R6bdE7+xF6N1xNjkg@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] libsemanage: always check append_arg return
 value
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Merged: https://github.com/SELinuxProject/selinux/pull/94

On Mon, Apr 23, 2018 at 9:50 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Sun, Apr 22, 2018 at 12:30 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>> When split_args() calls append_arg(), the returned value needs to be
>> checked in order to detect memory allocation failure. Checks were
>> missing in two places, which are spotted by clang's static analyzer:
>>
>>     semanage_store.c:1352:7: warning: Value stored to 'rc' is never
>>     read
>>             rc = append_arg(&argv, &num_args, arg);
>>             ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     semanage_store.c:1368:3: warning: Value stored to 'rc' is never read
>>             rc = append_arg(&argv, &num_args, arg);
>>             ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>  libsemanage/src/semanage_store.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
>> index 14ad99c152ad..bce648c46464 100644
>> --- a/libsemanage/src/semanage_store.c
>> +++ b/libsemanage/src/semanage_store.c
>> @@ -1350,6 +1350,8 @@ static char **split_args(const char *arg0, char *arg_string,
>>                                 if (isspace(*s) && !in_quote && !in_dquote) {
>>                                         if (arg != NULL) {
>>                                                 rc = append_arg(&argv, &num_args, arg);
>> +                                               if (rc)
>> +                                                       goto cleanup;
>>                                                 free(arg);
>>                                                 arg = NULL;
>>                                         }
>> @@ -1366,6 +1368,8 @@ static char **split_args(const char *arg0, char *arg_string,
>>         }
>>         if (arg != NULL) {
>>                 rc = append_arg(&argv, &num_args, arg);
>> +               if (rc)
>> +                       goto cleanup;
>>                 free(arg);
>>                 arg = NULL;
>>         }
>> --
>> 2.17.0
>>
>>
>
> ack
