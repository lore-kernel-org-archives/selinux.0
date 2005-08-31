Subject: Re: Another place where policy blows up because of translations in
	MCS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1125493031.18888.238.camel@moss-spartans.epoch.ncsc.mil>
References: <43148322.5030201@redhat.com>
	 <1125418171.18888.138.camel@moss-spartans.epoch.ncsc.mil>
	 <4314958B.5000602@redhat.com>
	 <1125493031.18888.238.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 10:08:16 -0400
Message-Id: <1125497296.18888.287.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-31 at 08:57 -0400, Stephen Smalley wrote:
> Ok, you are correct - matchpathcon_init is calling the invalidcon
> callback with the translated context, and setfiles' invalidcon function
> is then invoking sepol_check_context when checking a file_contexts file
> against a binary policy file.  Since libsepol isn't translation-aware,
> it needs a raw context instead.  Options seem to be:
> - Change setfiles to invoke the libsetrans functions to translate to a
> raw context prior to calling libsepol, or

Note that we wouldn't want to require setfiles to link against
libsetrans, as there is no upstream libsetrans and it is optional.
Hence, either setfiles would need to dlopen libsetrans in the same
manner as libselinux to access the translation functions or libselinux
needs to export wrapper functions for the translation functions it has
already looked up from libsetrans.  The latter seems simpler, but
requires that we add such functions to libselinux that are exported and
have proper namespace prefixes, unlike the hidden
trans_to_raw_context/raw_to_trans_context functions.  The exported
functions would also need to internally check the context_translations
flag unlike the current trans_to_raw_context/raw_to_trans_context
functions.

> - Make libsepol translation-aware.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
