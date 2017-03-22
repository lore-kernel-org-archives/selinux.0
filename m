Subject: Re: [PATCH 0/3 v2] libsepol and checkpolicy: Output CIL or
 policy.conf from kernel policy
To: Nicolas Iooss <nicolas.iooss@m4x.org>
References: <1490024417-12717-1-git-send-email-jwcart2@tycho.nsa.gov>
 <CAJfZ7=nr37LTOE+gyZQw4toiKrX00oF0snyn9-W1X51_cwj=9A@mail.gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <a7f57863-a195-9c69-8c0f-8f48fd607dde@tycho.nsa.gov>
Date: Wed, 22 Mar 2017 12:58:00 -0400
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=nr37LTOE+gyZQw4toiKrX00oF0snyn9-W1X51_cwj=9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/21/2017 06:43 PM, Nicolas Iooss wrote:
> On Mon, Mar 20, 2017 at 4:40 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:
>> It would sometimes be helpful for debugging or verification purposes to be able to convert
>> a binary policy to a human-readable form.
>>
>> This patchset adds libsepol functions that take a kernel policydb in and outputs either
>> a CIL or policy.conf text.
>>
>> Checkpolicy is modified to generate CIL text from a binary policy if using the "-C" option
>> and to add the "-F" option to generate policy.conf text from a binary policy.
>>
>> Where possible rules are sorted in alphabetical or numerical order to aid in debugging.
>>
>> Changes from v1:
>> - Moved __attribute__((format(printf...))) for printf-like functions to kernel_to_common.h
>> - Incorporated patch from Nicolas Iooss to make const char* variables where appropriate
>> - Fixed conditional block formatting problems when generating policy.conf
>> - Initialize mls_constraints and non_mls_constraints to NULL in kernel_to_conf.c and kernel_to_cil.c so they are not accessed without initializaton if an error occurs.
>> - Updated checkpolicy manpage to include the new option
>> - Removed commented-out block from checkpolicy.c
>>
>> James Carter (3):
>>   libsepol: Add ability to convert binary policy to CIL
>>   libsepol: Add ability to convert binary policy to policy.conf file
>>   checkpolicy: Add options to convert binary policy to CIL or a
>>     policy.conf
>
> Hello,
>
> I have tested this new version and it worked quite fine on my system.
> It also builds without any trouble on Travis-CI
> (https://travis-ci.org/fishilico/selinux/builds/213586224).
>
> After performing some tests, I quickly read the CIL policy generated
> with "checkpolicy -bC" and found:
>
> (booleanif (and git_cgi_enable_homedirs use_nfs_home_dirs)
>     (true
>         (allow httpd_git_script_t nfs_t (dir (getattr search open)))
>         (allow httpd_git_script_t nfs_t (dir (ioctl read getattr lock
> search open)))
>         (allow httpd_git_script_t nfs_t (dir (ioctl read getattr lock
> search open)))
>         (allow httpd_git_script_t nfs_t (file (ioctl read getattr lock open)))
>         (allow httpd_git_script_t nfs_t (filesystem (getattr)))
>     )
>     (false        (dontaudit httpd_git_script_t nfs_t (file (ioctl
> read getattr lock open)))
>     )
> )
>
> There is a missing "\n" after "(false" on line 2059 of kernel_to_cil.c
> (function write_cond_nodes_to_cil).
>

Not sure how I missed that.

> Moreover when trying to compile with secilc the resulting file, I get
> "Bad userrange declaration" on a line which contains "(userrange root
> systemlow systemlow)" (this is a non-MLS policy). There are missing
> parentheses around the levels when generating userrange statements in
> write_user_decl_rules_to_cil().
>

I guess I have been too focused on testing MLS policies.

> By iterating cycles of secilc and checkpolicy -bC, it appears that the
> roletypes statements get generated with alphabetical order of roles,
> but a random order for types (which is the order in the binary policy
> file if I understand the code correctly). Would it be possible to sort
> them in alphabetical order too? I guess a "struct strs"-based
> construction similar to what write_cond_av_list_to_cil() does can be
> used, even though I have not taken time to test this yet.
>

I do sort the types when generating a policy.conf. I should do them for CIL as well.


Thanks for the review and comments.

Jim

> Cheers,
> Nicolas
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
