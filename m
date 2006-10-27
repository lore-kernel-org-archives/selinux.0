Subject: RE: User object manager context location
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: jwcart2@epoch.ncsc.mil, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885146B9@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885146B9@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 18:48:22 -0400
Message-Id: <1161989302.17018.150.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 18:37 -0400, Joshua Brindle wrote:
 
> And that default context comes from here? I assume it should be the
> object manager that determines the default context, how else would it
> work? In that case storing the default context separate from the
> "actual" contexts is strange anyway. "actual" here is a loose concept
> since it could be authoritative (eg., policy server uses its context
> file only) or not authoritative (eg., file contexts where the initial
> contexts are stored with the policy but the real contexts are stored
> with the object).
> 
> Not that it matters but I still haven't heard really compelling reasons
> either way..

I concede the point - the lookup would have to return an error if there
were no installed mapping at all for a particular object class.  

More likely what would happen is matchpathcon_init() or some other
initialization routine returns the error, and the application either
disables the user space object manager or exits.  This is a corner case.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
