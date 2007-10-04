Message-ID: <470544CE.7000306@tycho.nsa.gov>
Date: Thu, 04 Oct 2007 15:53:50 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] libselinux: minor updates to AVC, mapping, callbacks
References: <47041CB6.8070408@tycho.nsa.gov> <47052C83.3020703@tycho.nsa.gov> <47053A58.8000705@manicmethod.com>
In-Reply-To: <47053A58.8000705@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Eamon Walsh wrote:
>> This patch allows empty strings to be specified as permissions in
>> the dynamic permission mapping.  An empty string will be interpreted
>> as a "skipped bit" which allows userspace object managers to use
>> non-contiguous permission bits.
>>
> 
> Why is this necessary?

In X there is only one hook function for each object type.  The access 
mode being requested is passed as a bitfield of globally defined 
permission bits.  This is a legacy of the SECURITY extension that 
existed before I started my work.  The global permissions are pasted 
below FYI.

This patch allows me to define the Flask permission bits to be the same 
as these global bits and just pass them through.  Without it, I'd have 
to remap the bits on each check.

If you think it's a bad solution, maybe we could go back to the original 
proposal for the mapping function which was to pass the desired class 
and permission values explicitly along with the strings.



#define DixUnknownAccess	0	/* don't know intentions */
#define DixReadAccess		(1<<0)	/* inspecting the object */
#define DixWriteAccess		(1<<1)	/* changing the object */
#define DixDestroyAccess	(1<<2)	/* destroying the object */
#define DixCreateAccess		(1<<3)	/* creating the object */
#define DixGetAttrAccess	(1<<4)	/* get object attributes */
#define DixSetAttrAccess	(1<<5)	/* set object attributes */
#define DixListPropAccess	(1<<6)  /* list properties of object */
#define DixGetPropAccess	(1<<7)	/* get properties of object */
#define DixSetPropAccess	(1<<8)	/* set properties of object */
#define DixGetFocusAccess	(1<<9)	/* get focus of object */
#define DixSetFocusAccess	(1<<10)	/* set focus of object */
#define DixListAccess		(1<<11)	/* list objects */
#define DixAddAccess		(1<<12)	/* add object */
#define DixRemoveAccess		(1<<13)	/* remove object */
#define DixHideAccess		(1<<14)	/* hide object */
#define DixShowAccess		(1<<15)	/* show object */
#define DixBlendAccess		(1<<16)	/* mix contents of objects */
#define DixGrabAccess		(1<<17)	/* exclusive access to object */
#define DixFreezeAccess		(1<<18)	/* freeze status of object */
#define DixForceAccess		(1<<19)	/* force status of object */
#define DixInstallAccess	(1<<20)	/* install object */
#define DixUninstallAccess	(1<<21)	/* uninstall object */
#define DixSendAccess		(1<<22)	/* send to object */
#define DixReceiveAccess	(1<<23)	/* receive from object */
#define DixUseAccess		(1<<24)	/* use object */
#define DixManageAccess		(1<<25)	/* manage object */
#define DixDebugAccess		(1<<26)	/* debug object */
#define DixBellAccess		(1<<27)	/* audible sound */


> 
>> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
>> ---
>>
>> mapping.c |    6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>>
>> Index: libselinux/src/mapping.c
>> ===================================================================
>> --- libselinux/src/mapping.c    (revision 2628)
>> +++ libselinux/src/mapping.c    (working copy)
>> @@ -68,6 +68,11 @@
>>
>>         k = 0;
>>         while (p_in->perms && p_in->perms[k]) {
>> +            /* An empty permission string skips ahead */
>> +            if (!*p_in->perms[k]) {
>> +                k++;
>> +                continue;
>> +            }
>>             p_out->perms[k] = string_to_av_perm(p_out->value,
>>                                 p_in->perms[k]);
>>             if (!p_out->perms[k])
>> @@ -111,6 +116,7 @@
>>
>>         for (i=0; i<current_mapping[tclass].num_perms; i++)
>>             if (tperm & (1<<i)) {
>> +                assert(current_mapping[tclass].perms[i]);
>>                 kperm |= current_mapping[tclass].perms[i];
>>                 tperm &= ~(1<<i);
>>             }
>>
>>
>>
> 
> 


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
