Date: Tue, 5 Feb 2002 16:34:22 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Lonnie Cumberland <lonnie@outstep.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: un-noticed security
In-Reply-To: <4408.192.168.1.12.1012941810.squirrel@192.168.1.2>
Message-ID: <Pine.GSO.4.33.0202051614131.13219-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 5 Feb 2002, Lonnie Cumberland wrote:

> I have my SELinux test server up and running and have made a standard
> test user account.

I assume that you've read the entire README and followed its instructions,
including steps 17-19, and that you are running your kernel in enforcing
mode.  If not, then read the README.

> My problem is that I have not really noticed any new security that is
> running on the system. It appears that the test user account can do
> exactly what they were able to do before I installed SELinux.

You didn't mention what role/domain you are using for your test user
account.  Are you using user_r:user_t from the example policy?  Or
something of your own creation?

The example policy is focused on protecting the integrity of the base
system, confining and protecting system processes, and protecting
administrator processes.  See the Ottawa paper and/or the policy report.
Hence, it isn't trying to prevent an ordinary user from doing ordinary
work.

> Is there some way to see some denials in action from this test
> account?

You could su to root (from your user_t domain or whatever your test
user domain is) and then try something that would violate the example
policy, e.g. writing to a file in /etc.

> I was guessing that with SELinux that I would be able to stop the
> test user from running some vsrious applications perhaps. How can
> this be demonstrated?

By changing the example policy to restrict execute access for the user_t
domain (or whatever your test user domain is).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
