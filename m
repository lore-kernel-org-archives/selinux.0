Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683868;
	b=2mduC8AL/j6DKbn6RnQ/SR93XfK79qDeAphCuqsWlYIJiupB43wX3dMAMx+yHn65f53X
	 0t1M6dmzuGLPz/JsGqF+NAw37aqpf1KnxhyqXAiqNFtQ/z77sJGydCsqM7lsScFekbVv5
	 oCI5iWzjJAxCzwqkTIKJQy5VNYrmrIaYWCFHar/a8/pz+aRNTnNaWXiR0ZI8SzDkDW7du
	 ikbaSS90ZtVgayAsKdiMe6/E1A3OHVU8gpDOoyjZfGun3tEkSqb6tIZCDWxsgNB8qgILz
	 dyKFQ3xBcIkKAaZjotWdYoXkxq1WKsyE2Vtc/vN4hql1tF9iWtrE7dGcZCGpg5wTWZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683868;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cY1hvaWh6Vk6/nIEt5/9rTdze650y5g5R3I1CecXjyo=;
	b=qq5mK2orgpx/UfZOGjKigz7Sq+y9MOFuM+2fEbTnwJGJvPZanbNewWJrnbUcb4jPqCUA
	 SyQG8iDiRQYYy2TFiGalM/X7mprYJh7MBCoYcTHaiCUIBbkWL7CvXFa82eLcpA9dnqRMa
	 qBqUWl+cuP/Fq7BiGl2zalTijAxyMbbian6lkgj54oP5ARUypL77hmhCDh15CCURuo1EO
	 QcsPr0cg041hF6ondgamIwoPIe3YdYRkgxjX9DLeil7NZnDPFwFERhG1kH1oAUb7XqbwX
	 Ew4UkpkF6tWLvPRWsuHBuEF5gKpLmqXA6eFQwhs+m7DiCxckVX+M2THThzNstfFDNOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JSUy/MnX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE316606A322;
	Thu, 22 Oct 2026 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSUy/MnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71EC1F031E0;
	Thu, 22 Oct 2026 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792683867;
	bh=cY1hvaWh6Vk6/nIEt5/9rTdze650y5g5R3I1CecXjyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JSUy/MnXegcnSG+fWAukS384bsK/wMQrMy5lkpbYQrgfGOExC0iCbDW599V2t85vN
	 vlzi8IJtSWee8I3GcVM0qy3olrYcraklK8mP7Sanqsn3XZEjm+axsN9qDtq2fh6+/K
	 lJmjlhjwSdYpMrRg2hpHK5khWNoZID5t9A1/y33+eGFLYna6wHU5alGgecC5p0k2x+
	 WWO10DiH3C4BP+0kvN1jWvKiP4HYj5MrHGdFfkS4YYoHADaTxvyDgUdHdomvvVMoYh
	 +j/x+peLVgtFX44NhkG+2mhxRsKxGSYKYAOEmt4m7qrDAyHTdQwnfsYaKbkK5YNFWU
	 YWux0CxHmkuJw==
Message-ID: <sashiko-outbox-181724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 8/8] selftests/dmabuf-heaps: Add dma-buf memcg
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
 =?utf-8?b?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, mripard@kernel.org, echanude@redhat.com, media-ci@linuxtv.org
In-Reply-To: <20261021-v2_20230123_tjmercier_google_com-v2-8-ef6ee2dd8c5c@redhat.com>
References: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
 <20261021-v2_20230123_tjmercier_google_com-v2-8-ef6ee2dd8c5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:44:25 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] selftests/dmabuf-heaps: missing skip check in test_xfer_charge_c=
groupfd_self()
- [Medium] selftests/dmabuf-heaps: missing cgroup2 and memcg checks in open=
_self_cgroupfd()
- [Medium] selftests/dmabuf-heaps: vmtest.sh executes runner from unshared =
/tmp in guest
- [Medium] selftests/dmabuf-heaps: vmtest.sh runs vng/make before check_dep=
s()
--

