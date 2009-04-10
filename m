Date: Fri, 10 Apr 2009 15:17:18 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: dpquigl@tycho.nsa.gov, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
Subject: Re: [nfsv4] my thoughts on how Labeled NFSv4 draft should move forward
Message-ID: <20090410201718.GB1500@Sun.COM>
References: <49DA6EF8.1080704@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49DA6EF8.1080704@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After that long thread on SAAG and a subsequent off-list discussion with
Casey (plus my reading Smack documentation) I'm almost ready to reach
the following conclusions:

 - We don't need policy agreement for MLS.  Servers have all the
   necessary information when comparing labels without reference to a
   policy.  However, clients have to be sharing a common MLS policy.

 - For "smart" MLS and Smack servers we need a method by which servers
   can determine the label range/set of client and user principals, but
   this need not be specified in a standard way except where label
   range/set is borne by authentication credentials (Kerberos V ticket
   authorization-data, PKIX cert extensions).

   This is already described in my RPCSEC_GSSv3 document.

 - For Smack we don't need policy agreement either, but it will be
   useful to distribute common subsets of Smack policy to clients, and
   to prefix labels from local-only sub-policies with a client ID (or
   client DOI, if you wish).

 - For DTE I've no idea what to do.  Policy agreement seems like a
   flight of fancy for DTE.  But *much* more importantly, because the
   process label transitions can span so many labels we simply cannot
   have too smart a server: the server can't meaningfully constrain the
   labels that a user@client can assert, therefore the server must trust
   all client assertions of process DTE labels or none at all.

   I.e., for DTE we can only have "dumb" servers.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
