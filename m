Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0AGdrxS025119
 for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2018 11:39:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 3zGvqp6VcRzrL7S
 for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2018 16:39:50 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 3zGvqm4cl2zrL7Y
 for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2018 16:39:48 +0000 (UTC)
Received: by mail-lf0-f52.google.com with SMTP id y71so20494663lfd.12
 for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2018 08:39:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171230171853.15639-1-richard_c_haines@btinternet.com>
References: <20171230171853.15639-1-richard_c_haines@btinternet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jan 2018 11:39:45 -0500
Message-ID: <CAHC9VhS_txcE=3r9MFNRwNuxNwK1JT1272h+yeqqx-gXMdYgzQ@mail.gmail.com>
To: linux-sctp@vger.kernel.org
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, nhorman@tuxdriver.com,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, marcelo.leitner@gmail.com,
 casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V4 0/4] Add SELinux SCTP protocol support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Dec 30, 2017 at 12:18 PM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Note: Some conflicts are expected when merging with current net-next due to
> Interleaving Data (I-DATA) sets of patches:
> PATCH 2/4 - Where 'sctp_datachk_len(&asoc->stream)' has replaced
> 'sizeof(struct sctp_data_chunk)' in include/net/sctp/sctp.h,
> net/sctp/chunk.c and net/sctp/socket.c
> PATCH 3/4 - Where include/uapi/linux/sctp.h requires a fix to update the
> #define SCTP_SENDMSG_CONNECT to a higher number.
>
> These patches have been built on Fedora 27 with kernel 4.14.8 plus
> the following userspace patches to enable testing:
>
> 1) Updates to libsepol 2.7 to support the sctp portcon statement.
>    The patch is available from:
>          http://arctic.selinuxproject.org/~rhaines/selinux-sctp/
>          selinux-Add-support-for-the-SCTP-portcon-keyword.patch
>
> 2) Updates to the SELinux Test Suite adding SCTP tests. Please read the
>    selinux-testsuite/README.sctp for details. The patch is available from:
>          http://arctic.selinuxproject.org/~rhaines/selinux-sctp/
>          selinux-testsuite-Add-SCTP-test-support.patch
>
> 3) Updates to lksctp-tools that show SELinux info in sctp_darn and
>    sctp_test. It also contains a minor patch for test_1_to_1_connect.c
>    as when CIPSO/CALIPSO configured, NetLabel returns a different error
>    code for illegal addresses in test 5. The patch is available from:
>          http://arctic.selinuxproject.org/~rhaines/selinux-sctp/
>          lksctp-tools-Add-SELinux-support-to-sctp_test-and-sc.patch
>
> All SCTP lksctp-tools/src/func_tests run correctly in enforcing mode.
>
> All SCTP regression tests "./sctp-tests run" run correctly in enforcing
> mode. These tests are obtained from: https://github.com/sctp/sctp-tests
>
> The selinux-testsuite patch also adds remote tests (that need some manual
> configuration). These are useful for testing CIPSO/CALIPSO over a network
> with a number of categories to produce large ip option fields with various
> message sizes forcing fragmentation etc..
>
> Changes since RFC Patch:
> Removed the NetLabel patch (was [RFC PATCH 4/5] netlabel: Add SCTP support)
> as re-engineered. However this patchset will require the NetLabel
> patch at [1] to fully run the SCTP selinux-testsuite.
>
> V1 Changes:
> PATCH 1/4
> Remove unused parameter from security_sctp_assoc_request().
> Reformat and update LSM-sctp.rst documentation.
> PATCH 2/4
> Add variables and RCU locks as requested in [2] to support IP options.
> PATCH 3/4
> Added security_sctp_assoc_request() hook to sctp_sf_do_unexpected_init()
> and sctp_sf_do_5_2_4_dupcook().
> Removed security_sctp_assoc_request() hook from sctp_sf_do_5_1C_ack() as
> no longer required.
> PATCH 4/4
> Reformat and update SELinux-sctp.rst documentation.
> Remove bindx and connectx permissions.
> Rework selinux_socket_connect() and selinux_netlbl_socket_connect() to
> utilise helpers for code reuse.
> Add spinlock to selinux_sctp_assoc_request().
> Remove unused parameter from security_sctp_assoc_request().
> Use address->sa_family == AF_INET in *_bind and *_connect to ensure
> correct address type.
> Minor cleanups.
>
> V2 Changes:
> PATCH 4/4 - Remove spin lock from selinux_sctp_assoc_request()
> PATCH 4/4 - Fix selinux_sctp_sk_clone() kbuild test robot catch [3]
>
> V3 Changes:
> PATCH 2/4 - Account for IP options length in sctp.h sctp_frag_point() by
> Marcelo
>
> V4 Changes:
> PATCH 1/4 - Move specific SELinux descriptions from LSM-sctp.rst and
> lsm_hooks.h to SELinux-sctp.rst in PATCH 4/4
> PATCH 4/4 - Rename selinux_netlbl_sctp_socket_connect() to
> selinux_netlbl_socket_connect_locked() and move description comments to
> selinux_sctp_bind_connect()
>
> [1] https://marc.info/?l=selinux&m=151061619115945&w=2
> [2] https://marc.info/?l=selinux&m=150962470215797&w=2
> [3] https://marc.info/?l=selinux&m=151198281817779&w=2

SCTP folks, any objections?  I'm planning on merging these into
selinux-next after the next merge window so if you want to see any
changes, please speak up ...

-- 
paul moore
www.paul-moore.com
