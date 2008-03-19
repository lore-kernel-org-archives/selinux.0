Subject: Re: unix_domain_sockets in mls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: B Topscher <bryan@jennandbryan.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <8b4cbe570803190802k4a597140p41a042dae85b0bcb@mail.gmail.com>
References: <8b4cbe570803190704u56b1181ta9502561324dd7f4@mail.gmail.com>
	 <1205937798.6466.223.camel@moss-spartans.epoch.ncsc.mil>
	 <8b4cbe570803190802k4a597140p41a042dae85b0bcb@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Mar 2008 11:23:41 -0400
Message-Id: <1205940221.6466.258.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-03-19 at 11:02 -0400, B Topscher wrote:
> Will I be allowed to use setsockcreatecon() on my
> system_u:levmA_r:levmA_t:s4-s4:c1,c100 process to set the connection
> to s4:c1 prior to connecting to the server from the client?  This
> would be the ideal way for me to do it given the information
> available. 
> 
> Ideally we want the connection to be made at s4:c1 level because it is
> the common mls level.   If there is another way to do it let me know.

That seems feasible, although a bit unfortunate that the client has to
know or somehow determine the level of the server a priori.

Looking at the actual constraint on the socket write operations, I'm
wondering whether you could alternatively add the mlsnetwriteranged
attribute to the server's type to allow it to write to the socket even
without altering the socket label.  That's mls_net_write_within_range()
in refpolicy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
