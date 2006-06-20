Message-ID: <44982C2C.5050405@redhat.com>
Date: Tue, 20 Jun 2006 13:11:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New patch for libselinux
References: <4497FCCF.1030805@redhat.com>	 <1150812243.17557.79.camel@moss-spartans.epoch.ncsc.mil>	 <44981564.9020106@redhat.com> <1150822180.17557.141.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1150822180.17557.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-06-20 at 11:33 -0400, Daniel J Walsh wrote:
>   
>> Patch to libselinux to fix handling of MATCHPATHCON_NOTRANS.
>>
>> Also added two new functions to handle looking at files on disk and 
>> comparing to the default file_contexts,  These functions are
>> intended to be used by rpm -V.
>>     
>
> I don't think we want to directly export
> selinux_compare_context_without_user(), or if we do, we want it
> abstracted in some manner that covers the general case.
>
>   
We are using similar functions in restorecon and I think somewhere else, 
so I thought
it would be good to move it into libselinux.  
> Also, I think selinux_verify_file_context needs to be generalized,
> because if/when rpm begins to use contexts from the rpm headers again,
> then rpm will need to pass in the context against which to compare
> rather than having selinux_verify_file_context always use matchpathcon.
>
>   
Not sure what you mean, You still have the other functions to use.   The 
idea with this
function is to compare a files on disk context with the system 
defaults.  You could also use
matchpathcon_init before calling this function to change the default 
file context file?


I also want to define a function

selinux_setdefault_filecon(file)

Which would do matchpathcon/setfilecon under the covers, and do the 
appropriate turn off translations stuff.
Since this code is propulgating into a series of programs.  (install, 
MAKEDEV, kadmin?, and Nautilus, restorecon and probably others.)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
