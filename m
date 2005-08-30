Message-ID: <43148322.5030201@redhat.com>
Date: Tue, 30 Aug 2005 12:02:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Another place where policy blows up because of translations in MCS.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

/usr/bin/checkpolicy -M -o policy.20 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 20) to 
policy.20
Validating file contexts files ...
/usr/sbin/setfiles -q -c policy.20 file_contexts/file_contexts
libsepol.sepol_ctx_struct_create: mls is enabled, but no mls context found
libsepol.sepol_ctx_struct_create: error creating context structure
libsepol.sepol_ctx_struct_from_string: unable to create context structure
libsepol.sepol_context_to_sid: could not convert 
system_u:object_r:default_t to sid
file_contexts/file_contexts:  line 155 has invalid context 
system_u:object_r:default_t
make: *** [policy.20] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.74451 (%build)

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
