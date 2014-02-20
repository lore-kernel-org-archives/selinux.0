Message-ID: <5306441F.8050207@tycho.nsa.gov>
Date: Thu, 20 Feb 2014 13:06:23 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>, SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Only attempt to load policy exactly once, in
 the real root
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
In-Reply-To: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
Content-Type: text/plain; charset=ISO-8859-1
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/20/2014 10:42 AM, Colin Walters wrote:
> Currently on at least Fedora, SELinux policy does not come in
> the initramfs. systemd will attempt to load *both* in the
> initramfs and in the real root.
> 
> Now, the selinux_init_load_policy() API has a regular error return
> value, as well as an "enforcing" boolean. To determine enforcing
> state, it looks for /etc/selinux/config as well as the presence
> of "enforcing=" on the kernel command line.
> 
> Ordinarily, neither of those exist in the initramfs, so it will return
> "unknown" for enforcing, and systemd will simply ignore the failure to
> load policy.
> 
> Then later after we switch to the real root, we have the config file,
> and all will work properly.
> 
> Except...this all blows up if someone explicitly specifies enforcing=1
> on the kernel command line. Then systemd will fail to load the
> nonexistent policy in the initramfs and freeze.
> 
> What this patch does is quite simple - we add an internal API that
> says where we expect to find policy, and attempt to load it exactly
> from there. Right now since I'm not aware of anyone who does
> policy-in-initramfs, this function is hardcoded to return false.
> 
> Lots-of-very-painful-debugging-by: Colin Walters <walters@verbum.org>
> ---
> src/core/main.c | 6 ++++--
> src/core/selinux-setup.c | 10 ++++++++++
> src/core/selinux-setup.h | 2 ++
> 3 files changed, 16 insertions(+), 2 deletions(-)

Wouldn't it be better (and more correct) to probe both the initramfs and
the real root, and if neither one can load policy successfully and
enforcing=1, then halt?
