Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7CDpMrT016694
	for <selinux@tycho.nsa.gov>; Thu, 12 Aug 2004 09:51:22 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7CDoiQo012833
	for <selinux@tycho.nsa.gov>; Thu, 12 Aug 2004 13:50:44 GMT
Subject: Re: network object
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alexis Wagner <venon@fugusec.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <411986C1.3030601@fugusec.net>
References: <411986C1.3030601@fugusec.net>
Content-Type: text/plain
Message-Id: <1092318623.16219.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 09:50:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-10 at 22:38, Alexis Wagner wrote:
> First of all, I have read on the web that network labelling is not 
> supported in kernel 2.6 an higher.  I have also read that it will be 
> possible to reimplement the necessary features using the packet filter.
> Is that true ?

The goal is to provide implicit packet labeling based on IPSEC SA,
rather than explicit labeling ala CIPSO.  The old SELinux included a
CIPSO/FIPS188 explicit packet labeling implementation contributed by
James Morris.  Whether or not implicit packet labeling will be
sufficient has been debated; some believe that explicit labels will
still be desired, so that you can use a single IPSEC SA for a range of
labels and so that packet filters can directly interpret the packet
labels.

> Imagine I want to allow the domain one_t to set up and use  a tcp 
> connection with the domain two_t on node two_t.  
> Is it the correct way to set up the policy ?

We won't truly know until we have the packet labeling mechanism and
permission checks implemented.

>         allow one_t node_two_t:node {node_bind tcp_send tcp_recv};

one_t wouldn't be binding to node_two_t's address.

>        #Wich domain I put here ? 
>         allow one_t ???:tcp_socket {acceptfrom recvfrom } ;

With labeled packets, acceptfrom and connectto could be revived as
socket-to-peersocket permission checks, so if one_t were the client
process domain and two_t were the server process domain, then you would
want:
# Let one_t connect to two_t (client-side check).
allow one_t two_t:tcp_socket connectto;
# Let two_t accept a connection from one_t (server-side check).
allow two_t one_t:tcp_socket acceptfrom;

Note the can_tcp_connect() macro in policy/macros/core_macros.te, a
legacy from the days of labeled packets.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
