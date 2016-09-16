Subject: Re: [PATCH] Change semantic of -r in sefcontext_compile
To: William Roberts <bill.c.roberts@gmail.com>
References: <1474031328-29743-1-git-send-email-jdanis@android.com>
 <1fa3c006-bfa9-357e-7f88-1c8dfa50a0d2@tycho.nsa.gov>
 <CAFftDdrwgiFBsA182ZT-q=9P3Vi01E4jq0EY=C2vc6usFr_kyA@mail.gmail.com>
Cc: Janis Danisevskis <jdanis@android.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 James Carter <jwcart2@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f43aad14-f573-2b24-8293-b51a2e111324@tycho.nsa.gov>
Date: Fri, 16 Sep 2016 11:14:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdrwgiFBsA182ZT-q=9P3Vi01E4jq0EY=C2vc6usFr_kyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/16/2016 11:08 AM, William Roberts wrote:
> On Fri, Sep 16, 2016 at 7:41 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 09/16/2016 09:08 AM, Janis Danisevskis wrote:
>>> This patch reestablishes the default behavior of sefcontext_compile
>>> to include precompiled regular expressions in the output. If linked
>>> against PCRE2 the flag "-r" now causes the precompiled regular
>>> expressions to be omitted from the output.
>>
>> I thought your original rationale was more compelling.  If we add
>> detection of the relevant arch properties, then we can do this.
>> Otherwise, I don't think we should.
> 
> I was assuming based on the thread earlier that those patches would be coming.
> If we cant detect and compile on the current "undefined behavior"
> case, then this
> needs to stay as is.
> 
> But I thought someone had a list of PCRE things that can be checked for "arch",
> so its just a matter of encoding those, assuming that list is correct.
> 
> Binary file_contexts only make sense if you compile in the regex info, else
> just use the textual representation.

That was my thought originally, but Janis did say that it was still
faster, and Android presently only ships file_contexts.bin, so we can't
just break that.
