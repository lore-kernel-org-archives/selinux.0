Subject: Re: [PATCH 2/2] secilc: Add options to control the expansion of
 attributes
To: Nicolas Iooss <nicolas.iooss@m4x.org>
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1491933223-18277-3-git-send-email-jwcart2@tycho.nsa.gov>
 <CAJfZ7=kPXQPpvnv2a1Xbf=UPhHOmWNeX6J81QmuN8Wdzy6Ch+w@mail.gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <78b69c6c-4fe2-9833-d931-57ffe175d396@tycho.nsa.gov>
Date: Wed, 12 Apr 2017 09:02:32 -0400
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=kPXQPpvnv2a1Xbf=UPhHOmWNeX6J81QmuN8Wdzy6Ch+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/11/2017 04:31 PM, Nicolas Iooss wrote:
> On Tue, Apr 11, 2017 at 7:53 PM, James Carter <jwcart2@tycho.nsa.gov
> <mailto:jwcart2@tycho.nsa.gov>> wrote:
>> Added "-G, --expand_generated" option to specify that all automatically
>> generated attributes should be expanded and removed.
>>
>> Added "-X, --expand_size <SIZE>" option to specify which attributes
>> are expanded when building a kernel policy. All attributes that have
>> less types assigned to it than SIZE will be expanded when writing AV
>> rules.
>
> With this change, some secilc options use underscore between words
> (--expand_generated...) and other ones use a dash (--disable-dontaudit,
> --preserve-tunables...). Moreover when there is a parameter, the current
> documentation uses an equal sign and a lowercase placeholder word
> (--policyvers=<version>) instead of no equal and uppercase (--expand_size <SIZE>).
>
> How should the options appear in the manpage and the program usage in order to
> have a consistent text?
>

You are right. I should make them "--expand-generated" and "--expand-size" for 
consistently.

Jim

> Cheers,
> Nicolas
>
> PS: Your patches pass the tests done by Travis-CI. The results are available at
> https://travis-ci.org/fishilico/selinux/builds/221101486 .


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
