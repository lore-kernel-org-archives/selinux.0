Subject: Re: [RFC] [PATCH]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: dustin.kirkland@us.ibm.com
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        James Morris <jmorris@namei.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <1140192267.3083.119.camel@kirkland1.austin.ibm.com>
References: <43F49805.2000109@trustedcs.com>
	 <1140113563.12655.140.camel@moss-spartans.epoch.ncsc.mil>
	 <43F4DBE0.3060204@trustedcs.com>
	 <1140122205.12655.171.camel@moss-spartans.epoch.ncsc.mil>
	 <43F5E12E.70003@trustedcs.com>
	 <1140192267.3083.119.camel@kirkland1.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 13:26:29 -0500
Message-Id: <1140200789.29938.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-17 at 10:04 -0600, Dustin Kirkland wrote:
> On Fri, 2006-02-17 at 08:43 -0600, Darrel Goeddel wrote:
> > It would seem to me that we need the current functionality of keeping all rules
> > that are set up and revalidating them upon policy loads.  If we don't do it here,
> > it would need to be done at the audit layer - it might not be as pretty there.
> 
> 
> I don't know...  My first thoughts are that it seems like the audit
> layer should be ignorant of policy loads/reloads--that's not really it's
> business.

Disagree - it is caching policy information, and thus should register a
callback for notification of reloads so that it can re-process its audit
rules at that time, similar to the netif table.  That would presumably
address the locking concern as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
