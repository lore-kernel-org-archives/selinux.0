Subject: Re: selinux_file_context_verify function returns wrong value.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <248378.46713.qm@web87007.mail.ird.yahoo.com>
References: <248378.46713.qm@web87007.mail.ird.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Feb 2011 13:25:04 -0500
Message-ID: <1297880704.27031.60.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 15:56 +0000, Richard Haines wrote:
> The selinux_file_context_verify seems to return the wrong value when I
> know the context of the file and that in the file_contexts file are
> the same (returns '1' but according to man page should be '0').
>  
> Looking at the libselinux source code (matchpathcon.c) the line:
>  
>        rc = (selinux_file_context_cmp(fcontext, con) == 0);
>  
> seems the problem.
>  
> I'm using libselinux 2.0.96
>  
> So should it return 0 on match, 1 if contexts are different (or if the
> file / file_contexts entries do not exist) and -1 on error.
>  
> And just to clarify the selinux_file_context_cmp function return
> values:
>  
>      Should it return 0 on match (after the 'user:' portion), 1 if
> contexts do not match and -1 on error.
>  
> Thanks
> Richard
>  

Looks like a bug in the man page, combined with inconsistent return
values on certain error paths within the code.  It looks like the intent
was for selinux_file_context_verify() to return 1 if they match, 0 if
they do not match, and -1 on error.  However:
a) that isn't what the man page says,
b) there is some special case handling of ENOTSUP and ENOENT internally
that looks suspect to me, and
c) utils/matchpathcon.c doesn't check for < 0

selinux_file_context_cmp is a bit simpler - it just follows strcmp
conventions, i.e. -1 for "less than", 0 for equal, and 1 for "greater
than".

Dan?


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
