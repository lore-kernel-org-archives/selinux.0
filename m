Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA25037
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 18:50:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA02904
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 23:48:46 GMT
Received: from Cantor.suse.de (Cantor.suse.de [194.112.123.193])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA02900
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 23:48:45 GMT
Received: from Hermes.suse.de (Hermes.suse.de [194.112.123.136])
	by Cantor.suse.de (Postfix) with ESMTP id 5C7071E272
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 00:49:57 +0100 (MET)
Received: from gruyere.muc.suse.de (unknown [10.23.1.2])
	by Hermes.suse.de (Postfix) with ESMTP id CB8B73E452
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 00:49:56 +0100 (MET)
Date: Wed, 27 Dec 2000 00:49:56 +0100
From: Andi Kleen <ak@suse.de>
To: selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: Mirror Site
Message-ID: <20001227004956.A32579@gruyere.muc.suse.de>
References: <200012262148.QAA06775@coalstove.epoch.ncsc.mil> <20001227001116.A22887@bunuel.tii.matav.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20001227001116.A22887@bunuel.tii.matav.hu>; from mag@bunuel.tii.matav.hu on Wed, Dec 27, 2000 at 12:11:16AM +0100
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Wed, Dec 27, 2000 at 12:11:16AM +0100, Magosányi Árpád wrote:
> Having a project sourceforged is important not for just technical reasons.
> If the project is on sourceforge, it more likely attracts more developers
> and users, so the critical mass of the project is more easily reached.
> BTW, is there any official word (either from Linus or from NSA), when will
> flask integrated into the mainstream kernel sources? It is also a major
> issue from the "marketing" perspective. (I would be happy to see it in 2.5)

Flask is clearly labelled as experimental and it does many radical things
compared to traditional Unix security, so it would probably be a good idea to 
do some experiments (collecting experience with it) before considering
to put it into the main kernel.

-Andi
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
