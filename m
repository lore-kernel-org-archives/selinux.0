Date: Mon, 3 Dec 2001 10:07:13 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Grant Bayley <gbayley@ausmac.net>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: have you seen spfx2.c?
In-Reply-To: <Pine.BSO.4.33.0112021406500.3173-100000@ausmac.net>
Message-ID: <Pine.GSO.4.33.0112030953040.4293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 2 Dec 2001, Grant Bayley wrote:

> What I don't understand with Linux users is the endless desire to
> prevent broken things by patching around them in the kernel.
>
> Why not concentrate on cleaning up the userland apps in Linux in such a
> way that they're not overflowable in the first place?
>
> No broken [suid | sgid | priviliged uid daemon ] userland apps means you
> have a substantially better chance of keeping a system secure without all
> the sleight of hand that lkms typically pull to prevent something bad from
> happening.

It sounds like you are also arguing against the approach of SELinux, which
adds mandatory access controls to the kernel that can confine user
programs and system servers to the minimum amount of privilege they
require to do their jobs.  While it is certainly good to work on
eliminating flaws from privileged applications, you're unlikely to
eliminate all of the flaws in all of the privileged applications for all
time.  Without mandatory access controls in the kernel, flawed
applications will still be able to easily cause failures in system
security.  Additionally, eliminating flaws from privileged applications
doesn't help with other problems solved by mandatory access controls,
e.g. confining malicious code, providing strong separation of processes
and data based on confidentiality and integrity requirements, protecting
applications against bypass or tampering.

The need for MAC is discussed further in the published papers about
SELinux and the background papers, all available on the web site.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
