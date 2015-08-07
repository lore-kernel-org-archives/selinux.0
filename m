Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t77DbAAj009211
 for <selinux@tycho.nsa.gov>; Fri, 7 Aug 2015 09:37:11 -0400
Received: by qkbm65 with SMTP id m65so36965258qkb.2
 for <selinux@tycho.nsa.gov>; Fri, 07 Aug 2015 06:37:09 -0700 (PDT)
Message-ID: <55C4B482.5050208@quarksecurity.com>
Date: Fri, 07 Aug 2015 09:37:06 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2 0/3] Add support for extracting modules
References: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
 <CAPzO=NxAAr3QGYkxQ_rkyhRUQPGc6Gs0CKP5auTu6H-HLHaORA@mail.gmail.com>
 <55C4B26C.90508@tycho.nsa.gov>
In-Reply-To: <55C4B26C.90508@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley wrote:
> On 08/07/2015 04:09 AM, Sven Vermeulen wrote:
>> Will you provide a patch to the reference policy to allow semanage_t
>> to write into all kinds of directories?
>>
>> I personally see little value in this patch, as everything is readily
>> accessible on the file system. Users who want to extract policies with
>> semodule will now encounter policy issues where semanage_t is not
>> allowed to write into the current working directory (depending where
>> the user is at):
>
> Directly accessing files under /var/lib/selinux is not very
> user-friendly or maintainable, as how the files are arranged and stored
> is an implementation detail of libsemanage.
>

Agreed, policy could (and maybe should) completely prevent users from 
messing around there, lest they corrupt something.

> The change allows users a new workflow in which they can readily extract
> a module (whether locally created or distro-provided), modify it, and
> then re-install it (and automatically have their modified version
> installed at higher priority, and thereby not clobber the
> distro-provided one or be clobbered by subsequent policy updates.
>
> semanage is already given userdom_read_user_home_content_files() and
> userdom_read_user_tmp_files() in order to support semodule -i from
> either of those locations, so broadening that to userdom_manage doesn't
> seem too onerous.
>
> Also, the situation doesn't seem terribly different from the already
> existing semanage export facility, which takes a -f output_file option.
>

Alternatively the module could always be output to stdout and then 
piping it to a file would use the users (or shells) domain rather than 
semanage_t.

There is definitely an integrity violation with having such a privileged 
program read from user directories but I suppose that ship has sailed.

>>     allow semanage_t tmp_t : dir { ioctl read write getattr lock
>> add_name remove_name search open } ;
>>     allow semanage_t selinux_config_t : dir { ioctl read write getattr
>> lock add_name remove_name search open } ;
>>     allow semanage_t default_context_t : dir { ioctl read write getattr
>> lock add_name remove_name search open } ;
>>     allow semanage_t file_context_t : dir { ioctl read write getattr
>> lock add_name remove_name search open } ;
>>     allow semanage_t semanage_store_t : dir { ioctl read write create
>> getattr setattr lock unlink link rename add_name remove_name reparent
>> search rmdir open } ;
>>     allow semanage_t semanage_tmp_t : dir { ioctl read write create
>> getattr setattr lock unlink link rename add_name remove_name reparent
>> search rmdir open } ;
>>     allow semanage_t policy_config_t : dir { ioctl read write getattr
>> lock add_name remove_name search open } ;
>>
>> Wkr,
>>    Sven Vermeulen
>>
>> On Thu, Aug 6, 2015 at 4:30 PM, Yuli Khodorkovskiy
>> <ykhodorkovskiy@tresys.com>  wrote:
>>> This patchset adds support for extracting modules from the module store as hll
>>> or cil to the current working directory. This also adds a function to the
>>> libsemanage API to extract modules and fixes a memory leak discovered while
>>> implementing this functionality.
>>>
>>> Changes from v1:
>>> - Add fallback behavior if a module does not exist at the default priority when
>>> extracting with semodule.
>>>
>>> Yuli Khodorkovskiy (3):
>>>    libsemanage: Add ability to extract modules
>>>    libsemanage: Fix null pointer dereference in
>>>      semanage_module_key_destroy
>>>    policycoreutils/semodule: update semodule to allow extracting modules
>>>
>>>   libsemanage/include/semanage/modules.h |  17 ++
>>>   libsemanage/src/direct_api.c           | 310 ++++++++++++++++++++++-----------
>>>   libsemanage/src/libsemanage.map        |   1 +
>>>   libsemanage/src/modules.c              |  23 ++-
>>>   libsemanage/src/policy.h               |   8 +
>>>   libsemanage/src/semanageswig_python.i  |   5 +
>>>   policycoreutils/semodule/semodule.8    |  14 ++
>>>   policycoreutils/semodule/semodule.c    | 146 +++++++++++++++-
>>>   8 files changed, 416 insertions(+), 108 deletions(-)
>>>
>>> --
>>> 1.9.3
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
