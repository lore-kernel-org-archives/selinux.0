Subject: Re: Security-enhanced BSD?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F56FA55F171@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F56FA55F171@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Feb 2011 16:06:38 -0500
Message-ID: <1296767198.10507.75.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-02-03 at 15:52 -0500, Alan Rouse wrote:
> Is there an active project analogous to SELinux for BSD?
> 
> I've seen trustedbsd.org but references there to SEBSD and related
> matter seem very dated (three to four years old).

I don't believe SEBSD is active anymore, but the MAC framework was
integrated into mainline FreeBSD along with several sample security
modules.

http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/mac.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
