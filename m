Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3F60B9C
	for <selinux@vger.kernel.org>; Fri, 17 May 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715974680; cv=none; b=V+CPkvzlWZ63Bjhi2RW103Aj1jetWI/L+kKFS+wbbQJhFkxUAeORFPFMwvBS3WPC/Wj0DntG8pJdiXYnrZtAmM3+HGUNGfLT1uSHJDM6fFu1Ic4Kpn+tg+xJgnoxgtPd5AFd+DNNxEKai+e2noyMecD5EDymf06F/MzYWp9zknM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715974680; c=relaxed/simple;
	bh=sWyRPBheB/ruk8SEUmWe5JFy8MgIQH9OH1g0A9y9GT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXPxc/5qJ54m6YK3Y71D9yd4iooLXQMMfKWUkKInHHoUCi1DnMA3FtJa3LN8McPSsqCRJNGksljtC6PZAv6DK6L9UwrCA1zE3ufPFLywKnnBU7AdLQQSrcN3w19Ww3do2Ka4TKn1P/qwA4tBtpGPGYmSNLrHjO/Gj0vyLEbqum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiYYntfd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiYYntfd"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52232d0e5ceso1329361e87.0
        for <selinux@vger.kernel.org>; Fri, 17 May 2024 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715974675; x=1716579475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDYTB2wrADR3VgO8VG7czZaOtox+LLQbPQT3Sj5sUkI=;
        b=MiYYntfdvKTE6Bv8ePXQTHQ0TMZYPoVhAWty9aiHoKSiORBKTOGxXDBsINjZx7N3Hg
         11K/qo1u/D5e9vi3aOIPqsOaqWHN19XaxE8vObxb8CdNxwyYmV4ttKSz/LkVYyLpelk0
         /A5KGTF4fMimx+kqyUh8w3FhA6h6mBXD10Ab8BGXAJYEUkYJ8k2wdnFyky1SM8lzNeqQ
         UvZO7uTHGacqAwHkZkHTyCe3/kZ31ylb7PVc0v56+EYqMuAL+Wy02f1Nxvpbrln5Nn4s
         gVdF4ueQTuobVHDCNf92oeDGXN8JoSETSGvhpJZXiSaSbZgDPzTltWmEoQso9VO8vWXr
         4DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715974675; x=1716579475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDYTB2wrADR3VgO8VG7czZaOtox+LLQbPQT3Sj5sUkI=;
        b=CtCUaoj6ILnUgpILSJ0xF1ZyQ+RHrSPFNxk6TAWPNX44JontVyJGe3rb8IKhHiHtS8
         rviL6DV2OcOsZJOhpEDdXyG/T0yI50+3ahOqqIyQGsx56vv0e24F2drf6BJzPD+yx1RJ
         hsEuSllfz7pn3USXlnudm9NQDsEbyKGxOKQw0e6rJZHektpe73FXKg9ZZUxgJuzsD9lr
         7ZgXUAZllEoti1oyJkgtynQFNCo5yKOk/4HerEIpUlAoe5jpPOMTOzRMkMf3xnIr26at
         4j0i3LNiT/mJrOJMyEM9BpnF8jk0L7ONTHsn1YQrbNAGonMdAzaXr8zN5gXYBtrQgLC0
         Okhg==
X-Gm-Message-State: AOJu0Yw4404EGe4w688hLflYTHsq1/bVVG4BUVWlzCBSCHGXronFCyKx
	LK+HMw/QSb6hZXDnBkUK01TkqPEENUMi35c2PnBXKB1T6tdU+UzyuypEwQ==
X-Google-Smtp-Source: AGHT+IGjYc/IBDEPKjSO3eCs/w3hdh0n3PLVIOg07/9IPUeenICobIadBxG0eMo+chnV9rAGo6cYOg==
X-Received: by 2002:a05:6512:3e1e:b0:523:2ed9:edf9 with SMTP id 2adb3069b0e04-5232ed9ef10mr11929006e87.63.1715974674932;
        Fri, 17 May 2024 12:37:54 -0700 (PDT)
