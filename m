Message-ID: <45DDB71D.9060507@redhat.com>
Date: Thu, 22 Feb 2007 10:30:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I think this is equivalent to what we have now and more efficient.
References: <45DDAA80.80603@redhat.com> <200702221015.21700.sgrubb@redhat.com>
In-Reply-To: <200702221015.21700.sgrubb@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> On Thursday 22 February 2007 09:36:48 Daniel J Walsh wrote:
>   
>>     } else {
>>         struct stat buf;
>>         return (stat("/proc/filesystems", &buf));
>>     }
>>     
>
> This doesn't tell you if a selinuxfs is available.
>
> -Steve
>   
That is the point.  The original code does not care whether selinuxfs is 
in /proc/filesystem or not it returns 0 if it could read it and the con 
was not "kernel". 

If I can read /proc/filesystem, either selinuxfs exists or it does not.  
Either way selinux is disabled.

If I can't tell, Ie I can't read /proc/filesystem return -1.

So the check becomes either selinux is enabled, or if I had a failure 
return -1;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
