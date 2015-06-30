Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5U8bfIu022935
 for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2015 04:37:41 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id 2E03CB66A1
 for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2015 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-200-22.brq.redhat.com
 [10.40.200.22])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t5U8bYJL026897
 for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2015 04:37:36 -0400
Message-ID: <5592554E.3040202@redhat.com>
Date: Tue, 30 Jun 2015 10:37:34 +0200
From: Miroslav Grepl <mgrepl@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: type inheritance in CIL
References: <5590F3DE.8070202@redhat.com> <20150629075651.GA8191@x250>
 <559129C1.4010201@redhat.com> <559194E2.20501@tycho.nsa.gov>
 <20150629192501.GA1380@x250>
In-Reply-To: <20150629192501.GA1380@x250>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/29/2015 09:25 PM, Dominick Grift wrote:
> On Mon, Jun 29, 2015 at 02:56:34PM -0400, James Carter wrote:
>> On 06/29/2015 07:19 AM, Miroslav Grepl wrote:
>>> On 06/29/2015 09:56 AM, Dominick Grift wrote:
>>>> On Mon, Jun 29, 2015 at 09:29:34AM +0200, Miroslav Grepl
>>>> wrote:
>>>>> Trying to make sandbox working using CIL but I see it does
>>>>> not support typeinherit statement.
>>>> 
>>>> One of those features that really define CIL but that is
>>>> currently not available or fully working yet.
>>>> 
>> 
>> Inheritance in CIL is handled with blocks.
>> 
>> The following policy:
>> 
>> (block b1 (type t) (allow t self (CLASS (PERM))) )
>> 
>> (block b2 (blockinherit b1))
>> 
>> Would result in two types (b1.t and b2.t) and two rules.
>> 
>> See block_test.cil and name_resolution_test.cil in secilc/test/
>> for more examples. Everything should work, but, of course, it has
>> seen less testing at this point.
> 
> Thanks I am aware of that featurew, namespacing is also still a bit
> buggy in my view though.
> 
> If this is meant to be a substitute for typeinherit then how is one
> supposed to implement something that behaves like
> typeinheritfilter?
> 
> You are aware the typeinherit and typeinheritfilter are still
> documented on https://github.com/SELinuxProject/cil/wiki?
>> 

Yeap.

So the point is I need to re-write the current sandbox policy to CIL
using block statements to use inheritance.

>> Jim
>> 
>>>> My suggestion is to study the "cilpolicy" (which is really
>>>> just a snapshot of reference policy transformed to cil with
>>>> hll i believe)
>>>> 
>>>> This will give you some pointers as to how to create an
>>>> alternative implementation that achieves a similar result.
>>>> 
>>>> When you write CIL policy, there are some "bugs" to take
>>>> into account and to workaround.
>>>> 
>>> 
>>> Sure there are different ways how to write it. I just wanted
>>> to combine it with the current Fedora policy as much as
>>> possible without re-writing the current Fedora policy.
>>> 
>>>>> 
>>>>> -- Miroslav Grepl Senior Software Engineer, SELinux
>>>>> Solutions Red Hat, Inc.
>>>>> _______________________________________________ Selinux 
>>>>> mailing list Selinux@tycho.nsa.gov To unsubscribe, send
>>>>> email to Selinux-leave@tycho.nsa.gov. To get help, send an
>>>>> email containing "help" to Selinux-request@tycho.nsa.gov.
>>>> 
>>>> 
>>>> 
>>>> _______________________________________________ Selinux
>>>> mailing list Selinux@tycho.nsa.gov To unsubscribe, send email
>>>> to Selinux-leave@tycho.nsa.gov. To get help, send an email
>>>> containing "help" to Selinux-request@tycho.nsa.gov.
>>>> 
>>> 
>>> 
>> 
>> 
>> -- James Carter <jwcart2@tycho.nsa.gov> National Security Agency 
>> _______________________________________________ Selinux mailing
>> list Selinux@tycho.nsa.gov To unsubscribe, send email to
>> Selinux-leave@tycho.nsa.gov. To get help, send an email
>> containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
> 
> _______________________________________________ Selinux mailing
> list Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
> "help" to Selinux-request@tycho.nsa.gov.
> 


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
