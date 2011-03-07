Date: Tue, 8 Mar 2011 10:31:00 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [GIT PULL] selinux for 2.6.39
In-Reply-To: <1299517713.7141.6.camel@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.1103081030040.19366@tundra.namei.org>
References: <1299517713.7141.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 7 Mar 2011, Eric Paris wrote:

> Please pull the following for 2.6.39.
> 
> The following changes since commit 821404434f3324bf23f545050ff64055a149766e:
> 
>   CacheFiles: Add calls to path-based security hooks (2011-01-24 10:49:45 +1100)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/eparis/selinux.git master

I get a build error:

security/selinux/ss/services.c: In function security_compute_sid:
security/selinux/ss/services.c:1412: error: implicit declaration of function security_is_socket_class
make[2]: *** [security/selinux/ss/services.o] Error 1

That function does not seem to be in my tree.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
