Subject: Re: [PATCH] libselinux: add support for pcre2
To: Janis Danisevskis <jdanis@android.com>
References: <1473948269-143019-1-git-send-email-jdanis@android.com>
 <25614fcd-20d5-c8ed-2d8a-7f47ae7938de@tycho.nsa.gov>
 <CAFftDdqDF1vC8-JQmZWPd2VZ7HpOQ7S5WagCfuxULtGU6+Q72w@mail.gmail.com>
 <CAAdwW5O6O630ORMOPBd0-2hg7xXGhgX=e6JEA2Poirz=8TFK6g@mail.gmail.com>
 <CAFftDdr+DqYSDOdjE7d5f6uz3++gvQqi2heJX7CJJXaHQQibVA@mail.gmail.com>
 <CAAdwW5PQvft0ZzFuG52Eid2Z=vZtvnmuOLw-_p+0x9bY+GZDGg@mail.gmail.com>
 <CAFftDdpN7Dzmt+5C1rADZh71wyoy+GrYf8eXUhv5GrOS-8_Leg@mail.gmail.com>
 <CAAdwW5M+qzpzZKqM0vvtCRvv14re_ahTLW_4E+wpezAiK8qqaA@mail.gmail.com>
 <CAFftDdodugeHpjiZRvr8J_5_UXQ92+iE+pO7Yq9RDSgPfrLTtw@mail.gmail.com>
 <20160916133146.GA8294@meriadoc.perfinion.com>
 <77ceec87-5ce6-c7f6-9620-bf2ac045f21c@tycho.nsa.gov>
 <CA+xTVEvzmjqOtKRKiapx-xfMKDRcKQV6JkFdV3eM9R1we6Jdqg@mail.gmail.com>
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <70dee52e-86e7-0a88-ec56-fa45fa172b69@tycho.nsa.gov>
Date: Fri, 16 Sep 2016 15:06:54 -0400
MIME-Version: 1.0
In-Reply-To: <CA+xTVEvzmjqOtKRKiapx-xfMKDRcKQV6JkFdV3eM9R1we6Jdqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/16/2016 02:57 PM, Janis Danisevskis wrote:
> I have started implementing an arch string patch. Unfortunately, i did
> not manage to finish it before I had to leave the office today.
> In essence I did this:
> The regex_arch_string has three components: the pointer width determined
> by sizeof(void*), PCRE2_SIZE width determined by sizeof(), and
> endianess determined by
> __BYTE_ORDER__==__ORDER_BIG/LITTEL_ENDIAN__
> 
> For example, the resulting string for x86_64 and aarch64el should look like
> this: "8-8-el".
> 
> I bumped the compiled context version number and added the string
> right after the version in the output.
> Comments?

What's the error handling when the versions do not match?  Just ignore
the compiled regexes in file_contexts.bin?
