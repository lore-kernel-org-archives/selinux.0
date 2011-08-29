Subject: Re: hidden_def and libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201108292342.22701.russell@coker.com.au>
References: <201108292342.22701.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Aug 2011 10:07:29 -0400
Message-ID: <1314626849.18430.13.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-08-29 at 23:42 +1000, Russell Coker wrote:
> A build of libselinux 2.1.0 fails on Debian because of new symbols.
> 
> setrans_lib_destructor() and matchpathcon_lib_destructor() look like
> good candidates for hidden_def (or something similar) as it doesn't
> seem possible to call them from outside the library.  What do you
> think?
> 
> There are a bunch of other new symbols that just need to be added to
> the symbol list.

Use hidden to hide the symbol from external users. Use
hidden_def/hidden_proto to declare and define a function that is
visible to external users but also called within the library (defines a
hidden internal reference that avoids relocations).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
