To: William Roberts <bill.c.roberts@gmail.com>,
 Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
References: <20180413203424.20542-1-nicolas.iooss@m4x.org>
 <20180413203424.20542-5-nicolas.iooss@m4x.org>
 <CAFftDdqZh7r6VE-f0f+hVEd0fXp89PZiubZTcLPcqgjfhNoqZw@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <186a7aed-f9ff-4144-d03a-ff8e83e8b851@tycho.nsa.gov>
Date: Mon, 16 Apr 2018 08:34:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdqZh7r6VE-f0f+hVEd0fXp89PZiubZTcLPcqgjfhNoqZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 5/5] libselinux: remove unused variable usercon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/13/2018 08:40 PM, William Roberts wrote:
> In general this series looks fine.
> 
> However, checkpatch.pl is complaining about DOS line endings in your patches:
> 
> For example:
> ERROR: DOS line endings
> #325: FILE: libselinux/src/label_file.h:281:
> +^I^Iint alloc_stems = data->alloc_stems * 2 + 16;^M$

If needed, dos2unix can be used to strip them. However, I think git am takes care of this for you.

> 
> 
> 
> 
> 
> On Fri, Apr 13, 2018 at 1:34 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>> In getconlist.c, main() does not use usercon. Remove this variable.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>  libselinux/utils/getconlist.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
>> index abfe2c742bfb..5ac0ca85075c 100644
>> --- a/libselinux/utils/getconlist.c
>> +++ b/libselinux/utils/getconlist.c
>> @@ -19,7 +19,7 @@ static __attribute__ ((__noreturn__)) void usage(const char *name, const char *d
>>
>>  int main(int argc, char **argv)
>>  {
>> -       char **list, *usercon = NULL, *cur_context = NULL;
>> +       char **list, *cur_context = NULL;
>>         char *user = NULL, *level = NULL;
>>         int ret, i, opt;
>>
>> @@ -69,7 +69,6 @@ int main(int argc, char **argv)
>>                 freeconary(list);
>>         }
>>
>> -       free(usercon);
>>         free(level);
>>
>>         return 0;
>> --
>> 2.17.0
>>
>>
> 
