Message-ID: <42DEA816.3080206@redhat.com>
Date: Wed, 20 Jul 2005 15:37:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <42DD6CBE.7090506@redhat.com>	 <1121811396.11941.19.camel@localhost.localdomain>	 <42DE679D.2080909@redhat.com> <1121884870.29587.7.camel@localhost.localdomain>
In-Reply-To: <1121884870.29587.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>>>+allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
>>>>+allow $1_cdrecord_t $1_home_t:dir search;
>>>>+allow $1_cdrecord_t $1_home_dir_t:dir r_dir_perms;
>>>>+allow $1_cdrecord_t $1_home_t:file r_file_perms;
>>>>')
>>>>   
>>>>
>>>>        
>>>>
>>>Same here... why is cdrecord reading the user's private documents.
>>>
>>> 
>>>
>>>      
>>>
>>Usually if you are creating a cd, it will be from your home dir.
>>    
>>
>
>Then cdrecord should be using the read_content macros.
>
>  
>
Ok changed to read_content.  (too many booleans...)

>>>>+allow $1_thunderbird_t fs_t:filesystem getattr;
>>>>   
>>>>
>>>>        
>>>>
>>>Why does it need to do that?
>>> 
>>>
>>>      
>>>
>>Don't know.  Probably checking filesystems in mtab
>>    
>>
>
>Is this statfs() related? 
>We need to implement a macro for statfs, since the same code can be
>found in: gnome_vfs, samba, daemon_core_domain (or daemon_* something),
>and now you're saying thunderbird does something similar. In most of
>those cases the code is incomplete, and doesn't quite work. 
>
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
