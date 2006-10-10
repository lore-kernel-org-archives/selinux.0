Subject: Re: PATCH: fix memory leaks in matchpathcon.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Todd.Miller@sparta.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <E0ADF7C3-6BA3-40B0-9CD9-B24339135AF4@sparta.com>
References: <E0ADF7C3-6BA3-40B0-9CD9-B24339135AF4@sparta.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 09:59:01 -0400
Message-Id: <1160488741.16807.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-09 at 13:18 -0400, Todd Miller wrote:
> The process_line() function does not clean up correctly on early  
> return in all cases.
> This diff does two things:
> 
>   1) replaces usage of the non-standard %as scanf() format (which  
> conflicts with C99)
>        with simple strtok().  This does mean that line_buf is  
> modified but this variable is
>        only used as an argument to process_line() and is then freed.

strtok should not be used in library code (compare with strtok_r,
already in use within libselinux).

>   2) adds a finish: label and ret variable that holds the return  
> value.  Instead of
>        returning early we just goto finish and let it clean things up  
> as needed.  This
>        does assume that free(NULL) is valid but that as been the case  
> since C89.
> 
> As far as the memory leaks go, #2 is the important part.  I needed #1  
> for our
> port of libselinux to FreeBSD and Darwin.
> 
>   - todd
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
