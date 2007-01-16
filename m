Subject: Re: I have been asked to add the following perms for NSCD.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <45ACEA2C.50908@redhat.com>
References: <45ACEA2C.50908@redhat.com>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 10:05:53 -0500
Message-Id: <1168959953.22731.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-16 at 10:07 -0500, Daniel J Walsh wrote:
> Patch attached.
> plain text document attachment (diff)
> --- nsaserefpolicy/policy/flask/access_vectors	2006-11-16 17:15:00.000000000 -0500
> +++ serefpolicy-2.5.1/policy/flask/access_vectors	2007-01-16 10:03:32.000000000 -0500
> @@ -594,6 +594,8 @@
>  	shmempwd
>  	shmemgrp
>  	shmemhost
> +	getserv
> +	shmemserv
>  }
>  
>  # Define the access vector interpretation for controlling

What do the new permissions allow to happen?  What domains should
initially be granted them (other than unconfined_t)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
