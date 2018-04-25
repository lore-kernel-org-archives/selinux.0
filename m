Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3PHABmt025336
 for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2018 13:10:13 -0400
Received: by mail-ot0-f193.google.com with SMTP id i5-v6so26179319oth.1
 for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2018 10:09:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdq8sfyE5w-1-_-psMc5547cvh5zXvZ0ZWDgkpc8vk1o_w@mail.gmail.com>
References: <20180422192148.7320-1-nicolas.iooss@m4x.org>
 <20180422192148.7320-2-nicolas.iooss@m4x.org>
 <CAFftDdq8sfyE5w-1-_-psMc5547cvh5zXvZ0ZWDgkpc8vk1o_w@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 25 Apr 2018 10:09:40 -0700
Message-ID: <CAFftDdp9XsENjYomF8nn7d3_z1+dfMVAXDxtV2f=uKQ7BkFmBQ@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] sestatus: free process and file contexts
 which are checked
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Merged: https://github.com/SELinuxProject/selinux/pull/94

On Mon, Apr 23, 2018 at 9:54 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Sun, Apr 22, 2018 at 12:21 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>> clang's static analyzer reports a potential memory leak because the
>> buffers allocated in pc and fc are not freed in main(), in sestatus.c.
>> Free these buffers properly.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>  policycoreutils/sestatus/sestatus.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
>> index d7f198c2fa0d..9a92e72ff4fd 100644
>> --- a/policycoreutils/sestatus/sestatus.c
>> +++ b/policycoreutils/sestatus/sestatus.c
>> @@ -436,6 +436,7 @@ int main(int argc, char **argv)
>>                         printf("%s\n", context);
>>                         freecon(context);
>>                 }
>> +               free(pc[i]);
>>         }
>>
>>         printf("\nFile contexts:\n");
>> @@ -478,6 +479,7 @@ int main(int argc, char **argv)
>>                                 freecon(context);
>>                         }
>>                 }
>> +               free(fc[i]);
>>         }
>>
>>         return 0;
>> --
>> 2.17.0
>>
>>
> ack on both patches in this series.
