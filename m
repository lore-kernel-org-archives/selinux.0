Message-ID: <4346FB32.6020805@cornell.edu>
Date: Fri, 07 Oct 2005 18:48:18 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>	 <4346CE4C.1030201@tresys.com>	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil> <1128719862.1450.119.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128719862.1450.119.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> (and yes, the interfaces can still change;
> this is just a snapshot).
>   
I think this is important, in particular with respect to my functions - 
I may still change those. I haven't decided if the key structure should 
play a role in sepol. Some of the user functions may not be needed.
> I didn't do anything about handles yet.  Note that the interfaces vary
> quite a bit in what they take, with some taking sepol_policydb's, others
> taking sepol_policy_file's, and others taking sepol_module_package's,
> and some taking a combination.  Plus Ivan's interfaces, some of which
> take sepol_policydb's but others just taking his new record structures.
> So it seems like a handle would have to be separated if it is going to
> be universal to all of the interfaces.
>   
Hmm, that's true... we should separate the handle.
Are there any other uses for a handle, besides debugging settings?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
