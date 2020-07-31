Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3878CC433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 10:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9DC20829
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 10:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbgGaKDg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 06:03:36 -0400
Received: from mr012msb.fastweb.it ([85.18.95.109]:43046 "EHLO
        mr012msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732227AbgGaKDg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 06:03:36 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2020 06:03:35 EDT
Received-SPF: pass (mr012msb.fastweb.it: domain assyoma.it designates
 93.63.55.57 as permitted sender) identity=mailfrom;
 receiver=mr012msb.fastweb.it; client-ip=93.63.55.57;
 envelope-from=g.danti@assyoma.it; helo=plutone.assyoma.it;
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrieekgddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhtefuvfghgfeupdcuqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpeggfffhvffufgfkgigtgfesthejjhdttdervdenucfhrhhomhepifhiohhnrghtrghnucffrghnthhiuceoghdruggrnhhtihesrghsshihohhmrgdrihhtqeenucggtffrrghtthgvrhhnpeeugedvudeuvedtvefhtddvhfejkeelveeghffgfeejgeegfedtheevtdeghfffieenucffohhmrghinhepfhgvughorhgrphhrohhjvggtthdrohhrghdprhgvughhrghtrdgtohhmpdgrshhshihomhgrrdhithenucfkphepleefrdeifedrheehrdehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehplhhuthhonhgvrdgrshhshihomhgrrdhithdpihhnvghtpeelfedrieefrdehhedrheejpdhmrghilhhfrhhomhepoehgrdgurghnthhisegrshhshihomhgrrdhitheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuqfftvefrvfeprhhftgekvddvnehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from plutone.assyoma.it (93.63.55.57) by mr012msb.fastweb.it (5.8.208)
        id 5F04EEC8021DBFF7 for selinux@vger.kernel.org; Fri, 31 Jul 2020 11:57:48 +0200
Received: from webmail.assyoma.it (localhost [IPv6:::1])
        by plutone.assyoma.it (Postfix) with ESMTPA id 0DE50DB75A34
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 11:57:48 +0200 (CEST)
MIME-Version: 1.0
Date:   Fri, 31 Jul 2020 11:57:48 +0200
From:   Gionatan Danti <g.danti@assyoma.it>
To:     selinux@vger.kernel.org
Subject: lnk_file read permission
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <9c20af23bf7b70d6e01ca6772cc31f88@assyoma.it>
X-Sender: g.danti@assyoma.it
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dear list,
I am writing this email as suggested here:
https://lists.fedoraproject.org/archives/list/selinux@lists.fedoraproject.org/message/GWEWGDUQS6PERAYEJHL2EE4GDO432IAO/

To recap: I have issue with selinux permission when relocating specific 
daemon data directory, and using symlink in the original location. For 
example, lets consider moving /var/lib/mysql in a new, bigger volume.

After moving /var/lib/mysql in /data/lib/mysql and creating a symlink 
for the new location, I used semanage fcontext to add the relative 
equivalency rules. Moreover, I changed my.cnf to explicitly point to the 
new data dir and socket file. So far, so good.

When restarting apache, I noticed it can't connect to mysql. ausearch -m 
avc showed the following:
...
type=AVC msg=audit(1596055762.070:175569): avc:  denied  { read } for  
pid=72946 comm="httpd" name="mysql" dev="sda2" ino=103 
scontext=system_u:system_r:httpd_t:s0 
tcontext=system_u:object_r:mysqld_db_t:s0 tclass=lnk_file permissive=0

The log above clearly states that httpd policy lacks lnk_read permission 
for mysqld_db_t type. While I solved the issue by leaving the socket 
file inside the original directory (removing the /var/lib/mysql symlink 
and recreating the mysql dir), I was wondering why each symlink type is 
specifically allowed
rather than giving any processes a generic access to symlinks.

Is this kind of rule not permitted by selinux? Can it open the door to 
other attacks? If so, why? Generally, what is the least invasive 
approach to relocate services?

As a side note, consider that the above applies to other common services 
as libvirt (fixed via this BZ 
https://bugzilla.redhat.com/show_bug.cgi?id=1598593) and mongodb [1].

Thanks.

[1] Another example, from relocating mongodb (this time on a CentOS 7 
box):
semanage fcontext -a -e /var/lib/mongo /tank/graylog/var/lib/mongo
mv /var/lib/mongo /tank/graylog/var/lib/mongo
ln -s /tank/graylog/var/lib/mongo /var/lib/mongo
restorecon /var/lib/mongo
systemctl restart mongod

Result:
MongoDB does not start. Issuing "cat /var/log/audit/audit.log |
audit2allow" show the following error: "allow mongod_t
mongod_var_lib_t:lnk_file read;"

Indeed, sesearch can not find any permission to read mongod_var_lib_t 
links:
[root@localhost ~]# sesearch -A -s mongod_t | grep lnk_file | grep
mongod_var_lib_t

-- 
Danti Gionatan
Supporto Tecnico
Assyoma S.r.l. - www.assyoma.it
email: g.danti@assyoma.it - info@assyoma.it
GPG public key ID: FF5F32A8
