From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v1 1/9] checkpolicy: Add support for ibpkeycon labels
Date: Wed, 17 May 2017 19:09:05 +0000
Message-ID: <VI1PR05MB16785E389AAD3EC48B2BD470C4E70@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-2-git-send-email-danielj@mellanox.com>
 <1494958940.21557.3.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/16/2017 1:18 PM, Stephen Smalley wrote:
> On Mon, 2017-05-15 at 23:42 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> +	if (subnet_prefix.s6_addr[2] || subnet_prefix.s6_addr[3]) {
>> +		yyerror("subnet prefix should be 0's in the low
>> order 64 bits.");
>> +		rc = -1;
>> +		goto out;
>> +	}
>> +
>> +	memcpy(&newc->u.ibpkey.subnet_prefix[0],
>> &subnet_prefix.s6_addr[0],
>> +	       sizeof(newc->u.ibpkey.subnet_prefix));
>> +
>> +	newc->u.ibpkey.low_pkey = low;
>> +	newc->u.ibpkey.high_pkey = high;
> Kernel patch also rejects low or high > 0xffff, so we likely ought to
> do the same here?

Done
