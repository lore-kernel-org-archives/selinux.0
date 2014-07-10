Message-ID: <53BEF01B.9050504@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 15:57:15 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [PATCH] selinux: fix the default socket labeling in sock_graft()
References: <20140710153728.21266.78354.stgit@localhost>
 <53BEC5B5.5020508@tycho.nsa.gov> <53BED153.2020206@tycho.nsa.gov>
 <1828895.6E1loEUEHn@sifl>
In-Reply-To: <1828895.6E1loEUEHn@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Milan Broz <gmazyland@gmail.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2014 03:47 PM, Paul Moore wrote:
> On Thursday, July 10, 2014 01:45:55 PM Stephen Smalley wrote:
>> It seems a bit fragile though and certainly doesn't align with the
>> sock_graft hook documentation anymore.  Wondering if we should assert
>> that sksec->sid is not SECINITSID_UNLABELED in the inet/inet6/unix case
>> (i.e. that sksec->sid has been set prior to copying it to isec->sid) ...
> 
> Now that I'm changing the code I'm wondering if we could ever arrive at a 
> situation where sksec->sid would legitimately end up as SECINITSID_UNLABELED 
> in selinux_sock_graft().  In the normal case of no labeled networking, the 
> sksec->sid label should end up as SECSID_NULL so I'm not to worried about 
> that, but if would you get the SECINITSID_UNLABELED SID if you fed 
> "...:unlabeled_t:..." into security_secctx_to_secid()?  I'm pretty sure the 
> answer is "no", but I haven't looked at that code in a while.

Yes, you can get back an initial SID from security_secctx_to_secid() if
the context string matches.  In what scenario would sksec->sid be set to
the result of security_secctx_to_secid() on a context string though, and
from where would that context string originate?  At most we only copy
the MLS attributes of the peer label, right?
