Message-ID: <1518727655.30922.11.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Aman Sharma <amansh.sharma5@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Date: Thu, 15 Feb 2018 15:47:35 -0500
In-Reply-To: <CAPMH7-_9hM6Kp4DjzLZaAxyxatkrAPqxGV+jBrWdeftkE4xmFw@mail.gmail.com>
References: <CAPMH7-_9hM6Kp4DjzLZaAxyxatkrAPqxGV+jBrWdeftkE4xmFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Facing problem while running the audit2allow command
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2018-02-15 at 10:30 +0530, Aman Sharma wrote:
> Hi All,
> 
> I am getting one issue while running the command audit2allow and
> below is the 
> logs for the same :
> 
> After switching back to lower version, running "audit2allow -a"
> command show below errors repeteadly and the command does not
> return: 
> libsepol.context_from_record: invalid security context:
> "sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023" 
> libsepol.context_from_record: could not create context structure 
> libsepol.context_from_string: could not create context structure 
> libsepol.sepol_context_to_sid: could not convert
> sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023 to sid 
> libsepol.context_from_record: invalid security context:
> "sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023" 
> libsepol.context_from_record: could not create context structure 
> libsepol.context_from_string: could not create context structure 
> libsepol.sepol_context_to_sid: could not convert
> sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023 to sid 
> libsepol.context_from_record: invalid security context:
> "sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023" 
> libsepol.context_from_record: could not create context structure 
> libsepol.context_from_string: could not create context structure 
> 
> And also Unconfined is disabled in my System and I am suspecting that
> after disabling , I am getting the above errors. Can anybody help me
> on this.
> 
> Please let me know if any comments are there.

This is normal; you have old audit records from when your policy
included unconfined, and now that you have removed unconfined,
audit2allow can't process those audit records.  However, it won't stop
working; it just continues to process any remaining audit records that
are valid.  You can delete your old audit logs if you want to avoid the
noise.  Or you can feed audit2allow only recent audit records, e.g.
ausearch -m AVC -ts today | audit2allow
to process today's audit records.
