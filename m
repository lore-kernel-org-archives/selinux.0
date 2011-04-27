Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3REn54I000338
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 10:49:05 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p3REn5fC024138
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 14:49:05 GMT
Message-ID: <4DB82CE0.9030903@tresys.com>
Date: Wed, 27 Apr 2011 10:49:04 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Elia Pinto <andronicus.spiros@gmail.com>
CC: selinux@tycho.nsa.gov, Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] fix description of init_system_domain in init.if
References: <1303914179-527553-1-git-send-email-andronicus.spiros@gmail.com>
In-Reply-To: <1303914179-527553-1-git-send-email-andronicus.spiros@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/27/11 10:22, Elia Pinto wrote:
> From: Elia Pinto <gitter.spiros@gmail.com>
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  Changelog                     |    2 ++
>  policy/modules/system/init.if |    2 +-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/Changelog b/Changelog
> index 99e8f45..e385097 100644
> --- a/Changelog
> +++ b/Changelog
> @@ -1,3 +1,5 @@
> +- Fix policy/modules/system/init.if init_system_domain description from 
> +  Elia Pinto.
>  - Postgresql selabel_lookup update from KaiGai Kohei.
>  - Dovecot managesieve support from Mika Pfluger.
>  - Semicolon after interface/template calls cleanup from Elia Pinto.

Please don't update the changelog.  It might have changed between the
time you created the patch and when it was committed.

> diff --git a/policy/modules/system/init.if b/policy/modules/system/init.if
> index cc83689..6553873 100644
> --- a/policy/modules/system/init.if
> +++ b/policy/modules/system/init.if
> @@ -304,7 +304,7 @@ interface(`init_ranged_daemon_domain',`
>  ## </summary>
>  ## <desc>
>  ##	<p>
> -##	Create a domain for long running processes (daemons/services)
> +##	Create a domain for short running processes (daemons/services)
>  ##	which are started by init scripts. These are generally applications that
>  ##	are used to initialize the system during boot.
>  ##	Long running processes

While you're right that it is for short running processes,
daemons/services aren't short running processes, so that part should be
removed.  I have manually fixed the description.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
