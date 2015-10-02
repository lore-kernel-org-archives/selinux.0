Subject: Re: av_decision on audit callback
To: "Roberts, William C" <william.c.roberts@intel.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC560107EEE9@ORSMSX103.amr.corp.intel.com>
 <560ED2EF.6090402@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560ED713.5090004@tycho.nsa.gov>
Date: Fri, 2 Oct 2015 15:12:19 -0400
MIME-Version: 1.0
In-Reply-To: <560ED2EF.6090402@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/02/2015 02:54 PM, Stephen Smalley wrote:
> On 10/02/2015 02:48 PM, Roberts, William C wrote:
>> I would like to be able to gather the result of permissive mode per
>> domain from a check_access() call for the userspace object managers on
>> Android.
>>
>>  From what I can tell check_access() calls avc_has_perm with a NULL 5th
>> argument. That argument is for the struct avc_entry_ref.
>>
>> That structure has a pointer to an opaque type, avc_entry. Which
>> contains struct av_decision.
>>
>> Which contains flags that have a permissive flag:
>>
>> struct av_decision {
>>
>>          access_vector_t allowed;
>>
>>          access_vector_t decided;
>>
>>          access_vector_t auditallow;
>>
>>          access_vector_t auditdeny;
>>
>>          unsigned int seqno;
>>
>>          unsigned int flags;
>>
>> };
>>
>> /* Definitions of av_decision.flags */
>>
>> #define SELINUX_AVD_FLAGS_PERMISSIVE    0x0001
>>
>> It looks like if check_access just passes this structure and then
>> avc_has_perm() when it calls avc_audit, it could supply the av_decision
>> structure to the avc_suppl_audit() call. We could then have an audit2
>> callback that takes this parameter.
>>
>> Is this mostly right, seem sane? Better way to do this?
>
> It doesn't need to be exposed at that level; the libselinux avc_audit()
> routine can log it, similar to what is done in the kernel.  It already
> has the av_decision structure available to it.

To clarify, anything directly known to the AVC, like the permissive 
flag, can be directly logged by it.  The audit callback is for logging 
auxiliary audit information not known to the AVC (the pid of the client 
process being a good example).
