Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0DGbxIi024967
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 11:37:59 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0DGa2Ps010687
	for <selinux@tycho.nsa.gov>; Thu, 13 Jan 2005 16:36:03 GMT
Date: Thu, 13 Jan 2005 16:48:28 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: ivg2@cornell.edu, SELinux@tycho.nsa.gov
Subject: Re: Multiple contexts
Message-ID: <20050113164827.GI17414@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net> <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil> <1105560687.11135.26.camel@cobra.ivg2.net> <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil> <20050112233241.GF11846@lkcl.net> <1105632966.24406.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105632966.24406.34.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 13, 2005 at 11:16:06AM -0500, Stephen Smalley wrote:
> On Wed, 2005-01-12 at 18:32, Luke Kenneth Casson Leighton wrote:
> >  would you accept that that could be done at policy compile time,
> >  and that it would be unnecessary to do that at runtime?
> 
> No, it cannot be done at policy compile time, because the information
> (the combinations of types on files) is not captured in the policy. 
> file_contexts is not authoritative and is not part of the policy, and
> the only authoritative source of information about the file attributes
> is the on-disk version.  Full filesystem traversal required to do the
> analysis you propose.  No examination of file_contexts or filesystem
> state required to do current analysis of potential information flow
> throughout the system.
 
  i believed that it would be acceptable to have as part of the
  intermediate stage a full filesystem traversal, but as i mentioned
  in the reply to james, i woke up with an insight into a flaw of
  what i am advocating and cannot now remember what it is!
  
  sorry!

  l.,

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
