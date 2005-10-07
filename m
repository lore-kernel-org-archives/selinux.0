Message-ID: <4346DD70.1070806@tresys.com>
Date: Fri, 07 Oct 2005 16:41:20 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	<1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	<1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	<1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>	<1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>	<4346CE4C.1030201@tresys.com>	<1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>	<4346D745.6080203@tresys.com> <1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-10-07 at 16:15 -0400, Joshua Brindle wrote:
> 
>>I'm not sure I understand. If the user sets the config option shouldn't 
>>it always override?
> 
> 
> Sorry, how does the code know whether the user has set the config
> option?  The value is always set by conf-parse to something, even if the
> conf file has no setting.  semanage_conf_init() initializes it to the
> max version supported by libsepol.
> 
> Frankly, I'm not sure I understand the point of seting a fixed value in
> a config file at all, given that it needs to change in response to the
> versions supported by the current shared libsepol (now available via the
> new functions I've introduced) and by the current kernel (already
> available via security_policyvers).  If the user sets it to 20 in the
> config file and then boots a 2.6.3 kernel, should we honor his setting?
> My inclination is to just pick the kernel version always if libsepol
> supports writing it, and otherwise fall back to the libsepol max
> supported version (which should still be accepted by the kernel).
> 

Sure, setting the policy version is probably not useful for most users, 
it's more of a development/debugging option than anything.

What if the user wants to build a policy for the new kernel he just 
installed? I guess a rebuild/reload after booting the kernel isn't bad, 
although we don't provide a way to do that without starting a 
transaction in the store.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
