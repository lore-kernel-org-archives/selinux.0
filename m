Message-ID: <430CA3EC.8080102@trustedcs.com>
Date: Wed, 24 Aug 2005 11:44:28 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Ok I plead ignorance to the way MLS works.
References: <430A33E5.1030100@redhat.com>	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>	 <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>	 <430C75B4.3020008@redhat.com> <1124892792.11553.26.camel@moss-spartans.epoch.ncsc.mil> <430C8944.6090306@redhat.com>
In-Reply-To: <430C8944.6090306@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Playing around with MCS, I see the following problems.
> 
> Should the initialsid of kernel be
> 
> sid kernel     system_u:system_r:kernel_t:s0:c0.c127
> or
> sid kernel     system_u:system_r:kernel_t:s0 - s0:c0.c127
> 
> I would like all the daemon processes in the system to run as "s0", Ie 
> by default not have access to any labeled
> data.  How do I do this?   Am I supposed to use something like:
> range_transition initrc_t httpd_exec_t s0 - s0;
> 
> Trying to use this is giving me a compilation error.

I think you would want to run the kernel would at s0:c0.c127.
Then, do a "range_transition kernel_t init_exec_t s0" to get the whole
of userspace started off with no categories present.  This is a change
from the range_transition that is ifdef'd currently for mls in kernel.te.
Are you going to have "ifdef mcs_policy" like the current
"ifdef mls_policy"?

I'm sure about the compilation error, I did a similar statement with a
toolchain that is are pre-modules - that worked.  I'm updating an FC4 box
now so I at least have something up-to-date.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