Received: from localhost.localdomain (85-156-69-24.elisa-laajakaista.fi. [85.156.69.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba739sm3373840e87.101.2024.05.17.12.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 12:37:54 -0700 (PDT)
From: Topi Miettinen <toiwoton@gmail.com>
To: selinux@vger.kernel.org
Cc: Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH PR #134] sesearch: CIL output
Date: Fri, 17 May 2024 22:33:12 +0300
Message-ID: <20240517193311.12163-2-toiwoton@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Examples:
$ sesearch --cil --allow --source init_t --target install_t --class process=
 policy.33.fedora
(allow init_t domain (process (getattr getpgid noatsecure rlimitinh setrlim=
it setsched sigchld sigkill signal signull sigstop)))
(allow init_t install_t (process (transition)))
(booleanif (deny_ptrace)
        (false
                (allow domain install_t (process (sigchld)))
        )
)

$ sesearch --cil --allow --bool httpd_builtin_scripting --class fifo_file p=
olicy.33.fedora
(booleanif ((and httpd_builtin_scripting (and httpd_unified httpd_enable_cg=
i)))
        (true
                (allow httpd_sys_script_t httpd_t (fifo_file (append getatt=
r ioctl lock read)))
        )
)

$ sesearch --cil --type_transition --source init_t --target NetworkManager_=
exec_t policy.33.fedora
(type_transition init_t NetworkManager_exec_t (process (NetworkManager_t)))

$ sesearch --cil --type_member --source pulseaudio_t policy.33.fedora
(type_member pulseaudio_t tmp_t (dir (user_tmp_t)))

$ sesearch --cil --type_change --source auditadm_t policy.33.fedora
(booleanif (login_console_enabled)
        (true
                (type_change auditadm_t console_device_t (chr_file (user_tt=
y_device_t)))
        )
)
(type_change auditadm_t sshd_devpts_t (chr_file (user_devpts_t)))
(type_change auditadm_t systemd_machined_devpts_t (chr_file (user_devpts_t)=
))
(type_change auditadm_t tty_device_t (chr_file (user_tty_device_t)))

$ sesearch --cil --role_allow --source staff_r --target secadm_r policy.33.=
fedora
(roleallow staff_r secadm_r)

$ sesearch --cil --role_trans --source system_r policy.33.fedora
(roletransition system_r unconfined_exec_t process unconfined_r)

$ sesearch --cil --range_trans --source init_t --target abrt_exec_t policy.=
33.fedora
(rangetransition init_t abrt_exec_t process (s0 s0 (c0 c1 c2 c3 c4 c5 c6 c7=
 c8 c9 c10 c11 c12 c13 c14 c15 c16 c17 c18 c19 c20 c21 c22 c23 c24 c25 c26 =
c27 c28 c29 c30 c31 c32 c33 c34 c35 c36 c37 c38 c39 c40 c41 c42 c43 c44 c45=
 c46 c47 c48 c49 c50 c51 c52 c53 c54 c55 c56 c57 c58 c59 c60 c61 c62 c63 c6=
4 c65 c66 c67 c68 c69 c70 c71 c72 c73 c74 c75 c76 c77 c78 c79 c80 c81 c82 c=
83 c84 c85 c86 c87 c88 c89 c90 c91 c92 c93 c94 c95 c96 c97 c98 c99 c100 c10=
1 c102 c103 c104 c105 c106 c107 c108 c109 c110 c111 c112 c113 c114 c115 c11=
6 c117 c118 c119 c120 c121 c122 c123 c124 c125 c126 c127 c128 c129 c130 c13=
1 c132 c133 c134 c135 c136 c137 c138 c139 c140 c141 c142 c143 c144 c145 c14=
6 c147 c148 c149 c150 c151 c152 c153 c154 c155 c156 c157 c158 c159 c160 c16=
1 c162 c163 c164 c165 c166 c167 c168 c169 c170 c171 c172 c173 c174 c175 c17=
6 c177 c178 c179 c180 c181 c182 c183 c184 c185 c186 c187 c188 c189 c190 c19=
1 c192 c193 c194 c195 c196 c197 c198 c199 c200 c201 c202 c203 c204 c205 c20=
6 c207 c208 c209 c210 c211 c212 c213 c214 c215 c216 c217 c218 c219 c220 c22=
1 c222 c223 c224 c225 c226 c227 c228 c229 c230 c231 c232 c233 c234 c235 c23=
6 c237 c238 c239 c240 c241 c242 c243 c244 c245 c246 c247 c248 c249 c250 c25=
1 c252 c253 c254 c255 c256 c257 c258 c259 c260 c261 c262 c263 c264 c265 c26=
6 c267 c268 c269 c270 c271 c272 c273 c274 c275 c276 c277 c278 c279 c280 c28=
1 c282 c283 c284 c285 c286 c287 c288 c289 c290 c291 c292 c293 c294 c295 c29=
6 c297 c298 c299 c300 c301 c302 c303 c304 c305 c306 c307 c308 c309 c310 c31=
1 c312 c313 c314 c315 c316 c317 c318 c319 c320 c321 c322 c323 c324 c325 c32=
6 c327 c328 c329 c330 c331 c332 c333 c334 c335 c336 c337 c338 c339 c340 c34=
1 c342 c343 c344 c345 c346 c347 c348 c349 c350 c351 c352 c353 c354 c355 c35=
6 c357 c358 c359 c360 c361 c362 c363 c364 c365 c366 c367 c368 c369 c370 c37=
1 c372 c373 c374 c375 c376 c377 c378 c379 c380 c381 c382 c383 c384 c385 c38=
6 c387 c388 c389 c390 c391 c392 c393 c394 c395 c396 c397 c398 c399 c400 c40=
1 c402 c403 c404 c405 c406 c407 c408 c409 c410 c411 c412 c413 c414 c415 c41=
6 c417 c418 c419 c420 c421 c422 c423 c424 c425 c426 c427 c428 c429 c430 c43=
1 c432 c433 c434 c435 c436 c437 c438 c439 c440 c441 c442 c443 c444 c445 c44=
6 c447 c448 c449 c450 c451 c452 c453 c454 c455 c456 c457 c458 c459 c460 c46=
1 c462 c463 c464 c465 c466 c467 c468 c469 c470 c471 c472 c473 c474 c475 c47=
6 c477 c478 c479 c480 c481 c482 c483 c484 c485 c486 c487 c488 c489 c490 c49=
1 c492 c493 c494 c495 c496 c497 c498 c499 c500 c501 c502 c503 c504 c505 c50=
6 c507 c508 c509 c510 c511 c512 c513 c514 c515 c516 c517 c518 c519 c520 c52=
1 c522 c523 c524 c525 c526 c527 c528 c529 c530 c531 c532 c533 c534 c535 c53=
6 c537 c538 c539 c540 c541 c542 c543 c544 c545 c546 c547 c548 c549 c550 c55=
1 c552 c553 c554 c555 c556 c557 c558 c559 c560 c561 c562 c563 c564 c565 c56=
6 c567 c568 c569 c570 c571 c572 c573 c574 c575 c576 c577 c578 c579 c580 c58=
1 c582 c583 c584 c585 c586 c587 c588 c589 c590 c591 c592 c593 c594 c595 c59=
6 c597 c598 c599 c600 c601 c602 c603 c604 c605 c606 c607 c608 c609 c610 c61=
1 c612 c613 c614 c615 c616 c617 c618 c619 c620 c621 c622 c623 c624 c625 c62=
6 c627 c628 c629 c630 c631 c632 c633 c634 c635 c636 c637 c638 c639 c640 c64=
1 c642 c643 c644 c645 c646 c647 c648 c649 c650 c651 c652 c653 c654 c655 c65=
6 c657 c658 c659 c660 c661 c662 c663 c664 c665 c666 c667 c668 c669 c670 c67=
1 c672 c673 c674 c675 c676 c677 c678 c679 c680 c681 c682 c683 c684 c685 c68=
6 c687 c688 c689 c690 c691 c692 c693 c694 c695 c696 c697 c698 c699 c700 c70=
1 c702 c703 c704 c705 c706 c707 c708 c709 c710 c711 c712 c713 c714 c715 c71=
6 c717 c718 c719 c720 c721 c722 c723 c724 c725 c726 c727 c728 c729 c730 c73=
1 c732 c733 c734 c735 c736 c737 c738 c739 c740 c741 c742 c743 c744 c745 c74=
6 c747 c748 c749 c750 c751 c752 c753 c754 c755 c756 c757 c758 c759 c760 c76=
1 c762 c763 c764 c765 c766 c767 c768 c769 c770 c771 c772 c773 c774 c775 c77=
6 c777 c778 c779 c780 c781 c782 c783 c784 c785 c786 c787 c788 c789 c790 c79=
1 c792 c793 c794 c795 c796 c797 c798 c799 c800 c801 c802 c803 c804 c805 c80=
6 c807 c808 c809 c810 c811 c812 c813 c814 c815 c816 c817 c818 c819 c820 c82=
1 c822 c823 c824 c825 c826 c827 c828 c829 c830 c831 c832 c833 c834 c835 c83=
6 c837 c838 c839 c840 c841 c842 c843 c844 c845 c846 c847 c848 c849 c850 c85=
1 c852 c853 c854 c855 c856 c857 c858 c859 c860 c861 c862 c863 c864 c865 c86=
6 c867 c868 c869 c870 c871 c872 c873 c874 c875 c876 c877 c878 c879 c880 c88=
1 c882 c883 c884 c885 c886 c887 c888 c889 c890 c891 c892 c893 c894 c895 c89=
6 c897 c898 c899 c900 c901 c902 c903 c904 c905 c906 c907 c908 c909 c910 c91=
1 c912 c913 c914 c915 c916 c917 c918 c919 c920 c921 c922 c923 c924 c925 c92=
6 c927 c928 c929 c930 c931 c932 c933 c934 c935 c936 c937 c938 c939 c940 c94=
1 c942 c943 c944 c945 c946 c947 c948 c949 c950 c951 c952 c953 c954 c955 c95=
6 c957 c958 c959 c960 c961 c962 c963 c964 c965 c966 c967 c968 c969 c970 c97=
1 c972 c973 c974 c975 c976 c977 c978 c979 c980 c981 c982 c983 c984 c985 c98=
6 c987 c988 c989 c990 c991 c992 c993 c994 c995 c996 c997 c998 c999 c1000 c1=
001 c1002 c1003 c1004 c1005 c1006 c1007 c1008 c1009 c1010 c1011 c1012 c1013=
 c1014 c1015 c1016 c1017 c1018 c1019 c1020 c1021 c1022 c1023)))

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 man/sesearch.1                      |   2 +
 sesearch                            |   3 +-
 setools/policyrep.pyi               |   2 +
 setools/policyrep/boolcond.pxi      | 123 +++++++++++++++++-----------
 setools/policyrep/mls.pxi           |  37 +++++----
 setools/policyrep/mlsrule.pxi       |   5 +-
 setools/policyrep/rbacrule.pxi      |  10 ++-
 setools/policyrep/role.pxi          |  24 ++++--
 setools/policyrep/selinuxpolicy.pxi |   5 +-
 setools/policyrep/terule.pxi        |  71 ++++++++++------
 10 files changed, 183 insertions(+), 99 deletions(-)

diff --git a/man/sesearch.1 b/man/sesearch.1
index 967d6e2d..452c7902 100644
--- a/man/sesearch.1
+++ b/man/sesearch.1
@@ -105,6 +105,8 @@ Print version information and exit.
 Print additional informational messages.
 .IP "--debug"
 Enable debugging output.
+.IP "-C, --cil"
+Set output format to CIL.
=20
 .SH EXAMPLE
 .nf
diff --git a/sesearch b/sesearch
index 0b6fdb46..22ab0587 100755
--- a/sesearch
+++ b/sesearch
@@ -21,6 +21,7 @@ parser.add_argument("policy", help=3D"Path to the SELinux=
 policy to search.", narg
 parser.add_argument("-v", "--verbose", action=3D"store_true",
                     help=3D"Print extra informational messages")
 parser.add_argument("--debug", action=3D"store_true", dest=3D"debug", help=
=3D"Enable debugging.")
+parser.add_argument("-C", "--cil", action=3D"store_true", dest=3D"gen_cil"=
, help=3D"Enable CIL output.")
=20
 rtypes =3D parser.add_argument_group("TE Rule Types")
 rtypes.add_argument("-A", action=3D"store_true", help=3D"Search allow and =
allowxperm rules.")
@@ -143,7 +144,7 @@ else:
         warnings.simplefilter("ignore")
=20
 try:
-    p =3D setools.SELinuxPolicy(args.policy)
+    p =3D setools.SELinuxPolicy(args.policy, gen_cil=3Dargs.gen_cil)
=20
     if args.tertypes:
         terq =3D setools.TERuleQuery(p,
diff --git a/setools/policyrep.pyi b/setools/policyrep.pyi
index 445a2b4d..58335d5e 100644
--- a/setools/policyrep.pyi
+++ b/setools/policyrep.pyi
@@ -135,6 +135,7 @@ class ConditionalOperator(PolicyObject):
     evaluate: Callable =3D ...
     precedence: int =3D ...
     unary: bool =3D ...
+    cil_text: str =3D ...
=20
 class Constraint(BaseConstraint):
     perms: frozenset[str] =3D ...
@@ -376,6 +377,7 @@ class SELinuxPolicy:
     dontaudit_count: int =3D ...
     dontauditxperm_count: int =3D ...
     fs_use_count: int =3D ...
+    gen_cil: bool =3D ...
     genfscon_count: int =3D ...
     handle_unknown: "HandleUnknown" =3D ...
     ibendportcon_count: int =3D ...
diff --git a/setools/policyrep/boolcond.pxi b/setools/policyrep/boolcond.pxi
index 93e48e1d..f9a2473d 100644
--- a/setools/policyrep/boolcond.pxi
+++ b/setools/policyrep/boolcond.pxi
@@ -78,50 +78,77 @@ cdef class Conditional(PolicyObject):
         return other in self.booleans
=20
     def __str__(self):
-        # sepol representation is in postfix notation.  This code
-        # converts it to infix notation.  Parentheses are added
-        # to ensure correct expressions, though they may end up
-        # being overused.  Set previous operator at start to the
-        # highest precedence (NOT) so if there is a single binary
-        # operator, no parentheses are output
-        stack =3D []
-        prev_op_precedence =3D 5
-
-        for expr_node in self.expression():
-            if isinstance(expr_node, Boolean):
-                # append the boolean name
-                stack.append(str(expr_node))
-            elif expr_node.unary:
-                operand =3D stack.pop()
-                operator =3D str(expr_node)
-                op_precedence =3D expr_node.precedence
-
-                # NOT is the highest precedence, so only need
-                # parentheses if the operand is a subexpression
-                if isinstance(operand, list):
-                    subexpr =3D [operator, "(", operand, ")"]
+        if self.policy.gen_cil:
+            # sepol representation is in postfix notation.  This code
+            # converts it to prefix notation used by CIL.  Parentheses
+            # are always needed.
+            stack =3D []
+
+            for expr_node in self.expression():
+                if isinstance(expr_node, Boolean):
+                    # append the boolean name
+                    stack.append(str(expr_node))
+                elif expr_node.unary:
+                    operand =3D stack.pop()
+                    operator =3D str(expr_node)
+
+                    subexpr =3D ["(", operator, " ", operand, ")"]
+
+                    stack.append(subexpr)
                 else:
-                    subexpr =3D [operator, operand]
+                    operand1 =3D stack.pop()
+                    operand2 =3D stack.pop()
+                    operator =3D str(expr_node)
=20
-                stack.append(subexpr)
-                prev_op_precedence =3D op_precedence
-            else:
-                operand1 =3D stack.pop()
-                operand2 =3D stack.pop()
-                operator =3D str(expr_node)
-                op_precedence =3D expr_node.precedence
+                    subexpr =3D ["(", operator, " ", operand1, " ", operan=
d2, ")"]
+
+                    stack.append(subexpr)
+            return ''.join(flatten_list(stack))
=20
-                if prev_op_precedence > op_precedence:
-                    # if previous operator is of higher precedence
-                    # no parentheses are needed.
-                    subexpr =3D [operand1, operator, operand2]
+        else:
+            # This code converts sepol to infix notation.  Parentheses are
+            # added to ensure correct expressions, though they may end up
+            # being overused.  Set previous operator at start to the
+            # highest precedence (NOT) so if there is a single binary
+            # operator, no parentheses are output
+            stack =3D []
+            prev_op_precedence =3D 5
+
+            for expr_node in self.expression():
+                if isinstance(expr_node, Boolean):
+                    # append the boolean name
+                    stack.append(str(expr_node))
+                elif expr_node.unary:
+                    operand =3D stack.pop()
+                    operator =3D str(expr_node)
+                    op_precedence =3D expr_node.precedence
+
+                    # NOT is the highest precedence, so only need
+                    # parentheses if the operand is a subexpression
+                    if isinstance(operand, list):
+                        subexpr =3D [operator, "(", operand, ")"]
+                    else:
+                        subexpr =3D [operator, operand]
+
+                        stack.append(subexpr)
+                        prev_op_precedence =3D op_precedence
                 else:
-                    subexpr =3D ["(", operand1, operator, operand2, ")"]
+                    operand1 =3D stack.pop()
+                    operand2 =3D stack.pop()
+                    operator =3D str(expr_node)
+                    op_precedence =3D expr_node.precedence
+
+                    if prev_op_precedence > op_precedence:
+                        # if previous operator is of higher precedence
+                        # no parentheses are needed.
+                        subexpr =3D [operand1, operator, operand2]
+                    else:
+                        subexpr =3D ["(", operand1, operator, operand2, ")=
"]
=20
-                stack.append(subexpr)
-                prev_op_precedence =3D op_precedence
+                        stack.append(subexpr)
+                        prev_op_precedence =3D op_precedence
=20
-        return ' '.join(flatten_list(stack))
+            return ' '.join(flatten_list(stack))
=20
     def __hash__(self):
         return hash(self.key)
@@ -222,6 +249,7 @@ cdef class ConditionalOperator(PolicyObject):
=20
     cdef:
         str text
+        str cil_text
         readonly int precedence
         # T/F the operator is unary
         readonly bint unary
@@ -231,12 +259,12 @@ cdef class ConditionalOperator(PolicyObject):
         readonly object evaluate
=20
     _cond_expr_val_to_details =3D {
-        sepol.COND_NOT: ("!", 5, lambda x: not x),
-        sepol.COND_OR: ("||", 1, lambda x, y: x or y),
-        sepol.COND_AND: ("&&", 3, lambda x, y: x and y),
-        sepol.COND_XOR: ("^", 2, lambda x, y: x ^ y),
-        sepol.COND_EQ: ("=3D=3D", 4, lambda x, y: x =3D=3D y),
-        sepol.COND_NEQ: ("!=3D", 4, lambda x, y: x !=3D y)}
+        sepol.COND_NOT: ("!", "not", 5, lambda x: not x),
+        sepol.COND_OR: ("||", "or", 1, lambda x, y: x or y),
+        sepol.COND_AND: ("&&", "and", 3, lambda x, y: x and y),
+        sepol.COND_XOR: ("^", "xor", 2, lambda x, y: x ^ y),
+        sepol.COND_EQ: ("=3D=3D", "eq", 4, lambda x, y: x =3D=3D y),
+        sepol.COND_NEQ: ("!=3D", "ne", 4, lambda x, y: x !=3D y)}
=20
     @staticmethod
     cdef inline ConditionalOperator factory(SELinuxPolicy policy, sepol.co=
nd_expr_t *symbol):
@@ -245,11 +273,14 @@ cdef class ConditionalOperator(PolicyObject):
         op.policy =3D policy
         op.key =3D <uintptr_t>symbol
         op.unary =3D symbol.expr_type =3D=3D sepol.COND_NOT
-        op.text, op.precedence, op.evaluate =3D op._cond_expr_val_to_detai=
ls[symbol.expr_type]
+        op.text, op.cil_text, op.precedence, op.evaluate =3D op._cond_expr=
_val_to_details[symbol.expr_type]
         return op
=20
     def __str__(self):
-        return self.text
+        if self.policy.gen_cil:
+            return self.cil_text
+        else:
+            return self.text
=20
     def statement(self):
         raise NoStatement
diff --git a/setools/policyrep/mls.pxi b/setools/policyrep/mls.pxi
index 908fd7ae..9966e88a 100644
--- a/setools/policyrep/mls.pxi
+++ b/setools/policyrep/mls.pxi
@@ -168,17 +168,20 @@ cdef class BaseMLSLevel(PolicyObject):
         cats =3D sorted(self._categories, key=3Dlambda k: k._value)
=20
         if cats:
-            # generate short category notation
-            shortlist =3D []
-            for _, i in itertools.groupby(cats, key=3Dlambda k,
-                                          c=3Ditertools.count(): k._value =
- next(c)):
-                group =3D list(i)
-                if len(group) > 1:
-                    shortlist.append(f"{group[0]}.{group[-1]}")
-                else:
-                    shortlist.append(str(group[0]))
-
-            lvl +=3D ":" + ','.join(shortlist)
+            if self.policy.gen_cil:
+                lvl +=3D " (" + " ".join(c.name for c in cats) + ")"
+            else:
+                # generate short category notation
+                shortlist =3D []
+                for _, i in itertools.groupby(cats, key=3Dlambda k,
+                                              c=3Ditertools.count(): k._va=
lue - next(c)):
+                    group =3D list(i)
+                    if len(group) > 1:
+                        shortlist.append(f"{group[0]}.{group[-1]}")
+                    else:
+                        shortlist.append(str(group[0]))
+
+                lvl +=3D ":" + ','.join(shortlist)
=20
         return lvl
=20
@@ -431,10 +434,16 @@ cdef class Range(PolicyObject):
         return r
=20
     def __str__(self):
-        if self.high =3D=3D self.low:
-            return str(self.low)
+        if self.policy.gen_cil:
+            if self.high =3D=3D self.low:
+                return f"({self.low})"
+
+            return f"({self.low} {self.high})"
+        else:
+            if self.high =3D=3D self.low:
+                return str(self.low)
=20
-        return f"{self.low} - {self.high}"
+            return f"{self.low} - {self.high}"
=20
     def __hash__(self):
         return hash(str(self))
diff --git a/setools/policyrep/mlsrule.pxi b/setools/policyrep/mlsrule.pxi
index 402bb2d8..1d6243d3 100644
--- a/setools/policyrep/mlsrule.pxi
+++ b/setools/policyrep/mlsrule.pxi
@@ -67,7 +67,10 @@ cdef class MLSRule(PolicyRule):
             yield self
=20
     def statement(self):
-        return f"{self.ruletype} {self.source} {self.target}:{self.tclass}=
 {self.default};"
+        if self.policy.gen_cil:
+            return f"(rangetransition {self.source} {self.target} {self.tc=
lass} {self.default})"
+        else:
+            return f"{self.ruletype} {self.source} {self.target}:{self.tcl=
ass} {self.default};"
=20
=20
 #
diff --git a/setools/policyrep/rbacrule.pxi b/setools/policyrep/rbacrule.pxi
index 818ed483..3e93b838 100644
--- a/setools/policyrep/rbacrule.pxi
+++ b/setools/policyrep/rbacrule.pxi
@@ -63,7 +63,10 @@ cdef class RoleAllow(PolicyRule):
             yield self
=20
     def statement(self):
-        return f"{self.ruletype} {self.source} {self.target};"
+        if self.policy.gen_cil:
+            return f"(roleallow {self.source} {self.target})"
+        else:
+            return f"{self.ruletype} {self.source} {self.target};"
=20
=20
 cdef class RoleTransition(PolicyRule):
@@ -122,7 +125,10 @@ cdef class RoleTransition(PolicyRule):
             yield self
=20
     def statement(self):
-        return f"{self.ruletype} {self.source} {self.target}:{self.tclass}=
 {self.default};"
+        if self.policy.gen_cil:
+            return f"(roletransition {self.source} {self.target} {self.tcl=
ass} {self.default})"
+        else:
+            return f"{self.ruletype} {self.source} {self.target}:{self.tcl=
ass} {self.default};"
=20
=20
 #
