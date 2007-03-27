Subject: Re: SELinux cache.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <800112.19807.qm@web86906.mail.ukl.yahoo.com>
References: <800112.19807.qm@web86906.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 27 Mar 2007 08:38:16 -0400
Message-Id: <1174999097.3864.271.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-27 at 10:31 +0100, JanuGerman wrote:
> Hi Every one,
> 
>   SELinux maintains a cache called "access vector
> cache (avc)" for caching the security server
> decisions. Beside the avc, is there is any other cache
> as well, which is maintained outside the domain of
> Linux kernel or SElinux?.
> 
> The book "SELinux by example" have mentioned a cache
> in the userspace (library libselinux), but
> unfortunately, i was not able to locate this library.
> 
> Currently, my selinux is running in "Enforcing" mode,
> with "targeted" policy. Some times, it executes the
> functions within the selinux/hooks.c such as
> "may_create", "may_link", "file_has_perm" and some
> times not. The avc calls are normally executed within
> these methods. So, logically, these methods should be
> consulted, before examining the avc for a cache
> miss/hit. 
> 
> Am, i running SELInux in the wrong mode, i mean, at
> the moment it is "targeted", shall it be "strict" in
> order to execute these "hooks.c" functions each time a
> permission check is made, or there is another cache
> maintained outside the SELInux domain bounderies.

The hook functions are always called.  What makes you think they aren't?
Easiest way to see the calls is to add auditallow rules to your policy,
although this will generate a lot of audit messages.  Example:
$ cat test.te
policy_module(test, 1.0)

require {
        attribute domain;
        attribute file_type;
}

auditallow domain file_type:dir_file_class_set *;
$ make -f /usr/share/selinux/devel/Makefile
$ su -
# semodule -i test.pp
# tail -f /var/log/audit/audit.log

But be warned that this will generate a lot of audit.
To remove, use:
# semodule -r test

There is a userspace AVC in libselinux for use by userspace object
managers (applications that enforce policy over their own objects and
operations not directly visible to the kernel), but it isn't relevant to
the kernel.  If you have SELinux on your system, you have libselinux
already, e.g. /lib/libselinux.so.1.  The sources can be found in the
usual places.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
