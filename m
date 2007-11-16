Date: Sat, 17 Nov 2007 08:47:19 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        alan@redhat.com, chrisw@redhat.com, hpa@zytor.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 3/3] security: allow capable check to permit mmap or low
 vm space
In-Reply-To: <1195246545.2924.88.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0711170845050.22208@us.intercode.com.au>
References: <1195246545.2924.88.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Nov 2007, Eric Paris wrote:

> On a kernel with CONFIG_SECURITY but without an LSM which implements
> security_file_mmap it is impossible for an application to mmap addresses
> lower than mmap_min_addr.

Actually, should we be doing any checking in the dummy module, given that 
it is not done with !CONFIG_SECURITY ?



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
