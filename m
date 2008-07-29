Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6TLN4X8022065
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 17:23:04 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6TLN3EH017447
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 21:23:03 GMT
Message-ID: <488F8A31.8070301@kutulu.org>
Date: Tue, 29 Jul 2008 17:22:57 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy patch, second try] samba policy updates
References: <488DED3A.1030005@kutulu.org>	 <1217342823.4934.42.camel@defiant.pebenito.net>	 <488F5590.6060908@kutulu.org> <1217361293.5525.13.camel@gorn.pebenito.net>
In-Reply-To: <1217361293.5525.13.camel@gorn.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris PeBenito wrote:

> ifdef(`distro_redhat
>   optional_policy(`
>     tunable_policy(`samba_
>       oddjob_domtrans_
>     ')
>   ')
> ',`
>   tunable_policy(`samba_
>     unprivuser_create_
>     unprivuser_home_filetrans_
>   ')
> ')
> 
> Hopefully my pseudopolicy makes sense.

It does, but I wonder if it's making the policy more complex than it 
needs.  Right now, in the RedHat case, samba doesn't know nor care that 
oddjob is being used to make home directories, since the PAM module runs 
an external binary that transitions into its own domain, controlled by 
the oddjob module.  I'm not sure what actual policy rules could go into 
the samba_oddjob case that would do anything useful, and I don't yet 
have a RH or FC system up and running to test any changes on (thats in 
the works, tho).

IMHO I think the two best alternatives are: skip the distro-specific 
rules and do the same thing in all cases, or just do nothing at all in 
the RedHat case.  RedHat users really should never have to enable this 
option anyway, but if they do I don't think it opens any major new 
security risks: samba already needs to have full read/write permission 
to home directory *content* (based on the existing enable_home_dirs 
tunable) for this to make any sense, and I think I've fixed the policy 
so it can only create new home directories, not delete or rename them.

Would it be sufficient warning to add this to the .te file so it shows 
up in the booleans.conf file as such:

## <desc>
## <p>
## Allow samba to create new home directories.  (Not recommended
## for RedHat-based systems where oddjob is available.)
## </p>
## </desc>
gen_tunable(samba_create_home_dirs, false)


>>>> +interface(`unprivuser_create_home_dirs',`
>>>> +       unprivuser_home_filetrans_home_dir($1)
>>>> +       unprivuser_manage_home_dirs($1)
>>>> +')
>>> "Create" just means directory create, but you have the full manage
>>> permission set, in addition to a filetrans.
>> I think I did go a bit overboard with the manage permissions.  I'd 
>> copied these from the oddjob's policy, but I notice that oddjobs also 
>> permits deleting home directories, which probably isn't needed here.
>>
>> The filetrans is needed, though, because without it, the created home 
>> directories were getting labeled home_root_t instead of user_home_dir_t. 
>>   It also needs to copy the template files in and label them correctly, 
>> like the user_home_ssh_t on .ssh, etc.  I'll narrow this down.
> 
> Thats fine, but the filetrans shouldn't be included in the create
> interface itself.

Ok, but I'm a little confused then... if I move the filetrans call out 
of the interface, then it becomes just a call into an existing 
interface.  Am I misunderstanding something?  I think I'm having trouble 
determining how granular I should make interfaces like this.

After your previous response, I updated the interface to use more 
specific rules, but it still does the same basic stuff.  For this, I'm 
using "create" not in the low-level "make directory entry in /home" 
sense, but in the higher level "do what needs to be done to end up with 
a fully functional home directory" sense.  Is that where I'm getting 
confused?  Would it help to name the interface something different, like:

interface(`unprivuser_generate_full_home_dir',`
   gen_require(`
     type user_home_t, user_home_dir_t;
   ')

   # Create home directory itself, label as user_home_dir_t
   files_search_home($1)
   files_home_filetrans($1, user_home_dir_t, dir)

   # Copy /etc/skel tree into new home directory, label as
   # user_home_t
   filetrans_pattern($1, user_home_dir_t, user_home_t,
     notdevfile_class_set)
   rw_files_pattern($1, user_home_t, user_home_t)
   add_entry_dirs_pattern($1, user_home_t, user_home_t)
')


--Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
