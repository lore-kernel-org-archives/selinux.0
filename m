Date: Mon, 18 Oct 2010 09:59:07 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 5/6] SELinux: allow userspace to read policy back out of
 the kernel
In-Reply-To: <20101013215025.17293.42799.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1010180956490.9476@tundra.namei.org>
References: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com> <20101013215025.17293.42799.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Oct 2010, Eric Paris wrote:


> +/*
> + * Write the configuration data in a policy database
> + * structure to a policy database binary representation
> + * file.
> + */
> +int policydb_write(struct policydb *p, void *fp)

Perhaps check that fp->len is still the same as policydb.len here before 
writing to the buffer.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
