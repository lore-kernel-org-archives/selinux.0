Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB2HmtIi003313
	for <selinux@tycho.nsa.gov>; Thu, 2 Dec 2004 12:48:55 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB2HlLSK023187
	for <selinux@tycho.nsa.gov>; Thu, 2 Dec 2004 17:47:21 GMT
Subject: Re: Reissue previous patch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41AF23B0.4020100@redhat.com>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
	 <4192A029.5050909@redhat.com>
	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
	 <419CB2A8.7020504@redhat.com>
	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
	 <41A4B54F.3070709@redhat.com>
	 <1101325733.12859.37.camel@moss-lions.epoch.ncsc.mil>
	 <41ACE3E6.5030801@redhat.com>
	 <1101995669.8032.20.camel@moss-lions.epoch.ncsc.mil>
	 <41AF23B0.4020100@redhat.com>
Content-Type: text/plain
Message-Id: <1102009880.8372.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Dec 2004 12:51:20 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-02 at 09:16, Daniel J Walsh wrote:
> James Carter wrote:
> 
<snip>
> >>diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.19.7/macros/program/ssh_macros.te
> >>--- nsapolicy/macros/program/ssh_macros.te	2004-11-30 05:59:40.000000000 -0500
> >>+++ policy-1.19.7/macros/program/ssh_macros.te	2004-11-30 06:18:45.000000000 -0500
> >>@@ -82,7 +82,7 @@
> >> 
> >> # Grant permissions needed to create TCP and UDP sockets and
> >> # to access the network.
> >>-can_network($1_ssh_t)
> >>+can_network_client_tcp($1_ssh_t)
> >> can_ypbind($1_ssh_t)
> >> 
> >> # Use capabilities.
> >>    
> >>
> >
> >I used can_network_client() instead.
> >
> >The following was needed by ssh during my normal usage of it (like
> >updating the CVS tree on sourceforge.)
> >
> >allow user_ssh_t self:udp_socket create
> >
> >  
> >
> I think this is caused by the resolver.  This is why I would like to get 
> to the point of using
> can_resolve() where we specify the exact port that you can connect to.

You're right.  I changed it to use can_network_client_tcp() and
can_resolve().

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
