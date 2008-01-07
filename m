Subject: Re: dhcpc_exec_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30801031640uef51a15yef23cb5a33133e04@mail.gmail.com>
References: <dd18b0c30801031640uef51a15yef23cb5a33133e04@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 07 Jan 2008 13:11:56 -0500
Message-Id: <1199729516.2944.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-03 at 16:40 -0800, Justin Mattock wrote:
> Hello I seem to be a bit confused at what role I need to be in for
> selinux-policy-default mls to run dhclient, or any executables; the
> context is labeled 
> /sbin/dhclient3 system_u:object_r:dhcpc_exec_t:s0 . audit gives me an
> unknown avc error, when I chcon
> system_u:object_r:dhcpc_t:s0 /sbin/dhclient3 
> audit will see the context. Where in compiling the policy gives me the
> option for having sysadm_r run executables or do I need to newrole -r
> into 
> system_r to run dhclient? when also issueing newrole in mls I seem to
> keep reciving this error as well =Couldn't get default type. 
> any info would be helpful.

I think you have to post a little more information to get useful
feedback.

For example, what precise avc message did you get in /var/log/messages
or /var/log/audit/audit.log?

I'd expect sysadm_r (and thus sysadm_t) to be able to transition to
dhcpc_t, along with appropriate system domains like initrc_t.

You didn't say what your context was when you tried to run dhclient
(e.g. id -Z output).

newrole -r sysadm_r should work on a properly configured system.   The
"Couldn't get default type" message means that
your /etc/selinux/$SELINUXTYPE/contexts/default_type file lacked a
definition for the role.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
