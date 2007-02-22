Message-ID: <45DDBEFA.3050901@redhat.com>
Date: Thu, 22 Feb 2007 11:04:10 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I think this is equivalent to what we have now	and	more	efficient.
References: <45DDAA80.80603@redhat.com>	 <1172155540.14363.372.camel@moss-spartans.epoch.ncsc.mil>	 <45DDB102.6080309@redhat.com>	 <1172157049.14363.381.camel@moss-spartans.epoch.ncsc.mil>	 <45DDB878.2030505@redhat.com>	 <1172158714.14363.399.camel@moss-spartans.epoch.ncsc.mil> <1172159012.14363.404.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172159012.14363.404.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-02-22 at 10:38 -0500, Stephen Smalley wrote:
>   
>> On Thu, 2007-02-22 at 10:36 -0500, Daniel J Walsh wrote:
>>     
>>> Stephen Smalley wrote:
>>>       
>>>> On Thu, 2007-02-22 at 10:04 -0500, Daniel J Walsh wrote:
>>>>   
>>>>         
>>>>> Stephen Smalley wrote:
>>>>>     
>>>>>           
>>>>>> On Thu, 2007-02-22 at 09:36 -0500, Daniel J Walsh wrote:
>>>>>>   
>>>>>>       
>>>>>>             
>>>>>>> int is_selinux_enabled(void)
>>>>>>> {
>>>>>>>     security_context_t con;
>>>>>>>
>>>>>>>     if (getcon_raw(&con) == 0) {
>>>>>>>         int enabled = 1;
>>>>>>>         if (!strcmp(con, "kernel"))
>>>>>>>             enabled = 0;
>>>>>>>         freecon(con);
>>>>>>>         return enabled;
>>>>>>>     
>>>>>>>         
>>>>>>>               
>>>>>> IOW, if I can read /proc/self/attr/current successfully (will fail if
>>>>>> SELinux disabled or under certain unrelated conditions) and its value
>>>>>> indicates a policy has been loaded, then SELinux is enabled.
>>>>>>
>>>>>>   
>>>>>>       
>>>>>>             
>>>>>>>     } else {
>>>>>>>         struct stat buf;
>>>>>>>         return (stat("/proc/filesystems", &buf));
>>>>>>>     
>>>>>>>         
>>>>>>>               
>>>>>> That won't test for selinux at all - you have to check the contents
>>>>>> of /proc/filesystems for selinuxfs or stat /selinux and check for the
>>>>>> selinux magic number as per Steve's patch.
>>>>>>
>>>>>>   
>>>>>>       
>>>>>>             
>>>>> Ok I will look at Steve's patch, but our existing code is
>>>>> Returning 1 if I can get con and it is not equil kernel
>>>>> else
>>>>> returning 0 whether or not selinuxfs was in the list. 
>>>>> Only returning -1 if it failed to be able to detect, IE /proc was not 
>>>>> mounted. Also return -1 if out of memory.
>>>>>     
>>>>>           
>>>> I prefer an explicit test like checking for selinuxfs
>>>> in /proc/filesystems or statfs'ing /selinux and checking for
>>>> SELINUX_MAGIC rather than a heuristic like the getcon check; I'd
>>>> actually favor dropping the getcon check altogether.  As I said, the
>>>> only case where you can have no-policy-loaded and SELinux enabled is if
>>>> SELINUX=permissive and there was no policy or a corrupted policy file.
>>>> (of course, the old check was based on our own syscall when we had one).
>>>>
>>>>   
>>>>         
>>> What happens if the user disables selinux in the /etc/selinux/config file.
>>>
>>> Doesn't the selinuxfs file system still exist in this case?
>>>       
>> No, not since we introduced the /selinux/disable support and
>> modified /sbin/init to use it (via security_disable() in libselinux)
>> when SELINUX=disabled.  That unregisters selinuxfs, so it goes away
>> from /proc/filesystems altogether.  This is mostly a legacy of systems
>> predating that mechanism for disabling SELinux after boot.
>>     
>
> In selinux_init_load_policy() in libselinux, called by /sbin/init, it
> does the following:
> - get the desired mode from /etc/selinux/config
> - mount proc
> - read any kernel command line overrides from /proc/cmdline
> - umount proc
> - make a final determination on how we want to startup (command line
> takes precedence over /etc/selinux/config)
> - mount selinuxfs
> - if we are disabling selinux, then call security_disable()
> => /selinux/disable => disables SELinux kernel code and unregisters
> selinuxfs from /proc/filesystems, and then umount /selinux.
> - ...
>
>   
So the following should be sufficient, if getline handles EINTR correctl?

int is_selinux_enabled(void)
{
    char *line=NULL;
    size_t len;
    FILE *fp;
    ssize_t read;
    int enabled = 0;

    fp = fopen("/proc/filesystems", "r");
    if (fp == NULL)
        return -1;

    while ((read = getline(&line, &len, fp)) != -1) {
        if (strstr(line, "selinuxfs")) {
            enabled=1;
            break;
        }
    }
    free(line);
    fclose(fp);
    return enabled;
}





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
