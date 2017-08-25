MIME-Version: 1.0
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Fri, 25 Aug 2017 11:01:16 -0700
Message-ID: <CABXk95AiYO7D8o79TBdt0_0g1TXfULSpL5i7KzHF3R4i-WhwHw@mail.gmail.com>
To: Chenbo Feng <fengc@google.com>, netdev@vger.kernel.org,
 SELinux <Selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Permissions for eBPF objects
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I’d like to get your thoughts on adding LSM permission checks on BPF objects.

By default, the ability to create and use eBPF maps/programs requires
CAP_SYS_ADMIN [1]. Alternatively, all processes can be granted access
to bpf() functions. This seems like poor granularity. [2]

Like files and sockets, eBPF maps and programs can be passed between
processes by FD and have a number of functions that map cleanly to
permissions.

Let me know what you think. Are there simpler alternative approaches
that we haven’t considered?

Thanks!
Jeff

[1] http://man7.org/linux/man-pages/man2/bpf.2.html NOTES section
[2] We are considering eBPF for network filtering by netd. Giving netd
CAP_SYS_ADMIN would considerably increase netd’s privileges.
Alternatively allowing all processes permission to use bpf() goes
against the principle of least privilege exposing a lot of kernel
attack surface to processes that do not actually need it.
