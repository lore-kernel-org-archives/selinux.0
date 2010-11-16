Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oAGLVf7V030202
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2010 16:31:41 -0500
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oAGLVeWl011840
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2010 21:31:40 GMT
Date: Wed, 17 Nov 2010 08:31:23 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: Eric Paris <eparis@redhat.com>
Subject: Fw: Sluggishness on a GEM system due to SELinux's sidtab_search_context()
 as well as get_unmapped_area() (fwd)
Message-ID: <alpine.LRH.2.00.1011170831040.7789@tundra.namei.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Begin forwarded message:

Date: Mon, 15 Nov 2010 11:52:05 +0800
From: r6144 <rainy6144@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Sluggishness on a GEM system due to SELinux's sidtab_search_context() as well as get_unmapped_area()


Hello,

I'm noticing significant sluggishness when switching into a workspace
where Evolution is running.

My kernel is Fedora 12's 2.6.32.16-150.fc12.x86_64 (I know it is
old...), and the open source radeon (r600) driver is used.  Oprofile
shows the follows:

CPU: Core 2, speed 2003 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Clock cycles when not halted) with a
unit mask of 0x00 (Unhalted core cycles) count 100000
Counted INST_RETIRED_ANY_P events (number of instructions retired) with
a unit mask of 0x00 (No unit mask) count 100000
samples  %        samples  %        image name               app name
symbol name
126807   31.2201  38744    28.3866  vmlinux                  Xorg
(deleted)           find_vma
48661    11.9804  3474      2.5453  vmlinux                  Xorg
(deleted)           mls_compute_sid
41806    10.2927  5700      4.1762  vmlinux                  Xorg
(deleted)           sidtab_search_context
11888     2.9268  4234      3.1021  Xorg (deleted)           Xorg
(deleted)           /usr/bin/Xorg (deleted)
8660      2.1321  1589      1.1642  drm                      Xorg
(deleted)           /drm
6228      1.5333  6773      4.9624  radeon                   Xorg
(deleted)           /radeon
6214      1.5299  1832      1.3423  libc-2.11.2.so (deleted) Xorg
(deleted)           /lib64/libc-2.11.2.so (deleted)
5542      1.3644  4929      3.6113
libpixman-1.so.0.16.6.#prelink#.3I5wow (deleted) Xorg
(deleted)           /usr/lib64/libpixman-1.so.0.16.6.#prelink#.3I5wow
(deleted)
4149      1.0215  1776      1.3012  libexa.so                Xorg
(deleted)           /usr/lib64/xorg/modules/libexa.so
4140      1.0193  640       0.4689  vmlinux                  oprofiled
mls_compute_sid
3183      0.7837  847       0.6206  vmlinux                  Xorg
(deleted)           arch_get_unmapped_area_topdown
...

Although I haven't looked into it, presumably Evolution is asking the X
server to create and map a lot of TTM objects (pixmaps?).  The creation
of each object uses shmem_file_setup() and thus necessitates SELinux
calls, and since the X process already has a lot of mappings (one
mapping for each XRender glyph it seems, with "wc -l /proc/`pgrep
Xorg`/maps" returning 6766), the mapping part could also be slow.

I think the slowness of find_vma is related to
https://bugzilla.kernel.org/show_bug.cgi?id=17531 .  mls_compute_sid()
did a linear search over the range transition rules and was therefore
slow, but more recent kernels use a hash table so this problem has been
solved.  Another offender is sidtab_search_context() used to convert a
SELinux context back into an sid, which is also a linear search as there
is only a sid => context hash table, and I haven't seen any recent
changes in this area.

Please CC me as I'm not subscribed.

r6144

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
