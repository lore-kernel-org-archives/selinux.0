Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n66Hp40a031113
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 13:51:04 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n66Hpho3001124
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 17:51:44 GMT
Message-ID: <4A523934.3030100@manicmethod.com>
Date: Mon, 06 Jul 2009 13:49:40 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Christopher Pardy <cpardy@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [Patch 3/2] semodule: maintain old functionality
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>	 <4A4C17D1.3060208@redhat.com>	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CBC6C.5090709@redhat.com>	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CC469.3050805@redhat.com>	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CD320.2090706@redhat.com>	 <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>	 <4A51ED89.8010001@redhat.com>  <4A51EEA5.4070802@redhat.com>	 <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil> <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil> <4A520D47.4040708@redhat.com> <4A52100C.3010302@redhat.com> <4A523752.5000404@redhat.com>
In-Reply-To: <4A523752.5000404@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher Pardy wrote:
> Patch for semodule command
> semodule -B
> Will now turn on dontaudit rules
> semodule -DB
> Will turn off dontaudit rules.
> With other patch all other semanage commands will maintain state.
>
> Created by Dan Walsh
>
> Signed-off-by: Christopher Pardy<cpardy@redhat.com>
> ---
>   semodule/semodule.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff -up policycoreutils-2.0.64/semodule/semodule.c~ policycoreutils-2.0.64/semodule/semodule.c
> --- policycoreutils-2.0.64/semodule/semodule.c~	2009-06-23 15:36:25.000000000 -0400
> +++ policycoreutils-2.0.64/semodule/semodule.c	2009-07-01 13:34:42.027229000 -0400
> @@ -417,8 +418,10 @@ int main(int argc, char *argv[])
>   			printf("Committing changes:\n");
>   		if (no_reload)
>   			semanage_set_reload(sh, 0);
> -		if (build)
> +		if (build) {
> +			semanage_set_disable_dontaudit(sh, 0);
>   			semanage_set_rebuild(sh, 1);
> +		}
>   		if (disable_dontaudit)
>   			semanage_set_disable_dontaudit(sh, 1);
>   		result = semanage_commit(sh);

I don't like this, it is non-obvious. Eg., if set dontaudit and rebuild it will 
first set disable_dontaudit to 0 and then immediately after set it to 1. Can you 
rework these if statements to make it more obvious what is going on?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
