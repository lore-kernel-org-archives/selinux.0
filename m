Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4VEs5eE022762
	for <selinux@tycho.nsa.gov>; Sat, 31 May 2008 10:54:05 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4VEs4kX013496
	for <selinux@tycho.nsa.gov>; Sat, 31 May 2008 14:54:04 GMT
Received: by an-out-0708.google.com with SMTP id d30so147802and.75
        for <selinux@tycho.nsa.gov>; Sat, 31 May 2008 07:54:04 -0700 (PDT)
Message-ID: <dd18b0c30805310754x27c7ba30p1c5b0f8a355c7c01@mail.gmail.com>
Date: Sat, 31 May 2008 14:54:04 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: russell@coker.com.au
Subject: Re: question about security
Cc: "Charles, Theodore" <txc5810@lausd.net>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "Matthew Hammer" <matthewhammer89@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <200805312247.57138.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30805301004h5c9bbf7fmb4bfced81264b8c2@mail.gmail.com>
	 <367BE2FA995D5747B2E75B330734CA616BD237@MAILBE-LA17.lausd.net>
	 <dd18b0c30805301734q43f4509cle3e89be4451f53f@mail.gmail.com>
	 <200805312247.57138.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, May 31, 2008 at 12:47 PM, Russell Coker <russell@coker.com.au> wrote:
> On Saturday 31 May 2008 10:34, "Justin Mattock" <justinmattock@gmail.com>
> wrote:
>> would this have been a better outcome.  As for what happened at
>> comcast, I really don't know, I just don't like hearing story's like
>> that, The positive side is the hackers exposed holes which can then be
>> fixed, but in this case the hackers exposed the holes, they just chose
>> to ignore them,(if this is the case) causing a more of a wakeup call
>> later in time.
>
> http://en.wikipedia.org/wiki/Comcast
> http://en.wikipedia.org/w/index.php?title=Comcast&oldid=216058661
>
> According to the above page (I give the URLs for the latest page and the
> specific version that I cite) the comcast hack was based on "gained control
> of Comcast's domain management console at Network Solutions".
>
> http://blog.wired.com/27bstroke6/2008/05/comcast-hijacke.html
>
> The Wikipedia page cites the above Wired article which says "the pair used a
> combination of social engineering and a technical hack to get into Comcast's
> domain management console at Network Solutions. They declined to detail their
> technique, but said it relied on a flaw at the Virginia-based domain
> registrar".
>
> Sufficiently advanced/dedicated/lucky social engineering can get through
> almost any defence.  A majority of such attacks involve tricking someone into
> giving away their password.
>
> It is claimed that there is a flaw with Network Solutions software but no
> evidence is presented.  If the claim is correct then there would be nothing
> that Comcast could have done in software as the problem would be some
> combination of Comcast people and procedures combined with NetSol software.
>
> Web Apps are a problem area.  One question I have been asked a few times is
> about how to use SE Linux to secure a Web App that does something important.
> The question often is effectively "how can I make a program which is designed
> for the specific purpose of managing sensitive data not have the ability to
> mis-manage it".  The answer is that if you have multiple sets of data that
> you want to keep separate then you can do it, but if you have it all together
> then there's not much that can be done.
>
> I do however have some ideas for ways that it might be possible to use SE
> Linux to improve the security of Wordpress, I'll have to blog about that.
> But first I want to get a proof of concept.  I expect that like most people
> the Wordpress developers aren't enthusiastic about suggestions like "here's a
> way that you could do a heap of work to solve something that you might not
> even consider to be a bug, I'm not even sure it'll work but I'll tell you
> anyway".
>
> Finally one lesson that can be learned from Comcast is that if some data which
> is important to your operation unexpectedly gets changed to include profanity
> then you need to take it as proof of a serious problem which requires
> immediate action.  Also if someone who has no good reason to know your job
> calls you at home to discuss it then you should listen to what they have to
> say - once they have demonstrated that they have access to secret data you
> have to assume that there is more and you need to know what it is.
>
> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Blog
>
> http://www.coker.com.au/sponsorship.html Sponsoring Free Software development
>

Thanks for the response, After reading through I get mixed emotions,
but coming down to conclusions,
personally the hackers responsible should take more responsibility for
there actions and come out and admit
how they performed the attack, and so forth. (but then I would be
asked to get a reality check)
overall It seems maybe they need a job. I can't tell you how many
people have told me "the only way to get a job in computers is to hack
into a big company, or government entity" I always responded "yeah
right fuck that shit",  "Don't do the crime if you can't do the time".
Anyways the best would  be to learn from the mistakes, or holes in
this case and grow stronger.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
