Subject: Re: Java Legacy problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1108910713.3610.18.camel@cobra.ivg2.net>
References: <1108910713.3610.18.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 08:36:50 -0500
Message-Id: <1109079410.2256.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-02-20 at 09:45 -0500, Ivan Gyurdiev wrote:
> So, what is the recommended strategy for dealing with Java, so
> that those denials will go away?
> 
> user_t (java):
> denied { execute } ld_so_cache_t:file (/etc/ld.so.cache) 
> denied { execute } locale_t:file      (/usr/lib/locale/locale-archive)
> denied { execmod } shlib_t:file       (/lib/libc-2.3.4.so)
> denied { execmod } ld_so_t:file       (/lib/ld-2.3.4.so)

It has been suggested that SELinux should not be checking execute-
related permissions when the kernel automatically adds execute via the
read-implies-execute logic for legacy binaries.  To achieve that, we
would need to modify the core kernel to pass the original requested
protection to the security hooks in mmap and mprotect and have SELinux
perform its checking based on that requested protection (as specified by
the application) rather than the actual protection applied by the kernel
_if_ some setting were enabled, e.g. echo 1 > /selinux/legacycompat.
What do people think about that?  

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
