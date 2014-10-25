MIME-Version: 1.0
In-Reply-To: <544AC5A6.6080200@schaufler-ca.com>
References: <5436CC14.2040906@schaufler-ca.com>
 <CAHC9VhQ-0biopRvb8f-ssZ0dfGhAd5Jvh8ozgjA=gfASA=3czg@mail.gmail.com>
 <544AC5A6.6080200@schaufler-ca.com>
Date: Sat, 25 Oct 2014 12:45:01 -0400
Message-ID: <CAHC9VhQ37HsMqyxGSgtPN07QUn6J2mJXBQy6RQZD1FnbzunV9Q@mail.gmail.com>
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

On Fri, Oct 24, 2014 at 5:33 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Would you consider patches that address this as part of the Multiple
> LSM work? I wouldn't be doing the security server integration as that
> would be outside the scope of the effort, but I consider the namespace
> issue to be in scope. I won't bother if you aren't open to it.

No, sadly I think a rename patch would need to be part of a larger
cleanup/integration effort; otherwise it just looks like a lot of
churn for minimal benefit.  I understand that is probably looks
significant within the work you are doing to stack LSMs, but
considering how rare/unique that work is, I don't think this is
problem many people are likely to run into on a regular basis.


-- 
paul moore
www.paul-moore.com
