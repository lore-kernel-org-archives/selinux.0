Date: Wed, 6 Feb 2002 18:58:53 +0200 (EET)
From: Hacko <toltec@karai.net>
To: SELinux@tycho.nsa.gov
Subject: test selinux account
In-Reply-To: <Pine.GSO.4.33.0202051614131.13219-100000@raven>
Message-ID: <Pine.LNX.4.44.0202061849040.31648-100000@karai.karai.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,
if you wish please test selinux,2.4.14-lsm on slackware-curent, PC,
enforcing, test is in user_r:user_t, as some of the other user accounts,
many restrictions are not present, test is normal shell account.


hostname: karai.net
login: test
password: test

sorry if connection is sometimes slow ;).

best regards,

Hacko




>
> You didn't mention what role/domain you are using for your test user
> account.  Are you using user_r:user_t from the example policy?  Or
> something of your own creation?
>
> The example policy is focused on protecting the integrity of the base
> system, confining and protecting system processes, and protecting
> administrator processes.  See the Ottawa paper and/or the policy report.
> Hence, it isn't trying to prevent an ordinary user from doing ordinary
> work.
>
> > Is there some way to see some denials in action from this test
> > account?
>
> You could su to root (from your user_t domain or whatever your test
> user domain is) and then try something that would violate the example
> policy, e.g. writing to a file in /etc.
>
> > I was guessing that with SELinux that I would be able to stop the
> > test user from running some vsrious applications perhaps. How can
> > this be demonstrated?
>
> By changing the example policy to restrict execute access for the user_t
> domain (or whatever your test user domain is).
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
>
>
>
>
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
