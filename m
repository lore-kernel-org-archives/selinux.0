Date: Fri, 12 Apr 2002 18:50:44 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412185044.A6824@lemuria.org>
References: <20020412172954.A30349@lemuria.org> <Pine.GSO.4.33.0204121232150.21729-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204121232150.21729-100000@raven>; from sds@tislabs.com on Fri, Apr 12, 2002 at 12:35:46PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 12, 2002 at 12:35:46PM -0400, Stephen Smalley wrote:
> At present, if you want to use the generic user support, you also need an
> entry for user_u in /etc/security/default_context (i.e.
> user_u:user_r:user_t).  Such an entry is in the example default_context
> file in the upstream SELinux distribution.

I have that. However, trying to log in via ssh fails with the same SID
error message I had earlier for tom when I didn't have tom in the
default_context. So this was my first idea - but not luck. I also do
have that user_u in the users role file (I didn't modify the default
very much yet).


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
