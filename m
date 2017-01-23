Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: Nicolas Iooss <nicolas.iooss@m4x.org>
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <CAJfZ7=kCGyw65inC0yDCcTS5ub+0iuhOs3QT_WsbN_Jd3YDYwQ@mail.gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <83a0b102-75ea-4f76-dc51-2b60c887353a@tycho.nsa.gov>
Date: Mon, 23 Jan 2017 11:09:20 -0500
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=kCGyw65inC0yDCcTS5ub+0iuhOs3QT_WsbN_Jd3YDYwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/21/2017 08:58 AM, Nicolas Iooss wrote:
> On Wed, Jan 18, 2017 at 9:53 PM, James Carter <jwcart2@tycho.nsa.gov
> <mailto:jwcart2@tycho.nsa.gov>> wrote:
>
>     Nicolas Iooss discovered that requiring a type in an optional block
>     after the type has already been declared in another optional block
>     results in a duplicate declaration error.
>
>     The following policy will trigger the error.
>
>     optional {
>       type T1;
>     }
>
>     optional {
>       require { type T1; }
>     }
>
>     In this case, although symtab_insert() in libsepol properly identifies
>     that the first T1 is a declaration while the second is a require, it
>     will return -2 which is the return value for a duplicate declaration
>     and expect the calling code to properly handle the situation. The
>     caller is require_symbol() in checkpolicy and it checks if the previous
>     declaration is in the current scope. If it is, then the require can be
>     ignored. It also checks to see if the declaration is a type and the
>     require an attribute or vice versa which is an error. The problem is
>     that -2 is returned if the declaration is not in scope which is
>     interpreted as a duplicate declaration error.
>
>     The function should return 1 instead which means that they symbol was not
>     added and needs to be freed later.
>
>
> Hello,
> I tested your patch with the following policy module written in a file named
> testmodule.te:
>
>     module testmodule 1.0.0;
>     require { class process { fork }; }
>     optional {
>       require { attribute ATTR; }
>       type TYPE1, ATTR;
>     }
>     optional {
>       require { type TYPE1; }
>       allow TYPE1 self:process fork;
>     }
>
> checkmodule failed to compile this module:
>
>   testmodule.te:10:ERROR 'This block has no require section.' at token '}' on
> line 10:
>   }
>     allow TYPE1 self:process fork;
>

I was looking at what my patch did late Friday and I thought that this might happen.

> Hence I modified the require statement of the second optional block to "require
> { type TYPE1, TYPE2; }" and checkmodule reported:
>
>   testmodule.te:9:ERROR 'type TYPE1 is not within scope' at token ';' on line 9:
>     require { type TYPE1, TYPE2; }
>     allow TYPE1 self:process fork;
>
> It seems there is a scope issue with TYPE1 when it is used in a block where it
> is required. Is this a bug?
>

This is not the desired behavior. I am looking at refactoring this code.

Thanks for the report.

Jim


> Thanks,
> Nicolas
>
> PS: while debugging this issue I found some other memory leaks in checkpolicy. I
> will send some patches later.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
