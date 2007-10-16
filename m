Subject: Re: newrole authentication
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <47143EDB.7040906@manicmethod.com>
References: <FB39F4E77226B448BC1388D3BE4E00CD0236CA79@blums0008.bluelnk.net>
	 <47143EDB.7040906@manicmethod.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 07:59:26 -0400
Message-Id: <1192535966.8702.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-16 at 00:32 -0400, Joshua Brindle wrote:
> Clarkson, Mike R (US SSA) wrote:
> > Will someone point me to information or send me an example on how to set
> > up newrole so that is does not ask for a password, so that it can by
> > used like this within software "newrole -l s1 -- -c <cmd>"?
> >   
> newrole is designed to be a human interface and therefore to ask for a 
> password, perhaps you are looking for runcon?

No, we warned him away from runcon because it requires the caller to be
fully privileged (just runs in the domain of the caller) and because it
doesn't deal with polyinstantiation (pam_namespace) or other kinds of
sanitization (e.g. fd reset) across the level transition.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
