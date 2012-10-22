Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9MHHS4w006855
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2012 13:17:33 -0400
Message-ID: <50857F8A.1090309@schaufler-ca.com>
Date: Mon, 22 Oct 2012 10:16:58 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        john.johansen@canonical.com, selinux@tycho.nsa.gov,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v5] LSM: Multiple concurrent LSMs
References: <5081B30F.6090009@schaufler-ca.com> <201210211206.DEI34330.FLFQMtFOOSJOHV@I-love.SAKURA.ne.jp>
In-Reply-To: <201210211206.DEI34330.FLFQMtFOOSJOHV@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/20/2012 8:06 PM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> +#define call_int_hook(RC, FUNC, ...)					\
>> +	do {								\
>> +		int called = 0;						\
>> +		int thisrc;						\
>> +		int i;							\
>> +									\
>> +		RC = 0;							\
>> +		for (i = 1; i < lsm_count; i++) {			\
>> +			if (!composer_ops[i]->FUNC)			\
>> +				continue;				\
>> +			thisrc = composer_ops[i]->FUNC(__VA_ARGS__);	\
>> +			if (thisrc)					\
>> +				RC = thisrc;				\
>> +			called = 1;					\
>> +		}							\
>> +		if (!called && composer_ops[0]->FUNC)			\
>> +			RC = composer_ops[0]->FUNC(__VA_ARGS__);	\
>> +	} while (0)
> Why can't we simplify like below? What is special with composer_ops[0] ?

composer_ops[0] is the capability operations. They get called if and
only if no LSM supplies something for a particular hook. LSMs are allowed
to call the capability hook themselves or not as they see fit. Thus the
special case for composer_ops[0].

>
> #define call_int_hook(RC, FUNC, ...)					\
> 	do {								\
> 		int i;							\
> 									\
> 		RC = 0;							\
> 		for (i = 0; i < lsm_count; i++) {			\
> 			if (!composer_ops[i]->FUNC)			\
> 				continue;				\
> 			RC = composer_ops[i]->FUNC(__VA_ARGS__);	\
> 			if (RC)						\
> 				break;					\
> 		}							\
> 	} while (0)
>
>
>
>>  int security_inode_alloc(struct inode *inode)
>>  {
>> -	inode->i_security = NULL;
>> -	return security_ops->inode_alloc_security(inode);
>> +	int i;
>> +	int rc;
>> +	struct lsm_blob tblob;
>> +	struct lsm_blob *bp = NULL;
>> +
>> +	memset(&tblob, 0, sizeof(tblob));
>> +	inode->i_security = &tblob;
>> +
>> +	for (rc = 0, i = 1; i < lsm_count && rc == 0; i++)
>> +		if (composer_ops[i]->inode_alloc_security)
>> +			rc = composer_ops[i]->inode_alloc_security(inode);
>> +
>> +	if (tblob.lsm_setcount != 0) {
>> +		if (rc == 0)
>> +			bp = kmemdup(&tblob, sizeof(tblob), GFP_KERNEL);
>> +		if (bp == NULL) {
>> +			if (rc == 0)
>> +				rc = -ENOMEM;
>> +			for (i--; i >= 1; i--) {
>> +				if (composer_ops[i]->inode_free_security)
> 	if (!composer_ops[i]->inode_free_security)


Yes, indeed.


>
>> +					continue;
>> +				composer_ops[i]->inode_free_security(inode);
>> +			}
>> +			lsm_blob_cleanup(rc, &tblob, __func__);
>> +		}
>> +	}
>> +	inode->i_security = bp;
>> +	return rc;
>>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
