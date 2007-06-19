Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JHLtIZ028089
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 13:21:55 -0400
Message-ID: <467810A5.3090306@redhat.com>
Date: Tue, 19 Jun 2007 13:21:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov
Subject: Re: problem setting the security context of directories vs files
References: <FB39F4E77226B448BC1388D3BE4E00CD01DBF7FE@blums0008.bluelnk.net> <1182272762.2086.78.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1182272762.2086.78.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:
> On Tue, 2007-06-19 at 09:34 -0700, Clarkson, Mike R (US SSA) wrote:
>   
>> I'm having trouble setting the security context of directories using
>> file contexts. It seems to be working fine for files, but not
>> directories.
>>
>> I have a module named import. Here is a copy of my import.fc file:
>>
>> /m2ds/import	--	gen_context(system_u:object_r:import_dir_t,s0)
>> /m2ds/import/datasources	--
>> gen_context(system_u:object_r:import_dir_t,s0)
>> /m2ds/import/stage	--
>> gen_context(system_u:object_r:import_stage_t,s0)
>> /m2ds/import/junk	--
>> gen_context(system_u:object_r:import_dir_t,s0)
>> /home/m2/SimulatedImport/bin/SimulatedImport	--
>> gen_context(system_u:object_r:import_exec_t,s0)
>> /home/m2/SimulatedImport/bin/SimulatedImport_Server	--
>> gen_context(system_u:object_r:import_exec_t,s0)
>>
>>
>>     
> Use "-d" for directories, instead of "--".
>
> The obscure options available to use are:
> -b	block
> -c	character
> -d 	directory
> -p	pipe
> -l	link
> -s	socket
> --	regular
>
>
>   
"  " matches all.
"-" followed by the first character output by 'ls -l'.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
