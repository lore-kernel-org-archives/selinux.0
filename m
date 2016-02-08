Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u18NDc1i021529
 for <selinux@tycho.nsa.gov>; Mon, 8 Feb 2016 18:13:48 -0500
Received: by mail-vk0-f46.google.com with SMTP id e185so106096088vkb.1
 for <selinux@tycho.nsa.gov>; Mon, 08 Feb 2016 15:13:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAB5=j_pWWH=qEpDoFF6NZgo9hxkVG6neuJ0R9E7oWT8TX3qYYg@mail.gmail.com>
References: <CAB5=j_pWWH=qEpDoFF6NZgo9hxkVG6neuJ0R9E7oWT8TX3qYYg@mail.gmail.com>
Date: Mon, 8 Feb 2016 18:13:37 -0500
Message-ID: <CAGNxgPjNyp5LPEgD353eWj6cy1uYqVOJx_3Ud1tbbUphSitr7g@mail.gmail.com>
Subject: Re: Policy feedback
From: Spencer Shimko <spencer@quarksecurity.com>
To: Mark Steele <mark@control-alt-del.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Feb 8, 2016 at 11:37 AM, Mark Steele <mark@control-alt-del.org> wrote:
> Hello list,
>
> I've written my first SELinux policy, and was wondering if this was the
> right place to ask for feedback for newly written policy. Apologies in
> advance if it isn't.
>
> The policy can be viewed here:
>
> https://github.com/marksteele/cinched/tree/master/policy
>
> The goal of the policy is to confine a service into a domain, and lock it
> down as much as possible.
>
> What I appear to have accomplished thus far is that only the sysadm_t type
> is allowed to transition into the domain via an executable, and only via
> that transition can the service access it's files.
>
> If anyone spots something that looks off, please feel free to get in touch.

Good call on sending out a request for input on custom policy. I don't
see that often.

Typically security requirements and overall functional goals drive the
policy itself. My response below lacks that context, but is based on
the solutions I've been contributing to over the years. Please
consider it based on that fact.

1. The raw requires block at the top is an indication of not calling
interfaces provided by other modules, rather using auto2allow without
reviewing and converting its output to reference policy interface
calls. All of the subsequent allow rules references the types in the
requires block should be addressed by using the appropriate
interfaces.

2. The fs_associate calls are indicative of the need to call
files_type() or similar interfaces.

3. Some rules indicate you disabled audit messages, which is useful
sometimes. But the rules you're adding are likely not necessary, such
as:
allow cinched_service_t chkpwd_t:process { siginh noatsecure rlimitinh };

4. Some are concerning, and while they might be necessary, they should
be considered carefully given their ability to r/w console devices:
allow cinched_service_t devpts_t:chr_file { read write getattr open ioctl };

5. The ability r/w etc files is suspect, particularly given the other
perms indicating this daemon is performing auth. In "normal" policies,
if you can clobber etc_t, you can overwrite PAM auth files:
files_manage_etc_files(cinched_service_t)

6. Logs should only be O_APPEND, the perms granted allow truncation, e.g.:
manage_files_pattern(cinched_service_t, cinched_log_t, cinched_log_t)

7. The network perms are way too excessive for most use cases. Label
all packets via SECMARK, drop the rest.

There might  be other issues but the above are based on a quick
cursory review of the module you linked to.

Thanks,
--Spencer

Spencer Shimko
Quark Security, Inc
quarksecurity.com
>
> Regards,
>
> Mark Steele
> CISSP, GPEN, GCIA, CSM
> mark@control-alt-del.org
>
> LinkedIn: https://ca.linkedin.com/in/markrsteele
> Github: https://github.com/marksteele
> Personal: http://www.control-alt-del.org
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
