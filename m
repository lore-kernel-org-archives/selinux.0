Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA02346
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 13:29:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA22007
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 18:28:11 GMT
Received: from Cantor.suse.de (Cantor.suse.de [194.112.123.193])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA21995
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 18:28:09 GMT
Date: Wed, 10 Jan 2001 19:29:31 +0100
From: Andi Kleen <ak@suse.de>
To: "Belmonte, Christopher" <cbelmonte@dit.state.va.us>
Cc: "'Johnathon Day'" <jcday@mail.thesportsregister.com>,
        selinux@tycho.nsa.gov
Subject: Re: SELinux and covert channels
Message-ID: <20010110192931.A3665@gruyere.muc.suse.de>
References: <A0669F3E0A6B3448A962DC6141E6C7A614415C@mis1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A0669F3E0A6B3448A962DC6141E6C7A614415C@mis1>; from cbelmonte@dit.state.va.us on Wed, Jan 10, 2001 at 11:44:37AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Wed, Jan 10, 2001 at 11:44:37AM -0500, Belmonte, Christopher wrote:
> Has anyone considered analyzing SELinux for covert channels?

Linux is full of covert channels between processes and I doubt selinux helps for most
of them.

If you want no or at least better controllable covert channels use vmware or simply
two different PCs. 


-Andi


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
