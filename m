Message-ID: <51F8006F.6050108@tycho.nsa.gov>
Date: Tue, 30 Jul 2013 14:05:35 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Thomas COUDRAY <amanone@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Building the Base Policy Module
References: <CABhRnsXoNT5JBbMjd36w5o3Q4KEJ51CqHmL9FJihC-H5yrdqFg@mail.gmail.com>
In-Reply-To: <CABhRnsXoNT5JBbMjd36w5o3Q4KEJ51CqHmL9FJihC-H5yrdqFg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/30/2013 01:45 PM, Thomas COUDRAY wrote:
> I followed the SELinux documentation for building the base policy module.
> 
> When I use checkmodule (checkmodule -o base.mod base.conf), I get this error.
> 
> # checkmodule -o base.mod base.conf
> checkmodule:  loading policy configuration from base.conf
> base.conf:1014:ERROR 'unknown role unconfined_r' at token ';' on line 1014:
> role unconfined_r types { unconfined_t };
> # The only role defined for this policy:
> checkmodule:  error(s) encountered while parsing configuration
> 
> Also the base.fc, dbus_context,  file, is missing.
> 
> [1]: http://selinuxproject.org/page/Building_a_Basic_Policy#Building_the_Base_Policy_Module

I didn't write that document, but offhand, I suspect the issue is that
at a later point in time, it became mandatory to separately declare all
roles with a basic role statement, i.e.
	role unconfined_r;
prior to using them in a role-types statement.  Originally the
role-types statement served to both implicitly declare the role and
assign domain types to it, but a separate declaration was later
introduced and made mandatory.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
