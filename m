Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB91JBKZ028885
 for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2016 20:19:12 -0500
Received: by mail-ua0-f193.google.com with SMTP id 12so312679uas.3
 for <selinux@tycho.nsa.gov>; Thu, 08 Dec 2016 17:14:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <83aee15b-15d3-0a13-dc16-64688b39caa6@redhat.com>
References: <1481206487-544-1-git-send-email-sds@tycho.nsa.gov>
 <83aee15b-15d3-0a13-dc16-64688b39caa6@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Dec 2016 20:14:11 -0500
Message-ID: <CAHC9VhSn2OJD-UwdGpL-xHgvywVdBCAL2dZVpmm48SFTpNdZuw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: allow context mounts on tmpfs, ramfs, devpts
 within user namespaces
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 seth.forshee@canonical.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Dec 8, 2016 at 5:09 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> On 12/08/2016 09:14 AM, Stephen Smalley wrote:
>> commit aad82892af261b9903cc11c55be3ecf5f0b0b4f8 ("selinux: Add support for
>> unprivileged mounts from user namespaces") prohibited any use of context
>> mount options within non-init user namespaces.  However, this breaks
>> use of context mount options for tmpfs mounts within user namespaces,
>> which are being used by Docker/runc.  There is no reason to block such
>> usage for tmpfs, ramfs or devpts.  Exempt these filesystem types
>> from this restriction.
>>
>> Before:
>> sh$ userns_child_exec  -p -m -U -M '0 1000 1' -G '0 1000 1' bash
>> sh# mount -t tmpfs -o context=system_u:object_r:user_tmp_t:s0:c13 none /tmp
>> mount: tmpfs is write-protected, mounting read-only
>> mount: cannot mount tmpfs read-only
>>
>> After:
>> sh$ userns_child_exec  -p -m -U -M '0 1000 1' -G '0 1000 1' bash
>> sh# mount -t tmpfs -o context=system_u:object_r:user_tmp_t:s0:c13 none /tmp
>> sh# ls -Zd /tmp
>> unconfined_u:object_r:user_tmp_t:s0:c13 /tmp
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  security/selinux/hooks.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 8a90a0b..8fae174 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -834,10 +834,14 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>>       }
>>
>>       /*
>> -      * If this is a user namespace mount, no contexts are allowed
>> -      * on the command line and security labels must be ignored.
>> +      * If this is a user namespace mount and the filesystem type is not
>> +      * explicitly whitelisted, then no contexts are allowed on the command
>> +      * line and security labels must be ignored.
>>        */
>> -     if (sb->s_user_ns != &init_user_ns) {
>> +     if (sb->s_user_ns != &init_user_ns &&
>> +         strcmp(sb->s_type->name, "tmpfs") &&
>> +         strcmp(sb->s_type->name, "ramfs") &&
>> +         strcmp(sb->s_type->name, "devpts")) {
>>               if (context_sid || fscontext_sid || rootcontext_sid ||
>>                   defcontext_sid) {
>>                       rc = -EACCES;
>
> We have confirmed that this patch fixes the first issue, we are seeing
> other issues, but I am not sure
> if SELinux/UserNamespace is the issue.
>
> Paul could you create a rpm kernel package with this patch?

I've been working on getting a new netlabel_tools release out today,
among other things.  I'm going to be looking at the patches posted
today tomorrow and merging as appropriate.  Early each week (usually
Monday, sometimes Tuesday if there are conflicts/problems), I create a
new Fedora Rawhide kernel build with all of the SELinux and audit
patches that are in my next branches, more information can be found at
the link below:

* https://copr.fedorainfracloud.org/coprs/pcmoore/kernel-secnext

-- 
paul moore
www.paul-moore.com