commit 0809a03b2fbc81e6f2b637ef5c0744b2c8ae99f1
Author: Albert Esteve <aesteve@redhat.com>

selftests/dmabuf-heaps: Add dma-buf memcg accounting tests

This commit adds selftests for dma-buf memcg accounting via charge_fd in
tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c and
tools/testing/selftests/cgroup/test_memcontrol.c, along with a virtme-ng
runner script in tools/testing/selftests/dmabuf-heaps/vmtest.sh.

> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 1d49df6719198..b1c58e5883f64 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

[ ... ]

> @@ -496,6 +505,213 @@ static void test_alloc_no_fd_leak_on_efault(char *h=
eap_name)

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
Can open_self_cgroupfd() return a directory fd that causes
test_alloc_cgroupfd_self() and test_xfer_charge_cgroupfd_self() to report a
hard failure instead of skipping when cgroup v2 or the memory controller is
not active on that path?

In open_self_cgroupfd(), the 0:: entry from /proc/self/cgroup is appended t=
o a
hardcoded /sys/fs/cgroup prefix without checking that /sys/fs/cgroup is a
cgroup2 mount. On systems using a hybrid hierarchy where /sys/fs/cgroup is a
tmpfs and unified cgroup v2 is mounted at /sys/fs/cgroup/unified, opening
/sys/fs/cgroup/ succeeds on tmpfs, and the kernel's cgroup_get_from_fd() th=
en
rejects charge_fd with EBADF.

Furthermore, unlike the pidfd path in dma_heap_ioctl_allocate() and
dma_buf_xfer_charge() which resolves the effective memcg via
get_mem_cgroup_from_mm(task->mm), the cgroupfd path calls
cgroup_css(cgrp, &memory_cgrp_subsys) directly on the target cgroup and
returns ENOENT if the memory controller is not enabled for that specific
cgroup (for example, when the test runs in a non-root cgroup whose parent h=
as
not enabled +memory in cgroup.subtree_control).

Should open_self_cgroupfd() verify that the resolved directory is on a
cgroup2 filesystem with the memory controller enabled, or should the callers
skip when the ioctl fails with ENOENT or EBADF?

> +
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
> +
> +	close(cgroup_fd);
> +	close(dmabuf_fd);
>  out:
>  	close(heap_fd);
>  }

[Severity: Medium]
Unlike test_alloc_pidfd_self(), test_alloc_pidfd_child(), and
test_alloc_cgroupfd_self(), test_xfer_charge_cgroupfd_self() does not call
pidfd_alloc_supported(heap_fd) or check for errno =3D=3D ENOTTY when
ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer) fails.

On an unpatched kernel where dmabuf_heap_alloc() and open_self_cgroupfd()
both succeed, won't ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer) retu=
rn
-1 with errno =3D=3D ENOTTY and cause ksft_test_result(!ret, ...) to report=
 a
failure instead of skipping?

[ ... ]

> diff --git a/tools/testing/selftests/dmabuf-heaps/vmtest.sh b/tools/testi=
ng/selftests/dmabuf-heaps/vmtest.sh
> new file mode 100755
> index 0000000000000..434857b765b84
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/vmtest.sh
> @@ -0,0 +1,205 @@

[ ... ]

> +readonly DMABUF_HEAP_TEST=3D"${SCRIPT_DIR}"/dmabuf-heap
> +readonly MEMCONTROL_TEST=3D"${CGROUP_DIR}"/test_memcontrol
> +readonly TMP_DIR=3D$(mktemp -d /tmp/dmabuf-vmtest.XXXXXXXX)

[ ... ]

