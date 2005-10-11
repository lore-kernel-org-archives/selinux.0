Message-ID: <434C4097.6090801@tresys.com>
Date: Tue, 11 Oct 2005 18:45:43 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	<1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	<1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	<1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>	<1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>	<4346CE4C.1030201@tresys.com>	<1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>	<4346D745.6080203@tresys.com>	<1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>	<4346DD70.1070806@tresys.com>	<1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>	<1129061117.3308.227.camel@moss-spartans.epoch.ncsc.mil> <1129061862.3308.231.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129061862.3308.231.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2005-10-11 at 16:05 -0400, Stephen Smalley wrote:
> 
>>Patch for libselinux is below.  The real cases are:
>>1) kernel policyvers falls within the libsepol supported range, in which
>>case libsemanage and libselinux will use the kernel policyvers for
>>generation and loading, or
>>2) kernel policyvers is higher than libsepol max, in which case
>>libsemanage and libselinux will use the libsepol max for generation and
>>loading (which the kernel will still accept),
>>3) kernel policyvers is less than libsepol min.  If this truly happens,
>>it is fatal, as it means that we cannot generate policy for the kernel.
>>However, it should never happen as libsepol provides backward
>>compatibility starting with the first policyvers ever supported by a 2.6
>>kernel.  At present, this also falls back to the libsepol max for
>>generation and loading as in (2); I suppose it should be altered to just
>>fail immediately.  I was originally thinking that we should still try
>>the libsepol max as a fallback in this case, as security_policyvers()
>>might return -1 due to a permission denial on /selinux/policyvers, but
>>immediate failure likely is more sensible.
> 
> 
> Ok, so further patches for libsemanage and libselinux below.  Now it
> treats case (3) as an immediate error, and also drops any use of the
> conf value, since it is useless and won't be honored by libselinux for
> loading anyway.

Fair enough, this should probably be removed entirely from the config 
parser and config struct.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
