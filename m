Message-ID: <427FAB86.4050905@redhat.com>
Date: Mon, 09 May 2005 14:27:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: russell@coker.com.au, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [Fwd: Latest Diff]
References: <427A757F.9040009@redhat.com>	 <1115344683.15149.11.camel@localhost.localdomain>	 <1115393991.17301.18.camel@localhost.localdomain>	 <200505072351.04728.russell@coker.com.au>	 <1115485468.21610.8.camel@localhost.localdomain>	 <1115495425.20062.2.camel@localhost.localdomain>	 <427F76BE.60506@redhat.com>	 <1115662376.10218.16.camel@localhost.localdomain>	 <427FA923.9010906@redhat.com> <1115663075.10218.25.camel@localhost.localdomain>
In-Reply-To: <1115663075.10218.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>Doesn't you patch mean that every app that links with orbit needs to 
>>able to read context files
>>and able to setfscreatecon?
>>
>>    
>>
>
>Oh - I thought you meant something else.
>Yes, it does. Is this a bad thing?
>
>The setfscreatecon is limited to self -
>
>##################################
>#
># can_setfscreate(domain)
>#
># Authorize a domain to set its fscreate context
># (via /proc/pid/attr/fscreate).
>#
>define(`can_setfscreate',`
>allow $1 self:process setfscreate;
>allow $1 proc_t:dir search;
>allow $1 proc_t:{ file lnk_file } read;
>allow $1 self:dir search;
>allow $1 self:file { getattr read write };
>')
>
>Here's the full list of selinux privileges needed:
>
>
># Set its type - libselinux integration
>can_setfscreate($1_t)
>can_getsecurity($1_t)
>r_dir_file($1_t, selinux_config_t)
>r_dir_file($1_t, file_context_t)
>allow $1_t default_context_t:dir search;
>
>  
>
I think I can create a file with context of passwd_t via those privs?

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
