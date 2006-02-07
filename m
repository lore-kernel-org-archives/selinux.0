Message-ID: <43E85213.9020605@acronis.com>
Date: Tue, 07 Feb 2006 10:53:55 +0300
From: Vladimir Simonov <Vladimir.Simonov@acronis.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: initrc_t has no execmod in targeted policy
References: <43E6FBD2.5040207@acronis.com>	 <1139235066.31135.49.camel@moss-spartans.epoch.ncsc.mil>	 <43E7A4F1.4010005@acronis.com> <1139257129.31135.158.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1139257129.31135.158.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Ok. Thank you a lot.
I'll investigate deeper which code triggers
relocation.

Best regards
Vladimir Simonov

Stephen Smalley wrote:
> On Mon, 2006-02-06 at 22:35 +0300, Vladimir Simonov wrote:
> 
>>Really dlopen-ed shared libs are quite typical -
>>created with --shared, -fpic, etc. They (and daemon itself)
>>do not use direct mmap/mprotect syscalls (just libc calls).
>>Daemon is called from simple bash init script located in
>>/etc/init.d. And I don't put bash script/demon/libs
>>into initrc_t domain directly. I suspect they are in initrc_t
>>by selinux magic.
> 
> 
> dlopen doesn't normally require text relocations - that reflects a
> defect in how the DSO was built usually.  See the URLs I referenced for
> more info.
> 
> Programs stay in the caller's domain unless a domain transition is
> defined.  So your daemon stays in initrc_t unless you put it into its
> own domain.
> 
> 
>>So some question remains:
>>Does selinux (on FC4) permit dlopen call from initrc_t domain?
>>If not, then why?
> 
> 
> See above.  The question is what DSO has text relocations, and why.
> 
> 
>>I'm afraid even if I put all above staff into separate domain
>>(but start daemon from init scripts) the daemon will be moved
>>to initrc_t domain by selinux. Am I correct?
> 
> 
> No, if you define a domain for the daemon and label its executable with
> the corresponding entrypoint type, then executing it (directly or via
> the init script) will transition into the daemon's domain when the
> executable is run.  
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
