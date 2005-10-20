Subject: Re: [ SEMANAGE ] More work on policy_components.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1129828287.2375.435.camel@moss-spartans.epoch.ncsc.mil>
References: <4356F1B3.3060000@cornell.edu>
	 <1129827334.2375.429.camel@moss-spartans.epoch.ncsc.mil>
	 <4357D211.3090205@cornell.edu>
	 <1129828287.2375.435.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 13:16:11 -0400
Message-Id: <1129828571.2375.436.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-20 at 13:11 -0400, Stephen Smalley wrote:
> On Thu, 2005-10-20 at 13:21 -0400, Ivan Gyurdiev wrote:
> > The problem is from earlier patches - you can comment out the init() and 
> > release() code in direct_api.c - should eliminate any bugs. I didn't 
> > think something as simple would be broken. I'll fix the problem a bit 
> > later today...
> 
> I think that this may help...

Yes, that eliminates the memory errors on semodule -b.  In libsemanage
1.3.29.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