> +build_selftests() {
> +	make -C "${KERNEL_CHECKOUT}" headers_install \
> +		INSTALL_HDR_PATH=3D"${TMP_DIR}/usr" -j"$(nproc)"
> +
> +	local khdr=3D"-isystem ${TMP_DIR}/usr/include"
> +
> +	if ! make -C "${SCRIPT_DIR}" KHDR_INCLUDES=3D"${khdr}" -j"$(nproc)"; th=
en
> +		die "failed to build dmabuf-heaps selftests"
> +	fi
> +
> +	if ! make -C "${CGROUP_DIR}" KHDR_INCLUDES=3D"${khdr}" \
> +		"${MEMCONTROL_TEST}" -j"$(nproc)"; then
> +		die "failed to build cgroup/test_memcontrol selftest"
> +	fi
> +}

[ ... ]

> +make_runner() {
> +	# virtme-ng shares the host filesystem, so TMP_DIR is accessible
> +	# inside the VM at the same absolute path.
> +	cat > "${TMP_DIR}/run_tests.sh" <<-EOF

[ ... ]

> +	EOF
> +	chmod +x "${TMP_DIR}/run_tests.sh"
> +}
> +
> +run_vm() {
> +	local verbose_opt=3D""
> +	local kernel_opt=3D""
> +
> +	${VERBOSE} && verbose_opt=3D"--verbose"
> +
> +	# If we are running from within the kernel source tree, use the kernel
> +	# source tree as the kernel to boot, otherwise use the running kernel.
> +	if [[ "$(realpath "$(pwd)")" =3D=3D "${KERNEL_CHECKOUT}"* ]]; then
> +		kernel_opt=3D"${KERNEL_CHECKOUT}"
> +	fi
> +
> +	vng --run ${kernel_opt} ${verbose_opt} --user root --memory 512M \
> +		--exec "${TMP_DIR}/run_tests.sh"
> +}

[Severity: Medium]
Will "${TMP_DIR}/run_tests.sh" be visible inside the guest VM when TMP_DIR =
is
created under /tmp?

When virtme-ng boots the guest, virtme-init mounts a fresh tmpfs over /tmp
inside the VM, which masks the host's /tmp directory unless TMP_DIR is
explicitly shared via --rodir / --rwdir or created under a shared directory
such as SCRIPT_DIR. Won't vng --run --exec "${TMP_DIR}/run_tests.sh" fail in
the guest because /tmp/dmabuf-vmtest.XXXXXXXX/run_tests.sh does not exist
there?

> +
> +while getopts :hvbH:p: o
> +do
> +	case $o in
> +	v) VERBOSE=3Dtrue;;
> +	b) BUILD=3Dtrue;;
> +	H) BUILD_HOST=3D$OPTARG;;
> +	p) BUILD_HOST_PODMAN_CONTAINER_NAME=3D$OPTARG;;
> +	h|*) usage;;
> +	esac
> +done
> +shift $((OPTIND-1))
> +
> +trap cleanup EXIT
> +
> +check_vng
> +handle_build
> +check_deps
> +make_runner
> +
> +echo "Booting VM and running tests..."
> +run_vm

[Severity: Medium]
Should check_deps() verify vng and make before check_vng() and handle_build=
()
are called?

Right now, if vng or make is not installed, check_vng() runs vng --version
first and prints a command-not-found error plus an untested-version warning,
and if -b is passed, handle_build() fails via die() with KSFT_FAIL instead =
of
exiting with KSFT_SKIP in check_deps().

Also, in handle_build(), the script uses pushd "${KERNEL_CHECKOUT}" and popd
to build the kernel, whereas run_vm() only sets kernel_opt=3D"${KERNEL_CHEC=
KOUT}"
when $(pwd) is inside KERNEL_CHECKOUT. If vmtest.sh -b is invoked from
outside KERNEL_CHECKOUT, won't run_vm() ignore the freshly built kernel and
boot the running host kernel instead? And in build_selftests(), should the
make headers_install command also be checked for failure before building the
tests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-v2_2023012=
3_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com?part=3D8
