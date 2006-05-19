Subject: RE: [RFC][PATCH] selinux:  introduce support for deferred mapping
	of inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        selinux-dev <selinux-dev@tresys.com>,
        James Morris <jmorris@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015881707C7@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015881707C7@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 19 May 2006 10:18:26 -0400
Message-Id: <1148048306.25168.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-19 at 10:05 -0400, Joshua Brindle wrote:
> > We already have this problem in targeted with aliases.
> > 
> > Try
> > # ls -lZ /lib/libselinux.so.1
> > -rwxr-xr-x  root root system_u:object_r:lib_t          
> > /lib/libselinux.so.1
> > # chcon -t shlib_t /lib/libselinux.so.1
> > # ls -lZ /lib/libselinux.so.1
> > -rwxr-xr-x  root root system_u:object_r:lib_t          
> > /lib/libselinux.so.1
> > 
> 
> Another reason why canonicalizing the paths on getxattr() is non-ideal.
> Why can't we use an alternate interface for canonicalizing paths
> (optionally, if the client wants it).

The original motivation for the getxattr canonicalization was to make
the transition to MCS (MLS-enabled) transparent.  Which required it to
be transparently applied to all callers, not just a few.
It also solved our longstanding problem with not being able to see the
effective MAC label of e.g. mountpoint-labeled filesystems, genfs
filesystems, /proc nodes, etc.  It wasn't so much about canonicalization
as it was about getting the incore inode label of a given inode.
Canonicalization just happens automatically when converting back and
forth between SIDs and contexts because sid_to_context always returns
the primary names.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
