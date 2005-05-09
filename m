Message-ID: <427FA923.9010906@redhat.com>
Date: Mon, 09 May 2005 14:17:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: russell@coker.com.au, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [Fwd: Latest Diff]
References: <427A757F.9040009@redhat.com>	 <1115344683.15149.11.camel@localhost.localdomain>	 <1115393991.17301.18.camel@localhost.localdomain>	 <200505072351.04728.russell@coker.com.au>	 <1115485468.21610.8.camel@localhost.localdomain>	 <1115495425.20062.2.camel@localhost.localdomain>	 <427F76BE.60506@redhat.com> <1115662376.10218.16.camel@localhost.localdomain>
In-Reply-To: <1115662376.10218.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>I am not crazy about this patch.  Since I don't think we need to run a 
>>priveledged orbit. 
>>    
>>
>
>orbit is not privileged - there will be no orbit domain - 
>it's just a file type with some macros to mark the appropriate sockets,
>and allow connections between them.
>
>The benefit of this is that:
>
>(1) Applications no longer access ROLE_tmp_t, 
>they access ROLE_orbit_tmp_t instead, which is a more
>specific type for this operation, separate from the type
>that would be used for other things.
>
>(2) Once things are properly confined they will not need
>to access ROLE_orbit_tmp_t either, which is really the point of 
>this patch - proper labeling of orbit sockets for each 
>application. Already gift is disallowed access to anything but 
>gconf orbit sockets. This doesn't work for mozilla yet, because 
>it talks to gnome-vfs-daemon, and other things, but eventually 
>all of them should be confined. 
>
>(3) This removes generic types, and adds more specific ones.
>I see this as a step forward.
>
>See the patches I sent for the implementation.
>
>  
>
>>If we have the init scripts create a /tmp/orbit directory and the login 
>>creates orbit-$USER
>>under there we can get all the transitions correct.  Can't we?
>>    
>>
>
>So, do you oppose the whole patch, or just the part the makes
>orbit depend on libselinux?
>
>I'm not sure about a startup script - that's a possible solution,
>but Bill Nottingham didn't like my /tmp skeleton idea, and after
>a while I thought it would be better to do this in the application
>as well.
>
>With a startup script, we have to create the folder for all users,
>regardless of whether they need it. Also, orbit
>creates /tmp/orbit-$USER-(random hex number) for some reason,
>and I haven't figured out why it does that yet. Also, tmpwatch
>might erase that folder due to inactivity (and maybe it should
>be able to). If that happens, we don't want to have to reboot
>to recreate it. 
>
>  
>
Doesn't you patch mean that every app that links with orbit needs to 
able to read context files
and able to setfscreatecon?

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
