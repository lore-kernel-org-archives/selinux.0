Subject: Re: Upstart not transitioning to target domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Damian Gerow <dgerow@afflictions.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1318478183.9025.140258154258765@webmail.messagingengine.com>
References: <1318478183.9025.140258154258765@webmail.messagingengine.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Oct 2011 09:52:55 -0400
Message-ID: <1318513975.17008.2.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-10-12 at 23:56 -0400, Damian Gerow wrote:
> I've been struggling for a few hours trying to write a new policy on an
> install of RHEL6.1.  I'm still cutting my teeth on SELinux, so if
> there's a more appropriate forum for this, I apologize.
> 
> I can't seem to convince upstart to transition to the target domain. 
> I've tried using init_daemon_domain, domain_auto_trans, and specifying
> the transition manually, but the resulting daemon continues to run under
> initrc_t.  Curiously, the logging_log_filetrans macro seems to be
> working just fine, as log files are created with an appropriate context.
> 
> The current policy is quite simple:
> 
> -----
> policy_module(foobar,0.5.7)
> 
> require {
>         attribute port_type;
> };
> 
> type foobard_t;
> type foobard_exec_t;
> init_daemon_domain(foobard_t, foobard_exec_t)
> 
> type foobard_etc_t;
> files_type(foobard_etc_t)
> 
> type foobard_log_t;
> files_type(foobard_log_t)
> 
> type foobard_var_lib_t;
> files_type(foobard_var_lib_t)
> 
> type foobar_port_t, port_type;
> -----
> 
> I've verified that the filesystem is labelled properly, yet the service
> itself continues to run under initrc_t:
> 
> -----
> system_u:system_r:initrc_t:s0   root      8724  0.0  1.5 694524 15636 ? 
>       Ssl  23:50   0:00 /usr/local/foobar/bin/foobard -a input -f
> /usr/local/foobar/conf/input.conf
> -----
> 
> What am I doing wrong?

Is the filesystem mounted nosuid?  If so, that will suppress the domain
transition.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
