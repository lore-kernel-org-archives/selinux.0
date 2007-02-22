Message-ID: <45DDB102.6080309@redhat.com>
Date: Thu, 22 Feb 2007 10:04:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I think this is equivalent to what we have now and more	efficient.
References: <45DDAA80.80603@redhat.com> <1172155540.14363.372.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172155540.14363.372.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-02-22 at 09:36 -0500, Daniel J Walsh wrote:
>   
>> int is_selinux_enabled(void)
>> {
>>     security_context_t con;
>>
>>     if (getcon_raw(&con) == 0) {
>>         int enabled = 1;
>>         if (!strcmp(con, "kernel"))
>>             enabled = 0;
>>         freecon(con);
>>         return enabled;
>>     
>
> IOW, if I can read /proc/self/attr/current successfully (will fail if
> SELinux disabled or under certain unrelated conditions) and its value
> indicates a policy has been loaded, then SELinux is enabled.
>
>   
>>     } else {
>>         struct stat buf;
>>         return (stat("/proc/filesystems", &buf));
>>     
>
> That won't test for selinux at all - you have to check the contents
> of /proc/filesystems for selinuxfs or stat /selinux and check for the
> selinux magic number as per Steve's patch.
>
>   
Ok I will look at Steve's patch, but our existing code is
Returning 1 if I can get con and it is not equil kernel
else
returning 0 whether or not selinuxfs was in the list. 
Only returning -1 if it failed to be able to detect, IE /proc was not 
mounted. Also return -1 if out of memory.
>>     }
>>
>> }
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
