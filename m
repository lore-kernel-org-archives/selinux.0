Date: Mon, 28 Mar 2005 17:47:54 +0200
From: Tom <tom@lemuria.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>,
   "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050328174753.D29441@lemuria.org>
References: <1111985855.1514.70.camel@cobra.ivg2.net> <1111986213.1514.77.camel@cobra.ivg2.net> <1111987652.1514.97.camel@cobra.ivg2.net> <20050328132653.F27857@lemuria.org> <1112012129.1514.187.camel@cobra.ivg2.net> <20050328151126.B28232@lemuria.org> <1112017584.1514.239.camel@cobra.ivg2.net> <20050328160935.B28563@lemuria.org> <1112022358.5811.47.camel@cobra.ivg2.net> <1112022750.2914.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112022750.2914.65.camel@moss-spartans.epoch.ncsc.mil>; from sds@tycho.nsa.gov on Mon, Mar 28, 2005 at 10:12:30AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 28, 2005 at 10:12:30AM -0500, Stephen Smalley wrote:
> Seems fairly pointless to perform such a relabeling if the context
> determination is based entirely on untrusted input from the same source
> as the data itself and the user isn't involved to any greater degree
> than selecting the file in the first place.

Not so sure about the pointlessness here. The point is that it makes it
more difficult to leverage exploits. Maybe I can break into Firefox,
but with that in place I can't jump from there to mplayer by forcing it
to play something I know will break it.

Lots and lots of system compromises I know about took more than one
exploit and more than one program needed to be broken.


Nevertheless, an explicit "good file" filter is certainly added value.
It doesn't have to be a full-blown virus scanner - on a proper SELinux
system I would expect any unexpected behaviour in mplayer to be
contained. Nevertheless, the filter should at least check whether the
data in question is what it claims to be. No need to port the nightmare
of .doc files that really are .exe or whatever to Linux.



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
