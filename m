Subject: Re: Developing a SELinux policy for antivirus - Activating a
 boolean variable when another has been actived
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alice Mynona <alice_mynona@bian-fu.net>
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <4C237345.2010200@bian-fu.net>
References: <4C237345.2010200@bian-fu.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Jun 2010 13:12:58 -0400
Message-ID: <1277399578.25186.50.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-06-24 at 17:01 +0200, Alice Mynona wrote:
> Hello,
> 
> during the developing of a SELinux module I got the following error messages when executing "audit2allow -a -l"
> 
> ...
> libsepol.context_from_record: type antivirus_t is not defined
> libsepol.context_from_record: could not create context structure
> libsepol.context_from_string: could not create context structure
> libsepol.sepol_context_to_sid: could not convert unconfined_u:unconfined_r:antivirus_t:s0 to sid
> 
> "antivirus_t" is a domain I have defined in my module:
> 
> type antivirus_t;
> domain_type(antivirus_t)
> 
> I have already removed the module (semodule -r antivirus.pp && semodule -R) and did a file context repair afterwards (fixfiles restore). The error still exists. 
> 
> I have reinstalled the policy (yum reinstall selinux-policy-*), but the problem remains. I have also taken a look at "file_contexts" (cd /etc/selinux/targeted/modules/active && grep antivirus_t file_contexts*), but there's no "antivirus_t" anymore.
> 
> Can you help me to find the cause of the problem? I don't know how to debug libsepol-messages.
> 
> I'm using "selinux-policy-targeted-3.6.32-118.fc12.noarch".

Sounds like the -l option to audit2allow isn't working correctly, so
that instead of only processing audit messages since the last policy
reload, you are still processing the audit messages from when that
policy module was installed, and unsurprisingly it cannot map those
contexts since you removed the module.  That would be a bug in
audit2allow/sepolgen.

Workaround would be to use ausearch to select the desired range of
messsages specifically, e.g.
/sbin/ausearch -m AVC -ts today | audit2allow

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
