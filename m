Reply-To: dwalsh@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
 Paul Moore <pmoore@redhat.com>
Cc: James Carter <jwcart2@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
References: <851ac48d-9479-41ac-6a61-9c93d6ea2a7f@redhat.com>
 <1515512408.24762.13.camel@tycho.nsa.gov>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <04e01c37-239e-a7d7-d496-dcde4f4afb79@redhat.com>
Date: Tue, 9 Jan 2018 10:45:48 -0500
MIME-Version: 1.0
In-Reply-To: <1515512408.24762.13.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: More problems with bounds checking.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/09/2018 10:40 AM, Stephen Smalley wrote:
> On Tue, 2018-01-09 at 10:19 -0500, Daniel Walsh wrote:
>> For some reason semodule will not allow me to install container.pp.
>> I
>> am trying to have type bounds from container_runtime_t to spc_t to
>> container_t.
> Any reason this isn't on list?
Nope bad habit. I will send this to the list.
> BTW, if you apply my "Generalize support for NNP/nosuid SELinux domain
> transitions" kernel patch (or use a kernel that includes it, >= 4.14)
> and enable the nnp_nosuid_transition policy capability, you shouldn't
> have to use type bounds at all anymore.
>
>> I start with no type bounds.
>>
>> # seinfo --typebounds
>>
>> Typebounds: 0
>>
>> During the install it tells me spc_t is already bound by a parent,
>> no
>> clue what parent.  And cil file does not exist when command
>> completes.
> Yes, that's a real pain.  To work around it, I will often run
> /usr/libexec/selinux/hll/pp on the pp file to generate the cil file so
> I can look at the line numbers reported, ala:
> /usr/libexec/selinux/hll/pp container.pp container.cil
> vi container.cil
>
>> # semodule -X 400 -i container.pp
>> Type spc_t already bound by parent at
>> /var/lib/selinux/targeted/tmp/modules/400/container/cil:35
>> Bad bounds statement at
>> /var/lib/selinux/targeted/tmp/modules/400/container/cil:1583
>> semodule:  Failed!
>>
>>
>> I have only the two commands added.
>>
>> # grep typebounds container.te
>> # Added to make typebounds check work.
>> # typebounds container_runtime_exec_t exec_type;
>> # typebounds container_runtime_exec_t mountpoint;
>> #    unconfined_typebounds(container_runtime_t)
>> typebounds container_runtime_t spc_t;
>> typebounds spc_t container_t;
>>
>> This is what is generated in the tmp file.
>>
>> # grep typebounds.* tmp/container.tmp
>>       #    unconfined_exec_typebounds(container_runtime_exec_t)
>>       #    unconfined_exec_typebounds(container_auth_exec_t)
>> # Added to make typebounds check work.
>> # typebounds container_runtime_exec_t exec_type;
>> # typebounds container_runtime_exec_t mountpoint;
>> #    unconfined_typebounds(container_runtime_t)
>> typebounds container_runtime_t spc_t;
>> typebounds spc_t container_t;
>>
>>
