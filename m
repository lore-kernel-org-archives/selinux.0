Message-ID: <1485368427.15074.74.camel@tycho.nsa.gov>
Subject: Re: pam_selinux: add new option to select from default_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: cgzones <cgzones@googlemail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Date: Wed, 25 Jan 2017 13:20:27 -0500
In-Reply-To: <CAJ2a_DeV0F6kWFKcz-AsYHCG2k_tjLyj4Y5j4WzuaPhAPPesAA@mail.gmail.com>
References: <CAJ2a_DePfW-F9Y48mr33XDg1s4RJE9-M_OToTpREQEaCP2DZnw@mail.gmail.com>
 <1485365934.15074.64.camel@tycho.nsa.gov>
 <CAJ2a_DeV0F6kWFKcz-AsYHCG2k_tjLyj4Y5j4WzuaPhAPPesAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-01-25 at 19:07 +0100, cgzones wrote:
> The use case is my sddm policy.
> I asked for help with it on the reference policy ML:
> http://oss.tresys.com/pipermail/refpolicy/2017-January/008950.html
> 
> The parent process (sddm-helper) spawns over one pam service
> (sddm-greeter) the login gui and over another pam service (sddm) the
> user shells.
> I edited the /etc/pam.d/sddm-greeter file:
> +session [success=ok ignore=ignore module_unknown=ignore default=bad]
> pam_selinux.so open debug select_default_context=2
> -session [success=ok ignore=ignore module_unknown=ignore default=bad]
> pam_selinux.so open
> 
> And with the policy returning:
> root@desktopdebian:/home/christian# compute_user
> "system_u:system_r:sddm_helper_t:s0" user_u
> user_u:user_r:user_t:s0
> user_u:user_r:sddm_greeter_t:s0
> 
> I get the correct contexts for the gui process and the user shells.
> I did not get it working via a process transitions based on the
> different entry points (/etc/sddm/Xsession vs /usr/bin/sddm-greeter)

Couldn't you just add an entry to default_contexts like so:
system_r:sddm_helper_t:s0 user_u:user_r:sddm_greeter_t:s0
user_u:user_r:user_t:s0

Then get_ordered_context_list() would return them in that order, and
the existing logic would be fine without needing to modify pam_selinux.
