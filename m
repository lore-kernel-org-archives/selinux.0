Subject: Re: [PATCH] Fix AUDIT_MAC_POLICY_LOAD event formatting
To: Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
References: <11128714.mipGzmS50p@x2>
 <CAHC9VhSYkymKzvbOW1vkZ_Ae=VGZc8TcMKimyXO0iO7e6M8GzQ@mail.gmail.com>
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0839aedc-39b9-7345-9cf7-606538204c9c@tycho.nsa.gov>
Date: Tue, 22 Nov 2016 08:56:57 -0500
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSYkymKzvbOW1vkZ_Ae=VGZc8TcMKimyXO0iO7e6M8GzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/21/2016 04:50 PM, Paul Moore wrote:
> On Mon, Nov 21, 2016 at 12:30 PM, Steve Grubb <sgrubb@redhat.com> wrote:
>> The AUDIT_MAC_POLICY_LOAD event has dangling text that means the same thing
>> as the event type and is missing the uid and results field. The bigger issue
>> is that in some failure cases no event is emitted. This patch fixes the noted
>> problems.

A potential problem with this patch is that it changes the semantic
meaning of this audit record, from meaning "a policy was loaded into the
kernel" to "there was an attempt to load a policy, check the res= field
to determine whether it succeeded".  So anything in userspace that used
the presence of this audit record to determine whether or not policy was
successfully loaded (e.g. audit2allow -l) will be confused.  While there
were failure cases that would still generate the audit record
previously, those were all selinuxfs node creation failures; the policy
would nonetheless have been loaded into the kernel and would be active
at that point, so saying res=0 is somewhat misleading.  This overlaps
with https://github.com/SELinuxProject/selinux-kernel/issues/1, which
highlights the fact that we can end up in an intermediate state where
policy is loaded but selinuxfs (particularly booleans, class/*, and
policy_capabilities/*) has not been regenerated.

>>
>> Signed-off-by: Steve Grubb <sgrubb@redhat.com>
> 
> First off, for patches such as these, I think it is good to CC the
> affected subsystem, SELinux in this case (fixed).
> 
> Beyond that, I'm a little concerned that you adding fields to record
> in the middle.  In the past you've warned against inserting fields in
> the middle of the record, or reordering fields in general ("you'll
> break the world") due to some poor userspace practices, yet you do
> these exact things when it suits you.
> 
> We need a consistent message when it comes to userspace record
> processing so we know what we can do in the kernel without causing
> massive failure.
> 
>> --- vanilla-4.9-rc5.orig/security/selinux/selinuxfs.c   2016-11-16 15:16:34.738723900 -0500
>> +++ linux-4.9.0-0.rc5.git0.1.fc24.x86_64/security/selinux/selinuxfs.c   2016-11-21 12:16:08.046787604 -0500
>> @@ -494,6 +494,7 @@ static ssize_t sel_write_load(struct fil
>>  {
>>         ssize_t length;
>>         void *data = NULL;
>> +       unsigned int result = 0;
>>
>>         mutex_lock(&sel_mutex);
>>
>> @@ -525,24 +526,26 @@ static ssize_t sel_write_load(struct fil
>>
>>         length = sel_make_bools();
>>         if (length)
>> -               goto out1;
>> +               goto out;
>>
>>         length = sel_make_classes();
>>         if (length)
>> -               goto out1;
>> +               goto out;
>>
>>         length = sel_make_policycap();
>>         if (length)
>> -               goto out1;
>> +               goto out;
>>
>>         length = count;
>> +       result = 1;
>>
>> -out1:
>> +out:
>>         audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
>> -               "policy loaded auid=%u ses=%u",
>> +               "uid=%u auid=%u ses=%u res=%u",
>> +               from_kuid(&init_user_ns, task_uid(current)),
>>                 from_kuid(&init_user_ns, audit_get_loginuid(current)),
>> -               audit_get_sessionid(current));
>> -out:
>> +               audit_get_sessionid(current), result);
>> +
>>         mutex_unlock(&sel_mutex);
>>         vfree(data);
>>         return length;
>>
>> --
>> Linux-audit mailing list
>> Linux-audit@redhat.com
>> https://www.redhat.com/mailman/listinfo/linux-audit
> 
> 
> 
