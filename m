Message-ID: <5502E8BB.4090404@tycho.nsa.gov>
Date: Fri, 13 Mar 2015 09:40:11 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix -Wformat errors
References: <1426251329-23672-1-git-send-email-plautrba@redhat.com>
 <5502E02C.7060306@tycho.nsa.gov> <5502E81C.50208@redhat.com>
In-Reply-To: <5502E81C.50208@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/13/2015 09:37 AM, Petr Lautrbach wrote:
> On 03/13/2015 02:03 PM, Stephen Smalley wrote:
>> On 03/13/2015 08:55 AM, Petr Lautrbach wrote:
>>> Fixes two types of errors which appear when building with gcc-5.0.0
>>>
>>> - format ‘%d’ expects argument of type ‘int’, but argument X has type ‘unsigned int’
>>> - format ‘%a’ expects argument of type ‘float *’, but argument X has type ‘char **’
>>
>> %a is the dynamic allocation conversion specified in glibc, at least
>> prior to glibc 2.7, and is available if _GNU_SOURCE is specified (which
>> is set in CFLAGS in libselinux/src/Makefile).  So your change will break
>> on older glibc IIUC.
>>
> 
> %ms format string is already used in
> libselinux/utils/sefcontext_compile.c and policycoreutils/hll/pp/pp.c

Ah, didn't realize that.

> The other way to fix it would be to use -std=gnu89 everywhere since
> gcc-5 defaults to -std=gnu11.

No, we'll just take the change, and if it presents a problem for
someone, we can always wrap all occurrences with a macro based on glibc
version.
