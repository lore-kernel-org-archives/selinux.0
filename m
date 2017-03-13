Subject: Re: [PATCH 0/3] libsepol and checkpolicy: Output CIL or policy.conf
 from kernel policy
To: Nicolas Iooss <nicolas.iooss@m4x.org>
References: <1489175376-27336-1-git-send-email-jwcart2@tycho.nsa.gov>
 <CAJfZ7==2e9bN7Z94sLDO3boHDgVPx8Gr+=pXWsvNEbdqkjc8fg@mail.gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <108f1499-4017-48dd-c7a6-77bd01cf389f@tycho.nsa.gov>
Date: Mon, 13 Mar 2017 11:32:59 -0400
MIME-Version: 1.0
In-Reply-To: <CAJfZ7==2e9bN7Z94sLDO3boHDgVPx8Gr+=pXWsvNEbdqkjc8fg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/11/2017 03:02 PM, Nicolas Iooss wrote:
> On Fri, Mar 10, 2017 at 8:49 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:
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
>> James Carter (3):
>>   libsepol: Add ability to convert binary policy to CIL
>>   libsepol: Add ability to convert binary policy to policy.conf file
>>   checkpolicy: Add options to convert binary policy to CIL or a
>>     policy.conf
>
> Hello,
> I agree such features are useful when analyzing policies. I have
> tested the patches and compiled with some warnings flags (I have not
> done a "real" code review). Here are some comments:
>
> - First, the documentation (at least checkpolicy manpage) needs to be
> updated with the new options. Also I spent some time trying to
> understand what I was doing wrong with options -C and -F until I read
> the third patch and understood that "-b" needs to be used as well.
>
> - Then, when using "checkpolicy -bF" on my policy, I got blocks such as:
>
> if ((git_cgi_enable_homedirs && use_samba_home_dirs)) {
>             allow httpd_git_script_t cifs_t:dir { getattr search open };
>         allow httpd_git_script_t cifs_t:dir { ioctl read getattr lock
> search open };
>         allow httpd_git_script_t cifs_t:dir { ioctl read getattr lock
> search open };
>         allow httpd_git_script_t cifs_t:file { ioctl read getattr lock open };
>         allow httpd_git_script_t cifs_t:filesystem { getattr };
>     } else {        dontaudit httpd_git_script_t cifs_t:file { ioctl
> read getattr lock open };
> }
>
> The blocks have indentation issues (the first line of the if statement
> has too much spaces and a "\n" is missing at the beginning of the else
> block. Moreover the permissions are not sorted in alphabetical order
> but this may be included in the "Where possible" part of your message.
>
> - Third, the first patch introduces functions with printf-like
> arguments and defines them with __attribute__((format(printf...))) in
> the .c file. This is fine for the static functions but the other ones
> need to have attributes in kernel_to_common.h instead (this enables
> the compiler to check the format strings at build time when compiling
> other files).
>
> - Finally when compiling with -Wwrite-strings, gcc reports some issues
> with literal strings assigned to non-const char* variables. I have
> quickly written a short patch to make some variables const char* and
> checkpolicy seems to work fine with it. The patch is attached to this
> email if you want to consider it.
>

Thanks for testing it out. I agree with all of your comments and suggestions 
above. Thanks for the patch as well.

Jim

> Cheers,
> Nicolas
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
