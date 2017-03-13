Date: Mon, 13 Mar 2017 18:06:23 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Casey Schaufler <casey@schaufler-ca.com>,
 yangshukui <yangshukui@huawei.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, Lizefan <lizefan@huawei.com>,
 paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
 james.l.morris@oracle.com, oleg@redhat.com, serge.hallyn@ubuntu.com
Subject: Re: isolate selinux_enforcing
In-Reply-To: <87innidvko.fsf@xmission.com>
Message-ID: <alpine.LRH.2.20.1703131704400.3299@namei.org>
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
 <b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com> <58736B2E.90201@huawei.com>
 <58C11A6C.7000408@huawei.com>
 <347f63b5-c274-c7bc-55f7-f6304d31418a@schaufler-ca.com>
 <87innidvko.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 9 Mar 2017, Eric W. Biederman wrote:

> My expectation is that a container would run as essentially all one
> label from a global perspective.
> 

Keep in mind that a different classes of objects may have distinct 
labeling in SELinux.  e.g. a process and a file typically have different 
labels (say, sshd_t vs. sshd_key_t).

Also, I think you will want to have the global namespace always use the 
original security labels.  If accessing an object from outside the 
container, the original global policy should always apply.  Really, this 
needs to be an invariant property.

I'd suggest implementing an orthogonal 2nd set of security labels which 
are only ever used within the container.


> To implement this would require a revision on the selinux labels xattrs
> so that they can be marked as being part of a container...  But having
> the labels look ordinary inside the container.
> 
> We almost have a patch that implements something like that for the
> capability xattr.

It'll be interesting to see.

-- 
James Morris
<jmorris@namei.org>
