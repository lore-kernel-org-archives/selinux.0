Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r04ECGV4014622
	for <selinux@tycho.nsa.gov>; Fri, 4 Jan 2013 09:12:16 -0500
Message-ID: <50E6E31D.7080302@hoentjen.eu>
Date: Fri, 04 Jan 2013 15:11:41 +0100
From: Sander Hoentjen <sander@hoentjen.eu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: policy for PowerDNS
References: <50BCB590.8010602@hoentjen.eu> <1354547319.13093.2.camel@localhost> <50BDE094.9010405@hoentjen.eu> <50BE0529.2090902@redhat.com> <CAPzO=NyBgG7q8yqzxzQGnePN6FyuxRi_5YEKLc+t4tuH3Kao3w@mail.gmail.com> <50BF355A.3090708@redhat.com> <20121205192426.GA6594@siphos.be> <50D84F10.4060401@hoentjen.eu> <50DC666E.4040101@redhat.com> <50DC67F3.6040008@hoentjen.eu> <50DC8383.1060006@redhat.com> <50E58BE1.9080708@hoentjen.eu> <50E5B490.3010206@redhat.com>
In-Reply-To: <50E5B490.3010206@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/03/2013 05:40 PM, Daniel J Walsh wrote:
> On 01/03/2013 08:47 AM, Sander Hoentjen wrote:
>> On 12/27/2012 06:21 PM, Daniel J Walsh wrote:
>>> On 12/27/2012 10:23 AM, Sander Hoentjen wrote:
>>>> On 12/27/2012 04:17 PM, Daniel J Walsh wrote:
>>>>> On 12/24/2012 07:48 AM, Sander Hoentjen wrote:
>>>>>> On 12/05/2012 08:24 PM, Sven Vermeulen wrote:
>>>>>>> On Wed, Dec 05, 2012 at 06:51:54AM -0500, Daniel J Walsh wrote:
>>>>>>>>> If named by default doesn't require this access, doesn't it
>>>>>>>>> make sense to keep it restricted? Remote code execution 
>>>>>>>>> vulnerabilities might be mitigated if the policy prohibits 
>>>>>>>>> execution of common binaries
>>>>>>>>>
>>>>>>>>> Reading /usr however seems less problematic (I'm even
>>>>>>>>> surprised it doesn't require this already).
>>>>>>>>
>>>>>>>> Perhaps but if you have enough control over a process to
>>>>>>>> execute random binaries, one would guess you have enough
>>>>>>>> control to call other syscalls implemented in those binaries.
>>>>>>>
>>>>>>> I can follow your reasoning, but I disagree.
>>>>>>>
>>>>>>> Remote command execution can be done either in a very simple way
>>>>>>> (for instance, user input that is not correctly sanitized and
>>>>>>> that is directly used for spawning specific commands) or through
>>>>>>> memory manipulation.
>>>>>>>
>>>>>>> Let's say it is memory manipulation, then there are imho two
>>>>>>> ways this can lead to a remote command execution: data memory or
>>>>>>> execution memory.
>>>>>>>
>>>>>>> Either the memory is data (non-executable) and is used by the 
>>>>>>> application for its flows, logic and what else. In this case,
>>>>>>> you won't have the ability to invoke syscalls yourself (through
>>>>>>> the exploit) but you can manipulate the application, which
>>>>>>> underlyingly might use the data to spawn commands.
>>>>>>>
>>>>>>> Or the memory is code (executable). In this case, if you can 
>>>>>>> manipulate this, then you indeed have control over the
>>>>>>> application completely and can invoke system calls yourself.
>>>>>>>
>>>>>>> The majority of Remote Code Execution vulnerabilities, imho,
>>>>>>> plays in the data memory, not in the executable memory. For one,
>>>>>>> because executable memory shouldn't be writeable in the first
>>>>>>> place (you can use PaX or other constraints for that). It is also
>>>>>>> harder to manipulate this code to the extend that you can do
>>>>>>> useful things with it.
>>>>>>>
>>>>>>> But if we're talking about data memory manipulation/corruption,
>>>>>>> then the syscalls don't play a role, and SELinux can reduce the
>>>>>>> impact of such vulnerabilities if you can downplay what the
>>>>>>> domain is allowed to do. Such as executing generic binaries.
>>>>>>>
>>>>>>> Of course, an even better way to handle this is to chroot the
>>>>>>> named daemon itself so that there are no binaries to execute
>>>>>>> beyond those that are already needed. I do believe that chrooting
>>>>>>> named is still a very useful approach even if you use SELinux
>>>>>>> [1], but there are people that think differently.
>>>>>>>
>>>>>> Trying to move the policy for pdns forward, do I understand
>>>>>> correctly that the following additions to the policy would be ok: 
>>>>>> ======pdns.fc====== /usr/sbin/pdns_server           -- 
>>>>>> gen_context(system_u:object_r:named_exec_t,s0) /etc/pdns/pdns\.conf
>>>>>> -- gen_context(system_u:object_r:named_conf_t,s0) 
>>>>>> /var/run/pdns\.controlsocket    -s 
>>>>>> gen_context(system_u:object_r:named_var_run_t,s0)
>>>>>> /var/run/pdns\.pid -- 
>>>>>> gen_context(system_u:object_r:named_var_run_t,s0)
>>>>>> =================== ======pdns.te====== policy_module(pdns,0.0.1)
>>>>>
>>>>>> require{ type named_t; }
>>>>>
>>>>>> #only needed if using the guardian allow named_t self:capability {
>>>>>> kill };
>>>>>
>>>>>> #gmysql backend: mysql_read_config(named_t) 
>>>>>> files_read_usr_files(named_t) mysql_stream_connect(named_t)
>>>>>
>>>>>> #postgres backend: postgresql_stream_connect(named_t) 
>>>>>> ===================
>>>>>
>>>>>> But the following addition to the .te is under discussion: #pipe 
>>>>>> backend: corecmd_exec_bin(named_t)
>>>>>
>>>>>> If i am correct up till this point, I would be okay with either
>>>>>> having corecmd_exec_bin in a boolean, or use a new type for this
>>>>>> and add documentation to pdns showing what type you need to make
>>>>>> your pipe backend.
>>>>>
>>>>>> What do you guys think?
>>>>>
>>>>>> -- This message was distributed to subscribers of the selinux
>>>>>> mailing list. If you no longer wish to subscribe, send mail to 
>>>>>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
>>>>>> without quotes as the message.
>>>>>
>>>>>
>>>>>
>>>>> What is the path to the bin_t?  I am not opposed to allow it to
>>>>> execute random bin_t, but if this is a constant path, then labeling
>>>>> it would be more secure. named_helper_exec_t or something.
>>>>>
>>>> Well, there is not a fixed path at this moment. The point of the 
>>>> pipe-backend is that you can easily write your own script/binary. Then
>>>> in the config you tell pdns where it is located. So then in the
>>>> documentation for the pipe-backend we could write that in the case of
>>>> selinux you either need top put it in the right path, or apply the
>>>> correct label yourself.
>>>
>>> Well it is not quite that easy, since the back end would be running as a 
>>> random label, we would have to write policy about more then just
>>> executing the script but also all of the access required for the dns
>>> server to talk to this back end.  Stuff like connecting to a labeled unix
>>> fifo file or sock file, connecting to a processes running what ever label
>>> the process is running with.
>>>
>> Well, in the simple case this is not needed, the example script[1] is just
>> a simple perl script, that needs no extra access. But I guess you mean that
>> if this script does things not allowed for named_t then it will fail. I
>> guess you are right, but I do not know what would be a good way to fix
>> this. It doesn't matter in this case if it is bin_t or some other type,
>> right?
> 
> 
>> [1] 
>> http://wiki.powerdns.com/trac/browser/trunk/pdns/modules/pipebackend/backend.pl
> 
>>  -- This message was distributed to subscribers of the selinux mailing
>> list. If you no longer wish to subscribe, send mail to
>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
>> as the message.
> 
> 
> Yes the question is do you expect admin to modify this script to do nutty
> things or do you envision this script to only be used as is.
> 
Well, the script will not be used as is, but running the pipe-backend is
also not a main use-case of powerdns. Requiring pipe-backend users to
write their own policy when they want selinux protection would imho not
be a very bad option, since you can never know in advance how it will be
used.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
