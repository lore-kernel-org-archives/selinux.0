Subject: Re: Added is_context_configurable function
From: Colin Walters <walters@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41E68BF4.1050400@redhat.com>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
	 <1105481440.24748.22.camel@nexus.verbum.private>
	 <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1105544883.10150.17.camel@nexus.verbum.private>
	 <1105567743.23136.59.camel@moss-spartans.epoch.ncsc.mil>
	 <1105588352.4649.37.camel@nexus.verbum.private>
	 <41E68BF4.1050400@redhat.com>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 10:53:40 -0500
Message-Id: <1105631621.4595.4.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-13 at 09:55 -0500, Daniel J Walsh wrote:

> You loose the ability to do something like fixfiles.cron.  I removed it 
> because it was bringing
> back too many false positives, and some people complained that they do 
> not trust that the file
> contexts aren't being modified.

Okay; are you saying you want to bring it back?  I don't see anything
inherently wrong with simply warning on contexts that differ from the
expected, particularly if we limit it to well-known critical directories
such as /etc.  What does seem wrong is relabeling all known files any
time we encounter a labeling issue. 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
