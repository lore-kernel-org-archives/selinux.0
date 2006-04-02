MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: The sort algorithm is broken by the second rule,  We need a way to pin these rules to the top.
Date: Sun, 2 Apr 2006 16:31:52 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880372D8@exchange.columbia.tresys.com>
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com>	 <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>	 <442D5A3F.9090409@cornell.edu>	 <1143831151.17469.13.camel@moss-spartans.epoch.ncsc.mil>	 <442D7CFC.8060704@cornell.edu>	 <1143832535.17469.29.camel@moss-spartans.epoch.ncsc.mil>	 <442D809D.8050105@tresys.com> <1143833570.17469.42.camel@moss-spartans.epoch.ncsc.mil> <4430100E.8050200@tresys.com> <44303066.2090904@cornell.edu>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Ivan Gyurdiev" <ivg2@cornell.edu>
Cc: <sds@tycho.nsa.gov>, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Fri, 2006-03-31 at 14:18 -0500, Joshua Brindle wrote:
>>> I think libsemanage should just put the .local file out for 
>>> libselinux to read. There is no guarantee that none of the entries 
>>> on .local won't be preceded by something in the normal file context 
>>> if it is merged in libsemanage.
>>
>> Last matching entry takes precedence, so as long as they are merged to
>> the end of file_contexts (as they presently are), the local entries will
>> always take precedence over any earlier matching entry.
>>
> If a user adds a file context entry with a regex operator to .local it 
> will get overridden by a specific match in the policy, I think this 
> would be unexpected to the end user.
So, why does sorting occur at build time, and then additional sorting of 
specific entries occurs at "runtime"?

Sorting at build time is to fix the unordering that occurs when you break file contexts up into lots of modules. The runtime sorting has always been there and only puts specific entries toward the bottom so that they are matched first. We can't really get rid of the runtime sorting because of legacy and the build time sorting is necessary for modular policy to work.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
