MIME-Version: 1.0
In-Reply-To: <20170414184946.GB16153@markus>
References: <20170414145759.GA7980@markus>
 <1492184005.26072.3.camel@tycho.nsa.gov>
 <fdcf2bd0-6a5a-aead-ef31-59b9b2235afe@redhat.com>
 <1492192590.26072.5.camel@tycho.nsa.gov>
 <20170414184946.GB16153@markus>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Fri, 14 Apr 2017 21:43:49 +0200
Message-ID: <CAJfZ7==rsOexenE+76YX0fbgX9_eXGjygmNzaHL1G8azKk8EMw@mail.gmail.com>
Subject: Re: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
To: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
 Daniel J Walsh <dwalsh@redhat.com>, Dominick Grift <dac.override@gmail.com>
Content-Type: multipart/mixed; boundary=001a114e3e3e1ed838054d25a938
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114e3e3e1ed838054d25a938
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2017 at 8:49 PM, Dominick Grift <dac.override@gmail.com> wr=
ote:
> On Fri, Apr 14, 2017 at 01:56:30PM -0400, Stephen Smalley wrote:
>> On Fri, 2017-04-14 at 13:47 -0400, Daniel Walsh wrote:
>> > On 04/14/2017 11:33 AM, Stephen Smalley wrote:
>> > > On Fri, 2017-04-14 at 16:57 +0200, Dominick Grift wrote:
>> > > > Bear with me please, because i might not fully grasp the issue (i
>> > > > received help with diagnosing this issue):
>> > > >
>> > > > This commit causes issues (and is, i think, a lousy hack):
>> > > > e3cab998b48ab293a9962faf9779d70ca339c65d
>> > > >
>> > > > The commit causes entities to "think" that SELinux is disabled
>> > > > after
>> > > > "mount -o remount,ro /sys/fs/selinux
>> > > >
>> > > > It is "neat" to be able to make processes "think" that selinux is
>> > > > disabled on a selinux enabled system but not if it break anything
>> > > >
>> > > > The above results in the following:
>> > > >
>> > > > Systemd services that have ProtectKernelTunables=3Dyes set in thei=
r
>> > > > respective service units, think that SELinux is disabled.
>> > > >
>> > > > However we have found that some of these services actually rely
>> > > > on
>> > > > SELinux to ensure proper labeling.
>> > > >
>> > > > So we have the option to make people aware that if you set
>> > > > ProtectKernelTunables=3Dyes that then the process cannot be
>> > > > SELinux-
>> > > > aware properly, or we can just get rid of the commit above and
>> > > > just
>> > > > accept that process know that SELinux is enabled.
>> > > >
>> > > > Actual bug that caused me to look into this: systemd-localed
>> > > > selinux
>> > > > awareness is broken due it having ProtectKernelTunables=3Dyes in
>> > > > its
>> > > > service unit
>> > >
>> > > If selinuxfs is mounted read-only, then they can't use most of the
>> > > selinuxfs interfaces, including even the ability to validate or
>> > > canonicalize security contexts.  That will break most SELinux-aware
>> > > services if we tell them that SELinux is enabled.  Are you sure
>> > > systemd-localed would actually work if you told it SELinux was
>> > > enabled
>> > > when selinuxfs was mounted read-only?  What SELinux interfaces is
>> > > it
>> > > using?
>> > >
>> > > The other question is whether ProtectKernelTunables ought to be
>> > > mounting selinuxfs read-only.  SELinux already controls the ability
>> > > to
>> > > use its interfaces, including limiting even root, so it is unclear
>> > > what
>> > > benefit we derive from having systemd add a further restriction on
>> > > top.
>> > >
>> >
>> > Why is selinuxfs mounted readonly in this case?
>>
>> I don't actually see this in upstream systemd unless I am just missing
>> it.
>>
>> systemd/src/core/namespace.c:
>> /* ProtectKernelTunables=3D option and the related filesystem APIs */
>> static const MountEntry protect_kernel_tunables_table[] =3D {
>>         { "/proc/sys",           READONLY,     false },
>>         { "/proc/sysrq-trigger", READONLY,     true  },
>>         { "/proc/latency_stats", READONLY,     true  },
>>         { "/proc/mtrr",          READONLY,     true  },
>>         { "/proc/apm",           READONLY,     true  }, /* Obsolete
>> API, there's no point in permitting access to this, ever */
>>         { "/proc/acpi",          READONLY,     true  },
>>         { "/proc/timer_stats",   READONLY,     true  },
>>         { "/proc/asound",        READONLY,     true  },
>>         { "/proc/bus",           READONLY,     true  },
>>         { "/proc/fs",            READONLY,     true  },
>>         { "/proc/irq",           READONLY,     true  },
>>         { "/sys",                READONLY,     false },
>>         { "/sys/kernel/debug",   READONLY,     true  },
>>         { "/sys/kernel/tracing", READONLY,     true  },
>>         { "/sys/fs/cgroup",      READWRITE,    false }, /* READONLY is
>> set by ProtectControlGroups=3D option */
>> };
>>
>> No mention of selinuxfs at all.  Maybe it is a Fedora patch?
>>
>> > The reason we want this is so that processes inside of containers do
>> > not
>> > attempt to do SELinux stuff.
>> >
>> > http://danwalsh.livejournal.com/73099.html
>
> Before one dismisses my concern (8 minute proof):
>
> https://www.youtube.com/watch?v=3DYqiM1MlOG0w

