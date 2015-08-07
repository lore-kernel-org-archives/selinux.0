Subject: Re: [PATCH v2 0/3] Add support for extracting modules
To: Joshua Brindle <brindle@quarksecurity.com>, Stephen Smalley
 <sds@tycho.nsa.gov>
References: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
 <CAPzO=NxAAr3QGYkxQ_rkyhRUQPGc6Gs0CKP5auTu6H-HLHaORA@mail.gmail.com>
 <55C4B26C.90508@tycho.nsa.gov> <55C4B482.5050208@quarksecurity.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <55C4D121.9010001@tresys.com>
Date: Fri, 7 Aug 2015 11:39:13 -0400
MIME-Version: 1.0
In-Reply-To: <55C4B482.5050208@quarksecurity.com>
Content-Type: text/plain; charset="windows-1252"
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 8/7/2015 9:37 AM, Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On 08/07/2015 04:09 AM, Sven Vermeulen wrote:
>>> Will you provide a patch to the reference policy to allow semanage_t
>>> to write into all kinds of directories?
>>>
>>> I personally see little value in this patch, as everything is readily
>>> accessible on the file system. Users who want to extract policies with
>>> semodule will now encounter policy issues where semanage_t is not
>>> allowed to write into the current working directory (depending where
>>> the user is at):
>>
>> Directly accessing files under /var/lib/selinux is not very
>> user-friendly or maintainable, as how the files are arranged and stored
>> is an implementation detail of libsemanage.
>>
> 
> Agreed, policy could (and maybe should) completely prevent users from
> messing around there, lest they corrupt something.

This is generally enforced in refpolicy, though a couple privileged
domains (eg package managers) can access it.

>> The change allows users a new workflow in which they can readily extract
>> a module (whether locally created or distro-provided), modify it, and
>> then re-install it (and automatically have their modified version
>> installed at higher priority, and thereby not clobber the
>> distro-provided one or be clobbered by subsequent policy updates.
>>
>> semanage is already given userdom_read_user_home_content_files() and
>> userdom_read_user_tmp_files() in order to support semodule -i from
>> either of those locations, so broadening that to userdom_manage doesn't
>> seem too onerous.
>>
>> Also, the situation doesn't seem terribly different from the already
>> existing semanage export facility, which takes a -f output_file option.
>>
> 
> Alternatively the module could always be output to stdout and then
> piping it to a file would use the users (or shells) domain rather than
> semanage_t.
>
> There is definitely an integrity violation with having such a privileged
> program read from user directories but I suppose that ship has sailed.

It's a side effect of the UBAC implementation, as all the users have the
same types for their home directory contents, but with different seusers.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
