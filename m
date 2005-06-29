Subject: Re: Execmem boolean
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: ivg2@cornell.edu, selinux@tycho.nsa.gov
In-Reply-To: <42C2F865.2040102@redhat.com>
References: <1119822163.4357.9.camel@localhost.localdomain>
	 <1119883756.32316.74.camel@moss-spartans.epoch.ncsc.mil>
	 <42C2DB70.2070204@redhat.com>
	 <1120070997.3553.172.camel@moss-spartans.epoch.ncsc.mil>
	 <1120071263.20484.45.camel@celtics.boston.redhat.com>
	 <42C2F865.2040102@redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 15:58:20 -0400
Message-Id: <1120075100.3553.226.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 15:37 -0400, Daniel J Walsh wrote:
> Ok.
> Should be a boolean allow_X_execmem.  Most people don't need execmem for 
> X.  (Only nvidia binary drivers)

I've seen it with other (open source) drivers too.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
