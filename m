Message-ID: <4BD19D9C.4090306@manicmethod.com>
Date: Fri, 23 Apr 2010 09:16:12 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/3] SELinux: standardize return code handling in policydb.c
References: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
In-Reply-To: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Eric Paris wrote:
> policydb.c has lots of different standards on how to handle return paths on
> error.  For the most part transition to
>
> 	rc=errno
> 	if (failure)
> 		goto out;
> [...]
> out:
> 	cleanup()
> 	return rc;
>
> Instead of doing cleanup mid function, or having multiple returns or other
> options.  This doesn't do that for every function, but most of the complex
> functions which have cleanup routines on error.
>

Any chance the same fixes could be made in libsepol policydb.c? :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
