Subject: Re: [PATCH 15/46] selinux: One check and function call less in
 genfs_read() after error detection
To: Casey Schaufler <casey@schaufler-ca.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <dbd8e89d-45a1-5785-f2dd-673389ac01a3@users.sourceforge.net>
 <a9983d7d-e1f7-8f85-f696-107cf32160ef@schaufler-ca.com>
Cc: Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <60ed4f02-4ff8-2ef2-bcc3-ae62bc61cda9@users.sourceforge.net>
Date: Tue, 17 Jan 2017 17:37:41 +0100
MIME-Version: 1.0
In-Reply-To: <a9983d7d-e1f7-8f85-f696-107cf32160ef@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

>> @@ -2015,7 +2015,7 @@ static int genfs_read(struct policydb *p, void *fp)
>>  		newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
>>  		if (!newgenfs) {
>>  			rc = -ENOMEM;
>> -			goto out;
>> +			goto exit;
>>  		}
>>  
>>  		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
>> @@ -2101,7 +2101,7 @@ static int genfs_read(struct policydb *p, void *fp)
>>  		kfree(newgenfs);
>>  	}
>>  	ocontext_destroy(newc, OCON_FSUSE);
>> -
>> +exit:
>>  	return rc;
> 
> Why not replace the "goto out" with "return rc" rather
> than add a target?

Would you accept to use the statement "return -ENOMEM;" there instead?

Regards,
Markus
