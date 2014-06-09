Message-ID: <5395B66D.5010909@tycho.nsa.gov>
Date: Mon, 09 Jun 2014 09:28:13 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: RBAC along with MLS?
References: <5391B555.4080100@gmail.com>
In-Reply-To: <5391B555.4080100@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/06/2014 08:34 AM, dE wrote:
> I'm learning SELinux on Fedora, here if you need to use MLS, you need to
> remove TE model cause the MLS is implemented in a completely different
> policy.
> 
> Is it possible to create a policy which supports both RABC/TE with MLS?

I've explained this previously, but to repeat it:  RBAC/TE is always
enabled in the SELinux security server (and in the policy), only MLS is
optional. So in Fedora, the -mls policy is in truth a RBAC/TE/MLS
policy.  And in Fedora, the -targeted policy is in truth a RBAC/TE/MCS
policy.  They both enable the MLS engine in the security server; they
only differ in the configuration (policy/mls versus policy/mcs).
