Message-ID: <4266511F.9040300@hp.com>
Date: Wed, 20 Apr 2005 08:54:55 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: selinux-policy-mls is now available for your testing pleasure.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 19 Apr 2005, Paul Moore wrote:
> 
> 
>>  5 Enabled the MLS policy via the Fedora GUI tool and ensured that the
>>    relabel option was selected
>>  6 Rebooted with the new MLS policy only to have the machine lock,
>>    it wasn't able to execute something related to init (I should have
>>    taken better notes here - sorry)
> 
> 
> You still need to perform the manual mointpoint relabeling per the MLS 
> readme.
> 

Yup, figured that one out the hard way ... ;) ... just figured I would
mention it here since Dan's original post didn't make any reference to
having to do any manual relabel operations.

>>10 Rebooted with 'single' and noticed lots of permission denied
>>    messages pertaining to '/dev/.udevdb/*' files
>  
> Odd, I haven't seen that.

Taking a bit of a closer look, the files with a permission denied error
seem to be missing a SELinux context as well as any permission flags as
well as an owner and group (ls -Z fills the fields in with a '?').

I'll try fixing them manually (or maybe just deleting them since it
looks like udev recreates them on boot anyway) and see what happens.

> Did you update to all of the new SELinux packages in Dan's FTP directory?

Not originally no, but looking at them this morning all the versions I
have installed are the same versions as Dan's or newer.  I also noticed
that Dan setup that directory as a YUM repository so I added it to my
list and did a yum update - no new/updated packages.

>>12 Rebooted normally, i.e. 'rhgb quiet 5', and X failed to start
> 
> 
> Haven't tried X yet, not sure it's supposed to work.
> 
> 
> - James

-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
