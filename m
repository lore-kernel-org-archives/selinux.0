MIME-Version: 1.0
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Fri, 25 Aug 2017 17:56:47 +0000
Message-ID: <CABXk95ATb_AFk+4GX9Xw+HEU6No8irb0mOoLE9O4EBuLAgA-1w@mail.gmail.com>
To: Chenbo Feng <fengc@google.com>, SELinux <Selinux@tycho.nsa.gov>,
 netdev@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a114881aae0e78a055797ab18"
Subject: Permissions for eBPF objects
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114881aae0e78a055797ab18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99d like to get your thoughts on adding LSM permission checks on BP=
F
objects.

By default, the ability to create and use eBPF maps/programs requires
CAP_SYS_ADMIN [1]. Alternatively, all processes can be granted access to
bpf() functions. This seems like poor granularity. [2]

Like files and sockets, eBPF maps and programs can be passed between
processes by FD and have a number of functions that map cleanly to
permissions.

Let me know what you think. Are there simpler alternative approaches that
we haven=E2=80=99t considered?

Thanks!
Jeff

[1] http://man7.org/linux/man-pages/man2/bpf.2.html NOTES section
[2] We are considering eBPF for network filtering by netd. Giving netd
CAP_SYS_ADMIN would considerably increase netd=E2=80=99s privileges. Altern=
atively
allowing all processes permission to use bpf() goes against the principle
of least privilege exposing a lot of kernel attack surface to processes
that do not actually need it.

--001a114881aae0e78a055797ab18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I=E2=80=99d like to get your thoughts on adding LSM p=
ermission checks on BPF objects.<br></div><div><br></div><div>By default, t=
he ability to create and use eBPF maps/programs requires CAP_SYS_ADMIN [1].=
 Alternatively, all processes can be granted access to bpf() functions. Thi=
s seems like poor granularity. [2]</div><div><br></div><div>Like files and =
sockets, eBPF maps and programs can be passed between processes by FD and h=
ave a number of functions that map cleanly to permissions.</div><div><br></=
div><div>Let me know what you think. Are there simpler alternative approach=
es that we haven=E2=80=99t considered?</div><div><br></div><div>Thanks!</di=
v><div>Jeff=C2=A0</div><div><br></div><div>[1] <a href=3D"http://man7.org/l=
inux/man-pages/man2/bpf.2.html">http://man7.org/linux/man-pages/man2/bpf.2.=
html</a> NOTES section</div><div>[2] We are considering eBPF for network fi=
ltering by netd. Giving netd CAP_SYS_ADMIN would considerably increase netd=
=E2=80=99s privileges. Alternatively allowing all processes permission to u=
se bpf() goes against the principle of least privilege exposing a lot of ke=
rnel attack surface to processes that do not actually need it.</div></div>

--001a114881aae0e78a055797ab18--
