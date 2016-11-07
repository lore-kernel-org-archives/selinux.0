Subject: Re: Security context of shared libraries
To: mm <mm19827@gmail.com>, selinux@tycho.nsa.gov
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8ff395c1-f0cd-061f-fb26-2bba74eb32d7@tycho.nsa.gov>
Date: Mon, 7 Nov 2016 08:35:29 -0500
MIME-Version: 1.0
In-Reply-To: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/05/2016 02:55 PM, mm wrote:
> Hi all,
> 
> I have an executable started by /bin/foo which runs confined within the
> context foo_t.
> The process loads (actually does LD_PRELOAD) bar.so which needs to
> access resources outside foo_t (actually unconfined_t).
> 
> I can allow access to such resources from foo_t, but I would like to
> allow such access only for code running within bar.so, instead of the
> whole process.
> 
> I have been looking in the docs, but I could not find if it is possible
> to specify a source context for shared libraries, instead of whole
> processes.
> My idea would be to define a context bar_t for code running within
> bar.so, and allow the required access (to unconfined_t) from bar_t,
> without extending access for foo_t.
> 
> Makes sense? Is it possible?

I understand what you are saying but it wouldn't be secure and it is not
possible.  Instead, run bar.so in a separate program/process and have
them communicate over an IPC mechanism.
