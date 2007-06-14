Date: Thu, 14 Jun 2007 13:43:49 -0400
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
 capabilities
From: Chad Sellers <csellers@tresys.com>
To: James Morris <jmorris@namei.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <C296F695.23449%csellers@tresys.com>
In-Reply-To: <Line.LNX.4.64.0706141334280.19226@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6/14/07 1:35 PM, "James Morris" <jmorris@namei.org> wrote:

> On Thu, 14 Jun 2007, Chad Sellers wrote:
> 
>> Yes, it's definitely an interesting scenario, when a program can succeed in
>> enforcing but fail in permissive. Though it might help us convince more
>> people to run in enforcing ;-)
> 
> ITYM "convince more people to disable SELinux"
> 
No, once Red Hat takes the SUID bit off all their programs and uses SELinux
to grant them capabilities, then neither permissive nor disabled will work.
They'll have to run with SELinux enforcing. ;-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
