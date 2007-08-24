Date: Fri, 24 Aug 2007 11:34:58 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
In-Reply-To: <200708241231.23793.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0708241130540.21714@us.intercode.com.au>
References: <46C37F99.1060406@trustedcs.com> <Xine.LNX.4.64.0708160711280.30949@us.intercode.com.au>
 <200708241231.23793.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Aug 2007, Paul Moore wrote:

> implementation convenience/cleanliness but it requires either a reduction in 
> the system's SID space from 32 bits to 16 bits (4.<mumble> billion unique 
> labels down to 65 thousand unique labels for all subjects/objects on the 
> system) or some sort of additional internal SID mapping mechanism which has 
> yet to be defined.

To clarify, with a network SID mapper, it means that we are only limiting 
the total number of SIDs being used over the wire at some time, not the 
total number of SIDs on the system.

Decoupling network representation of SIDs is likely a good idea anyway, 
for this and NFS.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
