Subject: Re: [PATCH] SELinux:  Reduce max avtab size to avoid page
 allocation failures
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Russell Coker <russell@coker.com.au>,
        selinux@tycho.nsa.gov
In-Reply-To: <1268664131.15512.54.camel@moss-pluto.epoch.ncsc.mil>
References: <1268664131.15512.54.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Mar 2010 15:23:23 -0400
Message-ID: <1268681003.3768.15.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-03-15 at 10:42 -0400, Stephen Smalley wrote:
> Reduce MAX_AVTAB_HASH_BITS so that the avtab allocation is an order 2
> allocation rather than an order 4 allocation on x86_64.  This
> addresses reports of page allocation failures:
> http://marc.info/?l=selinux&m=126757230625867&w=2
> https://bugzilla.redhat.com/show_bug.cgi?id=570433
> 
> Reported-by:  Russell Coker <russell@coker.com.au>
> Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

Acked-by: Eric Paris <eparis@redhat.com>

although if I get a coulpe of minutes I might look at using
lib/flex_array.c for this....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
