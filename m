Date: Mon, 11 Mar 2002 09:08:46 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Samarth Sharma <samarth7880@rediffmail.com>, <SELinux@tycho.nsa.gov>
Subject: Re:
In-Reply-To: <20020310164844.6FCAD3CDEA@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203110907550.25401-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 10 Mar 2002, Russell Coker wrote:

> I guess that you had cron rename the old wtmp to wtmp.1 and then create a new
> wtmp file, the new file gets a domain based on the domain that cron is
> running in and the domain of the parent directory.
>
> One way of solving this would be to have an executable which has no purpose
> other than to rotate the wtmp file (could be a wrapper for logrotate) with
> the SE Linux setup to have an automatic domain transition for that program
> into a domain that defaults to wtmp_t for the file type.

The SELinux-modified logrotate should handle this already - it preserves
the security context of the original file when it rotates the log.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
