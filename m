Subject: Re: [PATCH] Lazy config init in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <388819.82266.qm@web51510.mail.yahoo.com>
References: <388819.82266.qm@web51510.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 16:18:43 -0500
Message-Id: <1172524723.19041.286.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:57 -0800, Steve G wrote:
> >The problem with doing it on first use is it isn't thread-safe; the code
> >is initializing globals for the library's subsequent use.  And making
> >those variables per-thread would be wasteful as they truly are global
> >state to the library.  So initializing them in the library constructor
> >is the right thing to do.
> 
> How do you feel about __libc_once  ?

Not familiar with it - enlighten me.  How does it differ from a
constructor?  How does it work?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
