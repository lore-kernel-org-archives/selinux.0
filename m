MIME-Version: 1.0
In-Reply-To: <1fa3c006-bfa9-357e-7f88-1c8dfa50a0d2@tycho.nsa.gov>
References: <1474031328-29743-1-git-send-email-jdanis@android.com>
 <1fa3c006-bfa9-357e-7f88-1c8dfa50a0d2@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 16 Sep 2016 08:08:55 -0700
Message-ID: <CAFftDdrwgiFBsA182ZT-q=9P3Vi01E4jq0EY=C2vc6usFr_kyA@mail.gmail.com>
Subject: Re: [PATCH] Change semantic of -r in sefcontext_compile
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Janis Danisevskis <jdanis@android.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 16, 2016 at 7:41 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/16/2016 09:08 AM, Janis Danisevskis wrote:
>> This patch reestablishes the default behavior of sefcontext_compile
>> to include precompiled regular expressions in the output. If linked
>> against PCRE2 the flag "-r" now causes the precompiled regular
>> expressions to be omitted from the output.
>
> I thought your original rationale was more compelling.  If we add
> detection of the relevant arch properties, then we can do this.
> Otherwise, I don't think we should.

I was assuming based on the thread earlier that those patches would be coming.
If we cant detect and compile on the current "undefined behavior"
case, then this
needs to stay as is.

But I thought someone had a list of PCRE things that can be checked for "arch",
so its just a matter of encoding those, assuming that list is correct.

Binary file_contexts only make sense if you compile in the regex info, else
just use the textual representation.

>
>> ---
>>  libselinux/utils/sefcontext_compile.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
>> index 770ec4c..c1284d5 100644
>> --- a/libselinux/utils/sefcontext_compile.c
>> +++ b/libselinux/utils/sefcontext_compile.c
>> @@ -263,12 +263,10 @@ static void usage(const char *progname)
>>           "         will be fc_file with the .bin suffix appended.\n\t"
>>           "-p       Optional binary policy file that will be used to\n\t"
>>           "         validate contexts defined in the fc_file.\n\t"
>> -         "-r       Include precompiled regular expressions in the output.\n\t"
>> +         "-r       Omit precompiled regular expressions in the output.\n\t"
>>           "         (PCRE2 only. Compiled PCRE2 regular expressions are\n\t"
>>           "         not portable across architectures. When linked against\n\t"
>>           "         PCRE this flag is ignored)\n\t"
>> -         "         Omit precompiled regular expressions (only meaningful\n\t"
>> -         "         when using PCRE2 regular expression back-end).\n\t"
>>           "fc_file  The text based file contexts file to be processed.\n",
>>           progname);
>>               exit(EXIT_FAILURE);
>> @@ -278,7 +276,7 @@ int main(int argc, char *argv[])
>>  {
>>       const char *path = NULL;
>>       const char *out_file = NULL;
>> -     int do_write_precompregex = 0;
>> +     int do_write_precompregex = 1;
>>       char stack_path[PATH_MAX + 1];
>>       char *tmp = NULL;
>>       int fd, rc, opt;
>> @@ -299,7 +297,7 @@ int main(int argc, char *argv[])
>>                       policy_file = optarg;
>>                       break;
>>               case 'r':
>> -                     do_write_precompregex = 1;
>> +                     do_write_precompregex = 0;
>>                       break;
>>               default:
>>                       usage(argv[0]);
>>
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Seandroid-list-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
