Subject: Re: libsetrans: ___tls_get_addr
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060524150537.GB16189@sergelap.austin.ibm.com>
References: <20060524150537.GB16189@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 13:09:20 -0400
Message-Id: <1148490560.24463.457.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-24 at 10:05 -0500, Serge E. Hallyn wrote:
> compiling libselinux/src/libsetrans.c was failing on my gentoo laptop,
> with a few warnings about ___tls_get_addr being undefined.  The
> following patch lets it compile, though I suspect it messes something
> up :)
> 
> What would be the right way to fix this?  Am I just supposed to
> 'emerge tls'?

I don't know how one gets proper support for __thread attribute on
gentoo, but yes, that patch would break any multi-threaded user of
libselinux, as the cache then becomes global to the entire thread group
rather than per-thread.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
