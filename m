Subject: Re: [PATCH] Convert sepol_list_del to void return
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178800488.3504.77.camel@moss-spartans.epoch.ncsc.mil>
References: <63fcfe6bf3ffc49cf83b.1178745281@localhost.localdomain>
	 <1178800488.3504.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 11 May 2007 10:59:34 -0400
Message-Id: <1178895574.11064.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-10 at 08:34 -0400, Stephen Smalley wrote:
> On Wed, 2007-05-09 at 17:14 -0400, Karl MacMillan wrote:
> > Convert sepol_list_del to void return. There is no possibility of error after
> > converting the free functions to always return void.
> > 
> > Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> Merge at will.
> 

Merged into policyrep.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
