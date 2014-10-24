MIME-Version: 1.0
In-Reply-To: <5436CC14.2040906@schaufler-ca.com>
References: <5436CC14.2040906@schaufler-ca.com>
Date: Fri, 24 Oct 2014 15:49:30 -0400
Message-ID: <CAHC9VhQ-0biopRvb8f-ssZ0dfGhAd5Jvh8ozgjA=gfASA=3czg@mail.gmail.com>
Subject: Re: Functions prefixed with security_ in SELinux
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Cc: LSM <linux-security-module@vger.kernel.org>,
 SELinux <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Oct 9, 2014 at 1:55 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> As I've been working on the multiple concurrent modules project I have
> frequently encountered the use of the function prefix security_ in
> SELinux specific code. I understand and appreciate that this code has
> been there since the dawn of time. The LSM infrastructure also uses this
> prefix, and that's where I have my concern. When I'm grubbing about for
> uses of the LSM infrastructure in the SELinux code it's really quite
> annoying. Would the SELinux community be open to considering the
> possibility of thinking about cleaning up this bit of namespace
> pollution? It surely isn't a critical issue, but it would certainly look
> better.
>
> security_context_to_sid -> selinux_context_to_sid
>
> Just a thought.

Sorry for the delay.  I've been a bit busy and this got lost in my
SELinux folder.

It probably is something we should clean up, in fact we should
probably take a long hard look at why we still keep the "security
server" code separated from the SELinux hooks code.  I understand the
original reasoning, but I wonder if that still matters, especially
with many Linux-isms creeping into the security server code.

So to answer your question, yes, it is something I would consider, but
likely only as part of a larger effort to cleanup/integrate the
SELinux security server code into the Linux specific code.

-- 
paul moore
www.paul-moore.com
