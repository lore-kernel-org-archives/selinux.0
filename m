Message-ID: <3F89DF39.9070005@cisco.com>
Date: Sun, 12 Oct 2003 16:09:45 -0700
From: Michael Reilly <michaelr@cisco.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux@tycho.nsa.gov
Subject: Re: How to get Xfree86 to run - old API
References: <sf880644.030@atlas.snu.edu> <3F88FAEB.8000707@cisco.com> <200310121738.53945.russell@coker.com.au>
In-Reply-To: <200310121738.53945.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I first tried to run it as michaelr:staff_r:tstaff_t with the same results.

I have startx.te in my policy (although the file startx.te itself has 
nothing but comments in it).  I do see a couple of ifdef(`startx.te', ` in 
x_client_macros.te

The policy statements enabled by the ifdef are iincluded n policy.conf.

Why is nothing logged?

michael
Russell Coker wrote:
> On Sun, 12 Oct 2003 16:55, Michael Reilly wrote:
> 
>>When trying to run the Xfree86 server using startx as
>>michaelr:sysadm_r:sysadm_t
> 
> 
> This is probably not something that is desirable.  startx often runs lots of 
> things that shouldn't have full access to the system.
> 
> 
>>the server does not startup.  This message is displayed
>>
>>Fatal server error:
>>xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)
> 
> 
> Do you have startx.te compiled into your policy?
> 

-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
     Cisco Systems, Santa Cruz, CA


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
