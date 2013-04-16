Message-ID: <516DC740.6020107@redhat.com>
Date: Tue, 16 Apr 2013 14:48:48 -0700
From: Anand Avati <avati@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, eparis@redhat.com, kraman@redhat.com,
        dwalsh@redhat.com
Subject: Re: [PATCH] selinux: consider filesystem subtype in policies
References: <20130416182955.GA18965@sh-el5.eng.rdu2.redhat.com> <516DB757.2060203@tycho.nsa.gov>
In-Reply-To: <516DB757.2060203@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/16/2013 01:40 PM, Stephen Smalley wrote:
> On 04/16/2013 02:29 PM, Anand Avati wrote:
>> Not considering filesystem has the following limitation. Support
>> for SELinux in FUSE is dependent on the particular userspace
>> filesystem, which is identified by the subtype. For e.g, GlusterFS,
>> a FUSE based filesystem supports SELinux (by mounting and processing
>> FUSE requests in different threads, avoiding the mount time
>> deadlock), whereas other FUSE based filesystems (identified by a
>> different subtype) have the mount time deadlock.
>>
>> By considering the subtype of the filesytem in the SELinux policies,
>> allows us to specify a filesystem subtype, in the following way:
>>
>> fs_use_xattr fuse.glusterfs gen_context(system_u:object_r:fs_t,s0);
>>
>> This way not all FUSE filesystems are put in the same bucket and
>> subjected to the limitations of the other subtypes.
>>
>> Signed-off-by: Anand Avati <avati@redhat.com>
>> ---
>> security/selinux/hooks.c | 46 ++++++++++++++++++++-----------------
>> security/selinux/include/security.h | 2 +-
>> security/selinux/ss/services.c | 7 +++++-
>> 3 files changed, 32 insertions(+), 23 deletions(-)
>>
>
>> diff --git a/security/selinux/ss/services.c
>> b/security/selinux/ss/services.c
>> index b4feecc..3c6cbba 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -2329,17 +2329,22 @@ out:
>> */
>> int security_fs_use(
>> const char *fstype,
>> + const char *subtype,
>> unsigned int *behavior,
>> u32 *sid)
>> {
>> int rc = 0;
>> struct ocontext *c;
>> + char type[32];
>
> Why is 32 bytes enough?

May not be. Just did a quick search for possible long names with 
subtypes. Will fix this.

>> read_lock(&policy_rwlock);
>>
>> c = policydb.ocontexts[OCON_FSUSE];
>> + snprintf(type, 32, "%s%s%s", fstype,
>
> s/32/sizeof type/
> Check for truncation?
>
>> + (subtype ? "." : ""), (subtype ? subtype : ""));
>> + type[31] = 0;
>> while (c) {
>> - if (strcmp(fstype, c->u.name) == 0)
>> + if (strcmp(type, c->u.name) == 0)
>> break;
>> c = c->next;
>> }
>
> If you do not find a match on the fstype.subtype string, shouldn't you
> retry with just the fstype string? Just in case there was in fact a
> fs_use rule for the fstype?

Good point. Will fix this.

Thanks!
Avati


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
