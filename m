MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: file(1)
Date: Fri, 28 Mar 2008 21:21:58 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801CD1E90@exchange.columbia.tresys.com>
In-Reply-To: <200803291219.12623.russell@coker.com.au>
References: <200803272349.32854.russell@coker.com.au> <1206711214.3302.442.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B0158801CD1E16@exchange.columbia.tresys.com> <200803291219.12623.russell@coker.com.au>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <russell@coker.com.au>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, "SE-Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<snip>
> > > Note btw that this format is expected to be obsoleted by the 
> > > policyrep work.
> 
> Which format?  The module format or the policy binary format?
> 

The kernel binary format isn't changing. The module format (and policy
package format) are going away in favor of source based modules. 

> In either case we still need file(1) support.  When someone 
> gives me a disk containing a Debian/Etch or Fedora Core 5 
> filesystem in 2012 which has most files in /lost+found and 
> asks me to recover data then the presence of magic entries 
> will really help.
> 

Which is fine, but it just won't be useful for future modules.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
