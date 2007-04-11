Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BKKMLM013623
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 16:20:22 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BKKKT2018219
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 20:20:21 GMT
Message-ID: <461D42FD.50601@redhat.com>
Date: Wed, 11 Apr 2007 16:20:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux_getattr patch
References: <460426EA.6050801@redhat.com> <1176320717.9840.55.camel@sgc>
In-Reply-To: <1176320717.9840.55.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2007-03-23 at 15:13 -0400, Daniel J Walsh wrote:
>   
>> Some apps doing a getattr of all files in / generate avc messages on
>> /selinux
>>
>> This patch removes those avc's.
>>     
>
> This looks more like something to do with the libselinux constructor.
> Perhaps we should have interfaces for selinux aware programs, for
> allowing and dontauditing the constructor, at least.
>
>   
This works for me.
>>
>>
>>
>> differences
>> between files
>> attachment
>> (selinux_getattr.patch), "selinux_getattr.patch"
>>
>> --- nsaserefpolicy/policy/modules/kernel/selinux.if     2007-02-27 14:37:10.000000000 -0500
>> +++ serefpolicy-2.5.10/policy/modules/kernel/selinux.if 2007-03-22 15:06:58.000000000 -0400
>> @@ -51,6 +51,44 @@
>>  
>>  ########################################
>>  ## <summary>
>> +##     Do not audit attempts to get the
>> +##     attributes of the selinuxfs filesystem
>> +## </summary>
>> +## <param name="domain">
>> +##     <summary>
>> +##     Domain to not audit.
>> +##     </summary>
>> +## </param>
>> +#
>> +interface(`selinux_dontaudit_getattr_fs',`
>> +       gen_require(`
>> +               type security_t;
>> +       ')
>> +
>> +       dontaudit $1 security_t:filesystem getattr;
>> +')
>> +
>> +########################################
>> +## <summary>
>> +##     Allow domain to get the
>> +##     attributes of the selinuxfs filesystem
>> +## </summary>
>> +## <param name="domain">
>> +##     <summary>
>> +##     Domain to not audit.
>> +##     </summary>
>> +## </param>
>> +#
>> +interface(`selinux_getattr_fs',`
>> +       gen_require(`
>> +               type security_t;
>> +       ')
>> +
>> +       allow $1 security_t:filesystem getattr;
>> +')
>> +
>> +########################################
>> +## <summary>
>>  ##     Search selinuxfs.
>>  ## </summary>
>>  ## <param name="domain">
>> --- nsaserefpolicy/policy/modules/system/selinuxutil.if 2007-01-02 12:57:49.000000000 -0500
>> +++ serefpolicy-2.5.10/policy/modules/system/selinuxutil.if     2007-03-22 15:06:59.000000000 -0400
>> @@ -616,7 +616,7 @@
>>         gen_require(`
>>                 type selinux_config_t;
>>         ')
>> -
>> +       selinux_dontaudit_getattr_fs($1)
>>         dontaudit $1 selinux_config_t:dir search;
>>         dontaudit $1 selinux_config_t:file { getattr read };
>>  ')
>> @@ -637,6 +637,8 @@
>>                 type selinux_config_t;
>>         ')
>>  
>> +       selinux_getattr_fs($1)
>> +
>>         files_search_etc($1)
>>         allow $1 selinux_config_t:dir list_dir_perms;
>>         read_files_pattern($1,selinux_config_t,selinux_config_t)
>>
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
