Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2JGIuNt024072
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 12:18:56 -0400
Received: by mail-oi0-f66.google.com with SMTP id f186so14796357oig.4
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 09:18:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdpngTjziTgfCvdEFD6Bmqm4=hqpDuJf73Z5W8ac8mgPnA@mail.gmail.com>
References: <20180317072616.GA4209@workstation>
 <20180319144615.4843-1-vmojzis@redhat.com>
 <CAFftDdpngTjziTgfCvdEFD6Bmqm4=hqpDuJf73Z5W8ac8mgPnA@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 19 Mar 2018 09:18:48 -0700
Message-ID: <CAFftDdrG-M0i_fuvV6=pAdgswYubkS+5dYhYD6m=ZKNkWRkraw@mail.gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libsemanage/direct_api.c: Fix iterating over
 array
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Mar 19, 2018 at 8:19 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Mon, Mar 19, 2018 at 7:46 AM, Vit Mojzis <vmojzis@redhat.com> wrote:
>> Fix sizeof calculation in array iteration introduced by commit
>> 6bb8282c4cf66e93daa9684dbe9c75bb6b1e09a7
>> "libsemanage: replace access() checks to make setuid programs work"
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>>  libsemanage/src/direct_api.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>> index 439122df..e7ec952f 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -60,6 +60,7 @@
>>
>>  #define PIPE_READ 0
>>  #define PIPE_WRITE 1
>> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>>
>>  static void semanage_direct_destroy(semanage_handle_t * sh);
>>  static int semanage_direct_disconnect(semanage_handle_t * sh);
>> @@ -1332,7 +1333,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>                                            SEMANAGE_SEUSERS_LINKED,
>>                                            SEMANAGE_USERS_EXTRA_LINKED};
>>
>> -               for (i = 0; i < (int) sizeof(files); i++) {
>> +               for (i = 0; i < (int) ARRAY_SIZE(files); i++) {
>>                         path = semanage_path(SEMANAGE_TMP, files[i]);
>>                         if (stat(path, &sb) != 0) {
>>                                 if (errno != ENOENT) {
>> --
>> 2.14.3
>>
>>
> ack

Thanks, merged:
https://github.com/SELinuxProject/selinux/pull/87

>
> Just noticing: that code has i as an int, which it probably should be size_t and
> the files array as an array of int's, it should probably use the
> enum type.
