Subject: Re: Desktop apps interoperability
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>,
   "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>
Cc: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
In-Reply-To: <1112022358.5811.47.camel@cobra.ivg2.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <1111986213.1514.77.camel@cobra.ivg2.net>
	 <1111987652.1514.97.camel@cobra.ivg2.net>
	 <20050328132653.F27857@lemuria.org>
	 <1112012129.1514.187.camel@cobra.ivg2.net>
	 <20050328151126.B28232@lemuria.org>
	 <1112017584.1514.239.camel@cobra.ivg2.net>
	 <20050328160935.B28563@lemuria.org>
	 <1112022358.5811.47.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 10:12:30 -0500
Message-Id: <1112022750.2914.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 10:05 -0500, Ivan Gyurdiev wrote:
> .. so what you're saying is that nautilus (running as user_t, which has
> read access to the file in question, as well as appropriate relabel
> access), should determine its mime type, or use the DND target app, and
> associate a context with that, which the mime handler can play, then
> relabel file to that context (can't copy - what if it's huge?).... and
> do this for every mime handler I attempt to open it with?

Seems fairly pointless to perform such a relabeling if the context
determination is based entirely on untrusted input from the same source
as the data itself and the user isn't involved to any greater degree
than selecting the file in the first place.  If you are going to run it
through a filtering pipeline (e.g. malicious code checker), then it
makes more sense to set up a relabeling or data copying pipeline using
TE to ensure that each filter stage is unbypassable and tamperproof
(i.e. an assured pipeline in TE parlance).  Note however that relabeling
in place is not necessarily safe, as Linux does not yet fully support
revocation of access.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
