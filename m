Date: Tue, 29 Jan 2002 12:10:30 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Additional permissions that appear to be necessary
In-Reply-To: <1012323070.1329.4.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0201291201301.11892-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 29 Jan 2002, Justin Smith wrote:

> This is apart from those made necessary by my own policy configuration
> (i.e., they probably apply to all Redhat 7.2 installations):
>
> allow initrc_t initrc_t:socket { create };

I've seen this permission denial associated with the iwconfig program on
RH7.2.  Do you really need to run iwconfig (configure a wireless network
interface)?  If not, why grant this permission?

The correct way to handle this denial would be to define new security
class for the protocol family used by iwconfig (it falls back to the
generic 'socket' class since it isn't recognized by the SELinux module)
and to define a domain for the iwconfig program.

> allow kmod_t kmod_t:capability { setuid };

I haven't seen this denial on RH7.2, but it seems harmless (kmod_t is the
domain associated with the kernel thread that invokes user mode helpers,
such as modprobe or hotplug).

> allow logrotate_t logrotate_t:capability { sys_pacct };

I don't see this denial, and I'm not sure why logrotate would need this
capability (configuration of process accounting).

> allow system_crond_t etc_t:dir { setattr write };
> allow system_crond_t file_labels_t:dir { setattr };

I don't see either of these denials, and it seems undesirable to grant
these permissions.

> allow system_crond_t var_lib_rpm_t:dir { add_name write };
> allow system_crond_t var_lib_rpm_t:file { create read write };
> allow system_crond_t var_log_t:file { setattr write };
>
> The last 5 lines only appear after running a system for several days so
> that its periodic maintenance is performed.

These are associated with running the rpm utilities.  We are likely to add
a new domain (and a new log type) for this purpose rather than directly
granting these permissions to system_crond_t.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
