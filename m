Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02979
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 14:14:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA24258
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 19:13:31 GMT
Received: from Cantor.suse.de (Cantor.suse.de [194.112.123.193])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA24254
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 19:13:30 GMT
Date: Wed, 10 Jan 2001 20:14:53 +0100
From: Andi Kleen <ak@suse.de>
To: Jose Nazario <jose@biocserver.bioc.cwru.edu>
Cc: Andi Kleen <ak@suse.de>,
        "Belmonte, Christopher" <cbelmonte@dit.state.va.us>,
        "'Johnathon Day'" <jcday@mail.thesportsregister.com>,
        selinux@tycho.nsa.gov
Subject: Re: SELinux and covert channels
Message-ID: <20010110201453.A4824@gruyere.muc.suse.de>
References: <20010110192931.A3665@gruyere.muc.suse.de> <Pine.LNX.4.30.0101101414520.31913-100000@biocserver.BIOC.CWRU.Edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.30.0101101414520.31913-100000@biocserver.BIOC.CWRU.Edu>; from jose@biocserver.BIOC.CWRU.Edu on Wed, Jan 10, 2001 at 02:15:50PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Wed, Jan 10, 2001 at 02:15:50PM -0500, Jose Nazario wrote:
> On Wed, 10 Jan 2001, Andi Kleen wrote:
> 
> > If you want no or at least better controllable covert channels use
> > vmware or simply two different PCs.
> 
> how would this stop them? unless network enforcement is there (local
> enforcement is absent as of yet), this is still a channel to send
> information between two parties who are not authorized to share it.

Linux has well designed and developed mechanisms to stop covert channels over networks,
assuming the user cannot get raw network access (which the security policy should 
prevent). Doing that is a very popular use of linux -- building firewalls. 

Stopping them between processes (e.g. things like encoding bits in the free space
reported by df) is very different and much harder. Also Linux was never designed to 
prevent that, and the kernel is full of them.


-Andi 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
