Message-ID: <4D8A4308.80400@manicmethod.com>
Date: Wed, 23 Mar 2011 14:59:20 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Harry Ciao <qingtao.cao@windriver.com>, sds@tycho.nsa.gov,
        jmorris@namei.org, eparis@parisplace.org, selinux@tycho.nsa.gov
Subject: Re: [v0 PATCH 3/3] SELinux: Write class field in role_trans_write.
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com>	 <1300847325-20308-4-git-send-email-qingtao.cao@windriver.com> <1300891710.28871.10.camel@unknown001a4b0c2895>
In-Reply-To: <1300891710.28871.10.camel@unknown001a4b0c2895>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Wed, 2011-03-23 at 10:28 +0800, Harry Ciao wrote:
>> From: Harry Ciao<harrytaurus2002@hotmail.com>
>>
>> If kernel policy version is>= 25, then write the class field of the
>> role_trans structure into the binary reprensentation.
>>
>> Signed-off-by: Harry Ciao<qingtao.cao@windriver.com>
>
> Looking at this patch (and the first one) I really start to feel like
> putting the class after the newrole on disk.  It really would clean up
> the patches and the code to not insert the conditional in the middle of
> reading/writing and instead do it at the end....

He doesn't have to put it after new_role to clean up the conditional, just break 
the buffer in 2. range_write() does this in userspace, I'm not sure what the 
kernel interface looks like.

>
>> ---
>>   security/selinux/ss/policydb.c |   18 +++++++++++++-----
>>   1 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
>> index b660f08..a6be0f5 100644
>> --- a/security/selinux/ss/policydb.c
>> +++ b/security/selinux/ss/policydb.c
>> @@ -2450,10 +2450,11 @@ static int cat_write(void *vkey, void *datum, void *ptr)
>>   	return 0;
>>   }
>>
>> -static int role_trans_write(struct role_trans *r, void *fp)
>> +static int role_trans_write(struct policydb *p, void *fp)
>>   {
>> +	struct role_trans *r = p->role_tr;
>>   	struct role_trans *tr;
>> -	u32 buf[3];
>> +	u32 buf[4];
>>   	size_t nel;
>>   	int rc;
>>
>> @@ -2467,8 +2468,15 @@ static int role_trans_write(struct role_trans *r, void *fp)
>>   	for (tr = r; tr; tr = tr->next) {
>>   		buf[0] = cpu_to_le32(tr->role);
>>   		buf[1] = cpu_to_le32(tr->type);
>> -		buf[2] = cpu_to_le32(tr->new_role);
>> -		rc = put_entry(buf, sizeof(u32), 3, fp);
>> +		if (p->policyvers>= POLICYDB_VERSION_ROLETRANS) {
>> +			buf[2] = cpu_to_le32(tr->cclass);
>> +			buf[3] = cpu_to_le32(tr->new_role);
>> +			rc = put_entry(buf, sizeof(u32), 4, fp);
>> +		} else {
>> +			buf[2] = cpu_to_le32(tr->new_role);
>> +			rc = put_entry(buf, sizeof(u32), 3, fp);
>> +		}
>> +
>>   		if (rc)
>>   			return rc;
>>   	}
>> @@ -3145,7 +3153,7 @@ int policydb_write(struct policydb *p, void *fp)
>>   	if (rc)
>>   		return rc;
>>
>> -	rc = role_trans_write(p->role_tr, fp);
>> +	rc = role_trans_write(p, fp);
>>   	if (rc)
>>   		return rc;
>>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
