Message-ID: <46F15876.3050004@tycho.nsa.gov>
Date: Wed, 19 Sep 2007 13:12:22 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Change default error handling in libselinux matchpathcon	to	use
 syslog instead of stderr.
References: <46EFF028.4040500@redhat.com> <46F0065B.1060101@manicmethod.com>	 <1190136184.14037.54.camel@moss-spartans.epoch.ncsc.mil>	 <46F00E55.9030100@manicmethod.com> <1190137543.14037.77.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190137543.14037.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-09-18 at 13:43 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:

[...]

>>> You already can override the callback (set_matchpathcon_printf), but the
>>> claim in the bug report is that isn't usable from a library function
>>> that calls matchpathcon because it doesn't know whether it has already
>>> been set by the application.
>>>   
>> Hrm... so the alternative is to send it to syslog? I don't buy it. Can 
>> we just add an interface to see if the default callbacks have been 
>> overridden?
> 
> Yep.  And it should be based on the newer interfaces.  There is already
> a selinux_set_callback() and adding a selinux_get_callback() should be
> trivial.  setfiles is already rewritten to use the new interfaces in
> trunk, and we should be moving everything off of matchpathcon and onto
> selabel_lookup.

We could add a get function, and/or modify selinux_set_callback(), 
currently void, to return the previous callback in the same way as 
signal(2).

> 
> For RHEL 5, I suppose there might be a matchpathcon-specific interface
> for getting the callback.
> 

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
