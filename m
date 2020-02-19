Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3844C34056
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 18:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6760424656
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 18:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="VURraHNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBSSDJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:03:09 -0500
Received: from mailomta9-re.btinternet.com ([213.120.69.102]:53360 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726610AbgBSSDI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 13:03:08 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200219180303.PGKD28365.re-prd-fep-044.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 19 Feb 2020 18:03:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582135383; 
        bh=CNkUdVPHbdbhQ6UGNKbbRV6eRhpyyhA4l/oteX6NL0w=;
        h=Message-ID:Subject:From:To:Cc:Date:MIME-Version;
        b=VURraHNj5Bc/pfpGuA0wVWirvTEsRLck2gqm63rhln/2yv/m4b+rnFkiGUaR8pXUCD66HHNDb6L2tHC9KkqWYQu6RJbejigTTbLxmgzW3I9vDSuYp0nWLFlKaYHjuMTKIvt16Qouugk447uqxKdyGtBVRi9gFYlub+4V83UiVgevosLH9a1y51nNrFuDAhdh+9BZbqTSKUX87p6Vx/ETOqlWCw/woxUcLGNNcvSq6cQqA5qoxm0nXFcVLkfySgZ5S14wbT9VvI69Why7qiFigM3lFZYiWZrDfzotwjgBwVp85F64hcz621jRXAxRolqdYj33RygniwOITSZ/HDAaJA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.1.238]
X-OWM-Source-IP: 86.134.1.238 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrkedtgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgtfgggsehmtderredtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrddurddvfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedruddrvdefkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoegsfhhivghlughssehfihgvlhgushgvshdrohhrgheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhmrgihhhgvfiesrhgvughhrghtrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.1.238) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A195F02425F0E; Wed, 19 Feb 2020 18:03:03 +0000
Message-ID: <db2a9d661ec9b53e01c029f98877a3556d8297bc.camel@btinternet.com>
Subject: Test to trace NFS unlabeled bug
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     smayhew@redhat.com, bfields@fieldses.org
Cc:     paul@paul-moore.com, sds@tycho.nsa.gov, selinux@vger.kernel.org
Date:   Wed, 19 Feb 2020 18:03:02 +0000
Content-Type: multipart/mixed; boundary="=-tvi0lVV/d8EDRwhitXhG"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--=-tvi0lVV/d8EDRwhitXhG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I've been building selinux-testsuite tests for various filesystems and
have come across an unlabeled issue when testing. Stephen thinks that
this is a bug sometimes seen with labeled NFS, where the top-level
mounted directory shows up with unlabeled_t initially, then later gets
refreshed to a valid context.

I've put together a test script, policy module and mount prog to
facilitate debugging this issue. I've set out how I tested this on a
Fedora 31 system below, if any problems let me know. 

The nfs.sh script:
MOUNT=`stat --print %m .`
TESTDIR=`pwd`
systemctl start nfs-server
exportfs -orw,no_root_squash,security_label localhost:$MOUNT
mkdir -p /mnt/selinux-testsuite
runcon -t test_nfs_unlabeled_bug ./mount -f nfs4 -s localhost:$TESTDIR
-t /mnt/selinux-testsuite -o
"nfsvers=4.2,proto=tcp,clientaddr=127.0.0.1,addr=127.0.0.1" -v
umount /mnt/selinux-testsuite
exportfs -u localhost:$MOUNT
systemctl stop nfs-server

Install mount.c, unlabeled_bug.te and nfs.sh

Build mount prog:
cc mount.c -o mount -Wall
Then:
chcon -t bin_t ./mount

Build policy module and install:
make -f /usr/share/selinux/devel/Makefile unlabeled_bug.pp
semodule -i unlabeled_bug.pp

Clean audit log:
> /var/log/audit/audit.log

run ./nfs.sh

Check audit log:
audit2allow -p /etc/selinux/targeted/policy/policy.31 <
/var/log/audit/audit.log

Should see:
#============= test_nfs_unlabeled_bug ==============
allow test_nfs_unlabeled_bug unlabeled_t:dir search;

Once done:
semodule -r unlabeled_bug

--=-tvi0lVV/d8EDRwhitXhG
Content-Disposition: attachment; filename="mount.c"
Content-Type: text/x-csrc; name="mount.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

