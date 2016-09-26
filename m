Subject: Re: [PATCH 3/3] libselinux: sefcontext_compile invert semantics of
 "-r" flag
To: William Roberts <bill.c.roberts@gmail.com>
References: <1474899756-93610-1-git-send-email-jdanis@android.com>
 <1474899756-93610-3-git-send-email-jdanis@android.com>
 <60891df7-2932-7d9a-d2d7-5252a0ccc946@tycho.nsa.gov>
 <CAFftDdpQ2Cq+qp+xGun_cs6JqryLXxrwqdTmuGDY9ynQUevd1w@mail.gmail.com>
Cc: Janis Danisevskis <jdanis@android.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 James Carter <jwcart2@tycho.nsa.gov>, Janis Danisevskis <jdanis@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <40c44ec6-8ba3-408f-f6cc-07d41a192694@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 13:53:09 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdpQ2Cq+qp+xGun_cs6JqryLXxrwqdTmuGDY9ynQUevd1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/26/2016 01:48 PM, William Roberts wrote:
> On Mon, Sep 26, 2016 at 10:43 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 09/26/2016 10:22 AM, Janis Danisevskis wrote:
>>> The "-r" flag of sefcontext_compile now causes it to omit the
>>> precompiled regular expressions from the output.
>>
>> The code itself looks ok, aside from William's suggestion. Experimenting
>> with this a bit, I noticed the following difference in sizes among the
>> various options:
>>
>> 383165  file_contexts (text)
>> 1507941 file_contexts.bin (binary with pcre1 regexes)
>> 8304105 file_contexts.bin (binary with pcre2 regexes)
>> 540540  file_contexts.bin (binary omitting pcre2 regexes, via -r)
> 
> What's the size of the textual intermediate file?

This was just taking the
/etc/selinux/targeted/contexts/files/file_contexts file on Fedora and
running it through sefcontext_compile built with and without USE_PCRE2=y
and in the PCRE2 case, running it with and without -r.  So the text size
above is exactly what was fed into sefcontext_compile, no intermediates.

> 
>>
>> The increase in file_contexts.bin size from pcre1 to pcre2 (unless using
>> -r) is quite substantial.  Wondering how that affects the cost/benefit
>> tradeoff...
>>
>>>
>>> Signed-off-by: Janis Danisevskis <jdanis@android.com>
>>> ---
>>>  libselinux/utils/sefcontext_compile.c | 12 +++++++-----
>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
>>> index 8c48d32..b2746c7 100644
>>> --- a/libselinux/utils/sefcontext_compile.c
>>> +++ b/libselinux/utils/sefcontext_compile.c
>>> @@ -276,10 +276,12 @@ static void usage(const char *progname)
>>>           "         will be fc_file with the .bin suffix appended.\n\t"
>>>           "-p       Optional binary policy file that will be used to\n\t"
>>>           "         validate contexts defined in the fc_file.\n\t"
>>> -         "-r       Include precompiled regular expressions in the output.\n\t"
>>> +         "-r       Omit precompiled regular expressions from the output.\n\t"
>>>           "         (PCRE2 only. Compiled PCRE2 regular expressions are\n\t"
>>> -         "         not portable across architectures. When linked against\n\t"
>>> -         "         PCRE this flag is ignored)\n\t"
>>> +         "         not portable across architectures. Use this flag\n\t"
>>> +         "         if you know that you build for an incompatible\n\t"
>>> +         "         architecture to save space. When linked against\n\t"
>>> +         "         PCRE1 this flag is ignored.)\n\t"
>>>           "-i       Print regular expression info end exit. That is, back\n\t"
>>>           "         end version and architecture identifier.\n\t"
>>>           "         Arch identifier format (PCRE2):\n\t"
>>> @@ -294,7 +296,7 @@ int main(int argc, char *argv[])
>>>  {
>>>       const char *path = NULL;
>>>       const char *out_file = NULL;
>>> -     int do_write_precompregex = 0;
>>> +     int do_write_precompregex = 1;
>>>       char stack_path[PATH_MAX + 1];
>>>       char *tmp = NULL;
>>>       int fd, rc, opt;
>>> @@ -315,7 +317,7 @@ int main(int argc, char *argv[])
>>>                       policy_file = optarg;
>>>                       break;
>>>               case 'r':
>>> -                     do_write_precompregex = 1;
>>> +                     do_write_precompregex = 0;
>>>                       break;
>>>               case 'i':
>>>                       printf("%s (%s)\n", regex_version(),
>>>
>>
> 
> 
> 
