From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 4/9] checkpolicy: Add support for ibendportcon labels
Date: Wed, 10 May 2017 22:27:44 +0000
Message-ID: <VI1PR05MB1678A0713029BD5DB5E71F21C4EC0@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-5-git-send-email-danielj@mellanox.com>
 <1494442835.24408.15.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/10/2017 1:56 PM, Stephen Smalley wrote:
> On Tue, 2017-05-09 at 23:50 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>> 	} ibendport;
> These were pkey and ib_endport in the kernel patch, and port was
> port_num.  Either way is fine but they probably ought to be consistent.

Yes, I received an internal comment that pkey wouldn't be an especially strange name collision in the future.  When I repost the kernel series I'll synchronize the names there for consistency.

>> @@ -396,6 +400,7 @@ typedef struct genfs {
>>  #define OCON_FSUSE 5	/* fs_use */
>>  #define OCON_NODE6 6	/* IPv6 nodes */
>>  #define OCON_IBPKEY 7	/* Infiniband PKEY */
>> +#define OCON_IBENDPORT 8	/* Infiniband End Port */
> These were OCON_PKEY and OCON_IB_ENDPORT in the last kernel patches I
> saw.  Ok either way but they probably ought to be consistent.
Same here.
