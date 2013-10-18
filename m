Message-ID: <1382126564.3041.13.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Fri, 18 Oct 2013 22:02:44 +0200
In-Reply-To: <52617C02.4060500@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
> I pushed an update of CIL to bitbucket.

I had to do this, to make it compile ( not sure what i might have broken
by doing this ):

--- a/src/cil.c
+++ b/src/cil.c
@@ -1493,7 +1493,6 @@ void cil_userbounds_init(struct cil_userbounds
**userbounds)
        *userbounds = cil_malloc(sizeof(**userbounds));
 
        (*userbounds)->user_str = NULL;
-       (*userbounds)->user = NULL;
        (*userbounds)->bounds_str = NULL;
 }

Also a thing i noticed, which is unrelated to secilc, but related to
cilpolicy is that object_r role is associated to identities.

The object_r string is not really a role, although it looks like it.

Its just a string that is used as a place holder for the role security
attribute of objects.

Anyhow, i am going to write a minimum policy with secilc tomorrow i
think, so maybe then i will find new bugs, insights.

Thanks for your work


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
