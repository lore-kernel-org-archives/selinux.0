Date: Wed, 16 Jan 2002 15:05:54 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: trace call path
In-Reply-To: <3C45CA77.8060609@pcez.com>
Message-ID: <Pine.GSO.4.33.0201161503010.7787-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 16 Jan 2002, Shaun Savage wrote:

> I have also added "role sysadm_t types { ipchains_t}; "

I assume that you mean 'role sysadm_r types { ipchains_t };'.
If not, then this is the error.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
