Message-ID: <46BB6F5F.3010202@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: Joe Nall <joe@nall.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul.moore@hp.com>, SE Linux <selinux@tycho.nsa.gov>,
        kaigai@ak.jp.nec.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 15:47:43 -0400 
MIME-Version: 1.0
in-reply-to: <CC6496B2-938D-4432-B43E-3A7D887BE938@nall.com>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> On Aug 9, 2007, at 11:42 AM, Darrel Goeddel wrote:
> 
>>  (why couldn't this have all waited a bit...)
> 
> Paul is addressing a real need. Like many things that really need  
> doing and take time, multiple people are simultaneously working on it.
> 
> I installed the netlabel patches and have tested them with good  
> results in MLS/permissive at a few levels (s0, s2:c0.c253,  
> s2:c0.c253). More testing to follow.
> 
> netlabelctl unlbl add interface:eth0 address:10.211.55.8/32  
> label:user_u:object_r:user_t:s2:c0.c253
> 
> /netlabelctl unlbl list
> accept:on
> interface:eth0,address: 
> 192.168.20.253/32,label:"user_u:object_r:user_t:s0"
> interface:eth0,address: 
> 10.211.55.8/32,label:"user_u:object_r:user_t:s2:c0.c253"
> 
> getpeercon() returned 'user_u:object_r:user_t:C O N F I D E N T I A L'
> 
> for a connection from 10.211.55.8.
> 
> This is a big improvement in linux labeled networking functionality.

As described in an earlier email, from my not-yet-full grasp on the patch,
this is a vulnerability waiting to happen in the event of using netlabel
fallback contexts alongside labeled ipsec.  That is not an improvement.
If there were consistency checks between the various forms of external
labels, this would not be an issue and the functionality would indeed
be an improvement.  Again, I do not have a test case, but Paul's response
to my query about getpeercon returning a netlabel modified version of
the xfrm label seemed to validate my concern.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
