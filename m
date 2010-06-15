Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5F4g3Kw019874
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2010 00:42:04 -0400
Received: from smtp106.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o5F4fENe028345
	for <selinux@tycho.nsa.gov>; Tue, 15 Jun 2010 04:41:14 GMT
Message-ID: <4C17049D.6090106@schaufler-ca.com>
Date: Mon, 14 Jun 2010 21:42:05 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        jmorris@namei.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 4/4] SELinux: allow userspace to read policy back out
 of the kernel
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>	 <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>	 <1276526926.8863.23.camel@moss-pluto.epoch.ncsc.mil> <1276528366.2749.3.camel@localhost>
In-Reply-To: <1276528366.2749.3.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Mon, 2010-06-14 at 10:48 -0400, Stephen Smalley wrote:
>   
>> On Fri, 2010-06-11 at 12:37 -0400, Eric Paris wrote:
>>     
>>> There is interest in being able to see what the actual policy is that was
>>> loaded into the kernel.  The patch creates a new selinuxfs file
>>> /selinux/policy which can be read by userspace.  The actual policy that is
>>> loaded into the kernel will be written back out to userspace.
>>>       
>> Why a new node vs a read op for /selinux/load?
>>     
>
> No reason why I couldn't.  Just 'load' seemed to imply a connotation
> which wasn't appropriate.  If you prefer I'll switch it when I do
> another version.
>   

If it makes any difference Smack /smack/load does read as well as write.
You have the opportunity to make 2 or 3 users less confused if you do
things consistently. After all, Smack uses load because SELinux does,
the name is actually arbitrary, and why do something differently when
it doesn't really matter?

> -Eric
>   
>>> Signed-off-by: Eric Paris <eparis@redhat.com>
>>> ---
>>>
>>>       
>>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>>> index 1de60ce..2e022db 100644
>>> --- a/security/selinux/ss/services.c
>>> +++ b/security/selinux/ss/services.c
>>> @@ -3126,3 +3125,27 @@ netlbl_sid_to_secattr_failure:
>>>  	return rc;
>>>  }
>>>  #endif /* CONFIG_NETLABEL */
>>> +
>>> +/**
>>> + * security_read_policy - read the policy.
>>> + * @data: binary policy data
>>> + * @len: length of data in bytes
>>> + *
>>> + */
>>> +int security_read_policy(void *data, ssize_t *len)
>>> +{
>>> +	int rc = 0;
>>> +	struct policy_file file = { data, *len }, *fp = &file;
>>> +
>>> +	if (!ss_initialized)
>>> +		return -EINVAL;
>>> +
>>> +	read_lock_irq(&policy_rwlock);
>>> +	rc = policydb_write(&policydb, fp);
>>> +	read_unlock_irq(&policy_rwlock);
>>> +
>>> +	*len = (unsigned long)fp->data - (unsigned long)data;
>>> +
>>> +	return rc;
>>> +
>>> +}
>>>       
>> Why _irq?
>>     
>
> Stolen from security_load_policy() and shouldn't have been.  Will fix.
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
