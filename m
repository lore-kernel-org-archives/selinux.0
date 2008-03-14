Subject: Re: Installing and building policy modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: kihamba nengo <knengo@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <818521.44962.qm@web90407.mail.mud.yahoo.com>
References: <818521.44962.qm@web90407.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 14 Mar 2008 09:05:07 -0400
Message-Id: <1205499907.22912.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-03-12 at 21:50 -0700, kihamba nengo wrote:
> Hi,
> When i run semodule -l, i get the message: No modules.
> How can i get modules related to the web server, install them and
> build them?

That just means that your entire policy was built into a single base
module and there are no non-base modules.  Which was true in FC5.  It
doesn't mean that you don't have the httpd policy rules.

You can tell whether you have httpd policy rules by checking whether
httpd is running in the httpd_t domain via ps -eZ.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
