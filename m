Message-ID: <1344461186.4612.27.camel@lenny>
Subject: Re: A filename to label translation daemon
From: Colin Walters <walters@verbum.org>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, lennart@poettering.net, sds@tycho.nsa.gov,
        dwalsh@redhat.com
Date: Wed, 08 Aug 2012 17:26:26 -0400
In-Reply-To: <1344454290.25533.12.camel@localhost>
References: <1344454290.25533.12.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Seems to make sense...though someone could also probably get fairly far
by writing a regular expression optimizer.  It might not even be that
hard to write a multi-regexp matching engine which took a set of regexps
at once and constructed a single matching DFA for them.

On Wed, 2012-08-08 at 15:31 -0400, Eric Paris wrote:
>         /* just to be safe! */
>         buffer[MAX_REQUEST_LEN] = '\0'; 

Should be buffer[len] = '\0';  right?

>                /* calculating the length of the address is magic since it starts with nul.
>                * there be dragons in here! */

See also https://bugzilla.gnome.org/show_bug.cgi?id=615960



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
