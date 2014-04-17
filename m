Message-ID: <53500353.4080309@tycho.nsa.gov>
Date: Thu, 17 Apr 2014 12:37:39 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Kernel Geek <kernelfreak@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Regarding call security_compute_av()
References: <1397793520.8610.3.camel@akshay-desktop>
 <535000D4.9060001@tycho.nsa.gov>
In-Reply-To: <535000D4.9060001@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/17/2014 12:27 PM, Stephen Smalley wrote:
> On 04/17/2014 11:58 PM, Kernel Geek wrote:
>>
>> Hello friends,
>>              I just had a few questions about the above mentioned call
>> which is located in selinux/ss/services.c. Questions as follows :
>>
>> 1) As the calls documentation reads, it is responsible for computing
>> access decisions for source and target security contexts. Does that
>> means if the call is always returns 0 then access would be permitted? Is
>> that a valid logic? I believe value of rc says if access is allowed or not?
> 
> No.  security_compute_av computes a complete allowed access vector
> (along with other access vectors for auditingthat can then be checked by
> the caller to see if access would be permitted.  Typically one does not
> directly call security_compute_av but rather avc_has_perm(), which will
> return an error if access is denied.  In fact, in modern kernels,
> security_compute_av() is a void function because all error paths are
> handled by returning an allowed access vector with all bits cleared so
> that it will be handled by the AVC as a normal denial.  In older kernel
> versions, security_compute_av could return an error on certain error
> conditions in which case the AVC would still treat it as a denial and
> audit it.
> 
>> 2) I noticed it calls context_struct_compute_av() which initializes AVC
>> defaults, does preliminary checks and returns value of rc. Is my reasoning 
>> correct?
> 
> In a current kernel, both security_compute_av and
> context_struct_compute_av() are void functions.  Even in older kernels,
> it was never the case that an error return code was used for a normal
> denial, only for an internal error on e.g. SID lookup or some other
> condition that prevented the normal computation from proceeding.
> 
>> 3) Who calls security_compute_av() ? 
> 
> The Access Vector Cache (AVC), security/selinux/avc.c in the kernel.
> 
> The specifics have changed over time but the general architecture and
> many of the interfaces were described in various background papers and
> technical reports available from our site,
> http://www.nsa.gov/research/selinux/background.shtml
> http://www.nsa.gov/research/selinux/docs.shtml

Also, FWIW, there are man pages for security_compute_av, avc_has_perm,
and other interfaces provided by libselinux that mirror those of the
kernel for use by userspace policy enforcers.  They are not always
identical as both have undergone changes over time independently, but
you may find it helpful.  These days, as I said in another recent thread
on this topic, selinux_check_access() is the preferred interface for
userspace policy enforcers / object managers.
