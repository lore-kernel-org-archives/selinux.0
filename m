Subject: Re: [ SEMANAGE ] [ SEPOL ] Backend iterate function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <433DD618.1070508@cornell.edu>
References: <433DA069.3090208@cornell.edu>
	 <1128112109.12459.216.camel@moss-spartans.epoch.ncsc.mil>
	 <433DA664.6040600@cornell.edu>  <433DD618.1070508@cornell.edu>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 10:53:50 -0400
Message-Id: <1128437630.26285.398.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 20:19 -0400, Ivan Gyurdiev wrote:
> The first patch here replaces the user list() function which I just 
> wrote with an iterate() one. This exercise wasn't useless - most of the 
> code is exactly the same - we just don't put the users in an array, and 
> we call a handler. List is removed, because it can be implemented on top 
> of iterate. In fact, most of the other functions in the sepol 
> users/interfaces/ports API should be removed once semanage is properly 
> functioning. I've also added iterate() on interfaces, ports, and 
> booleans. Tried this, and it seems to work fine - print handler prints 
> out all the data.
> 
> The second patch corrects the corresponding table in semanage (the 
> record_direct_table_t), and sets those functions in the tables for users 
> and ports. It also adds an iterate() function to the backend table, and 
> stubs for that. Finally, it adds cacheable parameter to each database, 
> that will indicate whether the database should be cached. If it says 0, 
> then .... it will fallback to implementation via iterate() in the 
> backend (without making a list of records)) (I haven't set this up yet). 
> Currently all databases are cacheable.

Merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
