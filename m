Subject: Re: [SEMANAGE][SEPOL][UTILS] Clone record on set_con
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <43E22026.6070504@cornell.edu>
References: <43E22026.6070504@cornell.edu>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 11:26:42 -0500
Message-Id: <1138897602.18268.187.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-02 at 10:07 -0500, Ivan Gyurdiev wrote:
> Hi, this patch clones the context record passed to:
> 
> semanage_fcontext_set_con
> [sepol/semanage]_iface_set_msgcon
> [sepol/semanage]_iface_set_ifcon
> [sepol/semanage]_port_set_con
> 
> This matches the behavior of the modify() function - no taking over the 
> caller's objects. Less likely to run into an error this way, and it 
> improves consistency. Unfortunately it also means set_con can fail, the 
> failure has to be handled, and the context freed by the caller... but I 
> think this is a more flexible interface (caller can reuse object if 
> necessary).
> 
> This is an API change, dependency is seobject.py, fixed in this patch.
> 
> ===
> Patch also fixes 3 bugs in the pywrap-test, which is rather surprising - 
> I do run those tests, not sure how they sneaked in.

Thanks, merged as of libsepol 1.11.12, libsemanage 1.5.20, and
policycoreutils 1.29.18.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
