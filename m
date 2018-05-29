To: bhawna goel <bhawnagoel13@gmail.com>, selinux@tycho.nsa.gov
References: <CABCvxxp040XVs4K_GGSJeNnTr9sNmeEfw62QoXVjF==xm9bNXg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fa1fcbf7-4413-9f84-7cc0-4dcdb0f96c99@tycho.nsa.gov>
Date: Tue, 29 May 2018 09:47:14 -0400
MIME-Version: 1.0
In-Reply-To: <CABCvxxp040XVs4K_GGSJeNnTr9sNmeEfw62QoXVjF==xm9bNXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: Invalid security context while executing audit2alllow.orig
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/29/2018 07:39 AM, bhawna goel wrote:
> Hi Team,
> 
> We are getting below error while creating policies using command audit2allow.orig. Can you help in identifying what could be the possible reason of such error.
> 
> Error:
> libsepol.context_from_record: invalid security context: "specialuser_u:system_r:ssh_t:s0"
> libsepol.context_from_record: could not create context structure
> libsepol.context_from_string: could not create context structure
> libsepol.sepol_context_to_sid: could not convert specialuser_u:system_r:ssh_t:s0 to sid

This means that a security context from the avc messages that you fed into audit2allow (or read from the audit logs) is not valid under the currently loaded policy, e.g. specialuser_u might not be defined or it might not be authorized for the system_r role.

This commonly happens when you take avc denials / audit logs from one system and try to apply audit2allow to them on a different system with a different policy, or if the denials occurred while a different policy was loaded.

You can specify a policy to audit2allow via -p and have it use that policy when decoding the security contexts.
