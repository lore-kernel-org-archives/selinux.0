Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t94FueP8025357
 for <selinux@tycho.nsa.gov>; Sun, 4 Oct 2015 11:56:41 -0400
In-Reply-To: <56109081.1040007@comcast.net>
References: <201510032038.27911.russell@coker.com.au>
 <56109081.1040007@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Computer Science and SE Linux
From: Russell Coker <russell@coker.com.au>
Date: Mon, 05 Oct 2015 02:56:28 +1100
To: Thomas Rozenbroek <tom.rozenbroek@comcast.net>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Thomas Rozenbroek <Tom.Rozenbroek@comcast.net>
Message-ID: <B1CEB313-5A0F-4F15-8AA5-10A0E243F6AC@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

No. But I'll probably write a blog post covering much of that material - at least the areas that I've personally worked on.

On October 4, 2015 1:35:45 PM GMT+11:00, Thomas Rozenbroek <tom.rozenbroek@comcast.net> wrote:
>Will these lecture(s) be recorded and made available to those of us,
>who 
>are not able to attend?
>
>Thank you for your efforts
>
>Respectfully,
>
>thr
>-----
>
>On 10/3/2015 6:38 AM, Russell Coker wrote:
>> I'm going to offer a lecture about the Computer Science aspects of SE
>Linux in
>> the near future.  Here's a quick summary of what I'm thinking of
>speaking
>> about.
>>
>> MAC vs DAC.
>>
>> Domain-Type as a concept (not details of implementation).
>>
>> LSM as a concept.
>>
>> PAM and cron modifications.  Generally how the Unix users fit in with
>SE Linux
>> and how that can be extended to other MAC systems.
>>
>> Why we modify init and what other options were tested.
>>
>> MLS as a concept in general.
>>
>> File labelling, why and how.
>>
>> Algorithms for optimising setfiles.
>>
>> I'd like to speak about some features of the kernel code.  I recall
>reading
>> about the optimisations for 32 core systems some time ago, I'm sure
>there's
>> something in that which is worth mentioning.  It's not an area that
>I've
>> worked on, can anyone suggest something I should read about this?
>>
>> Any suggestions for other things I should mention?  Note that I'm not
>planning
>> to mention anything about how to actually use SE Linux.  There are
>lots of web
>> sites about that and I could offer a lecture on that topic at a
>different venue.
>> The previous lecture in the series was about the design of the Enigma
>machines
>> for WW2 cryptography.  The audience want to generally learn about
>maths and
>> science not necessarily learn things that they can actually do.
>>
>> Also the format of the presentation is that it has to finish quickly
>when the
>> pizza arrives.  So the items at the bottom of the list may get
>skipped.
>>

-- 
Sent from my Samsung Galaxy Note 3 with K-9 Mail.
