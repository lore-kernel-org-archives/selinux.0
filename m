Message-ID: <4203C9D7.5050306@redhat.com>
Date: Fri, 04 Feb 2005 14:15:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Java Policy
References: <4203B048.5070607@redhat.com>	 <1107538571.8078.98.camel@moss-spartans.epoch.ncsc.mil>	 <4203C18F.8030609@redhat.com> <1107543502.8078.136.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1107543502.8078.136.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added to global_macros

# Define legacy_domain  for legacy binaries (java)
# "legacy" binary == lacks PT_GNU_STACK header, i.e. built with an old
# toolchain.  They cause the kernel to automatically start translating all
# read protection requests to read|execute for backward compatibility on
# x86.  They will all need execmem and execmod, including execmod to
# shlib_t and ld_so_t unlike non-legacy binaries.

define(`legacy_domain', `
bool allow_$1_legacy false;
if (allow_$1_legacy && allow_execmem) {
allow $1_t self:process { execmem };
}
if (allow_$1_legacy && allow_execmod) {
#Required when starting with /lib/tls/libc-
allow $1_t { texrel_shlib_t shlib_t }:file execmod;
allow $1_t ld_so_t:file execmod;
}
')
Java_macro now calls
legacy_domain($2_java)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
