Subject: Re: Apache/PHP module boot restriction?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew JH Ring <aring@mail.arc.nasa.gov>
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <NPENJIPGPDNEOOPGDIFGCEEICBAA.aring@mail.arc.nasa.gov>
References: <NPENJIPGPDNEOOPGDIFGCEEICBAA.aring@mail.arc.nasa.gov>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 08:22:57 -0500
Message-Id: <1140700977.21179.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-22 at 16:41 -0800, Andrew JH Ring wrote:
> I've recently set up a Fedora Core 4 web server running Apache 2.2.0
> with PHP 5.1.2.  I've managed to get Apache loading the module, after
> setting libphp5.so to shlib_t, however Apache seems to still be unable
> to access the module during boot.  I'm getting a Cannot load libphp5
> cannot restore segment prot after reloc.  Is this a known problem, and
> if so, how is it fixed?

cc'd fedora-selinux-list as well above, since you mentioned you were
using FC4.

This usually indicates a text relocation, which is undesirable if it can
be avoided.  The stock FC4 php doesn't appear to have any text
relocations in its libphp (readelf -d libphp5.so.1 |  grep TEXTREL).
Possibly it has a patch to avoid the problem.

Ideally, it would be best if you could similarly patch or fix the build
for PHP 5.1.2.  If you truly need to allow it, then you can label
the .so file with the texrel_shlib_t type (since you are using FC4, I
used the old type name).

Some discussion of the SELinux memory protection tests can be found in:
http://people.redhat.com/drepper/selinux-mem.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
