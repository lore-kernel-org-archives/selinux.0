MIME-Version: 1.0
In-Reply-To: <CAHC9VhTBSfNO+st9S+wCvy5KQVxQ1U1CBJN1Sec9Jh=pb6VT3A@mail.gmail.com>
References: <1495040944-11552-1-git-send-email-sbuisson@ddn.com>
 <CAHC9VhSa_0FnaHpFR9jB4tkV-7p_JxFqRaQGC7+LTkfcmdV7mA@mail.gmail.com>
 <1495116094.5475.4.camel@tycho.nsa.gov>
 <1495120065.5475.10.camel@tycho.nsa.gov>
 <CAHC9VhTkBJ4f6Zkeu=Ufae1XHyxVCgfARyj8Hc6yiEgh55Xz-Q@mail.gmail.com>
 <CAPkE-bW_dLo2hoE+rA_sOgZnqcZD_9L1RiDvyDBAtxJm3AM5Wg@mail.gmail.com>
 <CAHC9VhTBSfNO+st9S+wCvy5KQVxQ1U1CBJN1Sec9Jh=pb6VT3A@mail.gmail.com>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Wed, 24 May 2017 17:26:20 +0200
Message-ID: <CAPkE-bXeTJhD+CXFVpzBGWuAvsddTX+6gkRrmqZE69yu2Vwrtg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] selinux: add brief info to policydb
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org,
 Sebastien Buisson <sbuisson@ddn.com>, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-05-23 21:11 GMT+02:00 Paul Moore <paul@paul-moore.com>:
> On Tue, May 23, 2017 at 12:29 PM, Sebastien Buisson
> <sbuisson.ddn@gmail.com> wrote:
>> Another way could be to add another hook to check policy brief info
>> validity. It would take a string as an input parameter, and return 0
>> if it matches the current policy. So Lustre client code would
>> systematically call this hook, and only call security_policydb_brief()
>> when the policy has changed, to store the current value internally.
>
> I'm not sure I like this approach as much as the one above, for a
> variety of reasons.  Is this option more desirable from a Lustre point
> of view?

It is true that now that the notification code is present in the
selinux/next branch, it is worth using it. I was thinking, but I may
be wrong, that future inclusion of this series of patches in some
distributions' kernels like CentOS or RedHat would be easier if it did
not have dependencies on other patches. This is why I thought about an
alternative solution.
Technically speaking, the solution based on notifications can fit the
Lustre needs, letting Lustre maintain its own sequence number as you
suggest.

Sebastien.
