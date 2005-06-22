Subject: Re: 'name_connect' undefined!
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119394710.9416.23.camel@localhost>
References: <1119394710.9416.23.camel@localhost>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 07:42:41 -0400
Message-Id: <1119440561.13181.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-06-21 at 23:58 +0100, antoine wrote:
> On a x86 box running Gentoo SELinux profile , I cannot 'emerge sync' (in
> enforcing mode): I get the following error message:
> 
> audit(1119487194.838:0): avc:  denied  { name_connect } for  dest=873
> scontext=root:sysadm_r:portage_fetch_t
> tcontext=system_u:object_r:rsyncd_port_t tclass=tcp_socket
> 
> audit2allow gives me:
> allow portage_fetch_t rsyncd_port_t:tcp_socket name_connect;
> Which would make sense, except that 'name_connect' is not defined
> anywhere! (and therefore I cannot compile the policy with that value)
> So I tried allowing connect, name_bind and so on, but the audit message
> is still coming up. Where does this 'name_connect' come from if it is
> not in my policy source tree? (and how do I fix it)

name_connect permission was introduced in 2.6.12 (to provide better
control over outbound TCP connections), so you need a newer policy that
defines it and allows it where appropriate.  Or you can patch it into
your policy, e.g. grab policy/flask/* from the sourceforge CVS tree and
drop them into your policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
