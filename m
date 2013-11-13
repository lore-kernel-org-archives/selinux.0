From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 02/05] Add new icons for sepolicy gui
Date: Wed, 13 Nov 2013 10:38:38 -0500
Message-Id: <1384357118-21515-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 policycoreutils/sepolicy/Makefile         |   7 ++++++-
 policycoreutils/sepolicy/sepolicy_16.png  | Bin 0 -> 1525 bytes
 policycoreutils/sepolicy/sepolicy_22.png  | Bin 0 -> 1947 bytes
 policycoreutils/sepolicy/sepolicy_256.png | Bin 0 -> 25778 bytes
 policycoreutils/sepolicy/sepolicy_32.png  | Bin 0 -> 2542 bytes
 policycoreutils/sepolicy/sepolicy_48.png  | Bin 0 -> 3670 bytes
 6 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100644 policycoreutils/sepolicy/sepolicy_16.png
 create mode 100644 policycoreutils/sepolicy/sepolicy_22.png
 create mode 100644 policycoreutils/sepolicy/sepolicy_256.png
 create mode 100644 policycoreutils/sepolicy/sepolicy_32.png
 create mode 100644 policycoreutils/sepolicy/sepolicy_48.png

diff --git a/policycoreutils/sepolicy/Makefile b/policycoreutils/sepolicy/Makefile
index 2b8716c..90f88a5 100644
--- a/policycoreutils/sepolicy/Makefile
+++ b/policycoreutils/sepolicy/Makefile
@@ -47,6 +47,11 @@ install:
 	-mkdir -p $(DESTDIR)/usr/share/system-config-selinux
 	install -m 755 selinux_server.py $(DESTDIR)/usr/share/system-config-selinux
 	install -m 644 *.desktop $(DATADIR)/system-config-selinux
+	-mkdir -p $(DESTDIR) $(DATADIR)/pixmaps
+	install -m 644 sepolicy_256.png $(DATADIR)/pixmaps/sepolicy.png
+	for i in 16 22 32 48 256; do \
+		mkdir -p $(DESTDIR) $(DATADIR)/icons/hicolor/$${i}x$${i}/apps; \
+		install -m 644 sepolicy_$${i}.png $(DATADIR)/icons/hicolor/$${i}x$${i}/apps/sepolicy.png; \
+	done
 
 relabel:
