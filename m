Subject: Re: selinux 2.6-rc1 release planned 9/30
To: William Roberts <bill.c.roberts@gmail.com>,
 Janis Danisevskis <jdanis@google.com>
References: <883e1b35-467e-e3dd-5baa-1822ab003829@tycho.nsa.gov>
 <CAFftDdqgu0dNoetJXiRCVZ6uK_Qd4U+0xo2jTj=pscQAy48UWw@mail.gmail.com>
 <43a1504f-f8f7-7575-d97b-48412aefea3f@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <93d8efc2-3a4c-48d6-4452-7a9304eb98d7@tycho.nsa.gov>
Date: Wed, 21 Sep 2016 12:41:57 -0400
MIME-Version: 1.0
In-Reply-To: <43a1504f-f8f7-7575-d97b-48412aefea3f@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/21/2016 11:52 AM, Stephen Smalley wrote:
> On 09/21/2016 11:40 AM, William Roberts wrote:
>> I'd like to see the -r flip change in by then, so no official release
>> is cut with that behavior.
>>
>> Also, I was looking at the help output for -r, and its quite
>> confusing, I cant tell if -r includes or omits, verbatim output:
>>
>> -r       Include precompiled regular expressions in the output.
>>         (PCRE2 only. Compiled PCRE2 regular expressions are
>>         not portable across architectures. When linked against
>>         PCRE this flag is ignored)
>>         Omit precompiled regular expressions (only meaningful
>>         when using PCRE2 regular expression back-end).
>> fc_file  The text based file contexts file to be processed.
> 
> Yes, Janis actually posted a patch to fix that as well, but it presumes
> the prior patch to change the -r behavior.  So we can take those two
> patches once we have the arch detection and fallback patch in place.

Actually, I'm wrong: the two patches were two different options, one of
which switched the default and the other left the default unchanged and
fixed the usage message.  So I'll apply the latter now until the arch
detection is in place.
