Message-ID: <4AD628A9.3070603@manicmethod.com>
Date: Wed, 14 Oct 2009 15:38:17 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] libsepol: Add support for multiple target OSes
References: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>	 <4AB0EF22.8070003@manicmethod.com> <1254233003.2466.59.camel@moss-stripedbass.epoch.ncsc.mil> <4AD4DB77.9070904@manicmethod.com>
In-Reply-To: <4AD4DB77.9070904@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Paul Nuzzi wrote:
>> On Wed, 2009-09-16 at 09:58 -0400, Joshua Brindle wrote:
>>> I'd rather have separate ocontext structs for each system. That way it
>>> is very easy to understand which ones apply to which system and you
>>> don't get a crazy out of context ocontext struct.
>>>
>>
>> I looked into having separate ocontext structs but that would involve
>> changing a lot of files making the patch much larger and more intrusive.
>>
>>>> } u;
>>>> union {
>>>> uint32_t sclass; /* security class for genfs */
>>>> @@ -313,6 +323,17 @@ typedef struct genfs {
>>>> #define OCON_NODE6 6 /* IPv6 nodes */
>>>> #define OCON_NUM 7
>>>>
>>>> +/* object context array indices for Xen */
>>>> +#define OCON_ISID 0 /* initial SIDs */
>>>> +#define OCON_PIRQ 1 /* physical irqs */
>>>> +#define OCON_IOPORT 2 /* io ports */
>>>> +#define OCON_IOMEM 3 /* io memory */
>>>> +#define OCON_DEVICE 4 /* pci devices */
>>>> +#define OCON_DUMMY1 5 /* reserved */
>>>> +#define OCON_DUMMY2 6 /* reserved */
>>>> +#define OCON_NUM 7
>>>> +
>>>> +
>>>>
>>> Should these be namespaced? What if<random other system> has io port
>>> objects? You'd have to align them with each other and you have a mess of
>>> keeping the numbers the same (you already do this with OCON_ISID)
>>
>> Variables have been namespaced and there is no more overlap with
>> OCON_ISID.
>>
>>> Also we are relying on having the same number of OCON's which isn't good
>>> I don't think. As much as I hate the policydb_compat_info (read: alot)
>>> why aren't we using that to say how many ocons a xen policy really has?
>>
>> OCON_NUM is now dynamically read through policydb_compat_info.
>>
>>
>>> This is messy, why not an ocontext_selinux_free() and
>>> ocontext_xen_free() (note: I realize the xen_free() one won't do
>>> anything except freep the ocontext_t)
>>>
>>
>> done.
>>
>>>> len = buf[1];
>>>> - if (len != strlen(target_str)&&
>>>> - (!alt_target_str || len != strlen(alt_target_str))) {
>>>> - ERR(fp->handle, "policydb string length %zu does not match "
>>>> - "expected length %zu", len, strlen(target_str));
>>>> + if (len> 32) {
>>>>
>>> magic number 32?
>>
>> #defined.
>>
>> Thanks for your input. Below is the updated patch for libsepol.
>>
>
> Acked-by: Joshua Brindle <method@manicmethod.com>
>
> for the entire patchset with the following diff on top:
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 76d8ed3..c5fdf19 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -100,8 +100,8 @@ unsigned int policyvers = POLICYDB_VERSION_MAX;
> void usage(char *progname)
> {
> printf
> - ("usage: %s [-b] [-d] [-U handle_unknown (allow,deny,reject) [-M]"
> - "[-c policyvers (%d-%d)] [-o output_file] [-t platform]"
> + ("usage: %s [-b] [-d] [-U handle_unknown (allow,deny,reject)] [-M]"
> + "[-c policyvers (%d-%d)] [-o output_file] [-t (selinux,xen)]"
> "[input_file]\n",
> progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
> exit(1);
>
>

Merged in checkpolicy 2.0.20, libsepol 2.0.39, sepolgen 1.0.18




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
