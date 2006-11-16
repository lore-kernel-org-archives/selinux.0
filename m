Message-ID: <455C713D.9050104@tresys.com>
Date: Thu, 16 Nov 2006 09:10:05 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: ewalsh@tycho.nsa.gov
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 0/5] libselinux: labeling API for userspace object managers
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
In-Reply-To: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> This is a companion interface to the userspace AVC, for use by userspace
> object managers to look up contexts for use in labeling their objects.
> It also provides an alternate interface to the file contexts
> configuration.
>
> The need for this interface is discussed in this thread:
> http://marc.theaimsgroup.com/?l=selinux&m=116195833329572&w=2
>
> The interface provides support for pluggable backends, multithreading,
> and user-provided callbacks for logging, memory allocation, and context
> validation.  It is designed to allow policy separation by package (the
> "prefix" string).  Lookups are done by object class and a string "key".
>
>   
I didn't think this was a solved problem. I still think labeling is part 
of the object manager, not part of the policy. What are the advantages 
of doing it this way over letting the object managers manage their own 
labels?

about this implementation though, how are you planning to get contexts 
to the policy directory? As part of a package? any libsemanage 
interface? Will it be part of this patch set?

Did you need a special backend for file_contexts because it has 
overlapping object class specifications? How do you 'register' an object 
class or set of object classes to a particular backend? I know with X 
you are going to have 1 file with many object classes, will it need a 
special backend? If every single object manager needs a special backend 
what are we buying with this interface?

I assume this is for RFC and not for merging until the rest of the 
patches are out, right? If you could make the patches apply from the top 
of the repository with -p0 or -p1 (don't have a preference which) that 
would be really helpful.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
