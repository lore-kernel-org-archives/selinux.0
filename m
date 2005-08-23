Subject: Re: libselinux category patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>
References: <430A33E5.1030100@redhat.com>
	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>
	 <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 14:10:56 -0400
Message-Id: <1124820656.7874.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-23 at 14:03 -0400, Stephen Smalley wrote:
> I've committed the libselinux translation support (including my fix
> patch).  This is only the libselinux support; there is no libsetrans in
> our tree presently (and likely shouldn't be).

Note btw that you also need the procps patch posted by Chad Hanson on
Aug 15th if you want ps to display the translated names.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
