Subject: Re: translation patch for semanage
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <45A64526.2050701@redhat.com>
References: <45A64526.2050701@redhat.com>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 13:33:05 -0500
Message-Id: <1168540385.7048.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-11 at 09:09 -0500, Daniel J Walsh wrote:
> This patch works around a unicode problem in python.

Can you give a little more detail - perhaps a BZ? It appears that this
patch and the seobject patch or to force all translated strings to be
unicode and output as unicode, correct? Why is this necessary?

> --- nsapolicycoreutils/semanage/semanage        2006-11-16
> 17:14:26.000000000 -0500
> +++ policycoreutils-1.33.10/semanage/semanage   2007-01-09
> 11:55:52.000000000 -0500
> @@ -23,12 +23,21 @@
>  import os, sys, getopt
>  import seobject
>  import selinux
> +PROGNAME="policycoreutils"
> +
>  import gettext
> +gettext.bindtextdomain(PROGNAME, "/usr/share/locale")

Why is the location of the local files being forced? Is this appropriate
for all distros or does it need to be configurable?

> 
> +gettext.textdomain(PROGNAME)
> +import codecs
> +import locale
> +sys.stderr =
> codecs.getwriter(locale.getpreferredencoding())(sys.__stderr__,
> 'replace')
> +sys.stdout =
> codecs.getwriter(locale.getpreferredencoding())(sys.__stdout__,
> 'replace')

Is this related to
http://mail.python.org/pipermail/pythonmac-sig/2004-March/010651.html?
I.e., is this to force the encoding rather than relying on the term to
correctly communicate that it supports unicode / utf8 / etc.?

If so, is this the "right" fix or just expedient?

Karl
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
