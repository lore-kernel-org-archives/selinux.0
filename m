Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBHN8ZIi005412
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 18:08:35 -0500 (EST)
Received: from hawaii.grays-systems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBHN8biS005617
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 23:08:37 GMT
Received: (from nick@localhost)
	by hawaii.grays-systems.com (8.13.1/8.13.1/Submit) id iBHN8acx030872
	for selinux@tycho.nsa.gov; Fri, 17 Dec 2004 17:08:36 -0600
Subject: Question regarding port usage in respect to the tomcat policy
From: Nick Gray <nick-lists@austin.rr.com>
To: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 17 Dec 2004 17:08:35 -0600
Message-Id: <1103324915.32688.97.camel@hawaii.grays-systems.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In net_contexts I found this

ifdef(`use_http_cache', `
portcon tcp 3128  system_u:object_r:http_cache_port_t
portcon tcp 8080  system_u:object_r:http_cache_port_t
portcon udp 3130  system_u:object_r:http_cache_port_t
')

I needed 8080 for my tomcat tests so I stole it
by taking it out and creating my own


ifdef(`tomcat.te', `
portcon tcp 8080  system_u:object_r:tomcat_port_t
')

And I added this to the tomcat.te

allow tomcat_t tomcat_port_t:tcp_socket name_bind;

The question is why can I access port 8443 as well?

**

I think I figured it out. While doing the start/fix/restart, I found
that I needed this line as well (probably when I tried to access 8443)

allow tomcat_t port_t:tcp_socket name_bind;

So I am guessing that anything not labeled specifically must belong to
this type.

Nix


-- 
Nick Gray
Senior Systems Engineer
Bruzenak Inc
Office: 512-331-7998
Cell: 512-630-7009

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
