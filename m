Date: Mon, 8 Jul 2002 07:45:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: JW <jw@centraltexasit.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New user question
In-Reply-To: <200207080106.52843.jw@centraltexasit.com>
Message-ID: <Pine.GSO.4.33.0207080742310.19100-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 8 Jul 2002, JW wrote:

> Probably I will find ot the hard way before I actually get a reply from the
> list, but what is the drawback of not installing the modified selinux
> 'utils'?
>
> Since I'm using SuSE, not RedHat, I would rather not install the modified
> utils unless i have to. It is not at all clear to me what is differant
> about these utils that would require their use.

As noted in selinux/INDEX, only a few of the modified programs under utils
are truly critical, specifically the modified login, sshd, and crond.  You
will also want the newrole and run_init utilities.  Others have previously
posted on the list about porting the utilities to SuSE, so you can look at
the mailing list archives for suggestions.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