LyogY2MgbW91bnQuYyAtbyBtb3VudCAtV2FsbCAqLwojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1
ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2lu
Y2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzeXMvbW91bnQu
aD4KCnN0YXRpYyB2b2lkIHByaW50X3VzYWdlKGNoYXIgKnByb2duYW1lKQp7CglmcHJpbnRmKHN0
ZGVyciwKCQkidXNhZ2U6ICAlcyBbLXMgc3JjXSAtdCB0Z3QgWy1mIGZzX3R5cGVdIFstbyBvcHRp
b25zXVxuIgoJCSJXaGVyZTpcblx0IgoJCSItcyAgU291cmNlIHBhdGhcblx0IgoJCSItdCAgVGFy
Z2V0IHBhdGhcblx0IgoJCSItZiAgRmlsZXN5c3RlbSB0eXBlXG5cdCIKCQkiLW8gIE9wdGlvbnMg
bGlzdCAoY29tbWEgc2VwYXJhdGVkIGxpc3QpXG5cdCIKCQkiLXYgIFByaW50IGluZm9ybWF0aW9u
LlxuIiwgcHJvZ25hbWUpOwoJZXhpdCgtMSk7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pCnsKCWludCBvcHQsIHJlc3VsdCwgc2F2ZV9lcnIsIGZsYWdzID0gMDsKCWNoYXIgKnNy
YyA9IE5VTEwsICp0Z3QgPSBOVUxMLCAqZnNfdHlwZSA9IE5VTEwsICpvcHRzID0gTlVMTDsKCWJv
b2wgdmVyYm9zZSA9IGZhbHNlOwoKCXdoaWxlICgob3B0ID0gZ2V0b3B0KGFyZ2MsIGFyZ3YsICJz
OnQ6ZjpvOnYiKSkgIT0gLTEpIHsKCQlzd2l0Y2ggKG9wdCkgewoJCWNhc2UgJ3MnOgoJCQlzcmMg
PSBvcHRhcmc7CgkJCWJyZWFrOwoJCWNhc2UgJ3QnOgoJCQl0Z3QgPSBvcHRhcmc7CgkJCWJyZWFr
OwoJCWNhc2UgJ2YnOgoJCQlmc190eXBlID0gb3B0YXJnOwoJCQlicmVhazsKCQljYXNlICdvJzoK
CQkJb3B0cyA9IG9wdGFyZzsKCQkJYnJlYWs7CgkJY2FzZSAndic6CgkJCXZlcmJvc2UgPSB0cnVl
OwoJCQlicmVhazsKCQlkZWZhdWx0OgoJCQlwcmludF91c2FnZShhcmd2WzBdKTsKCQl9Cgl9CgoJ
aWYgKCF0Z3QpCgkJcHJpbnRfdXNhZ2UoYXJndlswXSk7CgoJaWYgKHZlcmJvc2UpCgkJcHJpbnRm
KCJNb3VudGluZ1xuXHRzcmM6ICVzXG5cdHRndDogJXNcblx0ZnNfdHlwZTogJXMgZmxhZ3M6IDB4
JXhcblx0b3B0czogJXNcbiIsCgkJICAgICAgIHNyYywgdGd0LCBmc190eXBlLCBmbGFncywgb3B0
cyk7CgoJcmVzdWx0ID0gbW91bnQoc3JjLCB0Z3QsIGZzX3R5cGUsIGZsYWdzLCBvcHRzKTsKCXNh
dmVfZXJyID0gZXJybm87CglpZiAocmVzdWx0IDwgMCkgewoJCWZwcmludGYoc3RkZXJyLCAiRmFp
bGVkIG1vdW50KDIpOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKCQlyZXR1cm4gc2F2ZV9lcnI7
Cgl9CgoJcmV0dXJuIDA7Cn0K


--=-tvi0lVV/d8EDRwhitXhG
Content-Type: application/x-shellscript; name="test-nfs.sh"
Content-Disposition: attachment; filename="test-nfs.sh"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCmZzX25hbWU9Im5mcyIKCk1PVU5UPS9ob21lICMgbXVzdCBiZSBhIHRvcC1sZXZl
bCBtb3VudApURVNURElSPSRNT1VOVC9NT1VOVC1GUy1NVUxUSS9zZWxpbnV4LXRlc3RzdWl0ZQpz
eXN0ZW1jdGwgc3RhcnQgbmZzLXNlcnZlcgpleHBvcnRmcyAtb3J3LG5vX3Jvb3Rfc3F1YXNoLHNl
Y3VyaXR5X2xhYmVsIGxvY2FsaG9zdDokTU9VTlQKL3Vzci9iaW4vc3lzdGVtY3RsIHN0b3AgdWRp
c2tzMiAjIFN0b3BzIGNyYXAgYXBwZWFyaW5nIGluIGpvdXJuYWwgbG9nCiMuL2ZzY29uZmlnICAk
ZnNfbmFtZSBsb2NhbGhvc3Q6JFRFU1RESVIgInZlcnM9NC4yLHJvb3Rjb250ZXh0PXN5c3RlbV91
Om9iamVjdF9yOnVuY29uZmluZWRfdDpzMCIKCi4vZnNjb25maWcgICRmc19uYW1lIGxvY2FsaG9z
dDokVEVTVERJUiAidmVycz00LjIscHJvdG89dGNwLGNsaWVudGFkZHI9MTI3LjAuMC4xLGFkZHI9
MTI3LjAuMC4xLHJvb3Rjb250ZXh0PXN5c3RlbV91Om9iamVjdF9yOnVuY29uZmluZWRfdDpzMCIK
CiMuL2ZzY29uZmlnICAkZnNfbmFtZSBsb2NhbGhvc3Q6JFRFU1RESVIgInZlcnM9NC4yLHByb3Rv
PXRjcCxjbGllbnRhZGRyPTEyNy4wLjAuMSxhZGRyPTEyNy4wLjAuMSIKCgojbW91bnQgLXQgbmZz
IC1vIHZlcnM9NC4yIGxvY2FsaG9zdDokVEVTVERJUiAvbW50L3NlbGludXgtdGVzdHN1aXRlCgoj
Li9mc2NvbmZpZyAkZnNfbmFtZSAkZGV2ICJyb290Y29udGV4dD1zeXN0ZW1fdTpvYmplY3Rfcjp1
bmNvbmZpbmVkX3Q6czAiCiMgZGVmY29udGV4dCBmYWlscyB3aXRoIGpvdXJuYWwgZW50cnk6IFNF
TGludXg6IG1vdW50IGludmFsaWQuCiMgICAgU2FtZSBzdXBlcmJsb2NrLCBkaWZmZXJlbnQgc2Vj
dXJpdHkgc2V0dGluZ3MgZm9yIChkZXYgbG9vcDAsIHR5cGUgYnRyZnMpCmV4cG9ydGZzIC11IGxv
Y2FsaG9zdDokTU9VTlQKc3lzdGVtY3RsIHN0b3AgbmZzLXNlcnZlcgovdXNyL2Jpbi9zeXN0ZW1j
dGwgc3RhcnQgdWRpc2tzMgo=


