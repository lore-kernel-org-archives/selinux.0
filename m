Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, ewalsh@tycho.nsa.gov,
        ajax@redhat.com, method@manicmethod.com
Message-Id: <9F20CFFB-812C-4EDA-9764-3906427D36F6@nall.com>
From: Joe Nall <joe@nall.com>
To: Eric Paris <eparis@redhat.com>
In-Reply-To: <1235752948.3386.53.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC] X+SELinux performance work
Date: Fri, 27 Feb 2009 11:12:34 -0600
References: <1235752948.3386.53.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 27, 2009, at 10:42 AM, Eric Paris wrote:

> (sorry for everyone who gets this twice, I misspelled the list address
> the first time)

That's ok. I enjoyed it just as much the second time.

> As a great example of how much selinux is killing X performance ajax
> showed me the x11perf -create test.
>
> ...
> Last thing was that translating from raw to whatever looked to be  
> taking
> up tons of syscalls, open a socket, bind, fail, close over and over  
> and
> over.  So I added new hook where X can just disable translations
> altogether.  What does X care if it has raw strings?  I think as  
> soon as
> we have things to "display" strings to users they should take care of
> translation and just let X internally hand things back and forth the  
> way
> the AVC can use them.


If X is going to call setrans that often, it needs to cache the  
result. Even if the cache period is short (60 seconds) it would  
dramatically improve performance under load. Especially if you are  
making 175000 identical translation requests :)

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
