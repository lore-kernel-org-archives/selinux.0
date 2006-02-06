Subject: Re: initrc_t has no execmod in targeted policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vladimir Simonov <Vladimir.Simonov@acronis.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43E6FBD2.5040207@acronis.com>
References: <43E6FBD2.5040207@acronis.com>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 09:11:06 -0500
Message-Id: <1139235066.31135.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-06 at 10:33 +0300, Vladimir Simonov wrote:
> Hi all,
> 
> Trying to launch my network daemon fron init.d on
> Fedora Core 4 I see "avc:  denied  { execmod } ..."
> in audit.log. The daemon loads some shared libraries
> via dlopen. If I guessed right, code relocation at load
> time modifies code segment and violates "no execmod
> for initrc_t" rile.
> 
> The questions:
> 1. Is my guess correct?

execmod usually indicates a text relocation, which reflects a problem in
the DSO that should be fixed if possible.  See:
http://people.redhat.com/drepper/selinux-mem.html
http://people.redhat.com/drepper/dsohowto.pdf

> 2. If yes, should it be considered as policy drawback
> (FC4 uses policy.19) or I'm missing something?

No, certainly not for initrc_t, as you shouldn't run your daemon
directly in that domain anyway.

> 3. How to add execmod to system_u:system_r:initrc_t
> type without full policy rebuild?

You don't want to do that - you want to define a new domain for your
daemon (or if it has the same security requirements as a daemon that
already has policy and you don't care about separating them, you could
just label it with the same entrypoint type).  

On FC4, you still have to install the policy sources package, add your
files defining your own rules, and rebuild the entire binary policy.
The modular policy support is coming in FC5.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
