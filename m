Message-ID: <526A9AB8.8060204@tycho.nsa.gov>
Date: Fri, 25 Oct 2013 12:22:16 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: hoefer@ieee.org
CC: Don Hoefer <don.hoefer@verizon.net>, selinux@tycho.nsa.gov
Subject: Re: Need information on building embedded systems.
References: <6904957.313951.1382641486454.JavaMail.root@vms170025>
In-Reply-To: <6904957.313951.1382641486454.JavaMail.root@vms170025>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/24/2013 03:04 PM, Don Hoefer wrote:
>  Here is a complete list of what we are working with. the processor is a Freescale PowerPC.
> 
> 
> 
<snip>
> libselinux:  2.1.9
> checkpolicy:  2.1.8
> libsepol:  2.1.4
> policycoreutils:  2.1.10
<snip>

Are you using those specific versions because newer ones have
dependencies on components that don't exist in your embedded Linux?
That's ok, just wondering.

The folks who previously did work on embedded SELinux prior to our
Android work tried to introduce an EMBEDDED option for libselinux (make
EMBEDDED=y) that would omit certain portions they didn't need or want.
That is still present but likely won't build at the moment; you'd have
to exclude some additional files as well to get it back into a buildable
state.

Or you could possibly just use our Android port of libselinux, as that
is already greatly reduced and avoids any glibc-specific dependencies.

checkpolicy and libsepol are only truly required on the build host, not
the device, unless you need/want the ability to downgrade policy formats
at load time.

The parts of policycoreutils that matter to you should already exist in
some form in busybox if you build it with SELinux support enabled



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
