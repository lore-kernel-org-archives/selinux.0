Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2S1BBDo022289
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 20:11:11 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2S1AR7X009219
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 01:10:27 GMT
Subject: Re: [ PATCH ] X clients cleanup patch #2
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1111972339.1119.8.camel@cobra.ivg2.net>
References: <1111972339.1119.8.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Sun, 27 Mar 2005 20:16:01 -0500
Message-Id: <1111972562.1119.12.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-03-27 at 20:12 -0500, Ivan Gyurdiev wrote:
> This continues to remove stuff out of x_client_macros.
> Again, the purpose of this is to decouple functionality
> that does not always go together, and to transition from
> a base-domain style macro (which we already have) to the bare
> minimum required to communicate with X. The changelog is
> rather large, but it's mostly because I'm trying to keep 
> track of what's changed very closely. I've tested the five
> x clients for damage.

Question 1: X has the following rules:

allow $1_$2_t self:unix_dgram_socket create_socket_perms;
allow $1_$2_t self:unix_stream_socket { connectto
create_stream_socket_perms };

Removing them seems to affect most (all?) X clients.
Are those related to establishing a connection to X,
or are they just common frequently used rules?

Question 2: 

games, mozilla, and gift want to read /etc/mtab, and /etc/nsswitch.conf.
Why is that neessary, and do those rules always go together?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
