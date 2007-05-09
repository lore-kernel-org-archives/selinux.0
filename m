Subject: Re: policyrep questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1178720005.2379.37.camel@localhost.localdomain>
References: <1178663380.2379.11.camel@localhost.localdomain>
	 <1178720005.2379.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 May 2007 11:30:01 -0400
Message-Id: <1178724601.16433.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-09 at 10:13 -0400, Karl MacMillan wrote:
> On Tue, 2007-05-08 at 18:29 -0400, Karl MacMillan wrote:
> > 
> > 3) The existing objects copy the passed in strings where I was hoping to
> > avoid the copy. Any opinions either way? I'm currently leaning towards
> > copying because that kind of change will create hard to track down bugs
> > for no good reason.
> > 
> 
> To make things more confusing - some of the existing code copies strings
> while others do not. For example sepol_bool_set_name copies the string
> while sepol_bool_key_create does not. I assume that the thought was that
> the keys were temporary and likely to be populated from other sources
> (existing bools, user input, etc.).
> 
> However - I think that this inconsistency is just confusing. I'm going
> to change all of the functions to copy the strings. Changing in this
> direction means the worst case is that a few strings will be leaked.

Yes, I think that the failure to copy the keys was also a complaint of
the setools folks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
