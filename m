MIME-Version: 1.0
In-Reply-To: <200901141243.32962.paul.moore@hp.com>
References: <496D759A.7010401@gmail.com> <200901141205.26904.paul.moore@hp.com>
	 <1231953881.31192.43.camel@localhost.localdomain>
	 <200901141243.32962.paul.moore@hp.com>
Date: Sun, 18 Jan 2009 11:17:30 -0500
Message-ID: <7e0fb38c0901180817k76080453u371996f079914a8d@mail.gmail.com>
Subject: Re: netlabel: UNLABELED ath9k not denying unlabeled traffic
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        "Justin P. Mattock" <justinmattock@gmail.com>,
        SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jan 14, 2009 at 12:43 PM, Paul Moore <paul.moore@hp.com> wrote:
> On Wednesday 14 January 2009 12:24:41 pm Stephen Smalley wrote:
>> On Wed, 2009-01-14 at 12:05 -0500, Paul Moore wrote:

>> > It's pretty cool.  In newer versions of netlabelctl I added an
>> > undocumented option to actually allow it to fix a sandwhich and do
>> > the dishes afterwards.  The exact command line option needed is
>> > left as an exercise for the reader :)
>>
>> I hope it doesn't run afoul of this patent:
>> http://www.wipo.int/pctdb/en/wo.jsp?IA=US2005044838&WO=2006068865&DIS
>>PLAY=STATUS
>
> Sigh.  I fear that it may, guess I'll have to pull feature from the next
> release :(  What am I going to do for lunch now!

"pre-assembly of various sandwich components and simultaneous
preparation of different parts of the same sandwich"

Unless netlabelctl is mutl-threaded I think you're safe based on the
"simultaneous preparation" portion of the patent.  I'm glad you've
done this.  I'm hungry, even if I have to wait for one part of the
sandwich to be finished before it starts working on the next....

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
