Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6REEaLp012408
 for <selinux@tycho.nsa.gov>; Wed, 27 Jul 2016 10:14:37 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A879485A06
 for <selinux@tycho.nsa.gov>; Wed, 27 Jul 2016 14:14:33 +0000 (UTC)
Received: from dhcp-10-19-62-196.boston.devel.redhat.com
 (dhcp-25-88.bos.redhat.com [10.18.25.88])
 by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u6REEXE1016350
 for <selinux@tycho.nsa.gov>; Wed, 27 Jul 2016 10:14:33 -0400
To: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Subject: I still think typebounds checking is too tight.
Message-ID: <d96a16a9-62e9-f65f-f045-eb7678acd620@redhat.com>
Date: Wed, 27 Jul 2016 10:14:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We are now seeing breakage on entrypoint.


If I have a less confined domain and I want to allow unconfined_t to
transition to it, the compiler and the kernel eliminate entrypoints calls.

unconfined_typebounds(svirt_lxc_net_t)

Causes thousands of these errors.

  (allow svirt_lxc_net_t ccs_exec_t (file (entrypoint)))
    <See previous>
  (allow svirt_lxc_net_t canna_initrc_exec_t (file (entrypoint)))
    <See previous>
  (allow svirt_lxc_net_t canna_exec_t (file (entrypoint)))
    <See previous>
  (allow svirt_lxc_net_t callweaver_initrc_exec_t (file (entrypoint)))
    <See previous>
  (allow svirt_lxc_net_t callweaver_exec_t (file (entrypoint)))
    <See previous>
  (allow svirt_lxc_net_t calamaris_exec_t (file (entrypoint)))
    <See previous>
  (allow svirt_lxc_net_t cachefilesd_exec_t (file (entrypoint)))
    <See previous>
  (allow svirt_lxc_net_t bumblebee_exec_t (file (entrypoint)))
    <See previous>

Since svirt_lxc_net_t can be entered via an exec_type.  But unconfined_t
can not.  I think this access should be treated like a target also.

IE Ignored, I don't want to have to allow unconfined_t or docker_t to be
able to be entered by all of the domains that svirt_lxc_net_t could be

entered from.
