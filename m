Subject: Re: [PATCH] libsemanage: Read-only FS [2/2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200607062052.k66KqLUx012479@localhost.localdomain>
References: <200607062052.k66KqLUx012479@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 11:32:42 -0400
Message-Id: <1152631962.29240.231.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-06 at 16:52 -0400, Caleb Case wrote:
> This patch compliments the libsemanage: Read-only FS patch by adding CUnit tests.  The tests in semanage_access_check should not be run as root (they use DAC permissions to simulate a read-only fs).

Thanks, both patches merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
