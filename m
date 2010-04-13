Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3DLfuLZ031965
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 17:41:56 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o3DLfQVY007091
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 21:41:26 GMT
Date: Tue, 13 Apr 2010 17:41:53 -0400
Subject: Re: sudo + selinux
From: Chad Sellers <csellers@tresys.com>
To: <jimi@sngx.net>, <selinux@tycho.nsa.gov>
Message-ID: <C7EA5D61.B6871%csellers@tresys.com>
In-Reply-To: <e2229269c988ce55126bc9fcc18f78c4@sngx.net>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/12/10 3:30 PM, "James Cammarata" <jimi@sngx.net> wrote:

> 
> Hi, we're looking towards running SELinux on RHEL5 in strict mode here,
> however I'm not having any luck finding resources on configuring sudo to
> work with SELinux properly.  Are there any guides/resources to getting this
> working?  I've found some older mailing list threads that discuss adding
> some new features to sudo to make it selinux-aware, but that doesn't seem
> to have found it's way into RHEL5 yet (at least, as of 5.4).
> 
Hi James,

What do you want sudo to do with respect to SELinux? Are you looking for it
to transition to a more trusted domain when it is run?

Most of the time, we let sudo remain a DAC privilege escalation mechanism,
but do not use it to escalate SELinux priveleges. We do generally transition
into a derived domain for sudo (see sudo_role_template in reference policy
for more info), so you could easily grant that derived domain additional
privileges if that's what you're looking to do, but that's just policy and
requires no SELinux knowledge in sudo.

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
