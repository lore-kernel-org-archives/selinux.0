Message-ID: <430F6474.1040802@redhat.com>
Date: Fri, 26 Aug 2005 14:50:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Problems with MCS/Targeted policy update.
References: <430C776B.4060309@redhat.com>  <430F5C8B.3060102@redhat.com> <1125080692.8692.82.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1125080692.8692.82.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2005-08-26 at 14:16 -0400, Daniel J Walsh wrote:
>  
>
>>Basically this patch checks to see if
>>mls and translation is enabled and the *getfilecon_raw returns a context 
>>without a level, it calls the untranslate function to try to get a 
>>level, with MCS this will get you a s0.  So we could put back the raw 
>>calls in rpm_execcon.
>>
>>So we could have most contexts on disk without the s0 and the getfilecon 
>>raw call will return it.
>>    
>>
>
>Umm....I really don't think we want to do this.
>
>If you want transparently insert and remove a default MLS level in your
>libsetrans, that is fine.  But I don't want this in libselinux.
>
>I think we need to change the kernel to setxattr the on-disk xattr to be
>consistent with the incore inode security label in these cases, which
>will also solve the problem for us (once that is upstreamed).
>
>  
>
Ok then I think the security_context_to_sid functions in the kernel need 
to change to do the translation.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
