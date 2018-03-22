To: Pierre-Hugues Husson <phh@phh.me>, selinux@tycho.nsa.gov
References: <20180319184756.12561-1-phh@phh.me>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <39475599-7ead-afb0-0192-12be7c010871@tycho.nsa.gov>
Date: Thu, 22 Mar 2018 13:40:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180319184756.12561-1-phh@phh.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 0/1] Support multiple identical genfscon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/19/2018 02:47 PM, Pierre-Hugues Husson wrote:
> secilc has a multiple_decls option to allow for multiple type
> declarations.
> The next step is to allow multiple samples of the same rules.
> This commit does this on genfscon
> 
> One usecase is Android/Project Treble:
> With Project Treble, vendor might include rules included in later
> in framework.
> In order to be able to update the framework in this case, we need
> to remove identical rules.
> 
> I have several pending questions before considering merging:
> 
> Should the "compact" function be somewhere else? Or perhaps there is already
> some variant available?

Where you put it is fine. There is no other variant.

> Should the "compact" function simply take a cil_sort rather than a C array?
> Should we compact all types indifferently?

It looks like secilc is not checking for duplicates right now for any of the 
ocontext rules which is a problem.

I am assuming that if the genfscon is different only in the context, then that 
should be an error. Is that correct?

So the following should be an error:
(genfscon FS1 / (U R T1 ((S) (S))))
(genfscon FS1 / (U R T2 ((S) (S))))

but if they both had T1, then it would be ok, but the second rule would not be 
added to the policy.

I think the right approach in the compact function is to return an error if the 
compare function returns 0 and the multiple-decls flag has not been used or the 
contexts of the two rules are not the same. If the rule is exactly the same and 
the multiple-decls flag is set, then skip the duplicate rule.

> If so, we need to guarantee that the _compare function returns 0 only when the
> types rules are identical, and not just the same match rule. Is this already
> the case?
> How is memory allocation done/will compact impact the release of the memory?
> In my understanding this is just one big chunk, so the size isn't used when
> free-ing, so it should be ok
> 
Yes. It is one big chunk.

Thanks,
Jim

> 
> Pierre-Hugues Husson (1):
>    Delete identical genfscon-s
> 
>   libsepol/cil/src/cil_post.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
