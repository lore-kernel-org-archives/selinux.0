Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88DmR8h019034
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 09:48:27 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88Dm3X5000248
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 13:48:03 GMT
Subject: Re: [PATCH] policycoreutils semanage for nodes
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Rodrigo Vivi <vivijim@br.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200609051527.41081.vivijim@br.ibm.com>
References: <200609051527.41081.vivijim@br.ibm.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 09:47:08 -0400
Message-Id: <1157723228.21235.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-05 at 15:27 -0300, Rodrigo Vivi wrote:
> Hi all,
> 
> Since libsemanage support node context management and semanage command for 
> policycoreutils does not, I thought that was a good idea to implement this.
> 
> This patch provide all that semanage command needs to manage nodes context.
> (including a man page updated)
> 
> However I know that SECMARK mechanism largely obsoletes the use of
> netif and node contexts going forward, but I did this patch because I was 
> missing the node management at semanage command.
> 

I think that netif and node will be around for a while and node in
particular is useful for bind(2).

> Thanks,
> Rodrigo Vivi.
> (vivijim at #selinux)


> diff -ruN policycoreutils-1.30.26/semanage/semanage
> policycoreutils-dev/semanage/semanage
> --- policycoreutils-1.30.26/semanage/semanage   2006-08-12
> 09:21:39.000000000 -0300
> +++ policycoreutils-dev/semanage/semanage       2006-09-03
> 05:05:41.000000000 -0300
> @@ -41,6 +41,7 @@
>  semanage user -{a|d|m} [-LrRP] selinux_name\n\
>  semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range\n\
>  semanage interface -{a|d|m} [-tr] interface_spec\n\
> +semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr\n\
>  semanage fcontext -{a|d|m} [-frst] file_spec\n\
>  semanage translation -{a|d|m} [-T] level\n\n\
>  \
> @@ -65,7 +66,8 @@
>                 -l (symbolic link) \n\
>                 -p (named pipe) \n\n\
>  \
> -       -p, --proto      Port protocol (tcp or udp)\n\
> +       -p, --protocol   Port protocol (tcp or udp)\n\

Did you mean to make this change? It doesn't appear in the argument
parsing below. Additionally, I don't think that it is a good idea to
change the arguments at this point even if they are better.

Otherwise this looks good - thanks for also making the manpage change.
If you are OK with the change above being dropped I don't think there is
a reason to resubmit.

Acked-by Karl MacMillan <kmacmillan@mentalrootkit.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
