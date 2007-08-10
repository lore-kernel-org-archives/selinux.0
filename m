Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7ADHCJB002184
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 09:17:12 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7ADHA1t006443
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 13:17:11 GMT
Message-ID: <46BC6555.9010802@redhat.com>
Date: Fri, 10 Aug 2007 09:17:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] refpolicy: kernel_kernel changes
References: <200708022004.l72K4Ome029700@redsox.boston.devel.redhat.com> <1186497721.18881.27.camel@gorn>
In-Reply-To: <1186497721.18881.27.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2007-08-02 at 16:04 -0400, dwalsh@redhat.com wrote:
>   
>> Additional interfaces for kernel access
>>
>> @@ -1848,6 +1866,27 @@
>>
>>  ########################################
>>  ## <summary>
>> +##     Read the process state (/proc/pid) of all unlabeled_t.
>> +## </summary>
>> +## <param name="domain">
>> +##     <summary>
>> +##     Domain allowed access.
>> +##     </summary>
>> +## </param>
>> +#
>> +interface(`kernel_read_unlabeled_state',`
>> +       gen_require(`
>> +               type unlabeled_t;
>> +       ')
>> +
>> +       allow $1 unlabeled_t:dir list_dir_perms;
>> +       read_files_pattern($1,unlabeled_t,unlabeled_t)
>> +       read_lnk_files_pattern($1,unlabeled_t,unlabeled_t)
>> +')
>>     
>
> I'm concerned about this interface since unlabled_t is used for domains
> and objects.  Someone using this interface might not realize the
> specified domain can now also read other unlabeled files.
>
>   
The only domain that gets assigned this is sysadm_t.  I believe this was 
needed in order to kill processes that were in the unlabeled state.  For 
example if a sysadm unloads a policy file for a running process.  The 
process goes wild eating up all of cpu, and he can't kill it or even see 
which process is causing the problem.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
