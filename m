Date: Thu, 4 Oct 2001 09:07:55 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: sunil <sunil@liqwidkrystal.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Question about SELinux
In-Reply-To: <000501c14ccf$fe1031e0$5d01a8c0@liqwidkrystal.com>
Message-ID: <Pine.GSO.4.33.0110040905580.7555-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 4 Oct 2001, sunil wrote:

> 2. The users should be able to run only well-behaved programs on the server.
>      A well-behaved program would be one that uses reasonable amounts of
> CPU,
>     disk, network and memory resources and does not try to compromise the
> security of the system.
>     Therefore, malicious programs of any kind should be quietly terminated.

SELinux provides flexible and fine-grained nondiscretionary access controls,
so you can use it to provide separation and confinement of these untrusted
users and their programs.  However, SELinux does not currently provide any
additional controls over resource usage beyond what is already present in
Linux.  Also, the SELinux access controls don't terminate processes that
violate the policy - they merely deny access and optionally audit such
access denials.  Of course, this may yield the same effect in many cases,
since many programs simply exit upon error.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
