Date: Mon, 2 Apr 2001 09:43:51 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: David Chatterton <david.chatterton@adacel.com.au>
cc: SELinux@tycho.nsa.gov
Subject: Re: Support for multiple SELinux hosts
In-Reply-To: <000b01c0ba6f$9f26a4e0$e8022dcb@stratos.vic.bigpond.net.au>
Message-ID: <Pine.SOL.3.95.1010402092709.29296C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Yes, as you said, there is currently no support for the 
translation or transportation of security contexts between 
two SELinux hosts.  The plan is to integrate the existing
network mandatory access controls with the FreeSWAN 
IPSEC implementation to provide packet labeling and 
protection across the network.  Similar work was done
in the Flask and DTOS prototypes that preceded SELinux.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
