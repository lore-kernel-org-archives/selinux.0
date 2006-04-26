Subject: Re: getfscreatecon(3)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200604261337.50730.russell@coker.com.au>
References: <200604261337.50730.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 07:44:19 -0400
Message-Id: <1146051859.28745.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-04-26 at 13:37 +1000, Russell Coker wrote:
> RETURN VALUE
>        On error -1 is returned.
> 
>        On success getfscreatecon  returns  the  length  of  the  context  (not
>        including  the  trailing zero byte).  On success setfscreatecon returns
>        0.
> 
> 
> Currently getfscreatecon() returns 0 on success.  Should we change the man 
> page or change the library?
> 
> I think that it would be best to change the library.

The man page should be fixed.  Or you'd have to change all of the
process-oriented get*con functions.  As the string is NUL-terminated,
you don't need the length.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
