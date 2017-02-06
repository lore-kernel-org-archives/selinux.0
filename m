Subject: Re: Still having problems with typebounds check.
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
References: <3f830036-be32-243b-28ff-d8edb66f0c33@redhat.com>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <feb41047-45ce-67e2-8c5e-8938f54f5ac4@redhat.com>
Date: Mon, 6 Feb 2017 09:26:12 -0500
MIME-Version: 1.0
In-Reply-To: <3f830036-be32-243b-28ff-d8edb66f0c33@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 02/06/2017 09:03 AM, Daniel J Walsh wrote:
> I know we discussed this a few months ago, but I can not seem to find
> the emails.
>
> With current container runtime policy, we are adding type-bounds checks
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
> bin_t.  I seen an AVC that says
>
>
> type=AVC msg=audit(1486244245.275:7129): avc:  denied  { entrypoint }
> for  pid=20532 comm="exe" path="/wait-for-it.sh" dev="dm-0" ino=50618329
> scontext=system_u:system_r:container_t:s0:c116,c857
> tcontext=unconfined_u:object_r:usr_t:s0 tclass=file permissive=0
>
>         Was caused by:
>                 Unknown - would be allowed by active policy
>                 Possible mismatch between this policy and the one under
> which the audit message was generated.
>
>                 Possible mismatch between current in-memory boolean
> settings vs. permanent ones.
>
>
> The reason this is being blocked is container_runtime_t is not allowed
> to be entered from usr_t.  The typebounds call
>
> removes the entrypoint from container_t and the container fails.
>
>
> To fix this I would need to allow container_runtime_t to be entered by
> lots of new types.  Since container_runtime_t is an unconfined domain by
> default I don't want to have to add all of these entrypoints.  I also
> want to allow container_t to be transitioned to via unconfined_t, and
> again, I don't want these entrypoints added for unconfined_t.
>
> I feel that entrypoint should be ignored for typebounds just like target
> domains are.  Since they cause you too loosen the policy of the parent
> domain. 
>
>
Here is the bugzilla associated with this issue.
https://bugzilla.redhat.com/show_bug.cgi?id=1419288
