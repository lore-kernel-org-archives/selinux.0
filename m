Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CJUKNR013482
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 15:30:20 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5CJUJ19008077
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 19:30:19 GMT
Message-ID: <466EF43C.5050504@redhat.com>
Date: Tue, 12 Jun 2007 15:30:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: admin_amtu changes
References: <200705301530.l4UFUhob010631@localhost.localdomain> <1181674698.16029.71.camel@sgc.columbia.tresys.com>
In-Reply-To: <1181674698.16029.71.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2007-05-30 at 11:30 -0400, dwalsh@redhat.com wrote:
>   
>> Can you upstream this policy?
>>     
>
> I added it with some rearranging and I dropped these rules:
>
>   
>> +allow amtu_t self:capability net_raw;
>> +allow amtu_t self:packet_socket { bind create read write };
>> +allow amtu_t self:udp_socket { create ioctl };
>>     
>
> because there isn't any corenetwork usage, so it can't actually use any
> network interfaces.  Can you recheck these perms?  Also, the perms in
> general seem light, is this policy complete?
>
>   
Never used it, these came from the MLS test suite.
>> +files_manage_boot_files(amtu_t)
>> +files_read_etc_runtime_files(amtu_t)
>> +files_read_etc_files(amtu_t)
>> +
>> +kernel_read_system_state(amtu_t)
>> +
>> +libs_use_ld_so(amtu_t)
>> +libs_use_shared_libs(amtu_t)
>> +
>> +logging_send_audit_msg(amtu_t)
>> +
>> +optional_policy(`
>> +    seutil_use_newrole_fds(amtu_t)
>> +');
>> +
>> +optional_policy(`
>> +    userdom_use_sysadm_fds(amtu_t)
>> +');
>> +
>> +optional_policy(`
>> +    userdom_sigchld_sysadm(amtu_t)
>> +');
>> +
>> +optional_policy(`
>> +    nscd_dontaudit_search_pid(amtu_t)
>> +');
>> +
>> +optional_policy(`
>> +    kernel_dontaudit_read_system_state(amtu_t)
>> +');
>> +
>> +optional_policy(`
>> +    term_dontaudit_search_ptys(amtu_t)
>> +');
>> +
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
