Date: Fri, 12 Apr 2002 09:12:15 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Sung Kim <hunkim@cse.ucsc.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Compile error with Download 2.4 LSM-based Prototype (stable,
 recommended)
In-Reply-To: <Pine.GSO.4.33.0204120834330.21729-100000@raven>
Message-ID: <Pine.GSO.4.33.0204120910440.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Stephen Smalley wrote:

> You should only have set the Capabilities Support, the IP Networking
> Support, the NSA SELinux Support, and the NSA SELinux Development Module
> security options, as discussed in selinux/README.

Sorry, I omitted the Labeled IP Networking Support and CIPSO/FIPS-188 IP
Options security options.  You can enable those as well if you want to
experiment with the labeled networking support, but keep in mind that
those options are still considered experimental.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
