Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26Ed3C2031817
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 09:39:03 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l26EeTF8023091
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 14:40:29 GMT
Message-ID: <45ED7D52.2040608@redhat.com>
Date: Tue, 06 Mar 2007 09:40:18 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: ricci changes in policy
References: <200702261738.l1QHcBUu030687@localhost.localdomain> <1173191008.15853.12.camel@sgc>
In-Reply-To: <1173191008.15853.12.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2007-02-26 at 12:38 -0500, dwalsh@localhost.localdomain wrote:
>   
>> ricci modstorage needs to be able to configure lvm and work with ccs
>>     
>
> Merged except for one bit:
>
>   
>> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_services_ricci.patch===
>> --- nsaserefpolicy/policy/modules/services/ricci.te	2007-02-19 11:32:53.000000000 -0500
>> +++ serefpolicy-2.5.5/policy/modules/services/ricci.te	2007-02-26 11:02:34.000000000 -0500
>> @@ -448,7 +449,7 @@
>>  # ricci_modstorage local policy
>>  #
>>  
>> -allow ricci_modstorage_t self:process { setsched signal };
>> +allow ricci_modstorage_t self:process { setsched signal ptrace };
>>  allow ricci_modstorage_t self:capability { mknod sys_nice };
>>  allow ricci_modstorage_t self:fifo_file rw_fifo_file_perms;
>>  allow ricci_modstorage_t self:unix_dgram_socket create_socket_perms;
>>     
>
> Sure this shouldn't be dontaudited instead?
>
>   

We can try.  I find in some cases it is required, if the confined domain 
actually wants to read a value.  For example, hal currently reads an 
environment variable and requires ptrace.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
