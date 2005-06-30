Subject: Re: wish-list item for selinux policy analyss
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1120115156.26946.50.camel@localhost.localdomain>
References: <20050629021349.GA10219@lkcl.net>
	 <1120058832.17121.38.camel@celtics.boston.redhat.com>
	 <20050630003700.GB8415@lkcl.net>
	 <1120115156.26946.50.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 08:16:31 -0400
Message-Id: <1120133791.11798.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-30 at 03:05 -0400, Ivan Gyurdiev wrote:
> I don't understand why you need an internal kernel 
> change to do what you like, however - what's wrong with working 
> on top of the audit log? Just comment out all the rules you're
> interested in, and look for denials?

Or just add auditallow rules and let it audit all grantings for a while,
then reduce your rule set accordingly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
