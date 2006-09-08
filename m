Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88Drv8D019228
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 09:53:57 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k88DrBIs009440
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 13:53:11 GMT
Message-ID: <4501762F.9020803@gentoo.org>
Date: Fri, 08 Sep 2006 09:54:55 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Rodrigo Vivi <vivijim@br.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] policycoreutils semanage for nodes
References: <200609051527.41081.vivijim@br.ibm.com>
In-Reply-To: <200609051527.41081.vivijim@br.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rodrigo Vivi wrote:
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
> Thanks,
> Rodrigo Vivi.
> (vivijim at #selinux)
>   
>   
In addition to the comments below, I tried this patch out and while it 
indeed added the nodecon it didn't seem to have a net effect on the 
system. This is probably because of ordering issues which IIRC is why we 
never had this support to begin with.

> ------------------------------------------------------------------------
>
> diff -ruN policycoreutils-1.30.26/semanage/semanage policycoreutils-dev/semanage/semanage
> --- policycoreutils-1.30.26/semanage/semanage	2006-08-12 09:21:39.000000000 -0300
> +++ policycoreutils-dev/semanage/semanage	2006-09-03 05:05:41.000000000 -0300
> @@ -41,6 +41,7 @@
>  semanage user -{a|d|m} [-LrRP] selinux_name\n\
>  semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range\n\
>  semanage interface -{a|d|m} [-tr] interface_spec\n\
> +semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr\n\
>   
what does [ -p protocol ] mean for node? nodecon's don't have protocols

You also didn't add node to the line above these:
semanage {login|user|port|interface|fcontext|translation} -l [-n]
>  semanage fcontext -{a|d|m} [-frst] file_spec\n\
>  semanage translation -{a|d|m} [-T] level\n\n\
>  \
> @@ -65,7 +66,8 @@
>  		-l (symbolic link) \n\
>  		-p (named pipe) \n\n\
>  \
> -	-p, --proto      Port protocol (tcp or udp)\n\
> +	-p, --protocol   Port protocol (tcp or udp)\n\
>   
why change this?
> +        -M, --mask       Netmask\n\
>  	-P, --prefix     Prefix for home directory labeling\n\
>  	-L, --level      Default SELinux Level (MLS/MCS Systems only)\n\
>  	-R, --roles      SELinux Roles (ex: "sysadm_r staff_r")\n\
> @@ -94,7 +96,9 @@
>  		valid_option["port"] = []
>  		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--protocol' ] 
>  		valid_option["interface"] = []
> -		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
> +		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range']
> +                valid_option["node"] = []
> +		valid_option["node"] += valid_everyone + [ '-M', '--mask', '-t', '--type', '-r', '--range', '-p', '--protocol' ]
>   
I don't think protocol is valid for everyone
>  		valid_option["fcontext"] = []
>  		valid_option["fcontext"] += valid_everyone + [ '-f', '--ftype', '-s', '--seuser',  '-t', '--type', '-r', '--range'] 
>   
<snip>
>  		valid_option["translation"] = []
> 			
> +	def list(self, heading = 1):
> +		if heading:
> +			print "%-50s %s\n" % ("SELinux Addr", "Context")
> +		ddict = self.get_all()
> +		keys = ddict.keys()
> +		keys.sort()
> +		if is_mls_enabled:
> +			for k in keys:
> +				print "%-50s %s:%s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2], translate(ddict[k][3], 
I don't think  ddict[k][3] is what you think it is..
> False))
> +		else:
> +			for k in keys:
> +				print "%-50s %s:%s:%s " % (k,ddict[k][0], ddict[k][1],ddict[k][2])
> +
>  			
>  class fcontextRecords(semanageRecords):
>  	def __init__(self):
> @@ -1280,3 +1487,5 @@
>  		for k in keys:
>  			if ddict[k]:
>  				print "%-50s %-18s " % (k[0], ddict[k][0])
> +
> +
>   

whitespace?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
