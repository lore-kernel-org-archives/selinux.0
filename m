Message-ID: <4430100E.8050200@tresys.com>
Date: Sun, 02 Apr 2006 13:55:26 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: Ivan Gyurdiev <ivg2@cornell.edu>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: The sort algorithm is broken by the second rule,  We need a way
 to pin these rules to the top.
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com>	 <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>	 <442D5A3F.9090409@cornell.edu>	 <1143831151.17469.13.camel@moss-spartans.epoch.ncsc.mil>	 <442D7CFC.8060704@cornell.edu>	 <1143832535.17469.29.camel@moss-spartans.epoch.ncsc.mil>	 <442D809D.8050105@tresys.com> <1143833570.17469.42.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1143833570.17469.42.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-03-31 at 14:18 -0500, Joshua Brindle wrote:
>> I think libsemanage should just put the .local file out for libselinux 
>> to read. There is no guarantee that none of the entries on .local won't 
>> be preceded by something in the normal file context if it is merged in 
>> libsemanage.
> 
> Last matching entry takes precedence, so as long as they are merged to
> the end of file_contexts (as they presently are), the local entries will
> always take precedence over any earlier matching entry.
> 
If a user adds a file context entry with a regex operator to .local it 
will get overridden by a specific match in the policy, I think this 
would be unexpected to the end user.

>>  This is the same thing we do for file_contexts.homedirs so 
>> why not do it with .local? (Also, if we merge .local into the normal fc 
>> file then the .local can't override .homedirs)
> 
> .homedirs is a bit different in that it is generated via genhomedircon
> from a policy-provided template.  The last point is true - that does
> yield a difference between ordering of entries added via semanage
> fcontext -a vs. manually put into file_contexts.local.
> 
> However, changing libsemanage to install file_contexts.local instead of
> merging it now is a behavioral change that could clobber an existing
> file_contexts.local, so we'd have to be very careful about the "upgrade"
> situation and we'd likely want to push that to FC5 ASAP so that users
> there don't get used to being able to manually tinker with
> file_contexts.local separately.
> 

Right, it's too bad we didn't do this before the release.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
