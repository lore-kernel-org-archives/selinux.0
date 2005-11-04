Subject: Re: [ SEMANAGE] Resync seuser parser
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Jonathan Kim <jkim@TrustedCS.com>, SELinux@tycho.nsa.gov,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <436B7564.7030506@cornell.edu>
References: <36282A1733C57546BE392885C0618592D975CA@chaos.tcs.tcs-sec.com>
	 <1131048615.23420.142.camel@moss-spartans.epoch.ncsc.mil>
	 <1131050021.23420.153.camel@moss-spartans.epoch.ncsc.mil>
	 <1131050864.23420.165.camel@moss-spartans.epoch.ncsc.mil>
	 <436A8156.5090003@cornell.edu> <436B14FD.8010708@cornell.edu>
	 <436B188D.4050701@cornell.edu>
	 <1131112032.23420.210.camel@moss-spartans.epoch.ncsc.mil>
	 <436B71C7.700@cornell.edu>  <436B7564.7030506@cornell.edu>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 09:38:19 -0500
Message-Id: <1131115099.23420.240.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 09:51 -0500, Ivan Gyurdiev wrote:
> Now I notice that the libsemanage parser will fail if mls_enabled=0, 
> mls_found=1, while libselinux will accept that. Which should be fixed? 
> For comparison, note genusers/checkpolicy (?)/libsemanage will all fail 
> parsing users if mls_enabled=0, mls_found=1.

In that case, libselinux should at least ignore the level (i.e. leave it
NULL) even if specified, because otherwise, it will ultimately be used
in a context which will then be invalid.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
