Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4E3C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 12:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8B624687
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 12:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgA1MZd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:25:33 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:40986 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgA1MZd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 28 Jan 2020 07:25:33 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id CA50B132060C
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2020 13:25:29 +0100 (CET)
Date:   Tue, 28 Jan 2020 13:25:27 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: CIL: another segfault producer
Message-ID: <20200128122527.GA36656@brutus.lan>
Mail-Followup-To: selinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In trying to reduce points of failure in my policy I encountered another se=
gfault

I want to centralize common permissions, for example common create and comm=
on read/write socket perms:

 872 (classmap all_sockets                                                 =
         |
 873           (common_create_socket_perms common_readwrite_socket_perms)) =
         |
 874                                                                       =
         |
 875 (classmap common_alg_socket                                           =
         |
 876           (common_create_socket_perms common_readwrite_socket_perms)) =
         |
 877 (classmap common_appletalk_socket                                     =
         |
 878           (common_create_socket_perms common_readwrite_socket_perms)) =
         |
 879                                                                       =
         |
 880 (classmapping                                                         =
         |
 881  all_sockets                                                          =
         |
 882  common_create_socket_perms                                           =
         |
 883   (common_alg_socket                                                  =
         |
 884    (common_create_socket_perms)))                                     =
         |
 885                                                                       =
         |
 886 (classmapping                                                         =
         |
 887  all_sockets                                                          =
         |
 888  common_create_socket_perms                                           =
         |
 889  (common_appletalk_socket                                             =
         |
 890    (common_create_socket_perms)))                                     =
         |
 891                                                                       =
         |
 892 (classmapping                                                         =
         |
 893  all_sockets                                                          =
         |
 894  common_readwrite_socket_perms                                        =
         |
 895   (common_alg_socket                                                  =
         |
 896    (common_readwrite_socket_perms)))                                  =
         |
 897                                                                       =
         |
 898 (classmapping                                                         =
         |
 899  all_sockets                                                          =
         |
 900  common_readwrite_socket_perms                                        =
         |
 901  (common_appletalk_socket                                             =
         |
 902    (common_readwrite_socket_perms)))                                  =
         |
 903                                                                       =
         |
 904 (classmapping                                                         =
         |
 905  common_alg_socket                                                    =
         |
 906  common_create_socket_perms                                           =
         |
 907  (alg_socket                                                          =
         |
 908   (append bind connect create getattr getopt ioctl read setattr setopt=
 shutdown|
 909           write)))                                                    =
         |
 910                                                                       =
         |
 911 (classmapping                                                         =
         |
 912  common_alg_socket                                                    =
         |
 913  common_readwrite_socket_perms                                        =
         |
 914  (alg_socket                                                          =
         |
 915   (append bind connect getattr getopt ioctl read setattr setopt shutdo=
wn       |
 916           write)))                                                    =
         |
 917                                                                       =
         |
 918 (classpermission create_alg_socket_perms)                             =
         |
 919                                                                       =
         |
 920 (classpermissionset                                                   =
         |
 921  create_alg_socket_perms                                              =
         |
 922  (common_alg_socket                                                   =
         |
 923   (common_create_socket_perms)))                                      =
         |
 924                                                                       =
         |
 925 (classpermission readwrite_alg_socket_perms)                          =
         |
 926                                                                       =
         |
 927 (classpermissionset                                                   =
         |
 928  readwrite_alg_socket_perms                                           =
         |
 929  (common_alg_socket                                                   =
         |
 930   (common_readwrite_socket_perms)))                                   =
         |

<snip>
Building AST from Parse Tree
Destroying Parse Tree
Resolving AST
Qualifying Names
Compile post process
make: *** [Makefile:21: policy.32] Segmentation fault (core dumped)

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl4wKDEACgkQAlFoDzf+
eRNBTg//alyKG6oi1xwXzxj1dMBNg9OK0s8IXw6bRPeJ4ptq+l93VK2Q2yYVrDTb
KPRZ+4ZB/Tiych4yAB1vM0TTo+ZDOQeSEB64vcUyjcYPx3hzn8iJa+O/GTAcUIDK
D5tuSGQrOB+yy0xEGPTQdz0LPXu4/JDPfvFQejgTHR+a2JXRLIpBWbIXwWARpLTo
1bARbjqivcMQJVjsTFUxT9vnYfgtmMkMvYxTSBMkcTmvd5Svw2ATqJfrk/kXZUMT
Oz7cZKNQokpXCmp58QK2GmTI0EBxbMhv8oAdy2ynhAr/EKc4rVl+yyktf5Oy+947
yGciuJe1Utb5/Qzi5lZA686qpwkybo28PUVN9kse744eNz1Fq4pqwXxF7grbz2kH
B6j1kRbUvyxhqVejxDGgPPUSKoQPCFjfWZj7JVQ4pMpIGEk1AP+v+jDorPjp3AWC
AIec0RmVoCVyLRlSVIOW+EEW8dSF5PDUkix9vZIelz9V4S78LLzJI2wwPDTkBlFh
bVXtK66EJ1fE75qBzkQSqnsSWOSVzHducEmpSmQ3KS0qF+ZKmSVmvAUAOpUWs3wB
SO2GcPmm0P+jbtRVK8pkVM2bAjijSOBM2o2Bb/IY0RbaNQlfNB+O+QUUgmGLiNBR
otPVa7XQgqPl4KNxddVOnzKsQf3ddcpBvo1pSWCnUGFqox1zm8c=
=NU9H
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
