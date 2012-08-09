From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: A filename to label translation daemon
Date: Fri, 10 Aug 2012 00:37:21 +1000
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        lennart@poettering.net, sds@tycho.nsa.gov, dwalsh@redhat.com
References: <1344454290.25533.12.camel@localhost> <1344461186.4612.27.camel@lenny>
In-Reply-To: <1344461186.4612.27.camel@lenny>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201208100037.21877.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Aug 2012, Colin Walters <walters@verbum.org> wrote:
> Seems to make sense...though someone could also probably get fairly far
> by writing a regular expression optimizer.  It might not even be that
> hard to write a multi-regexp matching engine which took a set of regexps
> at once and constructed a single matching DFA for them.

Is this really going to help?  My slowest system is a P3-866 which takes less 
than 30ms of user time for "restorecon /bin/bash" and takes a total of 136ms 
of wall time if the cache is cold.  On a 1.8GHz 64bit system it's only 8ms of 
user time.

What benefit are we expecting to get here?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
