Message-ID: <430C8944.6090306@redhat.com>
Date: Wed, 24 Aug 2005 10:50:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Ok I plead ignorance to the way MLS works.
References: <430A33E5.1030100@redhat.com>	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>	 <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>	 <430C75B4.3020008@redhat.com> <1124892792.11553.26.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124892792.11553.26.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Playing around with MCS, I see the following problems.

Should the initialsid of kernel be

sid kernel     system_u:system_r:kernel_t:s0:c0.c127
or
sid kernel     system_u:system_r:kernel_t:s0 - s0:c0.c127

I would like all the daemon processes in the system to run as "s0", Ie 
by default not have access to any labeled
data.  How do I do this?   Am I supposed to use something like:
range_transition initrc_t httpd_exec_t s0 - s0;

Trying to use this is giving me a compilation error.



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