--=-tvi0lVV/d8EDRwhitXhG
Content-Disposition: attachment; filename="unlabeled_bug.te"
Content-Type: text/plain; name="unlabeled_bug.te"; charset="UTF-8"
Content-Transfer-Encoding: base64

CnBvbGljeV9tb2R1bGUodW5sYWJlbGVkX2J1ZywgMS4wKQoKcmVxdWlyZSB7Cglyb2xlIHVuY29u
ZmluZWRfcjsKCXR5cGUgYmluX3QsdXNlcl9kZXZwdHNfdCxuZnNfdCxrZXJuZWxfdDsKCWNsYXNz
IGZpbGUgeyBlbnRyeXBvaW50IGV4ZWN1dGUgcmVhZCB9OwoJY2xhc3MgY2FwYWJpbGl0eSB7IHN5
c19hZG1pbiB9OwoJY2xhc3Mgc3lzdGVtIHsgbW9kdWxlX3JlcXVlc3QgfTsKCWNsYXNzIGNocl9m
aWxlIHsgYXBwZW5kIGdldGF0dHIgcmVhZCB3cml0ZSB9OwoJY2xhc3MgZGlyIHsgc2VhcmNoIH07
CgljbGFzcyBmaWxlc3lzdGVtIHsgbW91bnQgfTsKfQoKIz09PT09PT09PT09PT0gdGVzdF9uZnNf
dW5sYWJlbGVkX2J1ZyA9PT09PT09PT09PT09PQp0eXBlIHRlc3RfbmZzX3VubGFiZWxlZF9idWc7
CnJvbGUgdW5jb25maW5lZF9yIHR5cGVzIHRlc3RfbmZzX3VubGFiZWxlZF9idWc7CmZpbGVzX3R5
cGUodGVzdF9uZnNfdW5sYWJlbGVkX2J1ZykKZG9tYWluX3R5cGUodGVzdF9uZnNfdW5sYWJlbGVk
X2J1ZykKYWxsb3cgdGVzdF9uZnNfdW5sYWJlbGVkX2J1ZyBiaW5fdDpmaWxlIHsgZW50cnlwb2lu
dCBleGVjdXRlIHJlYWQgfTsKZmlsZXNfbW91bnRvbl9kZWZhdWx0KHRlc3RfbmZzX3VubGFiZWxl
ZF9idWcpCmFsbG93IHRlc3RfbmZzX3VubGFiZWxlZF9idWcgYmluX3Q6ZmlsZSBtYXA7CmFsbG93
IHRlc3RfbmZzX3VubGFiZWxlZF9idWcgZGVmYXVsdF90OmRpciBtb3VudG9uOwphbGxvdyB0ZXN0
X25mc191bmxhYmVsZWRfYnVnIHNlbGY6Y2FwYWJpbGl0eSBzeXNfYWRtaW47CmFsbG93IHRlc3Rf
bmZzX3VubGFiZWxlZF9idWcga2VybmVsX3Q6c3lzdGVtIG1vZHVsZV9yZXF1ZXN0OwphbGxvdyB0
ZXN0X25mc191bmxhYmVsZWRfYnVnIG5mc190OmRpciBzZWFyY2g7CmFsbG93IHRlc3RfbmZzX3Vu
bGFiZWxlZF9idWcgbmZzX3Q6ZmlsZXN5c3RlbSBtb3VudDsKYWxsb3cgdGVzdF9uZnNfdW5sYWJl
bGVkX2J1ZyB1c2VyX2RldnB0c190OmNocl9maWxlIHsgYXBwZW5kIGdldGF0dHIgcmVhZCB3cml0
ZSB9OwoKI2FsbG93IHRlc3RfbmZzX3VubGFiZWxlZF9idWcgdW5sYWJlbGVkX3Q6ZGlyIHNlYXJj
aDsKCg==


--=-tvi0lVV/d8EDRwhitXhG--

