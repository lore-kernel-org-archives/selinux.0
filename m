Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n76Ki0Ft019727
	for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2009 16:44:00 -0400
Received: from AZ25EGS04.gdc4s.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n76KhWpi003501
	for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2009 20:43:32 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: FW: Is a monolithic monothlitic policy more secure than modular
Date: Thu, 6 Aug 2009 13:43:58 -0700
Message-ID: <FA8938DBA959E546BF6527F085F22FF804F0329E@AZ25EXM04.gddsi.com>
From: "West, Gary-P55389" <Gary.West@gdc4s.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had sent this to the wrong list. Thank you Mr. Smalley for your reply.


> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Sent: Thursday, August 06, 2009 1:39 PM
> To: West, Gary-P55389
> Subject: Re: Is a monolithic monothlitic policy more secure 
> than modular
> 
> On Thu, 2009-08-06 at 10:26 -0700, West, Gary-P55389 wrote:
> > Several engineers on our team think that a monolithic 
> policy is more 
> > secure than a modular policy.
> > 
> > I think that you have a domain that can load a module into 
> a modular 
> > policy, it could also replace the monolithic policy.
> > 
> > Any thoughts?
> 
> Did you mean to send your question to owner-selinux rather 
> than to the list?
> 
> Modular vs monolithic policy is purely a userspace difference 
> - in the end, it all gets turned into a monolithic policy 
> that is then loaded into the kernel via /selinux/load.  In 
> both cases, it comes down to what processes can write to the 
> files that ultimately form the policy and what processes can 
> load policy into the kernel.  Ideally you'd define a 
> processing pipeline (assured pipeline in TE parlance) over 
> the entire sequence of steps from policy creation to load.  
> But it isn't fundamentally different for modular vs 
> monolithic - in the latter case, you'd have to consider the 
> process by which source .te files are created, combined, and 
> then compiled into the monolithic policy just as the binary 
> modules are created, combined and expanded into a monolithic policy.
> 
> --
> Stephen Smalley
> National Security Agency
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
