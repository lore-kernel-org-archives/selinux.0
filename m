Message-ID: <544C3FB2.2010308@schaufler-ca.com>
Date: Sat, 25 Oct 2014 17:26:26 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: Functions prefixed with security_ in SELinux
References: <5436CC14.2040906@schaufler-ca.com>	<CAHC9VhQ-0biopRvb8f-ssZ0dfGhAd5Jvh8ozgjA=gfASA=3czg@mail.gmail.com>	<544AC5A6.6080200@schaufler-ca.com>
 <CAHC9VhQ37HsMqyxGSgtPN07QUn6J2mJXBQy6RQZD1FnbzunV9Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ37HsMqyxGSgtPN07QUn6J2mJXBQy6RQZD1FnbzunV9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: LSM <linux-security-module@vger.kernel.org>,
 SELinux <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/25/2014 9:45 AM, Paul Moore wrote:
> On Fri, Oct 24, 2014 at 5:33 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Would you consider patches that address this as part of the Multiple
>> LSM work? I wouldn't be doing the security server integration as that
>> would be outside the scope of the effort, but I consider the namespace
>> issue to be in scope. I won't bother if you aren't open to it.
> No, sadly I think a rename patch would need to be part of a larger
> cleanup/integration effort; otherwise it just looks like a lot of
> churn for minimal benefit.  I understand that is probably looks
> significant within the work you are doing to stack LSMs, but
> considering how rare/unique that work is, I don't think this is
> problem many people are likely to run into on a regular basis.

OK, I shan't worry about it. I suspect that I'm the only person
on the planet likely to be bothered especially much by it, and I
do have enough other kittens to fry.
