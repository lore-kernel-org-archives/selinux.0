Subject: Re: x client policy interfaces
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <cadfc0e40806200936x4c7ceb4aneaaccd09c9061ac8@mail.gmail.com>
References: <cadfc0e40806200936x4c7ceb4aneaaccd09c9061ac8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 23 Jun 2008 08:54:03 -0400
Message-Id: <1214225643.11146.214.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-06-20 at 11:36 -0500, Xavier Toth wrote:
> I've been looking at the xserver_common_x_domain_template and AVCs
> coming out of X applications and thinking it would be good to have
> finer grained interfaces that could be used to build policy for the
> wide variety of GUI apps. X extensions and selection are a couple of
> area that caught my eye can you think of others.

Adding the interfaces is fine.  Its something that I expected.  The X
policy is big beast, and I didn't add any additional interfaces since I
wanted to make sure the core was right :)

> Example:


> interface(`xserver_use_xextension',`
> 	gen_require(`
>                 class x_extension { use getattr };
> 		type $2_xext_t;
>	')
>
>        allow $1 $2_xext_t:x_extension { use getattr };
> ')
> 

> interface(`xserver_use_screensaver_xextension',`
> 	gen_require(`
>                 class x_extension { use getattr };
> 		type screensaver_xext_t;
>	')
>
>        xclient_use_xextension($1, screensaver)
>')

I think the allow rule should just be used.  I don't think we gain
anything by having the top interface.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
