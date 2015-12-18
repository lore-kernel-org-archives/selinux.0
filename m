Subject: Re: security_bounded_transition fails
To: Hannu Savolainen <hannu.savolainen@huawei.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <B295455A1EDEE541907F53334176EF68070002FE@lhreml504-mbx>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56740C7C.8060001@tycho.nsa.gov>
Date: Fri, 18 Dec 2015 08:39:08 -0500
MIME-Version: 1.0
In-Reply-To: <B295455A1EDEE541907F53334176EF68070002FE@lhreml504-mbx>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/18/2015 01:12 AM, Hannu Savolainen wrote:
> Hi,
>
> I'm having a problem with a multithreaded application. It does lengthy  initialization in advance under relatively privileged context and then switches to a less privileged one after the moment when the actual request arrives. After that it will create a chrooted container and join all threads to a new SELinux context.
>
> However the transition fails with audit message "op=security_bounded_transition result=denied oldcontext=old_context newcontext=new_context".
>
> Is there any policy rule that could be used to fix this or is this just not supported?

First, it is easier and safer to perform the privileged initialization 
and switch to the unprivileged context _before_ spawning other threads. 
  Then you won't have this problem at all.

If for some reason you cannot do that, then the requirement for a 
multi-threaded process is that you can only setcon to a domain bounded 
by your current domain, where these bounding relationships are defined 
through the use of the typebounds statement in policy.  The 
child/bounded domain is then restricted to a subset of the permissions 
of the parent/boundary domain, so you cannot allow the child/bounded 
domain any permission not allowed to the parent/boundary domain.
