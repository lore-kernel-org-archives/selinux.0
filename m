Subject: Re: Announce: SELinux conditional policy extensions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: "Joshua D. Guttman" <guttman@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>, Amy L Herzog <aherzog@mitre.org>,
   "John D. Ramsdell" <ramsdell@mitre.org>,
   "Galen B. Williamson" <gwilliam@mitre.org>,
   "Grant M. Wagner" <gmw@tycho.ncsc.mil>
In-Reply-To: <1076649558.17927.14.camel@nexus.verbum.private>
References: <1072133247.3032.22.camel@colossus.columbia.tresys.com>
	 <nhawu6r93im.fsf@malabar.mitre.org>
	 <1076649558.17927.14.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1076683389.10189.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 09:43:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-13 at 00:19, Colin Walters wrote:
> A different approach that comes to mind is binary policy "patches".  So
> say you have a base policy which includes the unmodified ping.te.  But
> as described in README-COND, you also want to sometimes allow users to
> execute ping.  So you create a separate file ping-user.te, which
> contains the necessary added permissions.  This would be compiled
> specially by checkpolicy to a binary policy "patch" relative to the base
> policy, which could be loaded and also unloaded at runtime by the
> kernel.
> 
> Implementing unloading would require implementing negation, but that
> seems useful enough on its own too that it would be worthwhile.

Binary policy patching was implemented earlier by Tresys as a short term
solution to the same problem (see
http://marc.theaimsgroup.com/?l=selinux&m=105459714906101&w=2), but the
conditional policy extensions provide a better solution.  With binary
policy patching, you still have to authorize some domain to reload the
entire policy, and you have no guarantees (except what is provided by
userspace) as to the specific nature of the changes implemented by the
reload.  With the conditional policy extensions, you can define the set
of policy variations within the policy itself, and control the ability
to make a particular well-formed change to the policy. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
