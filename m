Date: Mon, 17 Jun 2002 15:01:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Warren Lerner <wdl@zai.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: AVC Messages
In-Reply-To: <1024335869.3489.8.camel@montyburns>
Message-ID: <Pine.GSO.4.33.0206171445000.12900-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 17 Jun 2002, Warren Lerner wrote:

> I am very new to SELinux.  I have some questions, and I hope you all
> forgive me if they have been asked before.
>
> 1.  Is it possible to prevent the avc 'granted' or 'denied' messages
> off?  If so, how?

Granted messages are only generated if you have specified auditallow rules
in the configuration.  Denied messages are always generated unless you
specify auditdeny rules in the configuration.  A recently posted patch
(also committed to the sourceforge CVS tree) changes the 'auditdeny'
rules' to 'dontaudit' rules and provides more intuitive semantics.  See
the "Configuring the SELinux Policy" report for the precise syntax, or
look at examples in the example policy configuration.

> 2.  Can I write my own policy file from scratch and use only the
> functions necessary for my purpose?

Of course.  But writing a policy from scratch is nontrivial.  As with the
prior question, please read the aforementioned report.

> 3.  Will SELinux be incorporated in to the next kernel release?

The LSM kernel patch, on which SELinux is now based, will _hopefully_ be
incorporated into the 2.5 development series.  But obviously that isn't
under our control.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
