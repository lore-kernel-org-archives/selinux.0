Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j13G8Z53001155
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 11:08:36 -0500 (EST)
Received: from mx-3.zoominternet.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j13G6Lo7011117
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 16:06:26 GMT
Subject: Re: FC3, Apache and CGI web app
From: Scott Cain <cain@cshl.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42024A45.8060602@redhat.com>
References: <1107378461.3351.62.camel@localhost.localdomain>
	 <42016640.3050807@redhat.com>
	 <1107405040.3391.17.camel@localhost.localdomain>
	 <42023A75.7050501@redhat.com>
	 <1107444327.3307.13.camel@localhost.localdomain>
	 <420244C4.8060509@redhat.com>
	 <1107445729.3307.28.camel@localhost.localdomain>
	 <42024A45.8060602@redhat.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 03 Feb 2005 11:01:49 -0500
Message-Id: <1107446509.3307.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

OK, now I get this:

[scott@localhost gbrowse]$ sudo chcon -R -t httpd_sys_content_t /var/www/html/gbrowse/tmp
/usr/bin/chcon: can't apply partial context to unlabeled file /var/www/html/gbrowse/tmp/yeast_chr1

About my comment about the man page: I was just saying that it doesn't
say much about what options are available (like how would I know I need
to use 'httpd_sys_content_t'?)  I'm guessing this is further documented
somewhere else.

Thanks,
Scott

On Thu, 2005-02-03 at 10:59 -0500, Daniel J Walsh wrote:
> Scott Cain wrote:
> 
> >On Thu, 2005-02-03 at 10:35 -0500, Daniel J Walsh wrote:
> >  
> >
> >>No but you could just change the context of tmp to httpd_sys_content_t
> >>
> >>chcon -R httpd_sys_content_t /var/www/html/gbrowse/tmp
> >>
> >>Which should fix it. 
> >>
> >>    
> >>
> >
> >
> >[scott@localhost gbrowse]$ sudo chcon -R httpd_sys_content_t /var/www/html/gbrowse/tmp
> >/usr/bin/chcon: invalid context: httpd_sys_content_t
> >
> >Is there a typo in there somewhere?  Also, is this documented somewhere?
> >`man` and `info` are particularly terse and not very helpful.
> >
> >Thanks,
> >Scott
> >
> >
> >  
> >
> Oops
> chcon -R -t httpd_sys_content_t /var/www/html/gbrowse/tmp
> 
> There should be a man page, there is one on my machine
> 
> 
> plain text document attachment (chcon)
> CHCON(1)			User Commands			     CHCON(1)
> 
> 
> 
> NAME
>        chcon - change security context
> 
> SYNOPSIS
>        chcon [OPTION]... CONTEXT FILE...
>        chcon [OPTION]... --reference=RFILE FILE...
> 
> DESCRIPTION
>        Change the security context of each FILE to CONTEXT.
> 
>        -c, --changes
> 	      like verbose but report only when a change is made
> 
>        -h, --no-dereference
> 	      affect symbolic links instead of any referenced file (available
> 	      only on systems with lchown system call)
> 
>        -f, --silent, --quiet
> 	      suppress most error messages
> 
>        -l, --range
> 	      set range RANGE in the target security context
> 
>        --reference=RFILE
> 	      use RFILE’s context instead of using a CONTEXT value
> 
>        -R, --recursive
> 	      change files and directories recursively
> 
>        -r, --role
> 	      set role ROLE in the target security context
> 
>        -t, --type
> 	      set type TYPE in the target security context
> 
>        -u, --user
> 	      set user USER in the target security context
> 
>        -v, --verbose
> 	      output a diagnostic for every file processed
> 
>        --help display this help and exit
> 
>        --version
> 	      output version information and exit
> 
> REPORTING BUGS
>        Report bugs to <email@host.com>.
> 
> SEE ALSO
>        The full documentation for chcon is maintained as  a  Texinfo  manual.
>        If  the	info  and chcon programs are properly installed at your site,
>        the command
> 
> 	      info chcon
> 
>        should give you access to the complete manual.
> 
> 
> 
> chcon (coreutils) 5.0		  July 2003			     CHCON(1)
-- 
------------------------------------------------------------------------
Scott Cain, Ph. D.                                         cain@cshl.org
GMOD Coordinator (http://www.gmod.org/)                     216-392-3087
Cold Spring Harbor Laboratory


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
