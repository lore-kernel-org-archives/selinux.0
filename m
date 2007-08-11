Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7BBNsmQ020307
	for <selinux@tycho.nsa.gov>; Sat, 11 Aug 2007 07:23:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7BBNrHw003640
	for <selinux@tycho.nsa.gov>; Sat, 11 Aug 2007 11:23:53 GMT
Message-ID: <46BD9C47.6080407@redhat.com>
Date: Sat, 11 Aug 2007 07:23:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Mark <elihusmails@gmail.com>
CC: shahbaz khan <shazalive@gmail.com>, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com
Subject: Re: beginner to SE Linux policy
References: <9f066ee90707271204p2bfe6da7k4f8f50798c50c2e8@mail.gmail.com>	<7b740b700707280714u72d59b83j3f6c3065d15e2b79@mail.gmail.com> <9f066ee90708071056j74618a8akd860ef084f055243@mail.gmail.com>
In-Reply-To: <9f066ee90708071056j74618a8akd860ef084f055243@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mark wrote:
> Thanks for the help.  I just want to become more familiar with SE 
> Linux and understand the context of the te, fe, if..etc files and how 
> I can modify them so that my programs are more secure.  There just 
> seems to be alot of information that may or may not be related in 
> order to help me.  For instance, there is the seedit tools, SLIDE and 
> RedHat tools available.  Also, which is a better distribution to learn 
> SE Linux, CentOS or Fedora Core?
>
> I am an application developer who really just needs to learn how to 
> write policies for the programs I am developing.  Things like 
> policies, domains and domain transition are important areas I really 
> want to learn.
>
> Thanks for the help.
>
> PS.  I ordered the SE Linux by Example yesterday!
> -- 
> ..Cheers
> Mark
You might want to try system-config-selinux/polgengui to build you a 
policy template. 
>
> On 7/28/07, *shahbaz khan* <shazalive@gmail.com 
> <mailto:shazalive@gmail.com>> wrote:
>
>     Mark
>      
>     Selinux by example is the best answer to ur stated problem. NSA
>     documents will give u a good background because things have been
>     changing alot. Do not miss tresys' reference policy and policy
>     managemnt server. U can get more info about it from tresys'
>     website. Once u start to get aquainted with selinux this mailing
>     list will be more useful to u. Also join fedora selinux mailing list.
>      
>     I am not sure which policy analysis tool will be more useful to u.
>     Why dont u right a more specific question to this list w.r.t.
>     policy analysis tools. U might get good answers from selinux by
>     example.
>      
>     Shaz.
>
>      
>
>
>     On 7/28/07, *Mark* <elihusmails@gmail.com
>     <mailto:elihusmails@gmail.com>> wrote:
>
>         I have seen programs that will help me to edit and analyze SE
>         Linux policies.  What I am interested in is a resource that
>         will help me understand what a policy does and how to write
>         them.  At least for me, learning at the code level and not
>         using GUI tools helps me to understand things better. 
>
>         So what resources are out there for me to start looking at?
>
>         Thanks in advance.
>         Mark
>
>
>
> ------------------------------------------------------------------------
>
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
