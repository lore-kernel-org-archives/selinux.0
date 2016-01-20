Subject: Re: User range vs. context's range
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
 SELinux List <selinux@tycho.nsa.gov>
References: <569FF52A.6040207@tresys.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <569FFA78.2010302@tycho.nsa.gov>
Date: Wed, 20 Jan 2016 16:22:00 -0500
MIME-Version: 1.0
In-Reply-To: <569FF52A.6040207@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/20/2016 03:59 PM, Christopher J. PeBenito wrote:
> What is the intended behavior for a user's allowed range in the policy
> vs. any labels in the policy (e.g. netifcon)?  My expectation is that
> the allowed range should still apply, but it doesn't seem that
> checkpolicy checks that, based on what I've seen.  For example, the new
> sediff test policies have this user[1]:
>
> user added_user roles system level s1 range s1;
>
> and checkpolicy doesn't error on this[2] later in the policy:
>
> genfscon added_genfs / added_user:object_r:system:s0
>
> I think this should fail compilation since s0 is not in added_user's
> allowed range.

Not for objects (object_r), same as with role-type relation.
