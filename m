Subject: Re: policy module for httpd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: kihamba nengo <knengo@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <108108.89635.qm@web90403.mail.mud.yahoo.com>
References: <108108.89635.qm@web90403.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 17 Mar 2008 13:54:57 -0400
Message-Id: <1205776497.22912.222.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 2008-03-16 at 06:43 -0700, kihamba nengo wrote:
> Hi,
> How can i develop a policy module for apache on fedora 8. I have
> the .te file and i would like to know how to build a policy module
> manually without using the policy generation tools.

Fedora includes the apache policy in the base module by default in the
targeted policy.  So you already have the stock apache module if running
the default policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
