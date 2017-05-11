From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 7/9] semanage: Update semanage to allow runtime labeling
 of Infiniband Pkeys
Date: Thu, 11 May 2017 22:51:17 +0000
Message-ID: <VI1PR05MB1678F2B7F7AC0211FE3C7EA2C4ED0@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-8-git-send-email-danielj@mellanox.com>
 <1494444409.24408.21.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/10/2017 2:22 PM, Stephen Smalley wrote:
> On Tue, 2017-05-09 at 23:50 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>>
>>  libsepol/src/ibpkeys.c                        |  264 ++++++++++++++
>>  python/semanage/semanage                      |   60 +++-
>>  python/semanage/seobject.py                   |  253 +++++++++++++
>>  28 files changed, 2159 insertions(+), 17 deletions(-)
> That's a lot of code.  Did you look at whether you could generalize the
> port record stuff at all to see if we could factor out common helpers
> or anything?  I guess this is consistent with the current code, but it
> seems like a lot of very similar code being duplicated and then
> slightly tweaked.
I don't see a good way to generalize.  The high/low pkey/port part overlaps, but all that code is compact anyway.  To make it work for both would complicate it to figure out the correct key/ocontext to use.  The protocol and subnet_prefix handling is most of the code, and it's very different.
>
>>  
>>  	create_dir(newroot_path(), 0o755)
>> diff --git a/libsepol/VERSION b/libsepol/VERSION
>> index 5154b3f..e70b452 100644
>> --- a/libsepol/VERSION
>> +++ b/libsepol/VERSION
>> @@ -1 +1 @@
>> -2.6
>> +2.6.0
> Extraneous change?
Yes.
>> +struct sepol_ibpkey {
>> +	/* Subnet prefix */
>> +	char *subnet_prefix;
>> +	size_t subnet_prefix_sz;
> Do we need support for variable-length subnet prefix?  Can it change?
It doesn't need to be variable.  I'll remove.
>> +#ifdef DARWIN
>> +	memcpy(subnet_prefix_bytes, in_addr.s6_addr, 16);
>> +#else
>> +	memcpy(subnet_prefix_bytes, in_addr.s6_addr32, 16);
>> +#endif
> Just reduce to always using s6_addr
Done
>> +static int ibpkey_alloc_subnet_prefix(sepol_handle_t *handle,
>> +				      char **subnet_prefix,
>> +				      size_t *subnet_prefix_sz)
>> +{
>> +	char *tmp_subnet_prefix = malloc(16);
>> +	size_t tmp_subnet_prefix_sz = 16;
> No magic constants, and definitely not repeatedly used.
Done
