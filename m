To: Petr Lautrbach <plautrba@redhat.com>
Cc: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov, lvrabec@redhat.com
References: <20180412102601.32191-1-vmojzis@redhat.com>
 <22b8ccd4-1a6c-0a5a-ecfc-b17853027545@tycho.nsa.gov>
 <ed0c62cb-61ed-2f0f-3984-1ff2bd1325ce@tycho.nsa.gov>
 <20180412200329.GA14296@workstation>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fd59d7cc-f30d-3452-8231-09a0b5ece99b@tycho.nsa.gov>
Date: Thu, 12 Apr 2018 16:31:32 -0400
MIME-Version: 1.0
In-Reply-To: <20180412200329.GA14296@workstation>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] libsemanage: do not change file mode of seusers and
 users_extra
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/12/2018 04:03 PM, Petr Lautrbach wrote:
> On Thu, Apr 12, 2018 at 01:22:40PM -0400, Stephen Smalley wrote:
>> On 04/12/2018 11:07 AM, Stephen Smalley wrote:
>>> On 04/12/2018 06:26 AM, Vit Mojzis wrote:
>>>> Commit 8702a865e08b5660561e194a83e4a363061edc03 causes file mode of
>>>> seusers and users_extra to change based on the value defined in config
>>>> file whenever direct_commit is called and policy is not rebuilt.
>>>> (e.g. when setting a boolean).
>>>>
>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1512639
>>>
>>> I think this patch is correct and expect to apply it, but am left wondering about the permissions
>>> on /var/lib/selinux/targeted in general.  It appears that we are inconsistent in our file modes
>>> on files under /var/lib/selinux/targeted/active, e.g. file_contexts.homedirs, *.local, and modules/*/* are 0644,
>>> whereas other files are 0600.  Of course, given that the directories are 0600, only root can even lookup files under
>>> these directories regardless of their individual file modes so it isn't as though those files are truly accessible.
>>> Looks like there are other uses of sh->conf->file_mode that are suspect in semanage_direct_commit() for files
>>> in the store, whereas I think it should only be used for installed files (i.e. /etc/selinux/targeted/*).
>>
>> Actually, we seem to be inconsistent even among different modules; some seem to be 0600 and others 0644, likely due
>> to some being prebuilt/prepackaged that way and others installed via semodule -i.  Also, policy.kern and policy.linked are presently 0644.
>>
>> On a separate but related note, rpm -V selinux-policy-targeted output seems somewhat surprising, e.g. wouldn't expect file_contexts.local, commit_num, etc to be managed by rpm itself.  Not sure it should be managing /var/lib/selinux at all.
> 
> Note that /etc/selinux/targeted/modules/active was part of selinux-policy-targeted since 2011.
> 
> file_contexts.local is in /etc/selinux and is shipped with %config(noreplace). It means it's preserved during updates and
> `rpm -qf /etc/selinux/targeted/contexts/files/file_contexts.local` shows the relevant package.
> 
> The other files showed by `rpm -V` are probably not necessary to be included in the package.
> 
> As far as I know we need to ship the SELinux store in /var/lib/selinux as whole for systems using OSTree where packages
> are not installed, i.e. post installation scripts are not run, but they are just extracted to a filesystem.

Don't quite understand why you'd ship a file_contexts.local at all; any file contexts you want to ship in the base policy can just go in a policy module.  Also not sure why setrans.conf is part of selinux-policy-targeted instead of mcstrans.

Understand why you are packaging /var/lib/selinux, just wondering if they should be verified or not as part of rpm -V.
