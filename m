Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Richard Mayo" <rmayo@caci.com>, SELinux@tycho.nsa.gov
Subject: Re:
Date: Wed, 24 Jul 2002 16:19:52 +0200
References: <OF3775534F.EB0631B6-ON85256C00.004AAC59@hq.caci.com>
In-Reply-To: <OF3775534F.EB0631B6-ON85256C00.004AAC59@hq.caci.com>
MIME-Version: 1.0
Message-Id: <20020724141953.422DF7DE2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Jul 2002 15:37, Richard Mayo wrote:
> It's obvious to me how to configure my computer to boot only to SELinux,
> but how do I force the computer into Enforcing mode?

I am currently putting in a symlink from /usr/sbin/avc_toggle to 
/etc/rc.boot/avc_toggle, but I'll probably use an init script later on.

> Also, when a user logs on the system asks if he or she would like to switch
> user contexts.  Is there an easy way to suppress this?

It would be good to suppress the choice of role when the user is only 
authorised for one role though.  As for choice of domains, there is currently 
no way of automatically determining which domains might work (although in the 
current default policy only the main domain will work).


Russell Coker

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
