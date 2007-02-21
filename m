Message-ID: <45DC7DE3.7090903@mentalrootkit.com>
Date: Wed, 21 Feb 2007 12:14:11 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>
Subject: Re: sepolgen fixes.
References: <45DB0BED.5050205@redhat.com>
In-Reply-To: <45DB0BED.5050205@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
>    Change to Makefile to get proper python library path even on 64 bit 
> platforms.
>    Empty or poorly formated interface files cause sepol-ifgen to crash.
> 
> 

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

> ------------------------------------------------------------------------
> 
> diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/Makefile policycoreutils-2.0.1/sepolgen-1.0.0/src/sepolgen/Makefile
> --- nsasepolgen/src/sepolgen/Makefile	2007-02-07 12:12:15.000000000 -0500
> +++ policycoreutils-2.0.1/sepolgen-1.0.0/src/sepolgen/Makefile	2007-02-15 15:56:05.000000000 -0500
> @@ -1,4 +1,4 @@
> -PYTHONLIBDIR ?= `python -c "from distutils.sysconfig import *; print get_python_lib()"`
> +PYTHONLIBDIR ?= $(shell  python -c "from distutils.sysconfig import *; print get_python_lib(1)")
>  PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
>  
>  install:
> diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/refparser.py policycoreutils-2.0.1/sepolgen-1.0.0/src/sepolgen/refparser.py
> --- nsasepolgen/src/sepolgen/refparser.py	2007-02-07 12:12:15.000000000 -0500
> +++ policycoreutils-2.0.1/sepolgen-1.0.0/src/sepolgen/refparser.py	2007-02-15 15:16:09.000000000 -0500
> @@ -691,11 +691,13 @@
>              output.write(msg)
>  
>      def parse_file(f, module, spt=None):
> -        fd = open(f)
> -        txt = fd.read()
> -        fd.close()
>          try:
> +            fd = open(f)
> +            txt = fd.read()
> +            fd.close()
>              parse(txt, module, spt)
> +        except IOError, e:
> +            return
>          except ValueError, e:
>              raise ValueError("error parsing file %s: %s" % (f, str(e)))
>  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
