Subject: Re: Question about integration of IPsec with SELinux?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Valdis.Kletnieks@vt.edu, Park Lee <parklee_sel@yahoo.com>,
   Casey Schaufler <casey@schaufler-ca.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050612152038.GC31033@lkcl.net>
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com>
	 <20050612021611.94597.qmail@web51501.mail.yahoo.com>
	 <20050612114421.GA31033@lkcl.net>
	 <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu>
	 <20050612152038.GC31033@lkcl.net>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 08:49:53 -0400
Message-Id: <1118666993.24565.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-06-12 at 16:20 +0100, Luke Kenneth Casson Leighton wrote:
>  the underlying SIDs of selinux are 32-bit.
<snip>
>  ... when you only have 32-bit SIDs, as you do in selinux,
>  how do you merge two departments or two corporations together,
>  _after_ their MLS security has been independently developed?

SIDs are node-local and non-persistent (and now kernel-private)
identifiers.  Complete non-issue.

For a CIPSO-style implementation like the Selopt implementation by James
Morris for the old SELinux, you can store the SID in the option and then
perform translation on the receiving host based on a network SID cache
that maps (source address, SID) pairs to local SIDs, using a userspace
security context mapping daemon to get the actual security context if
the network SID isn't already cached.

For IPSEC, there is no explicit label in the packet, just the SPI that
indicates the IPSEC security association, and that contains the security
context/SID information that was exchanged when the SA was set up.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
