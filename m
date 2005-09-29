Subject: Re: apache tunable expression
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1128017619.12449.10.camel@sgc.columbia.tresys.com>
References: <1128017619.12449.10.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 14:28:57 -0400
Message-Id: <1128018537.27495.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-29 at 14:13 -0400, Christopher J. PeBenito wrote:
> In the apache policy, there is this conditional expression:
> 
> if (httpd_enable_cgi && httpd_unified && httpd_builtin_scripting
>     ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
> 
> Why is the httpd_disable_trans boolean checked?  If the transition to
> httpd_t is disabled, why does it matter if these rules are enabled or
> not?

Offhand guess:  because this block also contained transitions from
sysadm_t to the httpd script domains for direct execution of scripts for
debugging/development purposes with the same permission set as they
would have in real use, and those transitions also need to be disabled
if the boolean is set.  Looks like that is now wrapped by its own ifdef
anyway, so this may be historical and obsolete.  There was a discussion
of this issue at one point on fedora-selinux-list iirc, in which it was
concluded that people want such scripts to be able to access the pty/tty
for diagnostic output when running them directly for
debugging/development purposes and thus they should default to not
transitioning in that case at least under targeted policy.  They still
have the option of using runcon to explicitly run the script in the same
environment if desired (again, at least under targeted policy, where
they are able to use runcon without restriction).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
