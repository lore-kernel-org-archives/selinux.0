Message-ID: <45D4A6BD.2090006@tycho.nsa.gov>
Date: Thu, 15 Feb 2007 13:30:21 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
References: <1171309430.10871.2.camel@localhost.localdomain>	 <1171369673.3242.16.camel@moss-spartans.epoch.ncsc.mil>	 <1171387714.10871.22.camel@localhost.localdomain>	 <1171388407.3242.87.camel@moss-spartans.epoch.ncsc.mil> <1171395416.10871.37.camel@localhost.localdomain> <45D35110.10608@tresys.com>
In-Reply-To: <45D35110.10608@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> What happens when we start using a userspace security server and the 
> kernel policy doesn't have any userspace object classes? If the avc 
> routing gets changed the policy suddenly turns to default allow, not 
> good. We have to be careful here, chances are we'll remove user object 
> classes from kernel headers and that would make the result acceptable 
> but in the mean time this puts the policy in a bad state.

It would be nice if there were string-to-number or number-to-number 
lookup functions for the class and permission values so that userspace 
object managers didn't have to hardcode the values from the header files.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
