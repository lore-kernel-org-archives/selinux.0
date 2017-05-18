From: Daniel Jurgens <danielj@mellanox.com>
To: James Carter <jwcart2@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v1 5/9] libsepol: Add ibendport ocontext handling
Date: Thu, 18 May 2017 21:55:14 +0000
Message-ID: <VI1PR05MB167895B29C0B9EF6ED803B7DC4E40@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-6-git-send-email-danielj@mellanox.com>
 <9a91f584-5ca4-9122-21fe-e395e8df4508@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/17/2017 8:53 AM, James Carter wrote:
> On 05/15/2017 04:42 PM, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>>
>> +exit:
>> +	if (rc != 0) {
>> +		sepol_log_err("Error writing ibendportcon rules to CIL\n");
>> +	}
>> +
>> +	return rc;
>> +}
>> +
> You need to have the ibendport rules sorted like I mentioned for ibpkey in patch 2.
>
> Jim
Done for both patches.
