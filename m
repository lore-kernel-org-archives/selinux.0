Subject: Re: concerns about object-inheritance wrt files/directories
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050316135008.GA24000@lkcl.net>
References: <20050316135008.GA24000@lkcl.net>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 08:45:48 -0500
Message-Id: <1110980748.4802.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-16 at 13:50 +0000, Luke Kenneth Casson Leighton wrote:
>  for file types, i have a major concern.
> 
>  if not careful, we are going to be getting into the "multiple file
>  types" thing again, which it has already been discussed that, whilst
>  doable, has some hair-raising implications that make it too complex to
>  a) understand for implementation purposes b) understand the resultant
>  policy.

No, I think you misunderstood.  The objection to multiple contexts on
files is that you can't analyze the resulting policy without pulling in
the entire filesystem state, and a modification to the filesystem state
at any time can change the policy.  What KaiGai is proposing is an
extension to the policy language to allow certain relationships among
types to be expressed more easily, with the policy compiler taking care
of generating the necessary TE rules based on those relationships.
Thus, analysis is still feasible based solely on the centralized policy
configuration and changing the policy requires changing that
configuration.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
