Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199883;
	b=gyBK5qIbJVAAFjkv9RgXgIIr7P80itfm6+/eyRZBuov49CSLxpaEB7nM9B3dExIJZOPt
	 KuFf7MgkNkATaRLxB8Ywln0xR1uw+1EbNM69dDtYquytGWcsQy/SginZpP4AVYwVSrJ2D
	 eSO8LnVfHhiQ6YrU5jxzRICV6NIAgERyv6aVUNo3Sb+KeQtf3jMQO7rL/yh+Mauf/gw63
	 XS+T0xCpp2B3YxV+babTSPc8jiKR5OJgq5gsdwUZTTmuvq0gNgm+HxHtR+fh0I0Yzp+ub
	 t/o8srQsj2RvOCcwai4WFt31k4HwZGZCRR/2XTomOaDZc13USoQrH4DXSIPD1J7sswQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XYaYaDrK6jMizn1+Xu6y1/7dgY3Gd1He8P8gPiz0F7E=;
	b=kyGlICapXA36Zr1jQL/beph+AzGAf9raBK2eEZHJNh0vN1FYGLw+EjsI+WrO/DAt3ick
	 bagyxzI/KlqG0UzpQ86hod5ehUedlMQ0ab8Oc7k1ssuWsQ2+gxNIA2LaPNl/GWIxfpf+g
	 Aljz74trJ9Lo0WlvQDsFoKv4eFmHAACxVIIvqMUIyr7huIW92ggcuSEPLBxI7gbhiWewR
	 hMsOep80w32Tyx9FUe2EFu5XoerhAoEf9yyIiPSZkR93QE328MSAhHcg3MG2tU6+AvPsf
	 TUFK2GEMO5EH63iGFFBcyKtMUqkNT+O3dbXdo7C8yfzZBPCUSUetzamlhfu/uDX6+lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZk6euDx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE6606A32A;
	Wed, 28 Oct 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZk6euDx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5521F01825;
	Wed, 28 Oct 2026 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199883;
	bh=XYaYaDrK6jMizn1+Xu6y1/7dgY3Gd1He8P8gPiz0F7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZk6euDxLh9gazUrboTiSt4GUJlfKEae/MouSn9Wc1Arp91zupsB1k1jDRlMwYJvl
	 XGSXn+tVICjEwteXiLL5GEpIMJK1gez7aVMIXJdOnatS3FkOITUPgOM5SFZt5efn+o
	 X/nuKzvjpM8daROqjYI+GonVYeIWie4t/dbaJrA7z52OSXW2p9fNc2Fn/rH7z7RnNQ
	 MttyTvDiHHm+Z8ddJ1JlOjbvCVRbsfXqQ2bq+teRA2WSr0H7S8MhnUDOusbq+Qsjmt
	 EMj9sAah6zD3VVv7yFt/wyA41z35mtdy2CVcKLgr5ZWVQdBFxZEhLjchUbjo3JTjO6
	 24VSn+uFwxIOw==
Message-ID: <sashiko-outbox-188033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] selftests/dmabuf-heaps: Add dma-buf memcg
 accounting tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Albert Esteve" <aesteve@redhat.com>, "Tejun Heo" <tj@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, =?utf-8?b?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Michal
 Hocko" <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Benjamin Gaignard" <benjamin.gaignard@collabora.com>, "Brian
 Starkey" <Brian.Starkey@arm.com>, "John Stultz" <jstultz@google.com>, "T.J.
 Mercier" <tjmercier@google.com>, "Christian Brauner" <brauner@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 =?utf-8?b?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, "Jens Wiklander" <jenswi@kernel.org>, "Sumit
 Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-8-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-8-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:04:41 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] selftests/dmabuf-heaps: check_deps() runs before handle_build() =
in vmtest.sh
- [Medium] selftests/dmabuf-heaps: fail instead of skip on EOPNOTSUPP in XF=
ER_CHARGE test
- [Medium] selftests/dmabuf-heaps: pidfd_alloc_supported() treats EOPNOTSUP=
P as supported
- [Medium] selftests: dmabuf-heaps: no memory controller check in open_self=
_cgroupfd()
- [Medium] selftests: cgroup: MEMCG_DMABUF_WAIT_RETRIES is shorter than 2s =
rstat FLUSH_TIME
--

commit 764a620a8574ac6b7e6c57e6f71e4c743c373656
Author: Albert Esteve <aesteve@redhat.com>

