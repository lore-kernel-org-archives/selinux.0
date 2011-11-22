From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bhargava Shastry <bshas3@gmail.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux on Android
Date: Wed, 23 Nov 2011 09:03:26 +1100
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com> <1321900374.9385.39.camel@moss-pluto> <CAGGozWRoHG9TW0xEy7c3ji1ksfXeHt_Nb+53=j3hpZSp0fWmDw@mail.gmail.com>
In-Reply-To: <CAGGozWRoHG9TW0xEy7c3ji1ksfXeHt_Nb+53=j3hpZSp0fWmDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201111230903.27267.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 Nov 2011, Bhargava Shastry <bshas3@gmail.com> wrote:
> between the two files. To do this, I need sources for Ubuntu-SELinux policy
> (in order to compile a policy.conf) . I have somehow not been able to
> locate the source for the policy binary that ubuntu uses (I looked in the
> /etc/selinux dir to no avail). Any ideas as to where I can find them?
> Alternatively, is there a tool to reverse engineer policy.conf from the
> policy binary (e.g. policy.24)?

To get the source for something on Ubuntu you should run
"apt-get source PACKAGE".

Also you might find it better to use Debian SE Linux stuff instead of Ubuntu.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
