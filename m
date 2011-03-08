Subject: Re: [GIT PULL] selinux for 2.6.39
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <alpine.LRH.2.00.1103081030040.19366@tundra.namei.org>
References: <1299517713.7141.6.camel@localhost.localdomain>
	 <alpine.LRH.2.00.1103081030040.19366@tundra.namei.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Mar 2011 19:02:03 -0500
Message-ID: <1299542523.11289.37.camel@unknown001a4b0c2895>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-03-08 at 10:31 +1100, James Morris wrote:
> On Mon, 7 Mar 2011, Eric Paris wrote:
> 
> > Please pull the following for 2.6.39.
> > 
> > The following changes since commit 821404434f3324bf23f545050ff64055a149766e:
> > 
> >   CacheFiles: Add calls to path-based security hooks (2011-01-24 10:49:45 +1100)
> > 
> > are available in the git repository at:
> >   git://git.infradead.org/users/eparis/selinux.git master
> 
> I get a build error:
> 
> security/selinux/ss/services.c: In function security_compute_sid:
> security/selinux/ss/services.c:1412: error: implicit declaration of function security_is_socket_class
> make[2]: *** [security/selinux/ss/services.o] Error 1
> 
> That function does not seem to be in my tree.

My tree builds.  It's defined in security/selinux/flash.h

I wonder (blind guess in the dark) if maybe our autogen code doesn't
regen the files if the autogen script is what changes rather than it's
inputs?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
