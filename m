Message-ID: <45ACF356.3070501@mentalrootkit.com>
Date: Tue, 16 Jan 2007 10:46:30 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: translation patch for semanage
References: <45A64526.2050701@redhat.com>
In-Reply-To: <45A64526.2050701@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> This patch works around a unicode problem in python.
> 

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

Both this patch and the related seobject patch are merged as of 
policycoreutils 1.33.13.

Karl

> 
> ------------------------------------------------------------------------
> 
> --- nsapolicycoreutils/semanage/semanage	2006-11-16 17:14:26.000000000 -0500
> +++ policycoreutils-1.33.10/semanage/semanage	2007-01-09 11:55:52.000000000 -0500
> @@ -23,12 +23,21 @@
>  import os, sys, getopt
>  import seobject
>  import selinux
> +PROGNAME="policycoreutils"
> +
>  import gettext
> +gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> +gettext.textdomain(PROGNAME)
> +import codecs
> +import locale
> +sys.stderr = codecs.getwriter(locale.getpreferredencoding())(sys.__stderr__, 'replace')
> +sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.__stdout__, 'replace')
>  
>  try:
> -       gettext.install('policycoreutils')
> -except:
> -       pass
> +       gettext.install(PROGNAME, localedir="/usr/share/locale", unicode=1)
> +except IOError:
> +       import __builtin__
> +       __builtin__.__dict__['_'] = unicode
>  
>  is_mls_enabled=selinux.is_selinux_mls_enabled()
>  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