selftests/dmabuf-heaps: Add dma-buf memcg accounting tests

This commit adds selftests for dma-buf memcg accounting via charge_fd in
DMA_HEAP_IOCTL_ALLOC and DMA_BUF_IOCTL_XFER_CHARGE across the dmabuf-heaps
and cgroup test suites, along with a vmtest.sh runner script.

> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index 0ed82347044ed..0b41c3c6f62c1 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -19,10 +19,20 @@
>  #include <errno.h>
>  #include <sys/mman.h>
> =20
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <signal.h>
> +#include <sys/ioctl.h>
> +
> +#include "../pidfd/pidfd.h"
>  #include "kselftest.h"
>  #include "cgroup_util.h"
> =20
> +#define DMA_HEAP_SYSTEM		"/dev/dma_heap/system"
> +#define ONE_MEG			(1024 * 1024)
> +
>  #define MEMCG_SOCKSTAT_WAIT_RETRIES        30
> +#define MEMCG_DMABUF_WAIT_RETRIES          15

[Severity: Medium]
Is MEMCG_DMABUF_WAIT_RETRIES (15 retries at 100ms intervals, or 1.4 seconds
before the final read) long enough to avoid races with the periodic rstat
flush in test_memcg_dmabuf() and test_memcg_dmabuf_xfer_at_limit()?

In mm/memcontrol.c, reading memory.stat calls mem_cgroup_flush_stats(), whi=
ch
only flushes rstat synchronously when stats_updates exceeds
MEMCG_CHARGE_BATCH * num_online_cpus() (64 * num_online_cpus()):

mm/memcontrol.c:mem_cgroup_flush_stats()
    if (atomic_long_read(&vmstats->stats_updates) >
        MEMCG_CHARGE_BATCH * num_online_cpus())
        ...

Charging or uncharging a ONE_MEG (1 MB) dma-buf in a fresh child cgroup
updates MEMCG_DMABUF by 256 pages on 4KB-page kernels (or 16 pages on
64KB-page kernels). When num_online_cpus() >=3D 4 (where 256 > 64 * 4 is fa=
lse)
or on >4KB-page kernels, reading memory.stat skips synchronous flushing and
relies on the periodic deferred work stats_flush_dwork, which runs every
FLUSH_TIME (2UL * HZ, or 2.0 seconds).

In test_memcg_dmabuf(), even if the first poll for ONE_MEG catches a period=
ic
flush, that flush resets stats_updates to 0 and schedules the next
stats_flush_dwork 2.0 seconds later. Immediately closing dmabuf_fd adds only
256 to stats_updates, so the subsequent 1.4-second poll for dmabuf =3D=3D 0=
 can
time out before the next 2.0-second periodic flush runs. Should
MEMCG_DMABUF_WAIT_RETRIES be at least 30, matching
MEMCG_SOCKSTAT_WAIT_RETRIES?

> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 1d49df6719198..90ef14d2ecba0 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

[ ... ]

> @@ -496,6 +505,218 @@ static void test_alloc_no_fd_leak_on_efault(char *h=
eap_name)

[ ... ]

> +/*
> + * Probe whether the kernel honours charge_fd in DMA_HEAP_IOCTL_ALLOC.
> + */
> +static bool pidfd_alloc_supported(int heap_fd)
> +{
> +	int devnull_fd, dmabuf_fd =3D -1, ret;
> +
> +	devnull_fd =3D open("/dev/null", O_RDONLY);
> +	if (devnull_fd < 0)
> +		return false;
> +
> +	ret =3D dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, devnull_fd, &dmabu=
f_fd);
> +	if (dmabuf_fd >=3D 0) {
> +		close(dmabuf_fd);
> +		dmabuf_fd =3D -1;
> +	}
> +	close(devnull_fd);
> +	return ret < 0;
> +}

[Severity: Medium]
What happens in pidfd_alloc_supported() when the kernel is built with
CONFIG_MEMCG=3Dn?

In drivers/dma-buf/dma-heap.c, dma_heap_ioctl_allocate() passes a non-zero
charge_fd to mem_cgroup_get_from_fd():

drivers/dma-buf/dma-heap.c:dma_heap_ioctl_allocate()
    if (heap_allocation->charge_fd) {
        memcg =3D mem_cgroup_get_from_fd(heap_allocation->charge_fd);
        if (IS_ERR(memcg))
            return ERR_CAST(memcg);
    }

