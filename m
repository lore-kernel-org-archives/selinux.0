Date: Thu, 24 Jan 2002 10:37:38 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: Justin Smith <jsmith@mcs.drexel.edu>, <SELinux@tycho.nsa.gov>
Subject: Re: Shutdown issues
In-Reply-To: <3C5024BD.6050303@pcez.com>
Message-ID: <Pine.GSO.4.33.0201241030580.16828-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Thu, 24 Jan 2002, Shaun Savage wrote:

> Or you can via sysadm role shut down just the
> services.  The problem here is sysadm_t != initrc_t.  you have to do a
> runs as.

You can use run_init to run any of the init scripts in the proper security
context.  So, you can use run_init to shut down the services manually
while the system is still logging to a file.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
