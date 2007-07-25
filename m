Subject: RE: using semodule_package
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01FB737E@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01FB6DF2@blums0008.bluelnk.net>
	 <1184156241.3392.41.camel@moss-spartans.epoch.ncsc.mil>
	 <FB39F4E77226B448BC1388D3BE4E00CD01FB737E@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 13:51:46 -0400
Message-Id: <1185385906.12224.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-07-25 at 10:40 -0700, Clarkson, Mike R (US SSA) wrote:
> The manpage for checkmodule shows the following example using a .te
> file:
> 	checkmodule -M -m httpd.te -o httpd.mod
> 
> Is this correct?
> 
> It fails for me with the following error:
> 
> # checkmodule -M -m zebra.te -o zebra.mod
> checkmodule:  loading policy configuration from zebra.te
> (unknown source)::ERROR 'syntax error' at token 'policy_module' on line
> 2:
> policy_module(zebra,1.3.0)
> 
> checkmodule:  error(s) encountered while parsing configuration
> 
> 
> The example below (from Stephen Smalley's below email) uses the .tmp
> file and works:
> 	checkmodule -M -m tmp/zebra.tmp -o tmp/zebra.mod
> 
> 
> Although this successfully creates the zebra.mod file, when I try to use
> the zebra.mod file with semodule_package to create a zebra.pp file, the
> zebra.pp file appears to be invalid. When I try to load the zebra.pp
> file, I get the following error:
> 
> # semodule -i
> /etc/selinux/refpolicy-targeted-mls/src/policy/tmp/zebra.pp
> libsepol.context_from_record: user gen_context(system_u is not defined
> libsepol.context_from_record: could not create context structure
> libsepol.context_from_string: could not create context structure
> libsepol.sepol_context_to_sid: could not convert
> gen_context(system_u:object_r:zebra_conf_t,s0) to sid
> /etc/selinux/refpolicy-targeted-mls/contexts/files/file_contexts:  line
> 398 has invalid context gen_context(system_u:object_r:zebra_conf_t,s0)
> libsemanage.semanage_install_active: setfiles returned error code 1.
> semodule:  Failed!
> 
> I created the zebra.pp file with the following command:
> semodule_package -o zebra.pp -m zebra.mod -f
> ../policy/modules/services/zebra.fc
> 
> The other thing that I notice is that although I made no changes to the
> zebra.fc file (I'm just trying to successfully create a .pp file first),
> the zebra.pp file that the semodule_package cmd creates is not the same
> size as the original zebra.pp file. This happens even when I don't
> include the -f option with the semodule_package command.

The errors you are encountering are because you aren't running your
files through the m4 preprocessor (with appropriate includes) prior to
compiling and/or packaging the files.  At present, SELinux policy makes
heavy use of m4 preprocessing for macro expansion (e.g. policy_module
and gen_context are both macros).

If you had simply done a 'make zebra.pp', the Makefile would have taken
care of preprocessing the files, writing the preprocessed form to
the .tmp files, and then feeding those .tmp files to checkmodule and
semodule_package.  You of course could do the same, but why not just use
make?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
