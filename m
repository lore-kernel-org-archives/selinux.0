From: "R N" <rnmj44@hotmail.com>
To: russell@coker.com.au, SELinux@tycho.nsa.gov
Subject: Re: SELinux and SystemImager
Date: Fri, 13 Feb 2004 17:19:07 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F378aZRhQdOgl400022bb7@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


what do you mean by xattr's, could you please elaborate.
As we understand the SI is just doing a copy (using rsync) of the files, and 
SE Linux uses inode info along with context of the files. Once we have the 
SELinux copy we want to avoid the relabel after rebooting. If there is a way 
to relabel the copy thru SI or some other system command without the 
reboot??

Thanks,
-Rajeev

>It sounds like SI doesn't support xattr's.
>
>The easy way of working around this is to create a floppy disk that boots a 
>SE
>Linux kernel and initrd that can relabel the file system.  After doing the 
>SI
>work you just boot from the custom floppy to label it correctly, then it
>should be fully functional.

_________________________________________________________________
Find great local high-speed Internet access value at the MSN High-Speed 
Marketplace. http://click.atdmt.com/AVE/go/onm00200360ave/direct/01/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
