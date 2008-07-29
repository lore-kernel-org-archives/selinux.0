Message-ID: <488FA642.1030507@tycho.nsa.gov>
Date: Tue, 29 Jul 2008 19:22:42 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Should /dev/mem be SystemHigh?
References: <82459273-DA3E-4F80-B1D8-E3A168218B06@nall.com>
In-Reply-To: <82459273-DA3E-4F80-B1D8-E3A168218B06@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> ls -Z /dev/mem
> crw-r-----  root kmem system_u:object_r:memory_device_t:SystemHigh / 
> dev/mem
>
> In our MLS X policy, we are giving the X server  
> mls_file_read_all_levels and mls_file_write_all_levels to be able to  
> access the SystemHigh /dev/mem. I would prefer not to give X general  
> file MLS override if possible.
>   

The X server is trusted to manage MLS objects internally, so a general 
file MLS override doesn't seem to be inappropriate in this case.  But 
see below.

> Is there a way to assign MLS read up/write up on just one type (i.e.  
> allow X to read up only on memory_device_t)?
>   

You could add an exception to the MLS constraints for the "file read" 
ops.  This exception would be an "or" clause taking the form (t1 == 
xserver_type) and (t2 == memory_device_t).  Steve doesn't think these 
kinds of specific exemption are very maintainable, and I would tend to 
agree.

Another option could be to split up the "file read" constraint, taking 
the chr_file (character device file type) out and adding a separate 
override interface just for device files.

> Is there a potential refactoring of the X server that eliminates the  
> need for /dev/mem access? Dan hinted at this at the developer summit  
> to allow X to run as the user.
>   

My understanding of this is that the ability to run the X server as an 
unprivileged UID is a long-term goal but not something that's ready just 
yet.

> Would it be better to mls_file_write_within_range(memory_device_t)  
> (i.e. make it a trusted object) and pull the MLS override out of the X  
> policy?
>   

I think this may work.  You would be relying on type enforcement alone 
to protect /dev/mem in this case, if I understand correctly.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
