MIME-Version: 1.0
In-Reply-To: <1485184162.25059.15.camel@tycho.nsa.gov>
References: <1485178585.25059.0.camel@tycho.nsa.gov>
 <CANmMgnEVjT=M8XtY3TQJYkPJKtv_KUry+mNAudTQDXEa9DginA@mail.gmail.com>
 <1485184162.25059.15.camel@tycho.nsa.gov>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Date: Tue, 24 Jan 2017 01:48:59 +0000
Message-ID: <CANmMgnHzujdkbF=tOfk+OnRZ+MZ+xkq0k7gp7STL-qwYOMW9dQ@mail.gmail.com>
Subject: Re: selinux post
To: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm struggling with this.  Apologies for issues with this message,
starting with the length.



The recommendation / encouragement I'm getting is that I process e.g.
20 emails this weekend, or around 50 threads last month.  The reason
being not everyone Reply-All's all the time.  Apparently this list you
admin, is one of the ones that re-writes the From address without
copying it into a Reply-To.[1] I think that's the way forgetting to
Reply-All can miss out people who aren't subscribed to the list?

I should process it manually - no example is given of a system that
can process it. Or a howto? I haven't seen such systems in current
entry points.[2]

I've tried to do this before, without automation.  It just made me
twitchy and unhappy.

I know the subscribe address is in the README, it's nice and clear
next to the posting address and I chose not to use it. When later
asked to consider if I "want to receive mail from the list", my
decision was that I didn't. Then I get a third message, off-list -
implying that it's preferred for me to subscribe.

Also that there's this technical limitation.  Are you sure the
limitation isn't worth trying to document publicly?

I did gloss over the limitation half when I read it. My prior
impression has been it's mainly the moderation half not being a great
use of peoples time. Learning at this point that there's moderation, I
aspire to take the third message in good faith. And maybe there's a
reason for preferences, which I don't happen to understand, but I
could easily comply.

I'm being asked if I can comply with both halves. The simplest I can
think of is a temporary subscription to a separate address on GMail.
Do you think this is necessary and sufficient? If you saw that written
up as a recommendation, would you have a criticism of it?

This setup would rule out notifications (specifically, forwarding mail
for me to my normal setup), in favour of enshrining that I review all
list mail during the period, and ensure I find mails which didn't
Reply-All to me.

My personal preference is against this. I.e. if you asked how I handle
the constraints described to me so far, but blinded to the
implications in how it was communicated.  I simply find an archive to
look at at the start of the period, and use it to check later if I
suspect a missed message.  E.g. before re-sending a patch I had not
seen applied.  This might have lead to a delay sometime, but it's not
caused any real problem I can think of.

nntp://news.gmane.org still lives, by the way.  In principle you can
take a missed message from it and reply by email.

(Re?)discovering how to use the mail interface of Mailman (to adjust
delivery accordingly), described in the 2004 manual as harder and not
usually preferred, did not make me particularly happy at the time
either. I'm not aware of this being a common constraint... I think I'd
have had more fun creating a GMail w/ forwarding filter. Unless you
somehow sympathize with my own preferences enough that you want to add
a howto, because I think that would be better covering the Mailman
approach.

Alan

[1] http://www.spamresource.com/2014/04/google-groups-rewriting-from-addresses.html

[2] There's some movement against mailing lists.  "[rust-dev] rust-dev
will be shut down"
https://mail.mozilla.org/pipermail/rust-dev/2015-January/011558.html

I'm sure there's information around LKML, however what I remember is
religiously in favour of open mailing lists, Reply-All, and dropping
recipients without them asking being a Bad Idea.  So I'm not expecting
it to help interact with moderated lists.  (Hmm...)


On 23/01/17 15:09, Stephen Smalley wrote:
>
> On Mon, 2017-01-23 at 14:54 +0000, Alan Jenkins wrote:
>>
>> On 23/01/2017, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> Hi,
>>>
>>> You attempted to post to selinux without subscribing first.  I
>>> will approve your posting as it is on topic but I recommend that
>>> you
>>> subscribe in order to ensure that you receive all replies and that
>>> you
>>> can engage in further discussions without requiring manual
>>> moderation.
>>>
>>> To subscribe, send email to selinux-join@tycho.nsa.gov and follow
>>> the instructions in the confirmation email.
>>>
>>> Thanks.
>>
>> Thank /you/.  I've been very pleasantly surprised by the response
>> I've
>> gotten, and I wouldn't want to waste your time.
>>
>> Probably we need to add a few words to the README. It doesn't /feel/
>> like I posted unusually much, for a bug report or two.
>>
>> I'm guessing drivebys would still not be welcome on the Github issue
>> tracker, so the README should still target the ML for bug reports.
>>
>> (You did poke me earlier, but only about reading the ML. Many
>> open-source MLs are completely open for posting, and [nntp.]GMane.org
>> works great for reading.
>>
>> I was also slightly surprised how active SELinux appeared, even for
>> the few basic tools I've been using.  I'm probably going to be
>> "redirecting" all those incoming bytes to the bit bucket...  (v.s.
>> e.g. mailman subscriptions which can be set for digests or not to
>> receive anything).
>>
>> GMane also has a posting interface which I've used before.  I think
>> it's possible to request disabling it, but I'm not sure as the
>> website
>> part of GMane is down again right now).
>
> You aren't required to subscribe, but we do encourage it.
>
> We will approve on-topic postings from non-subscribers; it is just that
> they may be delayed since we can only access the administrative
> interface during normal working hours; it isn't Internet-accessible.
>  Also, you might not always see all replies if you aren't subscribed
> (some people only reply to the list), although I try to always include
> both.
>
> The README does mention how to subscribe, so I don't think we need to
> modify it.
>
> We do use mailman (we originally used majordomo but switched to mailman
> a few years ago), and I believe you can set digest options via email
> commands to it.  We just don't expose the web interface to the
> Internet.
>
> GMane has been down since this summer so it is no longer an option for
> selinux list.  Also, I don't believe we ever supported posting from it,
> just archiving there.
>
> marc.info and mail-archive.com are commonly used external mailing list
> archives for selinux list, but only for reading, of course.  There are
> also others, e.g. spinics.