When CONFIG_MEMCG is disabled, the stub in include/linux/memcontrol.h retur=
ns
ERR_PTR(-EOPNOTSUPP):

include/linux/memcontrol.h:mem_cgroup_get_from_fd()
    static inline struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
    {
        return ERR_PTR(-EOPNOTSUPP);
    }

Because dmabuf_heap_alloc_pidfd() returns -1 with errno =3D=3D EOPNOTSUPP,
returning ret < 0 causes pidfd_alloc_supported() to return true when
CONFIG_MEMCG=3Dn, and test_alloc_pidfd_self(), test_alloc_pidfd_child(),
test_alloc_cgroupfd_self(), and test_xfer_charge_cgroupfd_self() then proce=
ed
and report test failures instead of skipping. Should pidfd_alloc_supported()
also verify that errno !=3D EOPNOTSUPP (or errno =3D=3D EINVAL)?

[ ... ]

> +static int open_self_cgroupfd(void)
> +{
> +	char cgroup_path[PATH_MAX];
> +	char buf[PATH_MAX];
> +	FILE *f;
> +
> +	f =3D fopen("/proc/self/cgroup", "r");
> +	if (!f)
> +		return -1;
> +
> +	cgroup_path[0] =3D '\0';
> +	while (fgets(buf, sizeof(buf), f)) {
> +		char *p =3D buf;
> +
> +		if (strncmp(p, "0::", 3) =3D=3D 0) {
> +			p +=3D 3;
> +			p[strcspn(p, "\n")] =3D '\0';
> +			snprintf(cgroup_path, sizeof(cgroup_path),
> +				 "/sys/fs/cgroup%s", p);
> +			break;
> +		}
> +	}
> +	fclose(f);
> +
> +	if (!cgroup_path[0])
> +		return -1;
> +
> +	return open(cgroup_path, O_RDONLY | O_DIRECTORY);
> +}
> +
> +/*
> + * Test: allocate charging the calling process's own cgroup via a cgroup=
fd.
> + */
> +static void test_alloc_cgroupfd_self(char *heap_name)
> +{
> +	int heap_fd =3D -1, cgroup_fd =3D -1, dmabuf_fd =3D -1, ret;
> +
> +	heap_fd =3D dmabuf_heap_open(heap_name);
> +
> +	if (!pidfd_alloc_supported(heap_fd)) {
> +		ksft_test_result_skip("charge_fd not supported by this kernel\n");
> +		goto out;
> +	}
> +
> +	cgroup_fd =3D open_self_cgroupfd();
> +	if (cgroup_fd < 0) {
> +		ksft_test_result_skip("cannot open self cgroupfd\n");
> +		goto out;
> +	}
> +
> +	ret =3D dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, cgroup_fd, &dmabuf=
_fd);
> +	ksft_test_result(!ret, "Allocation with cgroupfd %d\n", ret);
> +	if (dmabuf_fd >=3D 0)
> +		close(dmabuf_fd);
> +	close(cgroup_fd);
> +out:
> +	close(heap_fd);
> +}

[Severity: Medium]
Can test_alloc_cgroupfd_self() and test_xfer_charge_cgroupfd_self() fail wi=
th
ENOENT instead of skipping when the test binary is run outside vmtest.sh (f=
or
example via make run_tests or vmtest.sh -s) in a cgroup where the memory
controller is not enabled?

Unlike the pidfd path in mem_cgroup_get_from_fd(), which uses
get_mem_cgroup_from_mm() and walks up to an online ancestor, the cgroupfd
path requires the memory controller CSS to be directly enabled on the target
cgroup itself:

