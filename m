Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <4346D745.6080203@tresys.com>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
	 <4346D745.6080203@tresys.com>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 16:23:45 -0400
Message-Id: <1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 16:15 -0400, Joshua Brindle wrote:
> I'm not sure I understand. If the user sets the config option shouldn't 
> it always override?

Sorry, how does the code know whether the user has set the config
option?  The value is always set by conf-parse to something, even if the
conf file has no setting.  semanage_conf_init() initializes it to the
max version supported by libsepol.

Frankly, I'm not sure I understand the point of seting a fixed value in
a config file at all, given that it needs to change in response to the
versions supported by the current shared libsepol (now available via the
new functions I've introduced) and by the current kernel (already
available via security_policyvers).  If the user sets it to 20 in the
config file and then boots a 2.6.3 kernel, should we honor his setting?
My inclination is to just pick the kernel version always if libsepol
supports writing it, and otherwise fall back to the libsepol max
supported version (which should still be accepted by the kernel).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
