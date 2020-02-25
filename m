Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28147C35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE44C2072D
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 16:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="p9oJhAYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBYQie (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:38:34 -0500
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:62785 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728051AbgBYQie (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 11:38:34 -0500
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200225163831.CRPU28880.re-prd-fep-042.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 25 Feb 2020 16:38:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582648711; 
        bh=GirAwhOZcJ+/Qchw1gm99PBmpssA9wq079YAXnl24co=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=p9oJhAYBOjECg8KNJXe8hyg3infMA9dD7NluMkjNQv658wLtjQpsEsjAcRz+yTSnR7oeS7kSdXBAcNXOVttrgfUBD1D1yZd+4m+wj4qQupZ7ywUCLSDpLpXzlMJiX79ch8JDGDxhwNKzBhcYvNGM2vixxKn0kzXcjuX457BLdyJMM2vZErPeULdqb2oLE/zFkInM2ckeotOoG30ON9HgT/9CQ030G9O5TQoC91Rs3CIiRWj4Ix9ty1xF4krVhsagTCZGpTLToE+g+QGrc+Rwe/MmwAyPjsjRPHbT9qUOyHxrjdsjNp3dsnY6xpno3OygHQpnsghJHxSqTRnYUlNSPg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.58.0]
X-OWM-Source-IP: 31.49.58.0 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrledvgdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheekrddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehkedrtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvsheshhhothhmrghilhdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.58.0) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A16DE032DF6DE; Tue, 25 Feb 2020 16:38:31 +0000
Message-ID: <80909c6b15e1816ad7857f759f9855e2fd70af71.camel@btinternet.com>
Subject: Re: [RFC V2 PATCH 1/2] selinux-testsuite: Use native filesystem for
 tests - Part 1
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Date:   Tue, 25 Feb 2020 16:38:30 +0000
In-Reply-To: <CAEjxPJ6cMrqbpqCxsog9HOY98awjDMPJ7UpNfCS99_pViwv1AQ@mail.gmail.com>
References: <20200224141524.407114-1-richard_c_haines@btinternet.com>
         <20200224141524.407114-2-richard_c_haines@btinternet.com>
         <CAEjxPJ7HXQGdWX5KHs42OEGVR9doSD_FpUAH0TR+U96DPu4ukQ@mail.gmail.com>
         <feb9aa8f41509a9f0eb4b8a8b198e73e5acdd352.camel@btinternet.com>
         <CAEjxPJ55qz3m-KadVe8X1Z5Un2EcpwWkA1H8hFb3nYz7y5jKXA@mail.gmail.com>
         <CAEjxPJ6cMrqbpqCxsog9HOY98awjDMPJ7UpNfCS99_pViwv1AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2020-02-25 at 11:26 -0500, Stephen Smalley wrote:
> On Tue, Feb 25, 2020 at 11:18 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > If you just ran the nametrans tests in the host filesystem rather
> > than
> > in the separate mount, I think it would work.
> > This would require adjusting the type_transition rules however to
> > reflect the actual parent directory type (probably test_file_t).
> 
> I just confirmed manually that name-based type transitions work over
> labeled NFS.  The problem is just that your existing type_transition
> rules aren't matching on the parent directory type because you are
> creating the files in a separate mount that is using one or more
> context= options rather than in the base mount itself, unlike the
> setfscreatecon() tests above them that just operate within the host
> filesystem.

Thanks, Ill fix

