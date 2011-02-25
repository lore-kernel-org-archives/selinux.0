Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1PK7tqD026817
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 15:07:55 -0500
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1PK7scb000937
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 20:07:54 GMT
Received: by iwn2 with SMTP id 2so1467997iwn.12
        for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 12:07:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110225095648.GA6653@secunet.com>
References: <20110223115343.GH20852@secunet.com>
	<20110223115715.GL20852@secunet.com>
	<201102230956.53069.paul.moore@hp.com>
	<20110224082252.GP20852@secunet.com>
	<AANLkTimVMykzZDE07C4zxW=o+1_cWkrzDEHFOi5jAA0S@mail.gmail.com>
	<20110225095648.GA6653@secunet.com>
Date: Fri, 25 Feb 2011 15:07:53 -0500
Message-ID: <AANLkTinOR0iWwQoj_boCUN9ZiSmA-=ngRu-CG57r3_oF@mail.gmail.com>
Subject: Re: [PATCH 4/4 v2] selinux: xfrm - notify users on dropped packets
From: Eric Paris <eparis@parisplace.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paul Moore <paul.moore@hp.com>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Patches 1-3 have been committed to
http://git.infradead.org/users/eparis/selinux.git

thanks!

-Eric

On Fri, Feb 25, 2011 at 4:56 AM, Steffen Klassert
<steffen.klassert@secunet.com> wrote:
> On Thu, Feb 24, 2011 at 09:51:04AM -0500, Eric Paris wrote:
>> All printk() statement require a KERN_*.  I've often heard upstream
>> people say that every printk should only be printed if you expect the
>> user to do something with it.  If it doesn't give the user enough
>> information to fix whatever the problem is, or know how to fix
>> whatever the problem is, it's a bad printk.  I don't know this code at
>> all, but I'm pretty sure if I got those printk's I'd just feel
>> dumb....
>>
>
> The problem with this patch is, that it was one of my debugging patches
> when I tried to find out why my packets are dropped. It was not
> contemplated to push it upstream when I wrote it. Then I thought it
> would be good to print out a message if these packets are dropped
> and I picked the patch from my debugging branch, which was a bad idea.
> I think we should drop this patch entirely and focus on the remaining
> 3 paches for now, as they are real fixes. So I could resend the remaining
> patches for another round of review, or does anybody want to thake them
> as they are?
>
> Steffen
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
