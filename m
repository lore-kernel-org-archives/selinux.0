Date: Mon, 17 Feb 2003 13:43:31 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: kayo <kayo@pyra.ca>
Cc: SELinux@tycho.nsa.gov
Subject: Re: user transparent encryption
Message-ID: <20030217024331.GA25958@snoopy.apana.org.au>
References: <1045448295.28041.15.camel@smeagol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1045448295.28041.15.camel@smeagol>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 16, 2003 at 08:18:16PM -0600, kayo wrote:
> I am wondering if any of you have heard of a file system encryption
> service that is or close to transparent to users in which couldnt be
> easily compramised even if root was. Or have any ideas on how this could
> be done. I know using a loopback type scheam that once mounted or while
> mounting root could steal the key or the data that should be private.
> Has any one heard of a group that are brainstorming simular concepts?

What type of attack are you trying to protect your data from?

If you don't trust the adminstrator, there is nothing you can do, root
needs to access the entire system for adminstration. He/she can commands
like run "su userid" for instance to become your UID. Even SE-Linux
policy won't help, and presumably it is the adminstrator who sets the
policy.

If on the otherhand, you are more concerned about a program running
as root which could be compromised and allow access to private files,
SE-Linux can help by limiting the prvileges that these programs have.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
