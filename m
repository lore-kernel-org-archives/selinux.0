Subject: Re: Another place where policy blows up because of translations in
	MCS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43148322.5030201@redhat.com>
References: <43148322.5030201@redhat.com>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 12:09:31 -0400
Message-Id: <1125418171.18888.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-30 at 12:02 -0400, Daniel J Walsh wrote:
> /usr/bin/checkpolicy -M -o policy.20 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 20) to 
> policy.20
> Validating file contexts files ...
> /usr/sbin/setfiles -q -c policy.20 file_contexts/file_contexts
> libsepol.sepol_ctx_struct_create: mls is enabled, but no mls context found
> libsepol.sepol_ctx_struct_create: error creating context structure
> libsepol.sepol_ctx_struct_from_string: unable to create context structure
> libsepol.sepol_context_to_sid: could not convert 
> system_u:object_r:default_t to sid
> file_contexts/file_contexts:  line 155 has invalid context 
> system_u:object_r:default_t
> make: *** [policy.20] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.74451 (%build)

That looks correct to me.  file_contexts for MCS should include the s0
component.  The goal wasn't to allow you to ship policy without MLS
fields, just to not require a complete relabeling of the filesystem upon
an upgrade from non-MLS to MLS/MCS.

A while back, I added the 'make mlsconvert' target to the policy
Makefile to allow simple conversion to a MLS enabled policy from the
example policy.

On a different note, is anyone working on kernel patch to cause SELinux
to set the on-disk xattr to be consistent with the incore inode security
label when it lacks the MLS field, so that getxattr will subsequently
return the right value?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
