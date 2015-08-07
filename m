Message-ID: <55C4B6D9.7030709@tycho.nsa.gov>
Date: Fri, 07 Aug 2015 09:47:05 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v2 0/3] Add support for extracting modules
References: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
 <CAPzO=NxAAr3QGYkxQ_rkyhRUQPGc6Gs0CKP5auTu6H-HLHaORA@mail.gmail.com>
In-Reply-To: <CAPzO=NxAAr3QGYkxQ_rkyhRUQPGc6Gs0CKP5auTu6H-HLHaORA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/07/2015 04:09 AM, Sven Vermeulen wrote:
> Will you provide a patch to the reference policy to allow semanage_t
> to write into all kinds of directories?
>

In Fedora, semanage_t is unconfined, so I hadn't thought about policy, but you 
are right, new policy is needed.

> I personally see little value in this patch, as everything is readily
> accessible on the file system. Users who want to extract policies with
> semodule will now encounter policy issues where semanage_t is not
> allowed to write into the current working directory (depending where
> the user is at):
>

But this patch is nice in that you don't have to know what priority the module 
is at and it uncompresses it for you.

I don't think that we need to worry about writing into anything other then a 
home and tmp directories.

Using
userdom_manage_user_home_content_files(semanage_t)
userdom_manage_user_tmp_files(semanage_t)

instead of
userdom_read_user_home_content_files(semanage_t)
userdom_read_user_tmp_files(semanage_t)

should get us most of the way there, shouldn't it?

Jim

>     allow semanage_t tmp_t : dir { ioctl read write getattr lock
> add_name remove_name search open } ;
>     allow semanage_t selinux_config_t : dir { ioctl read write getattr
> lock add_name remove_name search open } ;
>     allow semanage_t default_context_t : dir { ioctl read write getattr
> lock add_name remove_name search open } ;
>     allow semanage_t file_context_t : dir { ioctl read write getattr
> lock add_name remove_name search open } ;
>     allow semanage_t semanage_store_t : dir { ioctl read write create
> getattr setattr lock unlink link rename add_name remove_name reparent
> search rmdir open } ;
>     allow semanage_t semanage_tmp_t : dir { ioctl read write create
> getattr setattr lock unlink link rename add_name remove_name reparent
> search rmdir open } ;
>     allow semanage_t policy_config_t : dir { ioctl read write getattr
> lock add_name remove_name search open } ;
>
> Wkr,
>    Sven Vermeulen
>
> On Thu, Aug 6, 2015 at 4:30 PM, Yuli Khodorkovskiy
> <ykhodorkovskiy@tresys.com> wrote:
>> This patchset adds support for extracting modules from the module store as hll
>> or cil to the current working directory. This also adds a function to the
>> libsemanage API to extract modules and fixes a memory leak discovered while
>> implementing this functionality.
>>
>> Changes from v1:
>> - Add fallback behavior if a module does not exist at the default priority when
>> extracting with semodule.
>>
>> Yuli Khodorkovskiy (3):
>>    libsemanage: Add ability to extract modules
>>    libsemanage: Fix null pointer dereference in
>>      semanage_module_key_destroy
>>    policycoreutils/semodule: update semodule to allow extracting modules
>>
>>   libsemanage/include/semanage/modules.h |  17 ++
>>   libsemanage/src/direct_api.c           | 310 ++++++++++++++++++++++-----------
>>   libsemanage/src/libsemanage.map        |   1 +
>>   libsemanage/src/modules.c              |  23 ++-
>>   libsemanage/src/policy.h               |   8 +
>>   libsemanage/src/semanageswig_python.i  |   5 +
>>   policycoreutils/semodule/semodule.8    |  14 ++
>>   policycoreutils/semodule/semodule.c    | 146 +++++++++++++++-
>>   8 files changed, 416 insertions(+), 108 deletions(-)
>>
>> --
>> 1.9.3
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
