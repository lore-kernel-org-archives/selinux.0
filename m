Message-ID: <412E34EB.1030909@redhat.com>
Date: Thu, 26 Aug 2004 15:07:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Bill Nottingham <notting@redhat.com>, harald@redhat.com,
   SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Cleaned up udev-selinux patch
References: <20040223213614.GA12242@devserv.devel.redhat.com> <20040224233859.GA3265@kroah.com> <20040224234652.GA14775@devserv.devel.redhat.com> <403C8AE4.10403@redhat.com> <20040228005300.GA13860@kroah.com> <412DFE7B.6060409@redhat.com> <20040826155716.GA30726@kroah.com> <412E20AF.7000102@redhat.com> <20040826175139.GA12225@kroah.com>
In-Reply-To: <20040826175139.GA12225@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greg KH wrote:

>On Thu, Aug 26, 2004 at 01:41:03PM -0400, Daniel J Walsh wrote:
>  
>
>>Greg KH wrote:
>>
>>    
>>
>>>On Thu, Aug 26, 2004 at 11:15:07AM -0400, Daniel J Walsh wrote:
>>>
>>>
>>>      
>>>
>>>>This will create the security contexts on the fly.
>>>>
>>>>Please comment on what would be needed to get this acceptable?
>>>>  
>>>>
>>>>        
>>>>
>>>Same things I said on the mailing list:
>>>	- fix coding style
>>>	- no ifdefs in .c files
>>>	- make the selinux stuff all be in its own file
>>>	- make the build flag look like the other build flags
>>>	- not make the makefile changes have silly line continuations
>>>	  when not needed :)
>>>	- post the patch on the mailing list (linux-hotplug-devel) for
>>>	  others to comment on after fixing the above.
>>>
>>>thanks,
>>>
>>>greg k-h
>>>
>>>
>>>      
>>>
>>Another pass at a cleaned up patch.  This time attempting to folow Greg 
>>guidelines.
>>    
>>
>
>Looks good.  Do you really want it all in a .h file?  I don't mind
>having the selinux functions being in a .c file and building that if
>USE_SELINUX is enabled.
>
>But it's your call, as you are the one going to have to live with the
>code :)
>
>thanks,
>
>greg k-h
>  
>
I copied the way it was being done with logging.h

I already have some updates from comments from other people.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
