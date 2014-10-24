Message-ID: <544AC5A6.6080200@schaufler-ca.com>
Date: Fri, 24 Oct 2014 14:33:26 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: Functions prefixed with security_ in SELinux
References: <5436CC14.2040906@schaufler-ca.com>
 <CAHC9VhQ-0biopRvb8f-ssZ0dfGhAd5Jvh8ozgjA=gfASA=3czg@mail.gmail.com>
In-Reply-To: <CAHC9VhQ-0biopRvb8f-ssZ0dfGhAd5Jvh8ozgjA=gfASA=3czg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: LSM <linux-security-module@vger.kernel.org>,
 SELinux <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/24/2014 12:49 PM, Paul Moore wrote:
> On Thu, Oct 9, 2014 at 1:55 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> As I've been working on the multiple concurrent modules project I have
>> frequently encountered the use of the function prefix security_ in
>> SELinux specific code. I understand and appreciate that this code has
>> been there since the dawn of time. The LSM infrastructure also uses this
>> prefix, and that's where I have my concern. When I'm grubbing about for
>> uses of the LSM infrastructure in the SELinux code it's really quite
>> annoying. Would the SELinux community be open to considering the
>> possibility of thinking about cleaning up this bit of namespace
>> pollution? It surely isn't a critical issue, but it would certainly look
>> better.
>>
>> security_context_to_sid -> selinux_context_to_sid
>>
>> Just a thought.
> Sorry for the delay.  I've been a bit busy and this got lost in my
> SELinux folder.
>
> It probably is something we should clean up, in fact we should
> probably take a long hard look at why we still keep the "security
> server" code separated from the SELinux hooks code.  I understand the
> original reasoning, but I wonder if that still matters, especially
> with many Linux-isms creeping into the security server code.
>
> So to answer your question, yes, it is something I would consider, but
> likely only as part of a larger effort to cleanup/integrate the
> SELinux security server code into the Linux specific code.
>

Would you consider patches that address this as part of the Multiple
LSM work? I wouldn't be doing the security server integration as that
would be outside the scope of the effort, but I consider the namespace
issue to be in scope. I won't bother if you aren't open to it.

Thank you.
