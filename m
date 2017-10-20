Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9KGR4nT025535
 for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2017 12:27:04 -0400
Received: by mail-it0-f67.google.com with SMTP id y15so14505370ita.4
 for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2017 09:02:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABXk95D88yx3PV4XRkKTtr_u3SscQGsEVde=a5miX0KoAag4Ww@mail.gmail.com>
References: <20171019234915.21820-1-jaekyun@google.com>
 <CABXk95D88yx3PV4XRkKTtr_u3SscQGsEVde=a5miX0KoAag4Ww@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 20 Oct 2017 09:02:17 -0700
Message-ID: <CAFftDdp9jSrU9Q4EcXNAEgXr43gBq3+4i3+WVJbkgpQ6GbNrGQ@mail.gmail.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: Jaekyun Seok <jaekyun@google.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libselinux: android: support exact match for a
 property key
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Oct 20, 2017 at 7:54 AM, Jeffrey Vander Stoep via Selinux
<selinux@tycho.nsa.gov> wrote:
> Please hold off on submission. We're discussing if this is really necessary.

Yeah I'd like to hear about what issues the current longest match
logic was causing
in the commit message.

>
> On Thu, Oct 19, 2017 at 4:49 PM, Jaekyun Seok via Selinux
> <selinux@tycho.nsa.gov> wrote:
>> Performs exact match if a property key of property contexts ends with '$'
>> instead of prefix match.

This seems like an overly verbose way to accomplish exact match. The
property_contexts
file has things like:

*                  <-- match everything
foo.bar.       <- match prefix foo.bar. properties
foo.bar.baz <-- currently matches foo.bar.baz, foo.bar.bazbaz, etc. No
trailing .
                        could be changed to mean exact match.

Really what you would want is that if it doesn't end with a dot, don't
do a prefix
match. No need to add the $ semantic AFAICT.

>>
>> This will enable to define an exact rule which can avoid unexpected
>> context assignment.
>>
>> Signed-off-by: Jaekyun Seok <jaekyun@google.com>
>> ---
>>  libselinux/src/label_backends_android.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
>> index cb8aae26..4611d396 100644
>> --- a/libselinux/src/label_backends_android.c
>> +++ b/libselinux/src/label_backends_android.c
>> @@ -258,8 +258,13 @@ static struct selabel_lookup_rec *property_lookup(struct selabel_handle *rec,
>>         }
>>
>>         for (i = 0; i < data->nspec; i++) {
>> -               if (strncmp(spec_arr[i].property_key, key,
>> -                           strlen(spec_arr[i].property_key)) == 0) {
>> +               size_t property_key_len = strlen(spec_arr[i].property_key);
>> +               if (spec_arr[i].property_key[property_key_len - 1] == '$' &&
>> +                   strlen(key) == property_key_len - 1 &&
>> +                   strncmp(spec_arr[i].property_key, key, property_key_len - 1) == 0) {
>> +                       break;
>> +               }
>> +               if (strncmp(spec_arr[i].property_key, key, property_key_len) == 0) {
>>                         break;
>>                 }
>>                 if (strncmp(spec_arr[i].property_key, "*", 1) == 0)
>> --
>> 2.15.0.rc0.271.g36b669edcc-goog
>>
>>
>



-- 
Respectfully,

William C Roberts