-
diff --git a/policycoreutils/sepolicy/sepolicy_16.png b/policycoreutils/sepolicy/sepolicy_16.png
new file mode 100644
index 0000000000000000000000000000000000000000..199aae5a58826ac8beb29b1c14e55c8c652dd988
GIT binary patch
literal 1525
zcmbVMZEO>D7(ceI%+bMo!L>ljam9d2d#`QRx^8{B)|J>X$_!J7_SU<#$GF~cJ!m%#
zFpvtE7zhC}LBfj~LKFs(56ZA}8M;kiCM13sI2;i$@nw@@7))00#)^C(eDHGje|i4T
z@Atg?pXavLRKHwYG^+>zfMS0Y8I<P|<ttRn<J?S^k|&+yt&^7VjZ%UV8NfyJ4Gie#
zs0b5eD7txdFH;Tx`BApEPO1yMVh{72iBfb-NluW_08n0;6sT|$BY_P}gpE0%;nQgd
zWN8Pq+#Emxf`^H+RV^a3tfjg(+|m@b(NJXtSe~@Y1RNt#V3J!Ei`$b9XoA-+uN5&2
zffFiHlLNZ%R9&D3^zb4BnoYPdjG!oJv6xW8Y_Xt=Kny`K7?EF#5hd(qiygCqlMf_Y
z6X`~Kkn~O3l6MX$DoKJJh7*Z|DS?}KF#@ADn@!=sFr%ztj5o(5Drt<x4LJsqiHAj2
zkXSwjDvVSEzeaLEvZwb$;DkWn0dXuonJ77BaFP;W)P%qsr^Gd(9hZX4e{MWdJ6_u?
zFmRBG^J~Pgd>@U599YiX;|(c_vN!f6A}e1CwTk4!Yd9t*`AG*PpO|Qtw%c5Y%Sw=L
z)QTaNG88StFqhAZqXdT9TsAkB<9HO7z)3fPqh<mp+$ieB-2`s-`AE|1vbwCK)ttln
zV{wU!g_)dPR<=8dB_4~ldqjqkc(In}SLG_8Cdx~EJjx58XPE_D7@)#zOc6Y<T+sb^
zNk(MXGPF<RIdCGwcJ>h-$l=QMV<nJ>BKKl$kJsicvst_ZG>N7EPu5`B8CWTghsq@<
zl50>|J}7>9^Pqj0nA|g>+#DT^bRhub8T_QHHaXBhJM*|djQ5;J0e{r}DifHOukReq
zX4fN!&m2D0x_R>_Z+bi*weH-xX=v>BT#Yq$nI6sDSYr5LySiSD%sY{}HuD#)zT%y3
z;qI;1km9SGx~bhi6QN6zFCTmkoWHPV<W44%>f5%`SE3xcZi1eW_AIb{{!3G@G~=JI
z5AAi`I@-H9yW`HH&*qFB+#O1N^CPRtax0p2$M#>@cCl?BHK=(nVa1coctq9IK)?I_
ziB7G$<&aZnQKz!$8X`NMzr1UE1&g1XS&C>z$A;m2{34u+9B<bCd8OjJ14mYNgD;G<
z4fV~orB=-NLbw0kpendlPktP@OiZaV?%Oq-n4+JS)iSy=)$g4jzEzQ)@#*o7r^0nY
z@6MrX)^+W(W*Q>M`MwJUi(kCas@8#rcKCrgUB2ssA=8$@zdKW{ZJT$wmiB+(stRr$
zy4^n<dfoTaGmECH{t{qh{O$gc8`cF~!|8QM`508tfOh16^=syIsq?PBXYH0f*?-ha
z3xv}4lNqf2<ZAqKM~miMdg`sb!Xs@h$VibN;IiK$c>kU!$;{R&yr=1ngFZvy$W8G;
zxAX4e6-cpY=_vrugQXiZsxQ^gPJ4R8>iP}Faj*80b`YP9jlAEt@ea7R@=SAI=h+1s
zJd|hndY@Wz4FFH+>EF`nw2n3#wfg!B&2(o}yYQ+R=q*_fRy!|TZ<m0Q5TF_zpmsb_
QsZxH#es48-%pKbJFDG#$4FCWD

literal 0
HcmV?d00001

diff --git a/policycoreutils/sepolicy/sepolicy_22.png b/policycoreutils/sepolicy/sepolicy_22.png
new file mode 100644
index 0000000000000000000000000000000000000000..fa1f13700e5585557d9ab7c223393155e14e47bc
GIT binary patch
literal 1947
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
E4HGyGUH||9

literal 0
HcmV?d00001

diff --git a/policycoreutils/sepolicy/sepolicy_256.png b/policycoreutils/sepolicy/sepolicy_256.png
new file mode 100644
index 0000000000000000000000000000000000000000..40f1df52ccf2c4e95e8478704e30632e5c96f5b0
GIT binary patch
literal 25778
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

literal 0
HcmV?d00001

diff --git a/policycoreutils/sepolicy/sepolicy_32.png b/policycoreutils/sepolicy/sepolicy_32.png
new file mode 100644
index 0000000000000000000000000000000000000000..c57a7342d0f2de85bd83fadafa598311420f5fe5
GIT binary patch
literal 2542
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

literal 0
HcmV?d00001

diff --git a/policycoreutils/sepolicy/sepolicy_48.png b/policycoreutils/sepolicy/sepolicy_48.png
new file mode 100644
index 0000000000000000000000000000000000000000..6cc0a031610ead8560afaf362c7d4e897980f316
GIT binary patch
literal 3670
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

literal 0
HcmV?d00001

-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
