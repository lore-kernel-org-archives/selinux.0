Subject: Re: Kernel Panic after Kernel Upgrade
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Moises Mojica <moises.mojica@gmail.com>
Cc: James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <8c3441240606070823y7ff37503ub138fe627c444e57@mail.gmail.com>
References: <8c3441240606070823y7ff37503ub138fe627c444e57@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 09:43:41 -0400
Message-Id: <1150119821.8086.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-07 at 11:23 -0400, Moises Mojica wrote:
> Hi,
>  
> 
> I have a newly installed version of SELinux (2.6..9-34.EL) which works
> fine but I also have a need to develop an NATH323 gatekeeper solution
> and in order to accomplish this I must upgrade the kernel to 2.6.16.20
> and enable the NATH323 module but after compiling and installing the
> new kernel I am unable to boot from it do to a kernel panic.

That is because 2.6.16 expects a newer SELinux policy version than what
is shipped in RHEL4, so /sbin/init is failing to load policy and
aborting.  So if you want to run with SELinux enabled using that newer
kernel, you need to upgrade your policy toolchain (libsepol/checkpolicy)
and policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
