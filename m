Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5A1LihG001063
 for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2014 21:21:44 -0400
Message-ID: <53965DC4.1090802@tresys.com>
Date: Mon, 9 Jun 2014 21:22:12 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
To: Sven Vermeulen <sven.vermeulen@siphos.be>, <selinux@tycho.nsa.gov>
Subject: Re: SETools patch for libselinux-2.3
References: <20140528170411.GA13025@siphos.be>
In-Reply-To: <20140528170411.GA13025@siphos.be>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/28/2014 1:04 PM, Sven Vermeulen wrote:
> In libselinux-2.3, the interface of the lsetfilecon_raw function has been
> changed:
> 
> -extern int lsetfilecon_raw(const char *path, security_context_t con);
> +extern int lsetfilecon_raw(const char *path, const char * con);
> 
> The call to lsetfilecon_raw in setools' secmds/replcon.cc needs to be
> updated accordingly, as it otherwise fails during build:
> 
> replcon.cc: In function ‘int replcon_lsetfilecon(const char*, security_context_t)’:
> replcon.cc:73:25: warning: NULL used in arithmetic [-Wpointer-arith]
> replcon.cc:73:25: error: invalid operands of types ‘<unresolved overloaded function type>’ and ‘long int’ to binary ‘operator!=’
> 
> The below patch fixes this (but makes the setools version depend on
> libselinux-2.3 now).
> 
> With thanks to Arfrever Frehtes Taifersar Arahesis for the patch (I worked
> around it first by just calling lsetfilecon_raw directly). Something about
> weakly linked functions...
> 
> 
> Index: secmds/replcon.cc
> ===================================================================
> --- secmds/replcon.cc	(revision 4973)
> +++ secmds/replcon.cc	(working copy)
> @@ -60,7 +60,7 @@
>  	{NULL, 0, NULL, 0}
>  };
>  
> -extern int lsetfilecon_raw(const char *, security_context_t) __attribute__ ((weak));
> +extern int lsetfilecon_raw(const char *, const char *) __attribute__ ((weak));

Unfortunately, this breaks it in the same way if you compile with libselinux < 2.3 with this patch.  The preference would be a patch that allows it to compile with any recent libselinux, rather than requiring libselinux 2.3.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
