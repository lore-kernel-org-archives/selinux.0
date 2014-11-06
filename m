Message-ID: <545B76DD.5040506@tycho.nsa.gov>
Date: Thu, 06 Nov 2014 08:25:49 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: kuangjiou <kuangjiou@huawei.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Got Segmentation fault when use avc_context_to_sid() funtion!!
 can anyone help me?
References: <60ABE64B4BE4AC45964F1A967BA76CB2BBDFFB@SZXEML507-MBX.china.huawei.com>
 <545B722F.3020401@tycho.nsa.gov>
In-Reply-To: <545B722F.3020401@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/06/2014 08:05 AM, Stephen Smalley wrote:
> On 11/06/2014 07:44 AM, kuangjiou wrote:
>> Hello,everyone!
>> I am learning how to use the selinux userspace apps recent.And I got Segmentation fault when I use the  avc_context_to_sid() funtion, dose anyone know how to resolve this problem? Thank you very much!
>>
>> The following is my testing code with avc_context_to_sid()  funtion
>>
>> #include <selinux/selinux.h>
>> #include <selinux/avc.h>
>> #include <stdlib.h>
>> #include <stdio.h>
>>
>> int main()
>> {
>>          const char *scon = "system_u:object_r:unconfined_t";
>>          security_id_t sid;
>>          sid->ctx = scon;
>>          sid->refcnt = 28;
>>
>>          avc_context_to_sid(scon, &sid);
>>
>>          return 0;
>> }
> 
> Must be preceded by a call to avc_init() or avc_open().  In current
> libselinux, that is asserted on entry to the function.
> 
> However, I'd encourage you to consider using selinux_check_access()
> instead for SELinux userspace object managers; it internally handles
> calling avc_init() and avc_context_to_sid() as well as mapping class and
> permission strings to numbers, making it much easier to use the AVC from
> userspace.  We have been using it in the Android userspace.

Also, for avc_context_to_sid(), the sid is an output argument; you
aren't supposed to initialize it to anything prior to making the call.
avc_context_to_sid() looks to see if there is already a SID allocated
for the context; if so, it sets sid to reference that SID; if not, it
allocates a new SID and sets sid to reference it.  Any assignment you
make to sid prior to the call will be ignored and overridden.
