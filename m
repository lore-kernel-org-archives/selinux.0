Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w749Ywd6019913
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 05:34:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so3973148pgu.8
 for <selinux@tycho.nsa.gov>; Sat, 04 Aug 2018 02:34:29 -0700 (PDT)
Date: Sat, 4 Aug 2018 17:34:26 +0800
From: Jason Zaman <jason@perfinion.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180804093426.GA33404@baraddur.perfinion.com>
References: <20180804091147.19092-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180804091147.19092-1-nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/1] python/semanage: fix Python syntax of
 catching several exceptions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Aug 04, 2018 at 11:11:47AM +0200, Nicolas Iooss wrote:
> "except OSError, ImportError:" does not perform what it says: it is the
> Python 2 syntax of catching OSError exceptions as "ImportError" (like
> "except OSError, e:"), and this is indeed caught by Python3:
> 
>       File "./python/semanage/seobject.py", line 143
>         except OSError, ImportError:
>                       ^
>     SyntaxError: invalid syntax
> 
> The correct syntax consists in using parentheses.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Jason Zaman <jason@perfinion.com>


> ---
> For the record, I found this while playing with flake8 Python's linter.
> I am currently working on upstreaming a script which would run this on
> our Travis-CI environment in order to catch Python syntax errors before
> they are introduced.

Awesome! more linters are always good. I really do need to find the time
to kill seobject more thoroughly tho, its so slow compared to direct
setools. :(

-- Jason

> 
>  python/semanage/seobject.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 78ffb091ad2f..c14671855049 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -140,7 +140,7 @@ try:
>  
>              self.log_list = []
>              self.log_change_list = []
> -except OSError, ImportError:
> +except (OSError, ImportError):
>      class logger:
>  
>          def __init__(self):
> -- 
> 2.18.0
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
