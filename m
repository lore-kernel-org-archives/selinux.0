Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5DEMdkF004838
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 10:22:39 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5DEMbhG026420
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 14:22:38 GMT
Received: by wr-out-0506.google.com with SMTP id c37so2720189wra.26
        for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 07:22:37 -0700 (PDT)
Message-ID: <485282AB.5010409@gmail.com>
Date: Fri, 13 Jun 2008 10:22:35 -0400
From: max <maximilianbianco@gmail.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux References/Books
References: <48502D42.4030905@gmail.com> <1213273867.17842.179.camel@moss-spartans.epoch.ncsc.mil> <a040ffdc0806121100v7732f155h881379386ad546da@mail.gmail.com> <200806132228.21083.russell@coker.com.au>
In-Reply-To: <200806132228.21083.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Friday 13 June 2008 04:00, "max bianco" <maximilianbianco@gmail.com> wrote:
>> here that I am unaware of or that simply aren't occurring to me right
>> now. I can't be the first person to have such an idea and it will of
>> course be pointed out that live journals work much the same but here
>> my point is the scope of the audience that you are reaching on a
>> mailing list vs. an individual blog of which there are hundred's of
>> thousands if not millions. Also it would help by adding more
> 
> That's why you have blog syndication.  I expect that the number of people who 
> read my blog via the various Planets exceeds the number of subscribers that 
> most mailing lists have.  Of course blog syndication does not work well for 
> content that is being modified.
> 
>> other thing I noticed, while at the bookstore, is that various/most of
>> the Linux magazines on the shelf right now have articles on security
>> in them and one, i forget which, has a piece on SELinux. It seems its
>> a hot topic everywhere I look. Cspan aired a rerun, from yesterday I
> 
> My observation is that SE Linux is not as much of a hot topic as it used to 
> be.  Now there are many people using it (some of whom don't even realise that 
> they do), and it's part of the infrastructure.  When SE Linux was a new thing 
> that few people understood there was a lot more excitement.
> 

>> what I saw nobody mentioned the real problem. As far as I am concerned
>> the "real" problem is having the widespread use of an operating system
>> that makes things like drive by downloads so easy in the first place,
> 
> Until we get the X access controls in common use, SE Linux won't be doing that 
> much to prevent desktop attacks.

I had noticed a bit of traffic about X. It seems its going to be quite 
the effort to properly confine it.
I noticed also that Eamon Walsh had posted some links to info on X 
related magic. This interests me a lot because I like to game, although 
I haven't played any games since switching over to a Linux-based OS : ( 
  I know online gaming is very popular and there aren't many Linux games 
that meet expectations but I am sure that will change or maybe everyone 
will just buy a PS3. I have heard of a few vulnerabilities in games like 
world of warcraft and eve online, though I am not sure how many are 
directly related to the xserver or whatever passes for its equivalent on 
a windows box. I know some of these games are starting to release or 
work on linux clients, it will be interesting to see how much care they 
take to do it safely and securely. I am not very hopeful on this but 
perhaps I will be surprised : )
> 
>> where most of the security rests with a program(anti virus) that
>> relies almost exclusively on updates but that is another debate and
> 
> I don't think that you will get a debate on the merits of anti-virus software 
> on this list.  I think that there is general agreement that any attacker 
> worth worrying about will launch an attack that doesn't match a known 
> signature.  Past discussions on this list have covered issues such as the 
> utility of shells and interpreters such as Perl for launching attacks.
> 
I will have to spend some of this free time I have digging through the 
archives.

> Note that this doesn't mean that virus scanners for email and browser warnings 
> for bogus sites are a bad idea.  Mitigating factors that reduce the scope of 
> the threat make it easier to recognise real threats.
> 
Understood and I wasn't trying to suggest such a thing but a lot of home 
users think anti-virus = saftey as in the 100% variety. That attitude is 
held by a lot of people even unfortunately some in the IT field. Many 
people take their computers for granted and assume the makers of such 
devices automatically try to make them as safe as possible, when its 
actually "as cost effective as possible" that wins out in the majority 
of cases. One of the first things to get sacrificed is usually security 
it seems. They seem to like to spend all the dollars on making it look 
pretty : ( which would be fine if the substance was there but I suspect 
that's another never ending debate and actually it points to a social 
problem anyway.

>> probably not one worth having anyway. Unfortunately it will probably
>> take a major virus outbreak, on a scale we have yet to see, or a
>> massive, widespread, and very public breach of security to wake people
>> up. I will go ahead and shutdown here,  my real point is that it seems
>> people are starting to pay a lot more attention :^). Thanks for the
>> feedback.
> 
> http://conference.auscert.org.au/conf2006/presentation.php
> 
> There are significant amounts of money involved in computer crime nowadays.  
> At the AusCERT 2006 conference Jake Jacobson of the U.S. Secret Service gave 
> a very interesting talk about the organised computer crime groups.  The 
> amounts of money involved give a lot of nasty people significant incentives 
> to not have public breaches of security.
> 
> I've been involved in the SE Linux project for almost seven years.  Over that 
> time I have always felt that the problem scope is increasing faster than our 
> progress on fixing things.
> 
It would be nice if we (the human race) were as wise as we are eager.


> 
> PS  If you get a chance I recommend that you attend a lecture by Jake or one 
> of his colleagues.  It's an experience you'll remember for the rest of your 
> life.
> 
Will do. I am already putting the link you provided to use :^) I love 
information, if you have any other links I am always looking for good 
ones. Considering the volume of information available I think I am going 
to have to take a speed reading&retention course.

-- 
Fortune favors the BOLD

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
