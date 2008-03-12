Subject: Re: [PATCH] libsepol: support for permissive types
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, tmiller@tresys.com, jbrindle@tresys.com
In-Reply-To: <1205326167.23866.211.camel@moss-spartans.epoch.ncsc.mil>
References: <1205243961.5297.79.camel@localhost.localdomain>
	 <1205260096.23866.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1205260543.5297.113.camel@localhost.localdomain>
	 <1205261201.23866.186.camel@moss-spartans.epoch.ncsc.mil>
	 <1205270906.5297.141.camel@localhost.localdomain>
	 <1205326167.23866.211.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 12 Mar 2008 10:37:16 -0400
Message-Id: <1205332636.5297.172.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-03-12 at 08:49 -0400, Stephen Smalley wrote:
> On Tue, 2008-03-11 at 17:28 -0400, Eric Paris wrote:

> > ******
> > module define_alias 1.0;
> > 
> > require {
> > 	type type1_t;
> > }
> > 
> > type type_t;
> > typealias type_t alias alias_t;
> 
> Not sure what that require is for - remnant of earlier test?

I couldn't get a module to compile without a requires.  So I just threw
one in, type1_t is just one of the 2 types I had in my base module.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
