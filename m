Subject: Re: [ SEMANAGE] Resync seuser parser
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Jonathan Kim <jkim@TrustedCS.com>, SELinux@tycho.nsa.gov,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <436B188D.4050701@cornell.edu>
References: <36282A1733C57546BE392885C0618592D975CA@chaos.tcs.tcs-sec.com>
	 <1131048615.23420.142.camel@moss-spartans.epoch.ncsc.mil>
	 <1131050021.23420.153.camel@moss-spartans.epoch.ncsc.mil>
	 <1131050864.23420.165.camel@moss-spartans.epoch.ncsc.mil>
	 <436A8156.5090003@cornell.edu> <436B14FD.8010708@cornell.edu>
	 <436B188D.4050701@cornell.edu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 08:47:12 -0500
Message-Id: <1131112032.23420.210.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 03:15 -0500, Ivan Gyurdiev wrote:
> Ivan Gyurdiev wrote:
> > This patch is possibly wrong...  do you want the ':MLS' skipped, or 
> > only the 'MLS' (keeping the semicolon). If the second, then I need to 
> > change my patch a bit (but we still need to keep the parsers 
> > synchronized).
> Actually on second thought I can't handle the second case, and keep 
> multiline support at the same time...do you really need that?

I don't see why it is needed; it seems like one would omit the separator
as well if no level was being specified.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
