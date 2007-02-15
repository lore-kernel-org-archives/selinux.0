Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <45D4A6BD.2090006@tycho.nsa.gov>
References: <1171309430.10871.2.camel@localhost.localdomain>
	 <1171369673.3242.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1171387714.10871.22.camel@localhost.localdomain>
	 <1171388407.3242.87.camel@moss-spartans.epoch.ncsc.mil>
	 <1171395416.10871.37.camel@localhost.localdomain>
	 <45D35110.10608@tresys.com>  <45D4A6BD.2090006@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 15:51:58 -0500
Message-Id: <1171572718.32574.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 13:30 -0500, Eamon Walsh wrote:
> Joshua Brindle wrote:
> > What happens when we start using a userspace security server and the 
> > kernel policy doesn't have any userspace object classes? If the avc 
> > routing gets changed the policy suddenly turns to default allow, not 
> > good. We have to be careful here, chances are we'll remove user object 
> > classes from kernel headers and that would make the result acceptable 
> > but in the mean time this puts the policy in a bad state.
> 
> It would be nice if there were string-to-number or number-to-number 
> lookup functions for the class and permission values so that userspace 
> object managers didn't have to hardcode the values from the header files.

That was supposed to be done by now (c.f. dynamic discovery of object
classes).  Look up of userspace class and permission names via a
selinuxfs node or an auxiliary policy file that contained just those
mappings from the generated policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
