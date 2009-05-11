Subject: Re: EOF missing newline bug in squid.fc / toolchain
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <selinux@tycho.nsa.gov>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <4A04BCDC.2020106@tycho.nsa.gov>
References: <4A04BCDC.2020106@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 11 May 2009 08:45:42 -0400
Message-Id: <1242045942.5102.10.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-05-08 at 19:14 -0400, Eamon Walsh wrote:
> The file squid.fc in refpolicy has no newline at the end.
> 
> The toolchain doesn't correct for this, and squid.pp retains the missing
> newline, all the way to the finished file_contexts where I'm ending up with
> /var/squidGuard(/.*)?   system_u:object_r:squid_cache_t:s0#
> 
> (an empty comment line got mashed on), and setfiles verification fails
> with invalid MLS field.

I fixed this in refpolicy trunk.  I'll look into making sure there is an
extra endline at the end of file contexts when building a module.
However, the toolchain should probably add a newline between each of the
modules' file contexts when they're concatenated, since it isn't
required to use refpolicy infrastructure to build .pp's.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
