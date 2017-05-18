From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v1 2/9] libsepol: Add ibpkey ocontext handling
Date: Thu, 18 May 2017 21:10:11 +0000
Message-ID: <VI1PR05MB167884409662282DB8C458F4C4E40@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-3-git-send-email-danielj@mellanox.com>
 <1494960225.21557.5.camel@tycho.nsa.gov>
 <1494960311.21557.6.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/16/2017 1:41 PM, Stephen Smalley wrote:
> On Tue, 2017-05-16 at 14:43 -0400, Stephen Smalley wrote:
>> On Mon, 2017-05-15 at 23:42 +0300, Dan Jurgens wrote:
>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>
>>>
>>> +			case OCON_IBPKEY:
>>> +				 /* The subnet prefix is in
>>> network
>>> order */
>>> +				for (j = 0; j < 4; j++)
>>> +					buf[j] = c-
>>>> u.ibpkey.subnet_prefix[j];
>> Kernel write code always writes [2] and [3] as 0.
> This btw again raises the question of whether it worth storing them in
> the binary policy at all.
Done, just store the upper 8 bytes in the policy now.
