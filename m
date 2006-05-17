From: Steve Grubb <sgrubb@redhat.com>
To: Joshua Brindle <method@gentoo.org>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
Date: Wed, 17 May 2006 13:30:05 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
References: <446AFED3.9010800@redhat.com> <446B4D6C.3070605@redhat.com> <446B58E5.7030504@gentoo.org>
In-Reply-To: <446B58E5.7030504@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605171330.05860.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 17 May 2006 13:09, Joshua Brindle wrote:
> > One suggestion I have heard is to allow the administrator to turn off
> > the cache, perhaps via /etc/selinux/config???
>
> That sounds good, will this be included in the next patch?

I think if you have to parse /etc/selinux/config, you've lost all performance 
gains from caching. May as well not have this patch and call the daemon 
everytime.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
