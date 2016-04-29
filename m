Subject: Re: userspace object managers get confused if an update changes
 object classes and access vectors
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 Lukas Vrabec <lvrabec@redhat.com>, Miroslav Grepl <mgrepl@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>, Paul Moore <paul@paul-moore.com>
References: <d7fef34c-0b38-63f3-4a37-464930a03806@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <385dc3db-6bfc-9724-0a51-6fe8530bd292@tycho.nsa.gov>
Date: Fri, 29 Apr 2016 15:53:51 -0400
MIME-Version: 1.0
In-Reply-To: <d7fef34c-0b38-63f3-4a37-464930a03806@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/29/2016 01:04 PM, Dominick Grift wrote:
> 
> I have mentioned this before (probably a few times), and i am not sure
> if this issue is actually what i think it is but i will once again
> mention this issue i observed many times.
> 
> Excuse me if i am wrong here.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1331668
> 
> https://github.com/fedora-selinux/selinux-policy/commit/971e97a2b8cbcc14
> 3fc82badfaaf7900b4760399
> 
> When you change (user space?) access vectors then user space object
> managers get confused and stop working. This is now becoming an issue
> since core components are object managers (systemd/dbus)
> 
> So basically there is no way for distributions to add/remove access
> vectors without breaking the running system.
> 
> The only solution is immediately switch to permissive mode and to
> reboot the system after such an update. And you might not even be able
> to cleanly shutdown due to these confused components

(cc'd redhat folks so they can provide more context on what the actual
bug/issue was, since it wasn't entirely clear to me from the bugzilla or
commit above)

In general, the safest approach is to only add permissions at the end of
an existing class or add new classes at the end of the current list of
classes.  That avoids perturbing the values of any existing permission
or class and thus shouldn't cause any breakage.  It looks like the
commit you referenced was adding/removing permissions at the end of the
class though, so I'm not clear on what broke there. There is something
very odd there though - I don't understand how Fedora policy got into a
state where those permissions weren't defined in the first place, or why
they are inconsistent in their order with upstream refpolicy.

The fact that userspace code is using the system class at all is a bug
that has previously been pointed out; userspace needs to use its own
classes and not share one with the kernel.  The kernel recently took
another permission from that class, so there is a conflict looming.

For userspace, selinux commit b408d72ca9104cb0c1bc4e154d8732cc7c0a9190
was intended to help with these kinds of changes, but as noted in the
commit description, there is still the potential interleaving of a
policy reload and a call to selinux_check_access() that could cause
problems.

The kernel is presently the only component fully safe against arbitrary
changes to class/permission definitions at runtime, and that is because
it can atomically update its class/permission mappings with the policy
reload transaction.  I think making userspace fully safe would require
introducing a new selinuxfs interface (e.g. /sys/fs/selinux/access2)
that takes and returns class and permission strings rather than values,
so that the kernel can internally handle the mapping and ensure it is
updated atomic with policy reloads too.  And one would then need to
rework the userspace AVC and selinux_check_access() to use that
interface, and convert any remaining userspace components that are still
using something other than selinux_check_access() for SELinux permission
checking.
