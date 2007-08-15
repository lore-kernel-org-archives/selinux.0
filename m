MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/4] libsemanage: genhomedircon replacement
Date: Wed, 15 Aug 2007 17:12:34 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588EDEBAB@exchange.columbia.tresys.com>
In-Reply-To: <1187212166.2838.73.camel@localhost.localdomain>
References: <20070815204411.705994826@tresys.com> <1187190639.2674.51.camel@localhost.localdomain> <46C31BD0.5060200@tresys.com> <1187192832.2674.74.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com> <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil> <1187205378.2838.12.camel@localhost.localdomain> <1187207793.20485.103.camel@moss-spartans.epoch.ncsc.mil> <1187209022.2838.38.camel@localhost.localdomain> <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil> <1187210504.2838.56.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588EDEBA9@exchange.columbia.tresys.com> <1187212166.2838.73.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "Todd Miller" <tmiller@tresys.com>,
        <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Wed, 2007-08-15 at 16:47 -0400, Joshua Brindle wrote:
>> Karl MacMillan wrote:
>>> On Wed, 2007-08-15 at 16:31 -0400, Stephen Smalley wrote:
>>> 
>>> So I vote for removing genhomedircon entirely unless some other
>>> objection comes up. Anyone that wants that behavior could certainly
>>> set something up fairly easily.
>>> 
>> 
>> You haven't addressed the other concerns (policy server
> 
> Until this is available upstream or it is certain that it
> will be merged I don't think we can make decisions around the
> policy server. It is simply too much of an unknown.
> 
> Your question didn't make it to this list - here it is for others:
> 
> "They are needed for policy server to allow users to make
> changes to their policy. We need something like
> 
> Type httpd_ROLE_script_ra       system_u:object_r:httpd_ROLE_types_t
> Type httpd_ROLE_script_ro       system_u:object_r:httpd_ROLE_types_t
> 
> So that users can be granted access to use those types in modules:
> 
> Allow user_t httpd_user_types_t: type { add use };
> 
> And can create new types in their type space for finer
> grained access control."
> 
> Role expansion can happen during the policy build - it
> doesn't depend on system information (especially since role
> expansion doesn't work for modules).
> 
>>   user labeling
>> of home directories, etc).
> 
> The current method simply does not scale - it can't possibly
> work on systems with users in LDAP (enumeration of all users
> is just too expensive). So genhomedircon is not an answer to this.
> 
> The options that we have are:
> 
> 1) Have restorecon set this at runtime for home directories
> (it has all of the needed informaiton - there is no reason to
> do an expansion like genhomedircon does).
> 
> 2) Abandon automatic user re-labeling for home directories by default.
> The initial label could be set and inherited on the home
> directory at creation (or done explicitly by the admin) and
> restorecon will just not reset the user part of the context
> (I believe this is the current default).
> 
>>  It needs to stay and people that don't want it don't have to use it.
>> 
> 
> a) there is no real way to not use it currently and
> b) every time there is a choice like this it has a huge
> impact on maintenance and usability.
> 
> I think we should make a choice and support one standard way
> of doing things. People are still free to customize, but the
> upstream should have one standard.
> 

Then the upstream should have it available. RH doesn't have to use it
but like I told you off list we have systems that use it and need it. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
