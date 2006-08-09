Message-ID: <44D9F899.6050202@trustedcs.com>
Date: Wed, 09 Aug 2006 10:00:41 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [PATCH 2/2] userland support for new range_transition statements
References: <6FE441CD9F0C0C479F2D88F959B0158832AE66@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832AE66@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>>From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
>>
>>Joshua Brindle wrote:
>>

<snip>

>>Wouldn't this mean that the base module would have to define 
>>every possible combination of sensitivities and categories?  
>>That would make things a bit unmanageable.
> 
> 
> No, the required range would be interpreted the same way that any other
> range is. Every complete range used within a module (or optional block)
> would have to be required though, but I'm not sure how big of a deal
> that is, how many different combinations are typically used? Now that
> users aren't even put in the policy for different mls ranges I assume it
> is very few.

There are environments that use thousands of combinations.

> 
>>I don't look at categories and sensitivities s local 
>>configuration at all - they are a defined part of the policy. 
>> A human-readable translation for what the level means is a 
>>local configuration.  It is really the same story for types - 
>>I can use security_t in my module, but I am making 
>>assumptions about what security_t means in the base policy.  
>>When I put s4:c0,c5,c100.c150 into a module, I am making the 
>>same assumptions.
>>
> 
> 
> Not sure about this, SystemHigh is not the same on every system, how
> does a module reconcile that? You are right about the typespace which is
> something we want to address, refpolicy interfaces introduced
> encapsulation where modules don't know about other modules types,
> unfortunately since its all compile time now the encapsulation isn't
> enforced but interfaces in the language would be able to do that.

True, SystemHigh may not be the same on every system.  The policy would have
to have knowledge of the label encoding scheme of the target.  Typically,
an environment will have a approved scheme that is used by all systems.

(actually SystemHigh is probably the same because it should be the highest
sensitivity and all cats, but other labels such as secret, unclass, etc. may
have different encodings for different sites)

>>As for putting the translations into the policy - that 
>>doesn't work out very well.  I believe that we experimented 
>>with that a long time ago and found it to be a complete 
>>nightmare.  IMO, the correct place for translations would be 
>>at the level of a tool that would help create policy modules.
>>
> 
> 
> I understand that, I'm just wondering how one could ever distribute a
> module with any mls range to different sites. If everyone is using
> refpolicy the types are known to be the same, that isn't the case with
> sensitivities and categories since they truly are a local configuration
> via the translations.

Yep.  In practice, that "local" configuration is generally not local to a
specific system,  rather it is common to the entire enterprise.  It is a
customer or site configuration, not necessarily a machine configuration.
Policy for that environment must be aware of the labeling scheme.

I hope I got that right...

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