Hello,
I see this on Arch Linux as well, where there is no
distribution-specific patch which is applied to systemd (the only
patches which are applied are backported commits). A simple way to see
that the selinuxfs is mounted read-only is the following command:
"localectl && findmnt --task $(pgrep systemd-localed)". It will
display the mountpoints of systemd-localed.service, which (with
systemd 232 [1]) contains:

=E2=94=9C=E2=94=80/sys                           sys                      s=
ysfs
ro,nosuid,nodev,noexec,relatime,seclabel
=E2=94=82 =E2=94=9C=E2=94=80/sys/firmware/efi/efivars    efivarfs          =
       efivarfs
ro,nosuid,nodev,noexec,relatime
=E2=94=82 =E2=94=9C=E2=94=80/sys/kernel/security         securityfs        =
       securityfs
ro,nosuid,nodev,noexec,relatime
=E2=94=82 =E2=94=9C=E2=94=80/sys/fs/selinux              selinuxfs         =
       selinuxfs
ro,relatime
=E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup               tmpfs             =
       tmpfs
ro,nosuid,nodev,noexec,seclabel,mode=3D755
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup/systemd     cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,xattr,release_agent=3D/usr/lib/systemd/syst=
emd-cgroups-agent,name=3D
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup/net_cls     cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,net_cls
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup/perf_event  cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,perf_event
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup/pids        cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,pids
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup/blkio       cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,blkio
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup/freezer     cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,freezer
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup/cpu,cpuacct cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,cpu,cpuacct
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup/cpuset      cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,cpuset
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80/sys/fs/cgroup/devices     cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,devices
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80/sys/fs/cgroup/memory      cgroup    =
               cgroup
ro,nosuid,nodev,noexec,relatime,memory
=E2=94=82 =E2=94=9C=E2=94=80/sys/fs/pstore               pstore            =
       pstore
ro,nosuid,nodev,noexec,relatime,seclabel
=E2=94=82 =E2=94=9C=E2=94=80/sys/kernel/debug            debugfs           =
       debugfs
ro,relatime,seclabel
=E2=94=82 =E2=94=9C=E2=94=80/sys/kernel/config           configfs          =
       configfs
ro,relatime
=E2=94=82 =E2=94=94=E2=94=80/sys/fs/fuse/connections     fusectl           =
       fusectl
ro,relatime

/sys/fs/selinux is mounted read-only. Moreover when I run "strace -f
-p 1 -e mount" while starting systemd-localed.service, I get:

3401  mount(NULL, "/sys/fs/cgroup/perf_event", NULL,
MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) =3D 0
3401  mount(NULL, "/sys/fs/cgroup/blkio", NULL,
MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) =3D 0
3401  mount(NULL, "/sys/fs/cgroup/pids", NULL,
MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) =3D 0
3401  mount(NULL, "/sys/fs/selinux", NULL,
MS_RDONLY|MS_REMOUNT|MS_BIND, NULL) =3D 0
3401  mount(NULL, "/sys/fs/cgroup", NULL,
MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL) =3D 0
3401  mount(NULL, "/sys/kernel/debug", NULL,
MS_RDONLY|MS_REMOUNT|MS_BIND, NULL) =3D 0
...

