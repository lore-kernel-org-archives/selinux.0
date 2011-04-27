Date: Thu, 28 Apr 2011 09:54:10 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 4/6] SELinux: calculate and print hashtab stats with a
 generic function
In-Reply-To: <20110426180757.20636.61854.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1104280954010.17048@tundra.namei.org>
References: <20110426180739.20636.50947.stgit@paris.rdu.redhat.com> <20110426180757.20636.61854.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Apr 2011, Eric Paris wrote:

> We have custom debug functions like rangetr_hash_eval and symtab_hash_eval
> which do the same thing.  Just create a generic function that takes the name
> of the hash table as an argument instead of having custom functions.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Reviewed-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