diff --git a/setools/policyrep/role.pxi b/setools/policyrep/role.pxi
index a83d9de6..e7f66b50 100644
--- a/setools/policyrep/role.pxi
+++ b/setools/policyrep/role.pxi
@@ -34,15 +34,21 @@ cdef class Role(PolicySymbol):
=20
     def statement(self):
         cdef size_t count
-        types =3D list(str(t) for t in self._types)
-        count =3D len(types)
-        stmt =3D f"role {self.name}"
-        if count =3D=3D 0:
-            return f"role {self.name};"
-        if count =3D=3D 1:
-            return f"role {self.name} types {types[0]};"
-
-        return f"role {self.name} types {{ {' '.join(sorted(types))} }};"
+        if self.policy.gen_cil:
+            stmt =3D ""
+            for t in self._types:
+                stmt +=3D f"(roletype {self} {t})\n"
+            return stmt
+        else:
+            types =3D list(str(t) for t in self._types)
+            count =3D len(types)
+            stmt =3D f"role {self.name}"
+            if count =3D=3D 0:
+                return f"role {self.name};"
+            if count =3D=3D 1:
+                return f"role {self.name} types {types[0]};"
+
+            return f"role {self.name} types {{ {' '.join(sorted(types))} }=
};"
=20
=20
 #
