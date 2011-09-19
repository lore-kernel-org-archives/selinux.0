Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8J0mcER010033
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2011 20:48:38 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8J0mbwY003153
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2011 00:48:37 GMT
Subject: Re: [RFC 2/2] refpolicy: add systemd support to tresys main policy.
From: Guido Trentalancia <guido@trentalancia.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov, dwalsh@redhat.com
Date: Mon, 19 Sep 2011 02:41:58 +0200
In-Reply-To: <1316366988-3882-2-git-send-email-justinmattock@gmail.com>
References: <1316366988-3882-1-git-send-email-justinmattock@gmail.com>
	 <1316366988-3882-2-git-send-email-justinmattock@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316392918.2258.57.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Justin.

Here is the boolean you were looking for (quoted from your patch):

On Sun, 2011-09-18 at 10:29 -0700, Justin P. Mattock wrote:
> diff --git a/policy/modules/system/init.te
> b/policy/modules/system/init.te
> index 5125d1d..6fcc939 100644
> --- a/policy/modules/system/init.te
> +++ b/policy/modules/system/init.te
> @@ -16,6 +16,13 @@ gen_require(`
>  ## </desc>
>  gen_tunable(init_upstart, false)
>  
> +## <desc>
> +## <p>
> +## Enable support for systemd as the init program.
> +## </p>
> +## </desc>
> +gen_tunable(init_systemd, false) 

But please note it's disabled (false) by default. So you do need to make
sure it is enabled after having installed and loaded the policy, do not
forget:

setsebool -P init_systemd=on

After such boolean has been enabled, then all policy blocks that begin
with:

+       tunable_policy(`init_systemd',`

will eventually get included in the policy. Those are supposedly all
essential permissions needed to successfully run a system using systemd.

If you managed to create a patch which applies and compiles cleanly,
perhaps most of the job is done and you might only need to fine tune it.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
