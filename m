Message-ID: <436B7564.7030506@cornell.edu>
Date: Fri, 04 Nov 2005 09:51:16 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Jonathan Kim <jkim@TrustedCS.com>,
   SELinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [ SEMANAGE] Resync seuser parser
References: <36282A1733C57546BE392885C0618592D975CA@chaos.tcs.tcs-sec.com>	 <1131048615.23420.142.camel@moss-spartans.epoch.ncsc.mil>	 <1131050021.23420.153.camel@moss-spartans.epoch.ncsc.mil>	 <1131050864.23420.165.camel@moss-spartans.epoch.ncsc.mil>	 <436A8156.5090003@cornell.edu> <436B14FD.8010708@cornell.edu>	 <436B188D.4050701@cornell.edu> <1131112032.23420.210.camel@moss-spartans.epoch.ncsc.mil> <436B71C7.700@cornell.edu>
In-Reply-To: <436B71C7.700@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now I notice that the libsemanage parser will fail if mls_enabled=0, 
mls_found=1, while libselinux will accept that. Which should be fixed? 
For comparison, note genusers/checkpolicy (?)/libsemanage will all fail 
parsing users if mls_enabled=0, mls_found=1.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