So /sys/fs/selinux *is* remounted read-only by systemd. When I remove
"ProtectKernelTunables=3Dyes" from the unit file, /sys/fs/selinux is not
remounted and is kept RW in the namespace of the service.

About containers, in http://danwalsh.livejournal.com/73099.html there
is: "In containers we don't mount these file systems by default or we
mount it read/only causing libselinux to report that it is disabled.".
Why does /sys/fs/selinux need to be mounted read-only instead of not
been mounted at all?


About systemd-localed, its use of namespaces makes it "look like" a
container, but it needs to be SELinux-aware in order to use
/proc/thread-self/attr/fscreate. The use-case is to atomically create
files like /etc/vconsole.conf with the right context. In order to do
so, the service:
* loads the file context database,
* requests the expected context of /etc/vconsole.conf (selabel_lookup_raw),
* configures the fscreate context (setfscreatecon_raw)
* creates a temporary file with this context named for example
"/etc/.#vconsole.confiYiPml",
* writes data to it and closes it,
* and finally renames it to /etc/vconsole.conf (with the rename syscall)

I am not aware of a way of making /etc/vconsole.conf have the right
file context in the end without making the program use libselinux's
API (named type_transition does not support patterns suitable for
temporary files). Did I miss something?


Anyway, there is a bug in vanilla code (it is not specific to Fedora)
and it is not clear whether it is a bug in libselinux code or in
systemd's one. Is it's libselinux, I have prepared a patch for it
(attached). Otherwise, what does systemd did wrong in its use of the
SELinux API?

Nicolas

[1] ProtectKernelTunables=3Dyes has actually been introduced in systemd
232 with https://github.com/systemd/systemd/commit/0c28d51ac84973904e5f780b=
024adf8108e69fa1

--001a114e3e3e1ed838054d25a938
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-libselinux-detect-that-SELinux-is-enabled-when-sys-f.patch"
Content-Disposition: attachment;
	filename="0001-libselinux-detect-that-SELinux-is-enabled-when-sys-f.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j1i86tjq1

