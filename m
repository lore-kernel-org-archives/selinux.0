Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u34LQ85k028762
 for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2016 17:26:09 -0400
Subject: Re: On Fedora 24 I am seeing something strange with CIL
To: Steve Lawrence <slawrence@tresys.com>,
 Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <56FA96D5.4010806@redhat.com> <56FAC2BB.1070202@redhat.com>
 <5702BD5D.50104@gmail.com> <5702C4A7.4040602@redhat.com>
 <5702C5C2.9050008@gmail.com> <5702CF67.80200@tresys.com>
 <5702D220.1010906@tresys.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <5702DBEB.8030207@redhat.com>
Date: Mon, 4 Apr 2016 17:26:03 -0400
MIME-Version: 1.0
In-Reply-To: <5702D220.1010906@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 04/04/2016 04:44 PM, Steve Lawrence wrote:
> On 04/04/2016 04:32 PM, Steve Lawrence wrote:
>> On 04/04/2016 03:51 PM, Dominick Grift wrote:
>>> On 04/04/2016 09:46 PM, Daniel J Walsh wrote:
>>>
>>>
>>>> On 04/04/2016 03:15 PM, Dominick Grift wrote: On 03/29/2016 08:00
>>>> PM, Daniel J Walsh wrote:
>>>>>>> I investigated this a little further.
>>>>>>>
>>>> manage_chr_files_pattern(svirt_sandbox_domain,
>>>> svirt_sandbox_file_t, svirt_sandbox_file_t)
>>>> define(`manage_chr_files_pattern',` allow $1 self:capability
>>>> mknod; allow $1 $2:dir rw_dir_perms; allow $1 $3:chr_file
>>>> manage_chr_file_perms; ')
>>>>> Ok Makes sense but why didn't this come up with the
>>>>> svirt_sandbox_domain attribute as opposed to container_t?  Maybe
>>>>> this is a change in cil.
>>>>> I guess I should not make this the default for
>>>>> svirt_sandbox_domain, and only add it for specific domains.
>>>>> Thanks Dominick.
>>> Yes that may indeed well be a CIL thing. CIL does optimization, and
>>> this may make policy analysis a bit different. So yes, be careful when
>>> using type attributes to query the policy. Because CIL may have "moved
>>> rules around" for the sake of efficiency. Best to alway's, atleast
>>> also check the rules associated with the type.
>>>
>> I think this is actually the expected behavior. The issue here is that a
>> typeattribute is used with the 'self' keyword. When this happens, the
>> avrule is expanded to the individual rules. For example:
>>
>>    allow attr self : file read;
>>
>> becomes:
>>
>>    allow type1 type1 : file read;
>>    allow type2 type2 : file read;
>>
>> The original avrule never makes it into the policy. Using the -d flag
>> with sesearch will show this is the case. I don't know if 'self' with
>> typeattributes is a kernel limitation or not, but both CIL and
>> checkpolicy have the same behavior.
>>
> Ah, actually, I think the binary policy/kernel does not have a concept
> of 'self' at all. Once put in the binary, this
>
>    allow type1 self : file read;
>
> becomes
>
>    allow type1 type1 : file read;
>
> So 'self' is essentially replaced with the source type. However, you
> cannot do this replacement when source is an attribute because this
>
>    allow attr self : file read;
>
> and this
>
>    allow attr attr : file read;
>
> have very different meanings. So since the kernel has no concept of
> self, attributes with self must be expanded.
>
That makes sense, so it probably worked the same was as before, anyways 
I was confused,
and now I have a fix to get what I want which is a container process 
with no caps.

>>>>>>> If I write a policy file like
>>>>>>>
>>>>>>> ===============================================
>>>>>>> policy_module(container, 1.0) gen_require(` attribute
>>>>>>> svirt_sandbox_domain; ')
>>>>>>>
>>>>>>> type foobar_t; domain_type(foobar_t) typeattribute foobar_t
>>>>>>> svirt_sandbox_domain;
>>>>>>> ===============================================
>>>>>>>
>>>>>>> I get
>>>>>>>
>>>>>>>
>>>>>>> sesearch -A -s foobar_t  | grep capa allow foobar_t foobar_t
>>>>>>> : capability mknod ;
>>>>>>>
>>>>>>> If I remove the typeattribute line foobar_t no longer has
>>>>>>> mknod.
>>>>>>>
>>>>>>> I think this is a compiler problem.
>>>>>>>
>>>>>>> On 03/29/2016 10:53 AM, Daniel J Walsh wrote:
>>>>>>>> When I compile and install this policy
>>>>>>>>
>>>>>>>> ---------------------------------------------------------------
>>>>>>>> # cat /tmp/container.te policy_module(container, 1.0)
>>>>>>>>
>>>>>>>> virt_sandbox_domain_template(container)
>>>>>>>>
>>>>>>>> ----------------------------------------------------------------
>>>>>>>>
>>>>>>>>
>>> I end up with mknod capability.
>>>>>>>> sesearch -A -s container_t -t container_t  -c capability
>>>>>>>> Found 1 semantic av rules: allow container_t container_t :
>>>>>>>> capability mknod ;
>>>>>>>>
>>>>>>>> But I didn't add mknod to the policy.
>>>>>>>>
>>>>>>>> grep mknod tmp/container.tmp class capability { chown
>>>>>>>> dac_override dac_read_search fowner fsetid kill setgid
>>>>>>>> setuid setpcap linux_immutable net_bind_service
>>>>>>>> net_broadcast net_admin net_raw ipc_lock ipc_owner
>>>>>>>> sys_module sys_rawio sys_chroot sys_ptrace sys_pacct
>>>>>>>> sys_admin sys_boot sys_nice sys_resource sys_time
>>>>>>>> sys_tty_config mknod lease audit_write audit_control
>>>>>>>> setfcap };
>>>>>>>>
>>>>>>>> Any ideas?
>>>>>>> _______________________________________________ Selinux
>>>>>>> mailing list Selinux@tycho.nsa.gov To unsubscribe, send email
>>>>>>> to Selinux-leave@tycho.nsa.gov. To get help, send an email
>>>>>>> containing "help" to Selinux-request@tycho.nsa.gov.
>>>> -- Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B
>>>> 6B02
>>>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
>>>
>>> Dominick Grift
>>>>> _______________________________________________ Selinux mailing
>>>>> list Selinux@tycho.nsa.gov To unsubscribe, send email to
>>>>> Selinux-leave@tycho.nsa.gov. To get help, send an email
>>>>> containing "help" to Selinux-request@tycho.nsa.gov.
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
