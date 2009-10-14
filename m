Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9E7iwLD003221
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 03:44:58 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9E7i6Ba018531
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 07:44:06 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n9E7dKoB029441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 02:39:22 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n9E7YxNl006285
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 02:35:00 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] restorecond: Ignore IN_IGNORED inotify events
References: <4ABB86EB.3050909@martinorr.name>
Date: Wed, 14 Oct 2009 02:34:59 -0500
In-Reply-To: <4ABB86EB.3050909@martinorr.name> (Martin Orr's message of "Thu,
	24 Sep 2009 15:49:15 +0100")
Message-ID: <87d44qpgws.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 24 2009, Martin Orr wrote:

> With kernel 2.6.31, restorecond uses 99% of my CPU.
>
> This is because removing and readding the watch on utmp triggers inotify to
> return an IN_IGNORED event for the old watch descriptor.  If the watch gets
> allocated the same wd when it is readded, then restorecond thinks that utmp
> has changed, so removes and readds the watch again, potentially looping.
>
> With kernel <= 2.6.30, this never happened, because the kernel didn't reuse
> watch descriptors.  So the IN_IGNORED event comes with a wd that is no
> longer in use, and gets ignored.  But kernel 2.6.31 reuses the same watch
> descriptor.
>
> This patch fixes that by ignoring inotify events whose only bit set is
> IN_IGNORED.
>
> Note: it is not clear to me why it is necessary to remove and readd the
> watch in the first place.
>
> Note for testing: you need to log in (to cause a change in utmp) after
> starting restorecond to trigger the bug.  In fact you need to log in twice
> before the kernel reuses a watch descriptor.

	I can confirm seeing this behaviour, and that the patch fixed
 the problem for me.

        manoj

Tested-by: Manoj Srivastava <srivasta@debian.org>


> ---
>  policycoreutils/restorecond/restorecond.c |   29 ++++++++++++++++-------------
>  1 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/policycoreutils/restorecond/restorecond.c
> b/policycoreutils/restorecond/restorecond.c
> index 58774e6..4952632 100644
> --- a/policycoreutils/restorecond/restorecond.c
> +++ b/policycoreutils/restorecond/restorecond.c
> @@ -315,21 +315,24 @@ static int watch(int fd)
>  			printf("wd=%d mask=%u cookie=%u len=%u\n",
>  			       event->wd, event->mask,
>  			       event->cookie, event->len);
> -		if (event->wd == master_wd)
> -			read_config(fd);
> -		else {
> -			switch (utmpwatcher_handle(fd, event->wd)) {
> -			case -1:	/* Message was not for utmpwatcher */
> -				if (event->len)
> -					watch_list_find(event->wd, event->name);
> -				break;
>
> -			case 1:	/* utmp has changed need to reload */
> +		if (event->mask & ~IN_IGNORED) {
> +			if (event->wd == master_wd)
>  				read_config(fd);
> -				break;
> -
> -			default:	/* No users logged in or out */
> -				break;
> +			else {
> +				switch (utmpwatcher_handle(fd, event->wd)) {
> +				case -1:	/* Message was not for utmpwatcher */
> +					if (event->len)
> +						watch_list_find(event->wd, event->name);
> +					break;
> +
> +				case 1:	/* utmp has changed need to reload */
> +					read_config(fd);
> +					break;
> +
> +				default:	/* No users logged in or out */
> +					break;
> +				}
>  			}
>  		}

-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