mm/memcontrol.c:mem_cgroup_get_from_fd()
    cgrp =3D cgroup_get_from_fd(fd);
    if (!IS_ERR(cgrp)) {
        rcu_read_lock();
        css =3D cgroup_css(cgrp, &memory_cgrp_subsys);
        if (!css || !css_tryget_online(css)) {
            rcu_read_unlock();
            cgroup_put(cgrp);
            return ERR_PTR(-ENOENT);
        }

When dmabuf-heap runs in a leaf cgroup (such as a standard systemd user or
service scope) whose parent has not enabled +memory in
cgroup.subtree_control, or when booted with cgroup_disable=3Dmemory,
open_self_cgroupfd() still succeeds in opening the directory, and the ioctl
fails with ENOENT. Should open_self_cgroupfd() check that memory is active =
in
that cgroup (or should these two tests skip when the ioctl fails with
errno =3D=3D ENOENT)?

> +/*
> + * Test: transfer a dma-buf's charge to self cgroup via DMA_BUF_IOCTL_XF=
ER_CHARGE.
> + */
> +static void test_xfer_charge_cgroupfd_self(char *heap_name)
> +{
> +	int heap_fd =3D -1, cgroup_fd =3D -1, dmabuf_fd =3D -1, ret;
> +	struct dma_buf_transfer_charge xfer =3D { 0 };
> +
> +	heap_fd =3D dmabuf_heap_open(heap_name);
> +
> +	if (!pidfd_alloc_supported(heap_fd)) {
> +		ksft_test_result_skip("charge_fd not supported by this kernel\n");
> +		goto out;
> +	}
> +
> +	ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> +	if (ret) {
> +		ksft_test_result_fail("Allocation failed %d\n", ret);
> +		goto out;
> +	}
> +
> +	cgroup_fd =3D open_self_cgroupfd();
> +	if (cgroup_fd < 0) {
> +		ksft_test_result_skip("cannot open self cgroupfd\n");
> +		close(dmabuf_fd);
> +		goto out;
> +	}
> +
> +	xfer.charge_fd =3D cgroup_fd;
> +	ret =3D ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
> +	ksft_test_result(!ret, "XFER_CHARGE to self cgroupfd %d\n", ret);

[Severity: Medium]
Does test_xfer_charge_cgroupfd_self() report a failure instead of skipping
when main() iterates over non-system heaps in /dev/dma_heap (such as CMA
heaps when CONFIG_DMABUF_HEAPS_CMA=3Dy)?

In drivers/dma-buf/dma-heap.c, dma_heap_ioctl_allocate() validates charge_fd
before calling heap->ops->allocate(), so pidfd_alloc_supported() returns tr=
ue
for all heaps. However, in drivers/dma-buf/dma-buf.c, dma_buf_xfer_charge()
checks whether the exporter enabled memcg accounting on the buffer:

drivers/dma-buf/dma-buf.c:dma_buf_xfer_charge()
    if (!dmabuf->memcg_account)
        return -EOPNOTSUPP;

Because only system_heap sets exp_info.memcg_account =3D true (while export=
ers
such as cma_heap leave it false), ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARG=
E,
&xfer) returns -1 with errno =3D=3D EOPNOTSUPP on those heaps. Should
test_xfer_charge_cgroupfd_self() call ksft_test_result_skip() when ret < 0
and errno =3D=3D EOPNOTSUPP?

> diff --git a/tools/testing/selftests/dmabuf-heaps/vmtest.sh b/tools/testi=
ng/selftests/dmabuf-heaps/vmtest.sh
> new file mode 100755
> index 0000000000000..3574b71ca83e8
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/vmtest.sh

[ ... ]

> +check_deps() {
> +	for dep in vng make; do
> +		if [[ ! -x $(command -v "${dep}") ]]; then
> +			echo -e "skip:    dependency ${dep} not found!\n"
> +			exit "${KSFT_SKIP}"
> +		fi
> +	done
> +
> +	if ${SHELL_MODE}; then
> +		return
> +	fi
> +
> +	if [[ ! -x "${DMABUF_HEAP_TEST}" ]]; then
> +		printf "skip:    %s not found!" "${DMABUF_HEAP_TEST}"
> +		printf " Please build the kselftest dmabuf-heaps target (or use -b).\n"
> +		exit "${KSFT_SKIP}"
> +	fi
> +
> +	if [[ ! -x "${MEMCONTROL_TEST}" ]]; then
> +		printf "skip:    %s not found!" "${MEMCONTROL_TEST}"
> +		printf " Please build the kselftest cgroup target (or use -b).\n"
> +		exit "${KSFT_SKIP}"
> +	fi
> +}

[ ... ]

> +trap cleanup EXIT
> +
> +check_deps
> +check_vng
> +handle_build
> +make_runner

[Severity: Medium]
If vmtest.sh is invoked with -b on a clean tree where the selftest binaries
have not been built yet, won't check_deps() exit with KSFT_SKIP before
handle_build() has a chance to build them?

In the main flow, check_deps() runs before handle_build(), and inside
check_deps() only SHELL_MODE returns early before checking for
DMABUF_HEAP_TEST and MEMCONTROL_TEST. Should check_deps() also skip the
binary existence checks when BUILD is true (or run after handle_build())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D8