diff --git a/setools/policyrep/selinuxpolicy.pxi b/setools/policyrep/selinu=
xpolicy.pxi
index d7b59fdf..2f3c6a8a 100644
--- a/setools/policyrep/selinuxpolicy.pxi
+++ b/setools/policyrep/selinuxpolicy.pxi
@@ -36,6 +36,7 @@ cdef class SELinuxPolicy:
         dict category_alias_map
         dict sensitivity_alias_map
         object __weakref__
+        bint gen_cil
=20
         # Public attributes:
         readonly str path
@@ -44,7 +45,7 @@ cdef class SELinuxPolicy:
         readonly unsigned int version
         readonly bint mls
=20
-    def __cinit__(self, policyfile=3DNone):
+    def __cinit__(self, policyfile=3DNone, gen_cil=3DFalse):
         """
         Parameter:
         policyfile  Path to a policy to open.
@@ -60,6 +61,8 @@ cdef class SELinuxPolicy:
         else:
             self._load_running_policy()
=20
+        self.gen_cil =3D gen_cil
+
     def __dealloc__(self):
         PyMem_Free(self.cat_val_to_struct)
         PyMem_Free(self.level_val_to_struct)
diff --git a/setools/policyrep/terule.pxi b/setools/policyrep/terule.pxi
index e6bbcb0f..20fc54f7 100644
--- a/setools/policyrep/terule.pxi
+++ b/setools/policyrep/terule.pxi
@@ -195,20 +195,27 @@ cdef class AVRule(BaseTERule):
=20
     def statement(self):
         if not self.rule_string:
-            self.rule_string =3D f"{self.ruletype} {self.source} {self.tar=
get}:{self.tclass} "
-
-            # allow/dontaudit/auditallow/neverallow rules
-            perms =3D self.perms
-            if len(perms) > 1:
-                self.rule_string +=3D f"{{ {' '.join(sorted(perms))} }};"
+            if self.policy.gen_cil:
+                self.rule_string =3D f"({self.ruletype} {self.source} {sel=
f.target} ({self.tclass} ({' '.join(sorted(self.perms))})))"
+                try:
+                    self.rule_string =3D f"(booleanif ({self.conditional})=
\n\t({str(self.conditional_block).lower())}\n\t\t{self.rule_string}\n\t)\n)"
+                except RuleNotConditional:
+                    pass
             else:
-                # convert to list since sets cannot be indexed
-                self.rule_string +=3D f"{list(perms)[0]};"
+                self.rule_string =3D f"{self.ruletype} {self.source} {self=
.target}:{self.tclass} "
=20
-            try:
-                self.rule_string +=3D f" [ {self.conditional} ]:{self.cond=
itional_block}"
-            except RuleNotConditional:
-                pass
+                # allow/dontaudit/auditallow/neverallow rules
+                perms =3D self.perms
+                if len(perms) > 1:
+                    self.rule_string +=3D f"{{ {' '.join(sorted(perms))} }=
};"
+                else:
+                    # convert to list since sets cannot be indexed
+                    self.rule_string +=3D f"{list(perms)[0]};"
+
+                try:
+                    self.rule_string +=3D f" [ {self.conditional} ]:{self.=
conditional_block}"
+                except RuleNotConditional:
+                    pass
=20
         return self.rule_string
=20
@@ -379,14 +386,17 @@ cdef class AVRuleXperm(BaseTERule):
=20
     def statement(self):
         if not self.rule_string:
-            self.rule_string =3D f"{self.ruletype} {self.source} {self.tar=
get}:{self.tclass} {self.xperm_type} "
-
-            # generate short permission notation
-            perms =3D self.perms
-            if perms.ranges() > 1:
-                self.rule_string +=3D f"{{ {perms} }};"
+            if self.policy.gen_cil:
+                self.rule_string =3D f"({self.ruletype} {self.source} {sel=
f.target} ({self.tclass} ({self.xperm_type} {self.perms})))"
             else:
-                self.rule_string +=3D f"{perms};"
+                self.rule_string =3D f"{self.ruletype} {self.source} {self=
.target}:{self.tclass} {self.xperm_type} "
+
+                # generate short permission notation
+                perms =3D self.perms
+                if perms.ranges() > 1:
+                    self.rule_string +=3D f"{{ {perms} }};"
+                else:
+                    self.rule_string +=3D f"{perms};"
=20
         return self.rule_string
=20
@@ -454,12 +464,20 @@ cdef class TERule(BaseTERule):
=20
     def statement(self):
         if not self.rule_string:
-            self.rule_string =3D f"{self.ruletype} {self.source} {self.tar=
get}:{self.tclass} {self.default};"
+            if self.policy.gen_cil:
+                self.rule_string =3D f"({self.ruletype} {self.source} {sel=
f.target} ({self.tclass} ({self.default})))"
+                try:
+                    self.rule_string =3D f"(booleanif ({self.conditional})=
\n\t({str(self.conditional_block).lower())}\n\t\t{self.rule_string}\n\t)\n)"
+                except RuleNotConditional:
+                    pass
=20
-            try:
-                self.rule_string +=3D f" [ {self.conditional} ]:{self.cond=
itional_block}"
-            except RuleNotConditional:
-                pass
+            else:
+                self.rule_string =3D f"{self.ruletype} {self.source} {self=
.target}:{self.tclass} {self.default};"
+
+                try:
+                    self.rule_string +=3D f" [ {self.conditional} ]:{self.=
conditional_block}"
+                except RuleNotConditional:
+                    pass
=20
         return self.rule_string
=20
@@ -531,7 +549,10 @@ cdef class FileNameTERule(BaseTERule):
             yield self
=20
     def statement(self):
-        return f"{self.ruletype} {self.source} {self.target}:{self.tclass}=
 {self.default} {self.filename};"
+        if self.policy.gen_cil:
+            return f"({self.ruletype} {self.source} {self.target} ({self.t=
class} {self.default} {self.filename}))"
+        else:
+            return f"{self.ruletype} {self.source} {self.target}:{self.tcl=
ass} {self.default} {self.filename};"
=20
=20
 #

base-commit: 305c8fa49a69a88b05e503239e40edd90f9b2a76
--=20
2.43.0

