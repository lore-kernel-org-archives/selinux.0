Subject: Re: does this picture reflect the basics of the current selinux
 architecture?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4D851E45-B2C0-4392-872A-CC329013FC73@gmail.com>
References: <4D851E45-B2C0-4392-872A-CC329013FC73@gmail.com>
Content-Type: text/plain
Date: Fri, 08 May 2009 08:08:19 -0400
Message-Id: <1241784499.6452.175.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-05-08 at 13:03 +0200, Sebastian Pfaff wrote:
> hello,
> 
> i created a picture about the selinux architecture some weeks ago, atm  
> i'm not sure if everything is right within this picture. it would be  
> nice, when someone could give me some proposals on how to improve /  
> change / correct the picture. until now i found several pictures in  
> papers (for example in USENIX papers) and magazines, but most of them  
> differ slightly so i don't know which is right. Some of them are very  
> old, so i don't know if i can trust them.
> 
> I know that "my" picture doesn't show everything, the intention is to  
> only show the basics.
> 
> If you need additional please let me know. Any help is greatly  
> appreciated. tnx in advance.
> 
> LINK TO PICTURE:
> 
> http://4.bp.blogspot.com/_OR3mMHaW6Iw/SgP9K42jAVI/AAAAAAAAAAU/i-bFA7iNkOA/s1600-h/sel_1_eng.png

- Remove "user" as you suggest, as it incorrectly suggests that SELinux
operates at per-user granularity like DAC.

- Yes, SELinux runs as a security module in the address space of the
kernel.

- The policy is simply configuration data loaded into the security
server.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
