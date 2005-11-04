Subject: Re: [ SEMANAGE] Resync seuser parser
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Jonathan Kim <jkim@TrustedCS.com>, SELinux@tycho.nsa.gov,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <436B14FD.8010708@cornell.edu>
References: <36282A1733C57546BE392885C0618592D975CA@chaos.tcs.tcs-sec.com>
	 <1131048615.23420.142.camel@moss-spartans.epoch.ncsc.mil>
	 <1131050021.23420.153.camel@moss-spartans.epoch.ncsc.mil>
	 <1131050864.23420.165.camel@moss-spartans.epoch.ncsc.mil>
	 <436A8156.5090003@cornell.edu>  <436B14FD.8010708@cornell.edu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 08:23:05 -0500
Message-Id: <1131110585.23420.190.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 02:59 -0500, Ivan Gyurdiev wrote:
> This patch is possibly wrong...  do you want the ':MLS' skipped, or only 
> the 'MLS' (keeping the semicolon). If the second, then I need to change 
> my patch a bit (but we still need to keep the parsers synchronized).

The libselinux one presently allows omission of :MLS if MLS is disabled,
but otherwise requires at least the : if MLS is enabled.  Not sure
whether that is desirable.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
