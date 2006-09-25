Message-ID: <4517DA77.7000408@trustedcs.com>
Date: Mon, 25 Sep 2006 08:32:39 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Serge Hallyn <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [RFC PATCH] allow range_transitions and MLS users in modules
References: <6FE441CD9F0C0C479F2D88F959B01588443A3E@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588443A3E@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>>From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
>>
>>- Add the ability to require MLS sensitivities and categories 
>>in policy
>>  modules.
>>- Remove the restrictions on defining users in MLS-enabled modules.
>>- Handle range_trans_rules in modules.
>>
>>This all allows range_transition statements to be used in 
>>policy modules and allows definition of users in MLS policy modules.
>>
>>I haven't tested this as much as I would like, but it is 
>>working nicely for me.  I have built several policies (MLS, 
>>non-MLS, strict, targeted,
>>etc.) and have built several modules exercising the new functionality.
>>I'd appreciate any feedback you may have at this point.
>>
> 
> 
> Aside from the 2 initializers I mentioned earlier this looks good, can
> you add those initializers and resend please?

Thanks,  I'll get that out today.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