RnJvbSA5MjY4OGQ0OWYxNmEyODg3NTAzNGM5NTgyN2ZiZTBkMjBlMjIxZDdiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNvbGFzIElvb3NzIDxuaWNvbGFzLmlvb3NzQG00eC5vcmc+
CkRhdGU6IEZyaSwgMTQgQXByIDIwMTcgMjE6Mjc6NDIgKzAyMDAKU3ViamVjdDogW1BBVENIIDEv
MV0gbGlic2VsaW51eDogZGV0ZWN0IHRoYXQgU0VMaW51eCBpcyBlbmFibGVkIHdoZW4KIC9zeXMv
ZnMvc2VsaW51eCBpcyBtb3VudGVkIHJlYWQtb25seQoKc3lzdGVtZCBzZXJ2aWNlIHVuaXRzIGNh
biB1c2UgIlByb3RlY3RLZXJuZWxUdW5hYmxlcz15ZXMiIGluIG9yZGVyIHRvCm1vdW50IHNvbWUg
ZmlsZSBzeXN0ZW1zIHJlYWQtb25seSAodGhlIGRvY3VtZW50YXRpb24gaXMgYXZhaWxhYmxlIGF0
Cmh0dHBzOi8vd3d3LmZyZWVkZXNrdG9wLm9yZy9zb2Z0d2FyZS9zeXN0ZW1kL21hbi9zeXN0ZW1k
LmV4ZWMuaHRtbCkuClRoaXMgbWFrZXMgL3N5cy9mcy9zZWxpbnV4IHJlYWQtb25seSB0b28uCgpT
ZXJ2aWNlcyB1c2luZyBzdWNoIGEgY29uZmlndXJhdGlvbiBvcHRpb24gc2VlcyBTRUxpbnV4IGFz
IGRpc2FibGVkCmJlY2F1c2Ugb2YgdGhlIGJlaGF2aW9yIGRlc2NyaWJlZCBpbiBjb21taXQgZTNj
YWI5OThiNDhhICgibGlic2VsaW51eAptb3VudHBvaW50IGNoYW5naW5nIHBhdGNoLiIpOgoKICAg
IE5PVEU6ICBXZSBhZGRlZCB0aGUgY2hlY2sgZm9yIFJPLCB0byBhbGxvdyB0b29scyBsaWtlIG1v
Y2sgdG8gYmUKICAgIGFibGUgdG8gdGVsbCBhIGNocm9vdCB0aGF0IFNFTGludXggaXMgZGlzYWJs
ZWQgd2hpbGUgZW5mb3JjaW5nIGl0CiAgICBvdXRzaWRlIHRoZSBjaHJvb3QuCgpIb3dldmVyIHRo
aXMgY2hhbmdlcyB0aGUgYmVoYXZpb3Igb2Ygc29tZSBzeXN0ZW1kIHNlcnZpY2VzIGluIHVuZXhw
ZWN0ZWQKd2F5cy4gRm9yIGV4YW1wbGUgc3lzdGVtZC1sb2NhbGVkIHVzZXMgbGlic2VsaW51eCBp
biBvcmRlciB0byBjcmVhdGUKL2V0Yy9sb2NhbGUuY29uZiwgL2V0Yy92Y29uc29sZS5jb25mLi4u
IHdpdGggdGhlIHJpZ2h0IGZpbGUgY29udGV4dAp3aGlsZSB1c2luZyBhIHRlbXBvcmFyeSBmaWxl
ICh1c2luZyBzZXRmc2NyZWF0ZWNvbl9yYXcoKSB3aXRoIHRoZSBsYWJlbApvZiAvZXRjL3Zjb25z
b2xlLmNvbmYpLiBXaXRoIFByb3RlY3RLZXJuZWxUdW5hYmxlcz15ZXMsIHN5c3RlbWQtbG9jYWxl
ZApzZWVzIFNFTGludXggYXMgYmVpbmcgZGlzYWJsZWQgKGJlY2F1c2UgL3N5cy9mcy9zZWxpbnV4
IGlzIG1vdW50ZWQKcmVhZC1vbmx5KSBhbmQgY3JlYXRlcyBmaWxlcyBpbiAvZXRjIHdpdGggYSB3
cm9uZyBsYWJlbC4KCkZpeCB0aGlzIGlzc3VlIGJ5IG1ha2luZyB2ZXJpZnlfc2VsaW51eG1udCgp
IHVzZSByZWFkLW9ubHkgbW91bnQtcG9pbnRzCnRvby4KClJlcG9ydGVkLWJ5OiBEb21pbmljayBH
cmlmdCA8ZGFjLm92ZXJyaWRlQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogTmljb2xhcyBJb29z
cyA8bmljb2xhcy5pb29zc0BtNHgub3JnPgotLS0KIGxpYnNlbGludXgvc3JjL2luaXQuYyB8IDQg
Ky0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2xpYnNlbGludXgvc3JjL2luaXQuYyBiL2xpYnNlbGludXgvc3JjL2luaXQuYwpp
bmRleCA4MTRjN2U2YTk5NjQuLjRmY2EyYjljNmVjZCAxMDA2NDQKLS0tIGEvbGlic2VsaW51eC9z
cmMvaW5pdC5jCisrKyBiL2xpYnNlbGludXgvc3JjL2luaXQuYwpAQCAtNDIsOSArNDIsNyBAQCBz
dGF0aWMgaW50IHZlcmlmeV9zZWxpbnV4bW50KGNvbnN0IGNoYXIgKm1udCkKIAkJCXN0cnVjdCBz
dGF0dmZzIHZmc2J1ZjsKIAkJCXJjID0gc3RhdHZmcyhtbnQsICZ2ZnNidWYpOwogCQkJaWYgKHJj
ID09IDApIHsKLQkJCQlpZiAoISh2ZnNidWYuZl9mbGFnICYgU1RfUkRPTkxZKSkgewotCQkJCQlz
ZXRfc2VsaW51eG1udChtbnQpOwotCQkJCX0KKwkJCQlzZXRfc2VsaW51eG1udChtbnQpOwogCQkJ
CXJldHVybiAwOwogCQkJfQogCQl9Ci0tIAoyLjEyLjAKCg==
--001a114e3e3e1ed838054d25a938--
