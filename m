Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9B6a7T1009741
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 02:36:08 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9B6Yq2q022434
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 06:34:52 GMT
Message-ID: <452C90C9.7020009@gentoo.org>
Date: Wed, 11 Oct 2006 02:35:53 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Todd Miller <Todd.Miller@sparta.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: PATCH: fix memory leaks in matchpathcon.c
References: <E0ADF7C3-6BA3-40B0-9CD9-B24339135AF4@sparta.com>
In-Reply-To: <E0ADF7C3-6BA3-40B0-9CD9-B24339135AF4@sparta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> The process_line() function does not clean up correctly on early 
> return in all cases.
> This diff does two things:
>
>  1) replaces usage of the non-standard %as scanf() format (which 
> conflicts with C99)
>       with simple strtok().  This does mean that line_buf is modified 
> but this variable is
>       only used as an argument to process_line() and is then freed.
>
>  2) adds a finish: label and ret variable that holds the return 
> value.  Instead of
>       returning early we just goto finish and let it clean things up 
> as needed.  This
>       does assume that free(NULL) is valid but that as been the case 
> since C89.
>
> As far as the memory leaks go, #2 is the important part.  I needed #1 
> for our
> port of libselinux to FreeBSD and Darwin.

Can you please split this patch into a bugfix patch (for the memory 
leak) and a patch to remove the non-standard formats?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
