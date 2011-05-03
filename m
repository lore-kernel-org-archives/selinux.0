MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.00.1105031019400.19644@tundra.namei.org>
References: <20110428195402.6677.80147.stgit@paris.rdu.redhat.com>
	<alpine.LRH.2.00.1105031019400.19644@tundra.namei.org>
Date: Tue, 3 May 2011 09:15:12 -0400
Message-ID: <BANLkTim+sQrwXSaLgLMxyQsm1fetv_rQXQ@mail.gmail.com>
Subject: Re: [PATCH -v2] flex_arrays: allow zero length flex arrays
From: Eric Paris <eparis@parisplace.org>
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@redhat.com>, dave@linux.vnet.ibm.com,
        steffen.klassert@secunet.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It builds on another patch already committed to my tree.  I'll send
you a pull request for that branch right now!

-Eric

On Mon, May 2, 2011 at 8:20 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 28 Apr 2011, Eric Paris wrote:
>
>> Just like kmalloc will allow one to allocate a 0 length segment of memory
>> flex arrays should do the same thing.  It should bomb if you try to use
>> something, but it should at least allow the allocation.
>
> This patch does not apply to current -linus.
>
> --
> James Morris
> <jmorris@namei.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
