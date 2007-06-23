Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5NKKdNK009678
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 16:20:40 -0400
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5NKKboq012133
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 20:20:38 GMT
Date: Sat, 23 Jun 2007 16:20:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
cc: Christoph Hellwig <hch@infradead.org>, nfsv4@linux-nfs.org,
        Karl MacMillan <kmacmill@redhat.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        Chris Vance <Christopher.Vance@sparta.com>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
In-Reply-To: <20070623180143.GA7076@fieldses.org>
Message-ID: <Line.LNX.4.64.0706231419110.13660@localhost.localdomain>
References: <Line.LNX.4.64.0706201635280.25279@localhost.localdomain>
 <519223.91074.qm@web36605.mail.mud.yahoo.com> <20070623071536.GA23364@infradead.org>
 <Line.LNX.4.64.0706231118090.12813@localhost.localdomain>
 <20070623180143.GA7076@fieldses.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 23 Jun 2007, J. Bruce Fields wrote:

> This mostly seems to be an argument that we need something more than an
> xattr protocol on its own, which is obviously true.  But I don't
> understand why xattrs couldn't be used just for the purpose of getting
> and setting file labels.  Maybe an example would help me understand the
> problems you're seeing?

I didn't say they couldn't be used.

NFSv4 has an existing extensible mechanism for modifying and retrieving 
authorization of objects (SETATTR/GETATTR), which maps well to the 
requirements e.g. the bitmap4 structure can be used to unambiguously 
signify whether security labels are supported.

If Linux-style xattrs are to be implemented in NFSv4, then they could be 
used, although I'm not sure it would be the cleanest approach.

I think network xattrs work well when they are opaque and user-managed, so 
that the semantics at the NFS layer are simple and consistent.  With 
security labels, things are quite different in that they need to be 
interpreted and managed by the kernel, and that more generally, different 
types of kernel-managed labels may have vastly different semantics and are 
not necessarily a good case for a general solution.  For example, consider 
xattrs used for other security mechanisms such as filesystem encryption or 
integrity labeling.  I think there will be many instances of special case 
behavior with kernel-managed labels that do not fit cleanly with a 
generalized mechanism.  Again, please note that ACLs do not use xattrs 
over the wire, even though they could technically and do at the local 
filesystem level.

It's not something I have extraordinarily strong feelings about.  If the 
consensus is to do this with xattrs, then that's ok.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
