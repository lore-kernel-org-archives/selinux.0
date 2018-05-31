To: J Freyensee <why2jjj.linux@gmail.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, Daniel Jurgens
 <danielj@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
 <20180530141104.28569-4-peter.enderborg@sony.com>
 <c41e327f-9bf8-a2f1-bf6f-326357d5ed8b@gmail.com>
From: peter enderborg <peter.enderborg@sony.com>
Message-ID: <85176be7-360c-d823-c3b5-3651c74ca5a0@sony.com>
Date: Thu, 31 May 2018 07:35:12 +0200
MIME-Version: 1.0
In-Reply-To: <c41e327f-9bf8-a2f1-bf6f-326357d5ed8b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Subject: Re: [PATCH V3 3/5 selinux-next] selinux: sidtab_clone
 switch to use rwlock.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/30/2018 11:22 PM, J Freyensee wrote:
>
>>   +int sidtab_clone(struct sidtab *s, struct sidtab *d)
>> +{
>> +    int i, rc = 0;
> If s or d are NULL (see if() below), why would we want rc, the return value, to be 0?  How about defaulting rc to an error value (-EINVAL)?
Oops! Thanks, will fix in next set.
>> +    struct sidtab_node *cur;
>> +
>> +    if (!s || !d)
>> +        goto errout;
>> +
>> +    read_lock(&s->lock);
>> +    for (i = 0; i < SIDTAB_SIZE; i++) {
>> +        cur = s->htable[i];
>> +        while (cur) {
>> +            if (cur->sid > SECINITSID_NUM)
>> +                rc =  sidtab_insert(d, cur->sid, &cur->context);
>> +            if (rc)
>> +                goto out;
>> +            cur = cur->next;
>> +        }
>> +    }
>> +out:
>> +    read_unlock(&s->lock);
>> +errout:
>> +    return rc;
>> +}
>>
> Thanks,
> Jay
>
