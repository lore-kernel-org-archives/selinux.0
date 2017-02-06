Message-ID: <1486390514.12689.4.camel@tycho.nsa.gov>
Subject: Re: Still having problems with typebounds check.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Date: Mon, 06 Feb 2017 09:15:14 -0500
In-Reply-To: <3f830036-be32-243b-28ff-d8edb66f0c33@redhat.com>
References: <3f830036-be32-243b-28ff-d8edb66f0c33@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-02-06 at 09:03 -0500, Daniel J Walsh wrote:
> I know we discussed this a few months ago, but I can not seem to find
> the emails.
> 
> With current container runtime policy, we are adding type-bounds
> checks
> for containers, so that
> 
> docker --no-new-privs will work with SELInux.
> 
> The problem we are now seeing is I have docker running as
> container_runtime_t and it is executing the
> 
> container as container_t.
> 
> 
> typebounds container_runtime_t container_t;
> 
> 
> But sometimes a user executes a command like
> 
> 
> docker run --entrypoint="/wait-for-it.sh" -v
> /usr/local/wait-for-it.sh:/wait-for-it.sh:ro fedora
> 
> Where /usr/local/wait-for-it.sh is labeled as usr_t, or it could be
> bin_t.  I seen an AVC that says
> 
> 
> type=AVC msg=audit(1486244245.275:7129): avc:  denied  { entrypoint }
> for  pid=20532 comm="exe" path="/wait-for-it.sh" dev="dm-0"
> ino=50618329
> scontext=system_u:system_r:container_t:s0:c116,c857
> tcontext=unconfined_u:object_r:usr_t:s0 tclass=file permissive=0
> 
>         Was caused by:
>                 Unknown - would be allowed by active policy
>                 Possible mismatch between this policy and the one
> under
> which the audit message was generated.
> 
>                 Possible mismatch between current in-memory boolean
> settings vs. permanent ones.
> 
> 
> The reason this is being blocked is container_runtime_t is not
> allowed
> to be entered from usr_t.  The typebounds call
> 
> removes the entrypoint from container_t and the container fails.
> 
> 
> To fix this I would need to allow container_runtime_t to be entered
> by
> lots of new types.  Since container_runtime_t is an unconfined domain
> by
> default I don't want to have to add all of these entrypoints.  I also
> want to allow container_t to be transitioned to via unconfined_t, and
> again, I don't want these entrypoints added for unconfined_t.
> 
> I feel that entrypoint should be ignored for typebounds just like
> target
> domains are.  Since they cause you too loosen the policy of the
> parent
> domain. 

1) You can typebound the entrypoint types and then this will work
without allowing container_runtime_t entrypoint to usr_t or other
types.  For example,
typebounds container_runtime_exec_t usr_t;

You can likely do that in some existing interface where entrypoint
types are declared.  It would be simpler to do if we supported using
attributes as the child for typebounds, see
https://github.com/SELinuxProject/selinux/issues/24

2) audit2why has been augmented to understand typebounds failures and
to report them as such, but that's in selinux master, not yet in any
released version.  You could of course cherry-pick that change over if
desired.
