Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBI9xKIi007329
	for <selinux@tycho.nsa.gov>; Sat, 18 Dec 2004 04:59:20 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBI9vaPa023409
	for <selinux@tycho.nsa.gov>; Sat, 18 Dec 2004 09:57:37 GMT
Message-ID: <41C3FF6A.8000405@redhat.com>
Date: Sat, 18 Dec 2004 04:59:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Nick Gray <nick-lists@austin.rr.com>
CC: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Question regarding port usage in respect to the tomcat policy
References: <1103324915.32688.97.camel@hawaii.grays-systems.com>
In-Reply-To: <1103324915.32688.97.camel@hawaii.grays-systems.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick Gray wrote:

>In net_contexts I found this
>
>ifdef(`use_http_cache', `
>portcon tcp 3128  system_u:object_r:http_cache_port_t
>portcon tcp 8080  system_u:object_r:http_cache_port_t
>portcon udp 3130  system_u:object_r:http_cache_port_t
>')
>
>I needed 8080 for my tomcat tests so I stole it
>by taking it out and creating my own
>
>
>ifdef(`tomcat.te', `
>portcon tcp 8080  system_u:object_r:tomcat_port_t
>')
>
>And I added this to the tomcat.te
>
>allow tomcat_t tomcat_port_t:tcp_socket name_bind;
>
>The question is why can I access port 8443 as well?
>
>**
>
>I think I figured it out. While doing the start/fix/restart, I found
>that I needed this line as well (probably when I tried to access 8443)
>
>allow tomcat_t port_t:tcp_socket name_bind;
>  
>
No this says that you can bind to any port.
A better solution would be

ifdef(`tomcat.te', `
portcon tcp 8080  system_u:object_r:tomcat_port_t
portcon tcp 8083  system_u:object_r:tomcat_port_t
')


>So I am guessing that anything not labeled specifically must belong to
>this type.
>
>Nix
>
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
